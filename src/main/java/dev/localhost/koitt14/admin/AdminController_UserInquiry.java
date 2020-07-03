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
import dev.localhost.koitt14.inquiry.InquiryService;

// 관리자 페이지 - 유저 문의사항
@Controller
public class AdminController_UserInquiry {
  @Autowired
  AccountService accountService;

  @Autowired
  InquiryService inquiryService;

  // 목록 읽기
  @GetMapping({"/admin/board/inquiry", "/admin/board/inquiry/{page}"})
  public String readInquiryList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;
    inquiryService.readListByAdmin(page, model);

    return "admin/board_userInquiry";
  }

  // 게시물 읽기
  @GetMapping({"/admin/board/inquiry/{page}/read/{key}"})
  public String readInquiry (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    inquiryService.readListByAdmin(page, model);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquiryRead";
  }

  // 검색 폼 대응
  @PostMapping("/admin/board/inquiry/search")
  public String searchInquiry (HttpServletRequest request) throws UnsupportedEncodingException {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    String searchType = request.getParameter("searchType") + "/";
    String searchText = URLEncoder.encode(request.getParameter("searchText"), "UTF-8");

    return "redirect:/admin/board/inquiry/search/" + searchType + searchText + "/1";
  }

  // 검색결과 목록 읽기
  @GetMapping({"/admin/board/inquiry/search/{type}/{keyword}/{page}"})
  public String searchList (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    inquiryService.searchAllList(type, keyword, page, model);
    
    return "admin/board_userInquirySearch";
  }

  // 게시물 읽기
  @GetMapping({"/admin/board/inquiry/search/{type}/{keyword}/{page}/read/{key}"})
  public String searchRead (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("request", request);
    inquiryService.searchAllList(type, keyword, page, model);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquirySearchRead";
  }

  // 게시물 삭제
  @GetMapping("/admin/board/inquiry/delete/{key}")
  public String delete (@PathVariable("key") int key, HttpServletRequest request, Model model) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    inquiryService.deleteInquiryByAdmin(key, model);

    return "admin/board_userInquiryDeleteOk";
  }

  // 게시물 답변 폼
  @GetMapping({"/admin/board/inquiry/{page}/reply/{key}"})
  public String getReply (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("page", page);
    model.addAttribute("key", key);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquiryReply";
  }

  // 게시물 답변 처리
  @PostMapping({"/admin/board/inquiry/{page}/reply/{key}"})
  public String postReply (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("request", request);
    inquiryService.replyInquiry(key, model);
    inquiryService.readListByAdmin(page, model);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquiryRead";
  }

  // 게시물 답변 수정 폼
  @GetMapping({"/admin/board/inquiry/{page}/modifyReply/{key}"})
  public String getModifyReply (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("page", page);
    model.addAttribute("key", key);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquiryModifyReply";
  }

  // 게시물 답변 수정 처리
  @PostMapping({"/admin/board/inquiry/{page}/modifyReply/{key}"})
  public String postModifyReply (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("request", request);
    inquiryService.modifyReply(key, model);
    inquiryService.readListByAdmin(page, model);
    inquiryService.readInquiryByAdmin(key, model);
    
    return "admin/board_userInquiryRead";
  }

  // 게시물 답변 삭제
  @GetMapping("/admin/board/inquiry/{page}/deleteReply/{key}")
  public String deleteReply (@PathVariable("page") int page, @PathVariable("key") int key, HttpServletRequest request, Model model) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    inquiryService.deleteReply(key);
    inquiryService.readListByAdmin(page, model);
    inquiryService.readInquiryByAdmin(key, model);

    return "admin/board_userInquiryRead";
  }
}
