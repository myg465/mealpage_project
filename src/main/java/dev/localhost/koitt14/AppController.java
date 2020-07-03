package dev.localhost.koitt14;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dev.localhost.koitt14.customer.CustomerMapper;
import dev.localhost.koitt14.product.ProductMapper;
import dev.localhost.koitt14.product.ProductService;

@Controller
public class AppController {
	
  //상품서비스
  @Autowired
  private ProductService productService;
  
  //상품(매퍼 직접호출)
  @Autowired
  private ProductMapper productMapper;
  
  //고객센터(매퍼 직접호출)
  @Autowired
  private CustomerMapper customerMapper;
	
  @GetMapping("/")
  public String root (HttpSession session, Model model) {
	
	//배너얻기
	model.addAttribute("banner",productMapper.getBanner("main"));
	  
	//베스트 셀러 얻기
	model.addAttribute("best",productMapper.bestProduct());
	  
	//신상품얻기(1개)
	model.addAttribute("newProduct",productMapper.newProduct());
	
	//추천상품 얻기(2개)
	model.addAttribute("recommend",productMapper.recommendProduct());
	
	//세일상품 얻기(10개)
	model.addAttribute("nowSale",productMapper.saleProduct());
	
	//제품목록 얻기(5개)
	model.addAttribute("productList",productMapper.productSearch("","order by seq_key desc",1));
	
	//위시리스트 얻기
	productService.getWishList(session, model);
		
	//공지사항 얻기 (3개)
	model.addAttribute("noticeList",customerMapper.noticeList(1,3));
	  
	//nav 정보 (세션에 저장)
	productService.setNav(session);
    
	return "main/main";
  }

  @GetMapping("/intro")
  public String intro (HttpSession session, Model model) {
		return "main/intro";
	}
}
