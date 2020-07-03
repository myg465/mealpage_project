package dev.localhost.koitt14.admin;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dev.localhost.koitt14.productInquiry.ProductInquiryService;

@Controller
public class AdminController_ProductInquiry {

	  //상품문의서비스
	  @Autowired
	  ProductInquiryService inquiryService;
	  //---------------------------------------------------------------------------------------//
	  //상품문의 관리
	  @GetMapping({"/admin/productInquiry",
	  			  "/admin/productInquiry/{search_}/{order_}",
	  			  "/admin/productInquiry/{search_}/{order_}/{inquiryPage_}"})
	  public String productInquiry(@PathVariable Optional<Integer> inquiryPage_,
			  					  @PathVariable Optional<String> order_,
			  					  @PathVariable Optional<String> search_,
			  					  @RequestParam(required = false, value = "searchtext") String search,
			  					  Model model) {
		  
		  search=search_.isPresent() ? search_.get() : search;
		  if(search==null) search="All";
		  int inquiryPage=inquiryPage_.isPresent() ? inquiryPage_.get() : 1;
		  String order=order_.isPresent() ? order_.get() : "name";
		  
		  
		  inquiryService.inquiryListAll(model, inquiryPage, order, search);
		  
		  return "admin/product_inquiry";
		  
	  }//productInquiry
	  //---------------------------------------------------------------------------------------//
	  //답변작성뷰
	  @GetMapping("/admin/productInquiry/reply/{seqKey}")
	  public String productInquiryReply(@PathVariable("seqKey")int seqKey, Model model) {
		  
		  inquiryService.inquiryModifyView(seqKey, model);
		  
		  return "admin/product_inquiry_reply";
	  }//productInquiryReply
	  //---------------------------------------------------------------------------------------//
	  //답변입력
	  @PostMapping("/admin/productInquiry/replyInsert")
	  public String productInquiryReplyInsert(HttpServletRequest request, Model model) {
		  
		  inquiryService.replyInsert(request,model);
		  
		  return "admin/product_inquiry_reply";
	  }//productInquiryReplyInsert
	  //---------------------------------------------------------------------------------------//
	  //답변수정
	  @PostMapping("/admin/productInquiry/replyModify")
	  public String productInquiryReplyModify(HttpServletRequest request, Model model) {
		  
		  inquiryService.replyModify(request,model);
		  
		  return "admin/product_inquiry_reply";
	  }//productInquiryReplyModify
	  //
	  
	  @GetMapping("/admin/productInquiry/delete/{seqKey}")
	  public String productInquiryDelete(@PathVariable("seqKey")int seqKey) {
		  
		  inquiryService.inquiryDelete(seqKey);
		  
		  return "redirect:/admin/productInquiry";
	  }
	  
	
}
