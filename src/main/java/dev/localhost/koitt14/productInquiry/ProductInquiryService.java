package dev.localhost.koitt14.productInquiry;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.product.ProductService;


@Service
public class ProductInquiryService {
	
    @Autowired
    private ProductInquiryMapper productInquiryMapper;
  	
    //productInquiryList(상품문의 리스트 얻어오기)
    public void productInquiryList(Model model, int seqKey, int inquiryPage) {
		  
		int limit=5;//1페이지 = 게시글5개
		//전체게시글 카운트
		int inquiryListCount = productInquiryMapper.inquiryListCount(seqKey);
		//페이지수 계산(메소드 재활용)
		int inquiryStartRow=ProductService.pageCal(inquiryListCount, limit, inquiryPage, model);
		
		model.addAttribute("productKey", seqKey);
		
		//화면에 뿌려지는 변수
	    model.addAttribute("productInquiryList", productInquiryMapper.productInquiryList(seqKey,inquiryStartRow));
    
   }//productInquiryList
   //---------------------------------------------------------------------------------------//
   //inquiryListCount(상품문의갯수 얻어오기)
    public void inquiryListCount(Model model, int seqKey) {
    	model.addAttribute("inquiryListCount",productInquiryMapper.inquiryListCount(seqKey));
   }//inquiryListCount
   //---------------------------------------------------------------------------------------//
   //inquiryWrite(상품문의 작성)
    public void inquiryWrite(HttpServletRequest request, Model model) {
    	
    	int accountKey=Integer.parseInt(request.getParameter("accountKey"));
    	int productKey=Integer.parseInt(request.getParameter("productKey"));
    	String secret=request.getParameter("secret");
    	String content=request.getParameter("content");
    	
    	model.addAttribute("inquirySuccess",
    	productInquiryMapper.inquiryWrite(accountKey, productKey, secret, content));
    	
    }//inquiryWrite
    
    //---------------------------------------------------------------------------------------//
    //inquiryModifyView(상품문의 수정 뷰)
    public void inquiryModifyView(int seqKey, Model model) {
    	
    	model.addAttribute("inquiryModifyView",productInquiryMapper.inquiryModifyView(seqKey));
    	
    }//inquiryModifyView
    //---------------------------------------------------------------------------------------//
    //inquiryModify(상품문의 수정)
    public void inquiryModify(HttpServletRequest request, Model model) {
    	
    	int seqKey=Integer.parseInt(request.getParameter("seqKey"));
    	String secret=request.getParameter("secret");
    	String content=request.getParameter("content"); 
    	model.addAttribute("modifySuccess",productInquiryMapper.inquiryModify(seqKey,secret,content));
    	
    }//inquiryModifyView
    //---------------------------------------------------------------------------------------//
    //inquiryDelete(상품문의삭제)
    public void inquiryDelete(int seqKey) {
    	
    	productInquiryMapper.inquiryDelete(seqKey);
    	
    }//inquiryDelete
    //=================================관리자 전용============================================//
    //inquiryListAll(상품문의전체 얻어오기)
    public void inquiryListAll(Model model, int reviewPage, String order, String search) {
		String sqlOrder="";
		//정렬값 분기
		switch(order) {
			case "name" :
				sqlOrder="ORDER BY p."+order+" ASC";
				int limit=10;//1페이지 = 게시글10개
				int inquiryListCount = productInquiryMapper.inquiryListSearchCount(search);
				//페이지수 계산(메소드 재활용)
				int inquiryStartRow=ProductService.pageCal(inquiryListCount, limit, reviewPage, model);
				
				
				//화면에 뿌려지는 변수
				model.addAttribute("allCount", inquiryListCount);
			    model.addAttribute("inquiryList", productInquiryMapper.inquiryListAll(inquiryStartRow,search,sqlOrder));
			    model.addAttribute("search",search);
			    model.addAttribute("order",order);
				return;
			case "replyYes" :
				sqlOrder="ORDER BY i.reply ASC";
				break;
			case "created_date" :
				sqlOrder="ORDER BY i."+order+" DESC";
				break;
		}
		
		int limit=10;//1페이지 = 게시글10개
		int inquiryListCount = productInquiryMapper.inquiryListSearchCount(search);
		//페이지수 계산(메소드 재활용)
		int inquiryStartRow=ProductService.pageCal(inquiryListCount, limit, reviewPage, model);
		
		
		//화면에 뿌려지는 변수
		model.addAttribute("allCount", inquiryListCount);
	    model.addAttribute("inquiryList", productInquiryMapper.inquiryListAll(inquiryStartRow,search,sqlOrder));
	    model.addAttribute("search",search);
	    model.addAttribute("order",order);
    
   }//inquiryListAll
   //---------------------------------------------------------------------------------------//
   //replyInsert(상품문의 답변달기)
    public void replyInsert(HttpServletRequest request, Model model) {
    	
    	int seqKey=Integer.parseInt(request.getParameter("seqKey"));
    	String replyContent=request.getParameter("replyContent");
    	
    	model.addAttribute("replyInsertSuccess",productInquiryMapper.replyInsert(seqKey,replyContent));
    }//replyInsert
    //---------------------------------------------------------------------------------------//
    //replyInsert(상품문의 답변수정)
     public void replyModify(HttpServletRequest request, Model model) {
     	
    	int seqKey=Integer.parseInt(request.getParameter("seqKey"));
     	String replyModify=request.getParameter("replyModify");
     	
     	model.addAttribute("replyModifySuccess",productInquiryMapper.replyModify(seqKey,replyModify));
     	
     }//replyInsert
     //---------------------------------------------------------------------------------------//
     //(상품문의 수정 뷰)
     public int inquiryCount(String status) {
     	
     	return productInquiryMapper.inquiryCount(status);
     	
     }//inquiryModifyView
    
    

  
}
