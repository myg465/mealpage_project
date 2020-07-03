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
public class AdminController_CustomerFaq {
  @Autowired
  AccountService accountService;
	
  @Autowired
  CustomerService customerService;

  // 관리자단 FAQ 리스트
  @GetMapping({"admin/customer/faq",
	  		   "admin/customer/faq/{nowPage_}/{faqState}"})
  public String faqList(HttpServletRequest request,
		  				   @PathVariable Optional<Integer> nowPage_,
		  				   @PathVariable Optional<Integer> faqState_,
		  				   Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // 1 : 전체리스트, 2 : 검색의 경우
	  int faqState = faqState_.isPresent() ? faqState_.get() : 1;
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  
	  customerService.faqList(model);
	  
	  return "admin/board_faq";
  }
  
  // 관리자단 FAQ 카테고리 클릭 시
  @GetMapping({"admin/customer/faq/category/{category}",
	  		   "admin/customer/faq/category/{category}/{nowPage_}/{faqState_}"})
  public String adminFaqCategoryList(HttpServletRequest request,
		  							 @PathVariable("category") String category,
		  							 @PathVariable Optional<Integer> nowPage_,
			  						 @PathVariable Optional<Integer> faqState_,
		  							 Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // 1 : normal, 2 : category, 3 : search
	  int faqState = faqState_.isPresent() ? faqState_.get() : 2;
	  
	  model.addAttribute("category", category);
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  
	  customerService.faqCategoryList(model);
	  
	  return "admin/board_faq";
  }
  
  // 관리자단 FAQ 검색
  @GetMapping({"admin/customer/faq/search",
	  		   "admin/customer/faq/search/{nowPage_}/{faqState_}/{searchClassification_}/",
		  	   "admin/customer/faq/search/{nowPage_}/{faqState_}/{searchClassification_}/{searchInput_}"})
  public String adminfaqSearch(HttpServletRequest request, 
		  					 @PathVariable Optional<Integer> nowPage_,
		  					 @PathVariable Optional<Integer> faqState_,
		  					 @PathVariable Optional<String> searchClassification_,
		  					 @PathVariable Optional<String> searchInput_,
		  					 Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int faqState = faqState_.isPresent() ? faqState_.get() : 3;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  model.addAttribute("request", request);
	  customerService.faqSearch(model); 
	
	  return "admin/board_faq";
  }
  
  // 관리자단 FAQ 상세보기
  @GetMapping({"admin/customer/faq/view/{seqKey}/{nowPage}"})
  public String faqView(HttpServletRequest request,
		  				@PathVariable("seqKey") int seqKey,
		  				@PathVariable("nowPage") int nowPage,
		  				Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.faqAdminView(seqKey, nowPage, model);
	  
	  return "admin/board_faqView";
  }
  
  // 관리자단 FAQ 작성 페이지
  @GetMapping("admin/customer/faq/write/view")
  public String faqWriteView(HttpServletRequest request) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  return "admin/board_faqWrite";
  }
  
  // 관리자단 FAQ 작성
  @PostMapping("admin/customer/faq/write")
  public String faqWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.faqWrite(request, redirect);
	  
	  return "redirect:/admin/customer/faq";
  }
  
  // 관리자단 FAQ 수정 페이지
  @GetMapping("admin/customer/faq/modify/view/{seqKey}/{page}")
  public String faqModifyView(HttpServletRequest request,
		  					  @PathVariable("seqKey") int seqKey,
		  					  @PathVariable("page") int page,
		  					  Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.faqModifyView(seqKey, page, model);
	  
	  return "admin/board_faqModify";
  }
  
  //관리자단 FAQ 수정
  @PostMapping("admin/customer/faq/modify/{seqKey}/{page}")
  public String faqModify(HttpServletRequest request,
		  				  @PathVariable("seqKey") int seqKey,
		  				  @PathVariable("page") int page,
		  				  RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.faqModify(request, seqKey, redirect);
	  
	  return "redirect:/admin/customer/faq/view/" + seqKey + "/" + page;
  }

  // 관리자단 FAQ 삭제
  @GetMapping("admin/customer/faq/delete/{seqKey}")
  public String faqDelete(HttpServletRequest request,
		  				  @PathVariable("seqKey") int seqKey,
		  				  RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.faqDelete(seqKey, redirect);
	  
	  return "redirect:/admin/customer/faq";
  }
  
}
