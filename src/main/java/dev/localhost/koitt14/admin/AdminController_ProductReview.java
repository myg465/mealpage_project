package dev.localhost.koitt14.admin;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.review.ReviewService;

@Controller
public class AdminController_ProductReview {
  
  
  //리뷰서비스
  @Autowired
  ReviewService reviewService;
  
  //---------------------------------------------------------------------------------------//
  //상품리뷰 관리
  @GetMapping({"/admin/productReview",
  			  "/admin/productReview/{search_}/{order_}",
  			  "/admin/productReview/{search_}/{order_}/{reviewPage_}"})
  public String productReview(@PathVariable Optional<Integer> reviewPage_,
		  					  @PathVariable Optional<String> order_,
		  					  @PathVariable Optional<String> search_,
		  					  @RequestParam(required = false, value = "searchtext") String search,
		  					  Model model) {
	  
	  search=search_.isPresent() ? search_.get() : search;
	  if(search==null) search="All";
	  int reviewPage=reviewPage_.isPresent() ? reviewPage_.get() : 1;
	  String order=order_.isPresent() ? order_.get() : "name";
	  
	  
	  reviewService.reviewListAll(model, reviewPage, order, search);
	  
	  return "admin/product_review";
	  
  }//productReview
  //----------------------------------------------------------------------------------------//
  //리뷰삭제
  @GetMapping("/admin/productReview/delete/{seqKey}/{imgFileName}")
  public String productReviewDelete(@PathVariable("seqKey") int seqKey, @PathVariable("imgFileName") String imgFileName,
		  							Model model, HttpServletRequest request) {
	  
	  reviewService.reviewDelete(seqKey, imgFileName, request);
	  
	  return "redirect:/admin/productReview";
  }//productReviewDelete
  //----------------------------------------------------------------------------------------//
  //리뷰사진 보기
  @GetMapping("/admin/productReview/imgpop/{imageFileName}")
  public String productReviewImgpop(@PathVariable("imageFileName") String imageFile, Model model) {
	  
	  model.addAttribute("imageFile",imageFile);
	  
	  return "admin/product_review_imgpop";
  }
  
  
  

}
