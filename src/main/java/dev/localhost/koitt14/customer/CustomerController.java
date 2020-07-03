package dev.localhost.koitt14.customer;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class CustomerController {
  @Autowired
  private CustomerService customerService;

  // 공지사항 ----------------------------------------------------------------------
  // 공지사항 전체 리스트
  @GetMapping({"customer/notice",
	  		   "customer/notice/{nowPage_}/{nomalOrSearch}"})
  public String notice(@PathVariable Optional<Integer> nowPage_,
		  				@PathVariable Optional<Integer> nomalOrSearch_, Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int nomalOrSearch = nomalOrSearch_.isPresent() ? nomalOrSearch_.get() : 1;
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("nomalOrSearch", nomalOrSearch);
	  customerService.noticeList(model);
	  
	  return "customer/notice";
  }
  
  // 공지사항 검색
  @GetMapping({"customer/noticeSearch",
	  		   "customer/noticeSearch/{nowPage_}/{nomalOrSearch_}/{searchClassification_}/",
	  		   "customer/noticeSearch/{nowPage_}/{nomalOrSearch_}/{searchClassification_}/{searchInput_}"})
  public String noticeSearch(HttpServletRequest request, 
		  						@PathVariable Optional<Integer> nowPage_,
		  						@PathVariable Optional<Integer> nomalOrSearch_,
		  						@PathVariable Optional<String> searchClassification_,
		  						@PathVariable Optional<String> searchInput_,
		  						Model model) {

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
	  
	  return "customer/notice";
  }
  
  // 공지사항 상세보기
  @GetMapping("customer/noticeView/{seqKey}/{nowPage_}")
  public String noticeView(@PathVariable("seqKey") int seqKey,
							@PathVariable Optional<Integer> nowPage_,
			/* @PathVariable("nowPage") int nowPage, */
		  					Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("nowPage", nowPage);
	  
	  customerService.noticeView(model);
	  return "customer/noticeView";
  }
  
   
  // 비회원 1:1 문의 ---------------------------------------------------------------------
  // 비회원 1:1 문의 세션정보 가져오기
  @GetMapping("customer/inquiry")
  public String nonmemberInquiry(HttpSession session, Model model) {
	  
	  customerService.nonmemberInquiry(session, model);
	  
	  return "customer/inquiry";
  }
  
  // 로그인한 상태로 1:1문의 들어 올 경우 mypage의 회원 1:1 문의로 이동
  @GetMapping("mypage/inquiry")
  public String myPageInquiry() {
	  
	  return "mypage/inquiry";
  }
  
  // 미로그인 1:1문의 글쓰기
  @PostMapping("customer/inquiryWrite")
  public String nonmemberInquiryWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  
	  customerService.nonmemberInquiryWrite(request, redirect);
	  
	  return "redirect:/customer/inquiry";
  }
  
  // FAQ ---------------------------------------------------------------------
  // FAQ 전체 리스트
  @GetMapping({"customer/faq", 
	  		   "customer/faq/{nowPage_}/{faqState_}"})
  public String faq(@PathVariable Optional<Integer> nowPage_,
		  			@PathVariable Optional<Integer> faqState_,
		  			Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // 1 : nomal, 2 : category
	  int faqState = faqState_.isPresent() ? faqState_.get() : 1;
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  
	  customerService.faqList(model);
	  
	  return "customer/faq";
  }
  
  //FAQ 카테고리 클릭 시 
  @GetMapping({"customer/faqCategory/{category}",
	  		   "customer/faqCategory/{category}/{nowPage_}/{faqState_}"})
  public String faqCategoryList(@PathVariable("category") String category,
		  						@PathVariable Optional<Integer> nowPage_,
		  						@PathVariable Optional<Integer> faqState_,
		  						Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // 1 : normal, 2 : category, 3 : search
	  int faqState = faqState_.isPresent() ? faqState_.get() : 2;
	  
	  model.addAttribute("category", category);
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  
	  customerService.faqCategoryList(model);
	  
	  return "customer/faq";
  }
  
  //FAQ 검색
  @GetMapping({"customer/faqSearch",
	  		   "customer/faqSearch/{nowPage_}/{faqState_}/{searchClassification_}/",
	  		   "customer/faqSearch/{nowPage_}/{faqState_}/{searchClassification_}/{searchInput_}"})
  public String faqSearch(HttpServletRequest request, 
		  				  @PathVariable Optional<Integer> nowPage_,
		  				  @PathVariable Optional<Integer> faqState_,
		  				  @PathVariable Optional<String> searchClassification_,
		  				  @PathVariable Optional<String> searchInput_,Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // 1 : nomal, 2 : category, 3 : search
	  int faqState = faqState_.isPresent() ? faqState_.get() : 3;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("faqState", faqState);
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("request", request);
	  
	  customerService.faqSearch(model);
	  
	  return "customer/faq";
  }
   
  //이용안내 ---------------------------------------------------------------------
  @GetMapping("customer/guide")
  public String guide(Model model) {
	  
	  customerService.guide(model);
	  
	  return "customer/guide";
  }
  
  
}
