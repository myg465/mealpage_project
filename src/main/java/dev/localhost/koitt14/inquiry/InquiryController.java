package dev.localhost.koitt14.inquiry;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class InquiryController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private InquiryService inquiryService;

  // 목록 읽기
  @GetMapping({"/inquiry", "/inquiry/{page}"})
  public String readList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
  
    int page = param1.isPresent() ? param1.get() : 1;
    inquiryService.readList(page, model);
    
    return "mypage/inquiry";
  }

  // 게시물 읽기
  @GetMapping({"/inquiry/{page}/read/{key}"})
  public String readInquiry (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    inquiryService.readInquiry(key, model);
    if (page != 0) inquiryService.readList(page, model);
    
    return "mypage/inquiryRead";
  }

  // 게시물 쓰기 폼
  @GetMapping("/inquiry/write")
  public String getWrite (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    return "mypage/inquiryWrite";
  }

  // 게시물 쓰기 처리
  @PostMapping("/inquiry/write")
  public String postWrite (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";
    
    model.addAttribute("request", request);
    String result = inquiryService.writeInquiry(model);

    String uri = "";

    switch (result) {
      case "pass":
        uri = "redirect:/inquiry";
        break;
      case "limit":
        uri = "mypage/inquiryWriteLimit";
        break;
      default:
        uri = "error/500";
    }

    return uri;
  }

  // 검색 폼 대응
  @PostMapping("/inquiry/search")
  public String search (HttpServletRequest request, Model model) throws UnsupportedEncodingException {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    String searchType = request.getParameter("searchType") + "/";
    String searchText = URLEncoder.encode(request.getParameter("searchText"), "UTF-8");

    return "redirect:/inquiry/search/" + searchType + searchText + "/1";
  }

  // 검색결과 목록 읽기
  @GetMapping({"/inquiry/search/{type}/{keyword}/{page}"})
  public String searchList (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    inquiryService.searchList(type, keyword, page, model);
    
    return "mypage/inquirySearch";
  }

  // 검색결과 게시물 읽기
  @GetMapping({"/inquiry/search/{type}/{keyword}/{page}/read/{key}"})
  public String searchRead (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    inquiryService.searchList(type, keyword, page, model);
    inquiryService.readInquiry(key, model);
    
    return "mypage/inquirySearchRead";
  }

  // 게시물 수정 폼
  @GetMapping("/inquiry/{page}/modify/{key}")
  public String getModify (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    model.addAttribute("page", page);
    inquiryService.readInquiry(key, model);

    return "mypage/inquiryModify";
  }

  // 게시물 수정 폼 처리
  @PostMapping("/inquiry/{page}/modify/{key}")
  public String postModify (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("key") int key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    inquiryService.modifyInquiry(page, key, model);

    return "mypage/inquiryModifyOk";
  }

  // 게시물 삭제
  @GetMapping("/inquiry/delete/{key}")
  public String delete (@PathVariable("key") int key, HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    inquiryService.deleteInquiry(key, model);

    return "mypage/inquiryDeleteOk";
  }
}
