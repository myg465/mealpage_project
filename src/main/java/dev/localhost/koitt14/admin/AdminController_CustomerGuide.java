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
public class AdminController_CustomerGuide {
  @Autowired
  AccountService accountService;
	
  @Autowired
  CustomerService customerService;

  // 관리자단 이용안내 리스트
  @GetMapping({"admin/customer/guide",
		  	   "admin/customer/guide/{nowPage_}/{guideState_}"})
  public String guideList(HttpServletRequest request,
		  				   @PathVariable Optional<Integer> nowPage_,
		  				   @PathVariable Optional<Integer> guideState_,
		  				   Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // guideState => normal : 1 / search : 2
	  int guideState = guideState_.isPresent() ? guideState_.get() : 1;
	  
	  customerService.gudideList(nowPage, guideState, model);
	  
	  return "admin/board_guide";
  }

  // 관리자단 이용안내 검색
  @GetMapping({"admin/customer/guide/search",
	  		   "admin/customer/guide/search/{nowPage_}/{guideSate_}/{searchClassification_}/{searchInput_}"})
  public String guideSearch(HttpServletRequest request, 
		  					@PathVariable Optional<Integer> nowPage_,
		  					@PathVariable Optional<Integer> guideState_,
		  					@PathVariable Optional<String> searchClassification_,
		  					@PathVariable Optional<String> searchInput_,
		  					Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int guideState = guideState_.isPresent() ? guideState_.get() : 2;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  customerService.guideSearch(request, nowPage, guideState, searchClassification, searchInput, model);
	  
	  return "admin/board_guide";
  }
  
  // 관리자단 이용안내 상세보기
  @GetMapping({"admin/customer/guide/view/{seqKey}/{nowPage}"})
  public String guideAdminView(HttpServletRequest request,
		  					   @PathVariable("seqKey") int seqKey,
		  					   @PathVariable("nowPage") int nowPage,
		  					   Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.guideAdminView(seqKey, nowPage, model);
	  
	  return "admin/board_guideView";
  }
  
  // 관리자단 이용안내 작성 페이지
  @GetMapping({"admin/customer/guide/write/view"})
  public String guideWriteView(HttpServletRequest request) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  return "admin/board_guideWrite";
  }
  
  // 관리자단 이용안내 작성
  @PostMapping({"admin/customer/guide/write"})
  public String guideWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.guideWrite(request, redirect);
	  
	  return "redirect:/admin/customer/guide"; 
  }
  
  // 관리자단 이용안내 수정 페이지
  @GetMapping({"admin/customer/guide/modify/view/{seqKey}/{nowPage}"})
  public String guideModifyView(HttpServletRequest request,
		  						@PathVariable("seqKey") int seqKey,
		  						@PathVariable("nowPage") int nowPage,
		  						Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.guideModifyView(seqKey, nowPage, model);
	  
	  
	  return "admin/board_guideModify";
  }
  
  // 관리자단 이용안내 수정
  @PostMapping({"admin/customer/guide/modify/{seqKey}/{page}"})
  public String guideModify(HttpServletRequest request,
		  					@PathVariable("seqKey") int seqKey,
		  					@PathVariable("page") int page,
		  					RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.quideModify(request, seqKey, redirect);
	  
	  return "redirect:/admin/customer/guide/view/" + seqKey + "/" + page;
  }
  
  // 관리자단 이용안내 삭제
  @GetMapping({"admin/customer/guide/delete/{seqKey}"})
  public String guideDelete(HttpServletRequest request,
		  					@PathVariable("seqKey") int seqKey,
		  					RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.guideDelete(seqKey, redirect);
	  
	  
	  return "redirect:/admin/customer/guide";
  }
  
  
}
