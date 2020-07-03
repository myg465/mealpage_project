package dev.localhost.koitt14.admin;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.localhost.koitt14.product.ProductMapper;
import dev.localhost.koitt14.product.ProductService;

@Controller
public class AdminController_Banner {

	//상품서비스
	@Autowired
	private ProductService productService;
	//상품매퍼(직접호출)
	@Autowired
	private ProductMapper productMapper;
	//----------------------------------------------------------------------------------------------------//
	//배너 리스트 얻기(bannerList)
	@GetMapping("/admin/banner")
	public String bannerList(Model model) {
		
		model.addAttribute("nav1",productMapper.navCategory1());
		model.addAttribute("navList",productMapper.getBannerList());
		
		return "admin/banner";
	}//bannerList
	//----------------------------------------------------------------------------------------------------//
	//배너등록
	@PostMapping("/admin/banner/insert")
	public String bannerInsert(HttpServletRequest request, RedirectAttributes redirect) {
		
		productService.bannerInsert(request,redirect);
		
		return "redirect:/admin/banner";
	}//bannerInsert
	//----------------------------------------------------------------------------------------------------//
	//배너수정뷰
	@GetMapping("/admin/banner/modifyView/{seqKey}")
	public String bannerModifyView(@PathVariable("seqKey")int seqKey, Model model) {
		
		model.addAttribute("nav1",productMapper.navCategory1());
		model.addAttribute("bannerModify",productMapper.bannerModifyView(seqKey));
		
		return "admin/banner_modify";
	}//bannerModifyView
	//----------------------------------------------------------------------------------------------------//
	//배너수정(bannerModify)
	@PostMapping("/admin/banner/modify")
	public String bannerModify(HttpServletRequest request, Model model) {
		
		productService.bannerModify(request,model);
		
		return "admin/banner_modify";
	}//bannerModify
	//----------------------------------------------------------------------------------------------------//
	//배너삭제(bannerDelete)
	@ResponseBody
	@PostMapping("/admin/banner/delete")
	public HashMap<String, String> bannerDelete(@RequestBody HashMap<String, String> reqMap, HttpServletRequest request){
		 
		  HashMap<String, String> resMap = new HashMap<String, String>();
		  resMap.put("result", productService.bannerDelete(reqMap,request));
		  
		  return resMap;
	}//bannerDelete
	
	
}
