package dev.localhost.koitt14.product;

import java.util.HashMap;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.localhost.koitt14.cart.CartService;
import dev.localhost.koitt14.cart.CartVo;
import dev.localhost.koitt14.productInquiry.ProductInquiryService;
import dev.localhost.koitt14.review.ReviewService;
import dev.localhost.koitt14.wishlist.WishlistService;
import dev.localhost.koitt14.wishlist.WishlistVo;

@Controller
public class ProductController {

    //상품서비스
    @Autowired
    private ProductService productService;
  
    //리뷰서비스
    @Autowired
    private ReviewService reviewService;
  
    //상품문의서비스
    @Autowired
    private ProductInquiryService productInquiryService;
    
    //회원카트서비스
    @Autowired
    private CartService cartService;
    
    //회원 위시리스트 서비스
    @Autowired
    private WishlistService wishlistService;
  
    //---------------------------------------------------------------------------------------//
	
    // getList(상품리스트 얻기)
    @GetMapping({"/product/{category1}/{category2}",
	  		     "/product/{category1}/{category2}/{page_}"})
    public String productList (@PathVariable("category1") String category1, 
		    @PathVariable("category2") String category2, 
		    @PathVariable Optional<Integer> page_, Model model, HttpSession session) {
	  
	  //page가 null이면 1을 치환하는 구문  
	  int page=page_.isPresent() ? page_.get() : 1;
	  productService.productList(category1,category2,page,model);
	  productService.getWishList(session,model);
	
      return "product/list";
    }//productList
    //---------------------------------------------------------------------------------------//
    // detail(상품상세페이지)
    @GetMapping("/product/detail/{seqKey}")
    public String detail (@PathVariable("seqKey") int seqKey, Model model) {
    	
	  productService.detail(model,seqKey);
	  //리뷰수,리뷰 별점 평균 얻기
	  reviewService.reviewListCount(model, seqKey);
	  reviewService.gradeAvg(model, seqKey);
	  //상품문의수 얻기
	  productInquiryService.inquiryListCount(model, seqKey);
	
	  return "product/detail";
    }//detail
    //---------------------------------------------------------------------------------------//
    //detailContent(상품 상세정보)
    @GetMapping("/product/detailContent/{seqKey}")
    public String detailContent (@PathVariable("seqKey") int seqKey, Model model) {
    	
  	  productService.detail(model,seqKey);
	
  	  return "product/detailContent";
    }//detailContent
    //---------------------------------------------------------------------------------------//
	//search(상품 검색)
	@GetMapping({"/product/search",
				"/product/search/{productSearch_}/{searchOrder_}",
				"/product/search/{productSearch_}/{searchOrder_}/{searchPage_}"})
	public String search (@PathVariable Optional<String> productSearch_, 
			@RequestParam(required = false, value = "productSearch") String productSearch, //검색조건(검색창에서 검색할경우와 페이징을 할때를 구분해서 받음)
			@PathVariable Optional<String> searchOrder_,  // 검색조건(정렬기준)
			@PathVariable Optional<Integer> searchPage_, Model model ) {
		
		//검색창에서 들어올때와 페이징을 할때를 구분
		String searchOrder=searchOrder_.isPresent() ? searchOrder_.get() : "hot";
		
		productSearch=productSearch_.isPresent() ? productSearch_.get() : productSearch;
		
		
		//searchPage가 null이면 1을 치환하는 구문  
		int searchPage=searchPage_.isPresent() ? searchPage_.get() : 1;
		productService.search(productSearch,searchOrder,searchPage, model);
		
		return "product/search";
	}//search
	//---------------------------------------------------------------------------------------//
	//relationProduct(연관상품)
	@GetMapping({"/product/relationProduct/{category1}/{category2}",
				 "/product/relationProduct/{category1}/{category2}/{page_}"})
	public String relationProduct (@PathVariable("category1") String category1, 
			@PathVariable("category2") String category2,
			@PathVariable Optional<Integer> page_, Model model) {
		
		//page가 null이면 1을 치환하는 구문
		int page=page_.isPresent() ? page_.get() : 1;
		productService.relationProduct(category1,category2,page,model);
		
		return "product/relationProduct";
		
	}//relationProduct
	//---------------------------------------------------------------------------------------//
    //productNotice(정책 및 공지)->화면만 뿌려줌
    @GetMapping("/product/productNotice/{seqKey}")
    public String productNotice (@PathVariable("seqKey") int seqKey) {
	  
	    return "product/productNotice";
	    
    }//productNotice
    //==================================제품 상세페이지 회원관련====================================//
    //---------------------------------------------------------------------------------------//
    //*** 회원 카트 추가 (임시)
    @PostMapping("/mypage/cartAdd")
    public String memberCartAdd(HttpServletRequest request,RedirectAttributes redirect,Model model) {
    	
    	int productKey=Integer.parseInt(request.getParameter("productKey"));
    	int quantity=Integer.parseInt(request.getParameter("quantity"));
    	
    	model.addAttribute("request",request);
    	CartVo cartVo = cartService.selectCartByProduct(productKey, model); //cartVo 객체를 하나 얻어옴
    	
    	if(cartVo!=null) { // 카트 객체가 이미 있으면
    		
    		cartService.updateCart(productKey, quantity);;
    		
    	}
    	else { // 신규추가
    		
    		cartService.insertCart(productKey, quantity, model);
    		
    	}
    	
    	redirect.addAttribute("productFlag", "mCart");
    	
    	return "redirect:/product/detail/"+productKey;
    }//memberCartAdd
    //---------------------------------------------------------------------------------------//
    //*** 회원 위시리스트 추가 (임시)
    @PostMapping("/mypage/wishlistAdd")
    public String wishlistAdd(HttpServletRequest request,RedirectAttributes redirect,Model model) {
    	
    	int productKey=Integer.parseInt(request.getParameter("productKey"));
    	int quantity=Integer.parseInt(request.getParameter("quantity"));
    	
    	model.addAttribute("request",request);
    	WishlistVo wishlistVo = wishlistService.selectWishlistByProduct(productKey, model); //WishListVo 객체를 하나 얻어옴
    	
    	if(wishlistVo!=null) { // 카트 객체가 이미 있으면
    		
    		wishlistService.updateWishlist(productKey, quantity);;
    		
    	}
    	else { // 신규추가
    		
    		wishlistService.insertWishlist(productKey, quantity, model);
    		
    	}
    	
    	redirect.addAttribute("productFlag", "mWishList");
    	
    	return "redirect:/product/detail/"+productKey;
    }//cartAdd
    //---------------------------------------------------------------------------------------//
    //*** 회원 바로구매 (임시)
    @ResponseBody
    @PostMapping("/mypage/buyNow")
    public HashMap<String, String> buyNow(@RequestBody HashMap<String, String> reqMap, 
    									  HttpServletRequest request, Model model) {
    	
    	HashMap<String, String> resMap = new HashMap<String, String>();
    	
    	int productKey=Integer.parseInt(reqMap.get("productKey")); 
    	int quantity=Integer.parseInt(reqMap.get("quantity"));
    	String cartSeqKey="";
    	model.addAttribute("request",request);
    	CartVo cartVo = cartService.selectCartByProduct(productKey, model); //cartVo 객체를 하나 얻어옴
    	
    	if(cartVo!=null) { // 카트 객체가 이미 있으면
    		
    		cartService.updateCart(productKey, quantity);
    		CartVo cartVoOld = cartService.selectCartByProduct(productKey, model);
    		cartSeqKey=cartVoOld.getSeqKey()+""; // 현재카트의 seqKey를 받아옴
    		
    	}
    	else { // 신규추가
    		
    		cartService.insertCart(productKey, quantity, model);
    		CartVo cartVoNew = cartService.selectCartByProduct(productKey, model);// 삽입후 카트vo를 다시얻어옴
    		cartSeqKey=cartVoNew.getSeqKey()+"";
    		
    	}
    	
    	resMap.put("result", "ok");
    	resMap.put("cartSeqKey",cartSeqKey);
    	
    	return resMap;
    }//cartAdd
  
  
  
}
