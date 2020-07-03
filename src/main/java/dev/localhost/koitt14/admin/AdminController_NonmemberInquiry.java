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
public class AdminController_NonmemberInquiry {
  @Autowired
  AccountService accountService;
	
  @Autowired
  CustomerService customerService;

  // 관리자단 비회원 1:1 문의 리스트
  @GetMapping({"admin/customer/nonmemberInquiry",
	  		   "admin/customer/nonmemberInquiry/{nowPage_}/{nonmemberInquiryState_}"})
  public String nonmemberInquriyList(HttpServletRequest request,
		  							 @PathVariable Optional<Integer> nowPage_,
		  							 @PathVariable Optional<Integer> nonmemberInquiryState_,
		  							 Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // nonmemberInquiryState => normal : 1 / search : 2
	  int nonmemberInquiryState = nonmemberInquiryState_.isPresent() ? nonmemberInquiryState_.get() : 1;
	  
	  customerService.nonmemberInquiryList(nowPage, nonmemberInquiryState, model);
	  
	  return "admin/board_nonmemberInquiry";
  }
  
  // 관리자단 비회원 1:1 문의 검색
  @GetMapping({"admin/customer/nonmemberInquiry/search",
	  		   "admin/customer/nonmemberInquiry/search/{nowPage_}/{nonmemberInquiryState_}/{searchClassification_}/",
	  		   "admin/customer/nonmemberInquiry/search/{nowPage_}/{nonmemberInquiryState_}/{searchClassification_}/{searchInput_}"})
  public String nonmemberInquirySearch(HttpServletRequest request,
		  							   @PathVariable Optional<Integer> nowPage_,
		  							   @PathVariable Optional<Integer> nonmemberInquiryState_,
		  							   @PathVariable Optional<String> searchClassification_,
		  							   @PathVariable Optional<String> searchInput_,
		  							   Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // nonmemberInquiryState => normal : 1 / search : 2
	  int nonmemberInquiryState = nonmemberInquiryState_.isPresent() ? nonmemberInquiryState_.get() : 2;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "name";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  customerService.nonmemberInquirySearch(request, nowPage, nonmemberInquiryState, searchClassification, searchInput, model);
	  
	  return "admin/board_nonmemberInquiry";
  }
  
  // 관리자단 비회원 1:1 문의 상세보기
  @GetMapping({"admin/customer/nonmemberInquiry/view/{seqKey}",
	  		   "admin/customer/nonmemberInquiry/view/{seqKey}/{nowPage_}"})
  public String nonmemberInquiryView(HttpServletRequest request,
		  							 @PathVariable("seqKey") int seqKey,
		  							 @PathVariable Optional<Integer> nowPage_,
		  							 Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  
	  customerService.nonmemberInquiryView(seqKey, nowPage, model);
	  
	  return "admin/board_nonmemberInquiryView";
  }
  
  // 관리자단 비회원 1:1 문의 답변하기
  @PostMapping("admin/customer/nonmemberInquiry/reply/{seqKey}/{nowPage}")
  public String nonmemberInquiryReply(HttpServletRequest request,
		  							  @PathVariable("seqKey") int seqKey,
		  							  @PathVariable("nowPage") int nowPage,
		  							  RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  customerService.nonmemberInquiryReply(request, seqKey, redirect);
	  
	  return "redirect:/admin/customer/nonmemberInquiry/view/" + seqKey + "/" + nowPage;
  }
  
  // 관리자단 비회원 1:1 문의 삭제
  @GetMapping({"admin/customer/nonmemberInquiry/delete/{seqKey}",
	  		   "admin/customer/nonmemberInquiry/delete/{seqKey}/{fileName_}"})
  public String nonmemberInquriyDelete(HttpServletRequest request,
  									   @PathVariable("seqKey") int seqKey,
  									   @PathVariable Optional<String> fileName_,
  									   RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  String fileName = fileName_.isPresent() ? fileName_.get() : "nothing";

	  customerService.nonmemberInquiryDelete(request, seqKey, fileName, redirect);
	  
	  return "redirect:/admin/customer/nonmemberInquiry";
  }
  
  
}
