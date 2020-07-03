package dev.localhost.koitt14.productInquiry;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class ProductInquiryController {

  //상품문의서비스
  @Autowired
  private ProductInquiryService productInquiryService;
  
  //---------------------------------------------------------------------------------------//

  //productInquiryList(상품문의리스트 얻기)
  @GetMapping({"/productInquiry/inquiryList/{seqKey}","/productInquiry/inquiryList/{seqKey}/{inquiryPage_}"})
  public String productInquiryList (@PathVariable("seqKey") int seqKey,
  @PathVariable Optional<Integer> inquiryPage_, Model model) {
	  
	  int inquiryPage=inquiryPage_.isPresent() ? inquiryPage_.get() : 1;
	  productInquiryService.productInquiryList(model, seqKey, inquiryPage);
	  
	  return "/productInquiry/inquiryList";
  }//productInquiryList
  //---------------------------------------------------------------------------------------//
  //inpuiryWriteView(상품문의 작성페이지 불러오기)
  @GetMapping("/productInquiry/inquiryWriteView/{seqKey}")
  public String inquiryWriteView (@PathVariable("seqKey") int seqKey, Model model) {
	  
	  model.addAttribute("seqKey",seqKey);
	  
	  return "/productInquiry/inquiryWriteView";
  }//inquiryWriteView
  //---------------------------------------------------------------------------------------//
  //inquiryWrite(상품문의 작성하기)
  @PostMapping("/productInquiry/inquiryWrite")
  public String inquiryWrite (HttpServletRequest request, Model model) {
	  
	  productInquiryService.inquiryWrite(request, model);
	  
	  return "/productInquiry/inquiryWriteView";
  }//inquiryWrite
  //---------------------------------------------------------------------------------------//
  //inquiryModifyView(상품문의 수정페이지)
  @GetMapping("/productInquiry/inquiryModifyView/{seqKey}")
  public String inquiryModifyView (@PathVariable("seqKey") int seqKey, Model model) {
	  
	  productInquiryService.inquiryModifyView(seqKey,model);
	  
	  return "productInquiry/inquiryModifyView";
  }//inquiryModifyView
  //---------------------------------------------------------------------------------------//
  //inquiryModify(상품문의 수정)
  @PostMapping("/productInquiry/inquiryModify")
  public String inquiryModify (HttpServletRequest request, Model model) {
	  
	  productInquiryService.inquiryModify(request,model);
	  
	  return "productInquiry/inquiryModifyView";
  }
  
  
  //---------------------------------------------------------------------------------------//
  //inquiryDelete(상품문의 삭제하기)
  @GetMapping("/productInquiry/inquiryDelete/{productKey}/{seqKey}")
  public String inquiryDelete (@PathVariable("productKey") int productKey,
		  @PathVariable("seqKey") int seqKey ) {
	  
	  productInquiryService.inquiryDelete(seqKey);
	  
	  return "redirect:/productInquiry/inquiryList/"+productKey;
  }
  
  

  
  
}
