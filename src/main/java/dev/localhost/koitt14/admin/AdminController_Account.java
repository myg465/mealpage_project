package dev.localhost.koitt14.admin;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.coupon.CouponService;
import dev.localhost.koitt14.point.PointService;

// 관리자 페이지 - 회원관리
@Controller
public class AdminController_Account {
  @Autowired
  AccountService accountService;

  @Autowired
  CouponService couponService;

  @Autowired
  PointService pointService;

  // 회원목록 가져오기
  @GetMapping({"/admin/account/list", "/admin/account/list/{page}"})
  public String getAccountList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;
    accountService.getList(page, model);

    return "admin/account_list";
  }

  // 회원목록 검색 폼 대응
  @PostMapping("/admin/account/list/search")
  public String searchAccount (HttpServletRequest request) throws UnsupportedEncodingException {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    String searchType = request.getParameter("searchType") + "/";
    String searchText = URLEncoder.encode(request.getParameter("searchText"), "UTF-8");

    return "redirect:/admin/account/list/search/" + searchType + searchText + "/1";
  }

  // 회원목록 검색결과 목록 읽기
  @GetMapping({"/admin/account/list/search/{type}/{keyword}/{page}"})
  public String searchList (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    accountService.searchList(type, keyword, page, model);
    
    return "admin/account_listSearch";
  }

  // 회원정보 상세보기
  @GetMapping({"/admin/account/list/{page}/read/{key}"})
  public String readAccount (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") Object key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    accountService.selectAccountByAdmin(key, model);
    model.addAttribute("page", page);

    return "admin/account_listRead";
  }

  // 회원정보 수정 폼
  @GetMapping({"/admin/account/list/{page}/modify/{key}"})
  public String getModifyAccount (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") Object key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    accountService.selectAccountByAdmin(key, model);
    model.addAttribute("page", page);

    return "admin/account_listModify";
  }

  // 회원정보 수정 처리
  @PostMapping("/admin/account/list/{page}/modify/{key}")
  public String postModifyAccount (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") Object key) {
    model.addAttribute("request", request);
    accountService.updateAccountByAdmin(model);

    accountService.selectAccountByAdmin(key, model);
    model.addAttribute("page", page);

    return "admin/account_listRead";
  }

  // 회원 삭제(강제탈퇴)
  @GetMapping("/admin/account/list/delete/{key}/{id}")
  public String deleteAccount (@PathVariable("key") Object key, @PathVariable("id") String id, HttpServletRequest request, Model model) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int orderCount = accountService.dropAccountByAdmin(key, id, model);
    String uri = "";

    // 진행 중인 주문이 없을 때만 회원을 삭제할 수 있다
    if (orderCount == 0) {
      uri = "admin/account_listDeleteOk";
    } else {
      uri = "admin/account_listDeleteNg";
      model.addAttribute("orderCount", orderCount);
    }

    return uri;
  }

  // 포인트발급목록 가져오기
  @GetMapping({"/admin/account/point/add", "/admin/account/point/add/{page}"})
  public String getAddPointList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;
    pointService.getAddListByAdmin(page, model);

    return "admin/account_pointAdd";
  }

  // 포인트사용목록 가져오기
  @GetMapping({"/admin/account/point/used", "/admin/account/point/used/{page}"})
  public String getUsedPointList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;
    pointService.getUsedListByAdmin(page, model);

    return "admin/account_pointUsed";
  }

  // 쿠폰유효목록 가져오기
  @GetMapping({"/admin/account/coupon/able", "/admin/account/coupon/able/{page}"})
  public String getAbleCouponList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    couponService.updateDisableByAdmin();

    int page = param1.isPresent() ? param1.get() : 1;
    couponService.getAbleListByAdmin(page, model);

    return "admin/account_couponAble";
  }

  // 쿠폰만료목록 가져오기
  @GetMapping({"/admin/account/coupon/disable", "/admin/account/coupon/disable/{page}"})
  public String getDisableCouponList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    couponService.updateDisableByAdmin();

    int page = param1.isPresent() ? param1.get() : 1;
    couponService.getDisableListByAdmin(page, model);

    return "admin/account_couponDisable";
  }
}
