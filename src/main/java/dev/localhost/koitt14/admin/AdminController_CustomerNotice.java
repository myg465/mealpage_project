package dev.localhost.koitt14.admin;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.customer.CustomerService;

@Controller
public class AdminController_CustomerNotice {
  @Autowired
  AccountService accountService;
	
  @Autowired
  CustomerService customerService;

  // 관리자단 공지사항 리스트
  @GetMapping({"admin/customer/notice",
	  		   "admin/customer/notice/{nowPage_}/{nomalOrSearch_}"})
  public String noticeList(HttpServletRequest request,
		  				   @PathVariable Optional<Integer> nowPage_,
		  				   @PathVariable Optional<Integer> nomalOrSearch_,
		  				   Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int nomalOrSearch = nomalOrSearch_.isPresent() ? nomalOrSearch_.get() : 1;
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("nomalOrSearch", nomalOrSearch);
	  
	  customerService.noticeList(model);
	  
	  
	  return "admin/board_notice";
  }
  
  // 관리자단 공지사항 검색
 @GetMapping({"admin/customer/notice/search",
	  		  "admin/customer/notice/search/{nowPage_}/{nomalOrSearch_}/{searchClassification_}/",
	  		  "admin/customer/notice/search/{nowPage_}/{nomalOrSearch_}/{searchClassification_}/{searchInput_}"})
  public String noticeSearch(HttpServletRequest request, 
		  						@PathVariable Optional<Integer> nowPage_,
		  						@PathVariable Optional<Integer> nomalOrSearch_,
		  						@PathVariable Optional<String> searchClassification_,
		  						@PathVariable Optional<String> searchInput_,
		  						Model model) {
      if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int nomalOrSearch = nomalOrSearch_.isPresent() ? nomalOrSearch_.get() : 2;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("nomalOrSearch", nomalOrSearch);
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  model.addAttribute("request", request);
	  customerService.noticeSearch(model); 
	  
	  return "admin/board_notice";
  }
  
  // 관리자단 공지사항 상세보기
  @GetMapping({"admin/customer/notice/view/{seqKey}",
	  		   "admin/customer/notice/view/{seqKey}/{nowPage_}"})
  public String noticeView(HttpServletRequest request,
		  				   @PathVariable("seqKey") int seqKey,
						   @PathVariable Optional<Integer> nowPage_,
		  					Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("nowPage", nowPage);
	  
	  customerService.noticeView(model);
	  return "admin/board_noticeView";
  }  
  
  // 관리자단 공지사항 작성 페이지
  @GetMapping("admin/customer/notice/write/view")
  public String noticeWriteView(HttpServletRequest request) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  return "admin/board_noticeWrite";
  }
   
  // 관리자단 공지사항 작성
  @PostMapping("admin/customer/notice/write")
  public String noticeWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.noticeWrite(request, redirect);
	  
	  return "redirect:/admin/customer/notice"; 
  }
  
  // 관리자단 공지사항 수정 페이지
  @GetMapping("admin/customer/notice/modifyView/{seqKey}/{nowPage}")
  public String noticeModifyView(HttpServletRequest request,
		  						 @PathVariable("seqKey") int seqKey,
		  						 @PathVariable("nowPage") int nowPage,
		  						 Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  model.addAttribute("page", nowPage);
	  
	  customerService.noticeModifyView(seqKey, model);
	  
	  return "admin/board_noticeModify";
  }
  
  // 관리자단 공지사항 수정
  @PostMapping ("admin/customer/notice/modify/{seqKey}/{page}")
  public String noticeModify(HttpServletRequest request,
		  					 @PathVariable("seqKey") int seqKey,
		  					 @PathVariable("page") int page,
  							 RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.noticeModify(request, redirect);

	  return "redirect:/admin/customer/notice/view/" + seqKey + "/" + page; 
  }
  
  // 관리자단 공지사항 삭제
  @GetMapping({"admin/customer/notice/delete/{seqKey}",
	  		   "admin/customer/notice/delete/{seqKey}/{imageFileName_}"})
  public String noticeDelete(HttpServletRequest request,
		  					 @PathVariable("seqKey") int seqKey,
		  					 @PathVariable Optional<String> imageFileName_,
		  					 RedirectAttributes redirect) {
	  
	  String imageFileName = imageFileName_.isPresent() ? imageFileName_.get() : "nothing";
	  
	  customerService.noticeDelete(request, seqKey, imageFileName, redirect);
	  
	  return "redirect:/admin/customer/notice";
  }
  
  
}
