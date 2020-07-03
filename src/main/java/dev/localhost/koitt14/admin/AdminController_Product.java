package dev.localhost.koitt14.admin;

import java.util.HashMap;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dev.localhost.koitt14.product.ProductMapper;
import dev.localhost.koitt14.product.ProductService;

@Controller
public class AdminController_Product {

	  //상품서비스
	  @Autowired
	  ProductService productService;
	  
	  //상품매퍼(직접호출)
	  @Autowired
	  ProductMapper productMapper;
	  
	  //---------------------------------------------------------------------------------------//
	  //상품 관리
	  @GetMapping({"/admin/product",
	  			  "/admin/product/{search_}/{order_}",
	  			  "/admin/product/{search_}/{order_}/{productPage_}"})
	  public String productReview(@PathVariable Optional<Integer> productPage_,
			  					  @PathVariable Optional<String> order_,
			  					  @PathVariable Optional<String> search_,
			  					  @RequestParam(required = false, value = "searchtext") String search,
			  					  Model model) {
		  
		  search=search_.isPresent() ? search_.get() : search;
		  if(search==null) search="All";
		  int productPage=productPage_.isPresent() ? productPage_.get() : 1;
		  String order=order_.isPresent() ? order_.get() : "name";
		  
		  
		  productService.productListAll(model, productPage, order, search);
		  
		  return "admin/product";
		  
	  }//productReview
	  //---------------------------------------------------------------------------------------//
	  //상품사진 보기
	  @GetMapping("/admin/product/imgpop/{imageFileName}")
	  public String productReviewImgpop(@PathVariable("imageFileName") String imageFileName, Model model) {
		  
		  model.addAttribute("imageFile",imageFileName);
		  
		  return "admin/product_imgpop";
	  }//productReviewImgpop
	  //---------------------------------------------------------------------------------------//
	  //상품등록페이지
	  @GetMapping("/admin/product/insertView")
	  public String productInsertView(Model model) {
		  
		  //카테고리
		  model.addAttribute("navNum",productMapper.navNum());
		  String[]nav1=productMapper.navCategory1();
		  model.addAttribute("nav1",nav1);
		  model.addAttribute("nav2",productMapper.navCategory2(nav1[0]));
		  
		  
		  return "admin/product_insert";
	  }//productInsertView
	  //---------------------------------------------------------------------------------------//
	  //상품등록
	  @PostMapping("/admin/product/insert")
	  public String productInsert(HttpServletRequest request, Model model) {
		  
		  productService.productInsert(request,model);
		  
		  return "admin/product_insert";
	  }//productInsert
	  //---------------------------------------------------------------------------------------//
	  //상품수정뷰
	  @GetMapping("/admin/product/modifyView/{seqKey}")
	  public String productModifyView(@PathVariable("seqKey") int seqKey, Model model) {
		  
		  //카테고리
		  model.addAttribute("navNum",productMapper.navNum());
		  String[]nav1=productMapper.navCategory1();
		  model.addAttribute("nav1",nav1);
		  model.addAttribute("nav2",productMapper.navCategory2(nav1[0]));
		  
		  model.addAttribute("productModify",productMapper.detail(seqKey));
		  
		  return "admin/product_modify";
	  }//productModifyView
	  //---------------------------------------------------------------------------------------//
	  //상품수정
	  @PostMapping("/admin/product/modify")
	  public String productModify(HttpServletRequest request, Model model) {
		  
		  productService.productModify(request,model);
		  
		  return "admin/product_modify";
	  }//productModify
	  //---------------------------------------------------------------------------------------//
	  //상품삭제
	  @ResponseBody
	  @PostMapping("/admin/product/delete")
	  public HashMap<String, String> productDelete(@RequestBody HashMap<String, String> reqMap, HttpServletRequest request){
		 
		  HashMap<String, String> resMap = new HashMap<String, String>();
		  resMap.put("result", productService.productDelete(reqMap,request));
		  
		  return resMap;
	  }//productDelete
	  
	
}//class
