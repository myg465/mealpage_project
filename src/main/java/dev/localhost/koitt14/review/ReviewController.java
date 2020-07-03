package dev.localhost.koitt14.review;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class ReviewController {

  //리뷰서비스
  @Autowired
  private ReviewService reviewService;
	
  //리뷰전체 가져오기
  @GetMapping({"/review/reviewList/{seqKey}",
	  		   "/review/reviewList/{seqKey}/{reviewPage_}"})
  public String reviewList(@PathVariable("seqKey") int seqKey, 
		  @PathVariable Optional<Integer> reviewPage_, Model model) {
	  
	  int reviewPage=reviewPage_.isPresent() ? reviewPage_.get() : 1;
	  reviewService.reviewList(model, seqKey, reviewPage);
	  
	  return "review/reviewList";
  }//reviewList
  //---------------------------------------------------------------------------------------//
  //reviewImageView(리뷰사진 보기)
  @GetMapping("/review/reviewImageView/{imageFileName}")
  public String reviewImageView(@PathVariable("imageFileName") String imageFileName, Model model) {
	  
	  model.addAttribute("imageFileName",imageFileName);
	  
	  return "/review/reviewImageView";
  }//reviewImageView
  //---------------------------------------------------------------------------------------//
  // reviewWriteView(리뷰작성페이지 불러오기)
  @GetMapping("review/reviewWriteView/{productKey}/{seqKey}")
  public String reviewWriteView(@PathVariable("productKey") int productKey,
		  					    @PathVariable("seqKey") int seqKey, HttpSession session, Model model) {
	  
	  reviewService.status(seqKey, productKey, session, model);
	  model.addAttribute("productKey",productKey);
	  
	  return "/review/reviewWriteView";
  }//reviewWriteView
  //---------------------------------------------------------------------------------------//
  //reviewWrite(리뷰작성)
  @PostMapping("/review/reviewWrite")
  public String reviewWrite(HttpServletRequest request, Model model){
	  
	  reviewService.reviewWrite(request, model);
	  
	  return "/review/reviewWriteView";
  }//reviewWrite
  //---------------------------------------------------------------------------------------//
  //reviewModifyView(리뷰수정 페이지 불러오기)
  @GetMapping("/review/reviewModifyView/{seqKey}")
  public String reviewModifyView(@PathVariable("seqKey") int seqKey, Model model) {
	  
	  reviewService.reviewModifyView(seqKey,model);
	  
	  return "/review/reviewModifyView";
  }//reviewModifyView
  //---------------------------------------------------------------------------------------//
  //reviewModify(리뷰수정)
  @PostMapping("/review/reviewModify")
  public String reviewModify(HttpServletRequest request, Model model) {
	  
	  reviewService.reviewModify(request,model);
	  
	  return "/review/reviewModifyView";
  }//reviewModify
  //---------------------------------------------------------------------------------------//
  //reviewDelete(리뷰삭제)
  @GetMapping({"/review/reviewDelete/{productKey}/{seqKey}",
    		   "/review/reviewDelete/{productKey}/{seqKey}/{imageFileName_}"})
  public String reviewDelete(@PathVariable("productKey") int productKey, @PathVariable("seqKey") int seqKey,
		  @PathVariable Optional<String> imageFileName_, HttpServletRequest request) {
	  
	  String imageFileName=imageFileName_.isPresent() ? imageFileName_.get() : "n";
	  reviewService.reviewDelete(seqKey,imageFileName,request);
	  
	  return "redirect:/review/reviewList/"+productKey;
  }//reviewDelete
  
  
  
  
}
