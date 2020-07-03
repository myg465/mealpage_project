
package dev.localhost.koitt14.nonmember;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.product.ProductService;
import dev.localhost.koitt14.product.ProductVo;

@SuppressWarnings("all")
@Service
public class NonmemberService {
    @Autowired
  	private NonmemberMapper nonmemberMapper;
    
    @Autowired
  	private ProductService productService;
    //---------------------------------------------------------------------------------------//
    //비회원 로그인
    public String nonmemberLogin(HashMap<String, String> reqMap,HttpSession session) {
    	
    	String nonmemberName=reqMap.get("nonmemberName");
    	String orderNumber=reqMap.get("orderNumber");
    	String result="";
    	
    	String loginResult=nonmemberMapper.nonmemberLogin(nonmemberName,orderNumber);
    	if(loginResult==null || loginResult=="") {
    		result="fail";
    	}
    	else {
    		session.setAttribute("nonmemberName", nonmemberName);
    		session.setAttribute("orderNumber", orderNumber);
    		result="pass";
    	}
    	
    	return result;
    }//nonmemberLogin
    //---------------------------------------------------------------------------------------//
    //==================================비회원 주문내역=========================================//
  	//---------------------------------------------------------------------------------------//
    //주문내역(개괄)
  	public void nonmemberOrderListTotal(Model model,HttpSession session) {
  		String nonmemberName=(String)session.getAttribute("nonmemberName");
  		String orderNumber=(String)session.getAttribute("orderNumber");
  		
  		// 전체 게시글 count(*)
  		int listCount = nonmemberMapper.getNonmemberOrderListCount(nonmemberName, orderNumber);
  		model.addAttribute("listCount", listCount);
  		
  		// total 가격
  		int totalPrice = nonmemberMapper.getTotalPrice(nonmemberName, orderNumber);
  		model.addAttribute("totalPrice", totalPrice);
  		
  		ArrayList<NonmemberOrderVo> list = nonmemberMapper.nonmemberOrderList(nonmemberName, orderNumber);
  		int listSize = list.size();
  		
  		model.addAttribute("listSize", listSize);
  		model.addAttribute("nonmemberOrderList", list);
  		
  		
  		int listStat = 0;
  		model.addAttribute("listStat", listStat);
  		
  	}//nonmemberOrderListTotal(오버로딩)
    //---------------------------------------------------------------------------------------//
  	//주문내역(상세)
	public void nonmemberOrderListAll(Model model, HttpSession session) {
		
		String nonmemberName=(String)session.getAttribute("nonmemberName");
  		String orderNumber=(String)session.getAttribute("orderNumber");
		int nowPage = Integer.parseInt(model.asMap().get("page").toString());
		int listStat = Integer.parseInt(model.asMap().get("listStat").toString());
		
		ArrayList<NonmemberOrderVo> list = null;
		int page, limit, startRow ;
		
		// 전체 게시글 count(*)
		int listCount = nonmemberMapper.getNonmemberOrderListCount(nonmemberName, orderNumber);
		
		// total 가격
  		int totalPrice = nonmemberMapper.getTotalPrice(nonmemberName, orderNumber);
		
		if(listStat == 0) {
			list = nonmemberMapper.nonmemberOrderList(nonmemberName, orderNumber);
		}//if
		else if(listStat == 1) {
			// 페이징
			page=1;	//최초기본 1페이지 셋팅
			limit=5; // 1page 당 게시글 수
			
			// 넘어온 page번호가 있다면 예) 현재 4페이지 => page=4;
			if(nowPage != 1) {
				page = nowPage;
			}
			startRow=productService.pageCal(listCount, limit, page, model);
			
			list = nonmemberMapper.nonmemberOrderListAll(nonmemberName, orderNumber, startRow, limit);
			//	ArrayList<NonmemberOrderVo> list = nonmemberMapper.nonmemberOrderList(nonmemberName, orderNumber);
		}//else if
		
		model.addAttribute("listCount", listCount);
		model.addAttribute("totalPrice", totalPrice);
		
		int listSize = list.size();
		
		model.addAttribute("listSize", listSize);
		model.addAttribute("nonmemberOrderList", list);
		
		model.addAttribute("nonmemberName", nonmemberName);
		model.addAttribute("orderNumber", orderNumber);
		model.addAttribute("listStat", listStat);
	}//nonmemberOrderListAll
	//---------------------------------------------------------------------------------------//
  	//주문내역 상세페이지
	public void nonmemberDeliveryView(int seqKey, Model model) {
		
		model.addAttribute("delivery",nonmemberMapper.nonmemberDeliveryView(seqKey)); 
		
	}//nonmemberDeliveryView
	//---------------------------------------------------------------------------------------//
	//==================================비회원 교환 반품=========================================//
	//---------------------------------------------------------------------------------------//
	//비회원 반품 등 신청(takebackWrite)
	public void takebackWrite(HttpServletRequest request, Model model) {
		
		int seqKey=Integer.parseInt(request.getParameter("seqKey")); // 주문 고유번호
		String category=request.getParameter("category"); //분류(반품,교환,환불,취소)
		String content=request.getParameter("content"); //사유
		int result1 = nonmemberMapper.orderStateChange(seqKey, category);
		int result2 = nonmemberMapper.takebackWrite(seqKey,content);
		if(result1+result2==2) {
			model.addAttribute("takebackWriteSuccess","ok");
		}
		
	}//takebackWrite
	//---------------------------------------------------------------------------------------//
	//교환 반품 내역(개괄) (takebackStateList)
	public void takebackStateList(Model model ,HttpSession session) {
		String orderNumber=(String)session.getAttribute("orderNumber");
		String nonmemberName=(String)session.getAttribute("nonmemberName");
		// 전체 게시글 count(*)
  		int takebackListCount = nonmemberMapper.TakebackStateListCount(orderNumber,nonmemberName);
  		model.addAttribute("takebackListCount", takebackListCount);
  		
  		// total 가격
  		int totalTakebackPrice = nonmemberMapper.totalTakebackPrice(orderNumber,nonmemberName);
  		model.addAttribute("totalTakebackPrice", totalTakebackPrice);
  		
  		model.addAttribute("takebackStateList", nonmemberMapper.takebackStateList(orderNumber,nonmemberName));
  		
  		int listStat = 0;
  		model.addAttribute("listStat", listStat);
	}//takebackStateList
	//---------------------------------------------------------------------------------------//
	//교환 반품 내역 (상세) (takebackStateListAll)
	public void takebackStateListAll(int nowPage,int listStat, Model model, HttpSession session) {
		
		String orderNumber=(String)session.getAttribute("orderNumber");
		String nonmemberName=(String)session.getAttribute("nonmemberName");
		
		int page=0;
		int limit;
		int startRow ;
		ArrayList<NonmemberOrderVo> list = null;
		
		// 전체 게시글 count(*)
		int listCount = nonmemberMapper.TakebackStateListCount(orderNumber,nonmemberName);
		
		if(listStat == 0) {
			list.add(nonmemberMapper.takebackStateList(orderNumber,nonmemberName));
		}//if
		else if(listStat == 1) {
			// 페이징
			page=1;	//최초기본 1페이지 셋팅
			limit=5; // 1page 당 게시글 수
			
			// 넘어온 page번호가 있다면 예) 현재 4페이지 => page=4;
			if(nowPage != 1) {
				page = nowPage;
			}
			startRow=productService.pageCal(listCount, limit, page, model);
			
			list = nonmemberMapper.takebackStateListAll(orderNumber,nonmemberName, startRow, limit);
			//	ArrayList<NonmemberOrderVo> list = nonmemberMapper.nonmemberOrderList(nonmemberName, orderNumber);
		}//else if
		
		model.addAttribute("listCount", listCount);
		model.addAttribute("page", page);
		
		int listSize = list.size();
		
		model.addAttribute("listSize", listSize);
		model.addAttribute("takebackStateListAll", list);
		
	}//nonmemberOrderListAll
	//---------------------------------------------------------------------------------------//
	//반품내역 상세페이지(nonmemberRefundView)
	public void nonmemberRefundView(int seqKey, Model model) {
		
//		int orderKey=0;
//		if(nonmemberMapper.getOrderKey(seqKey)!=null) {
//			orderKey=nonmemberMapper.getOrderKey(seqKey);
//		}
		
		model.addAttribute("refund",nonmemberMapper.nonmemberRefundView(seqKey));
		
	}//nonmemberRefundView
	//---------------------------------------------------------------------------------------//
	//반품 등 사유보기 (takebackReasonView)
	public void takebackReasonView(int seqKey, Model model) {
		
		model.addAttribute("takebackReasonView", nonmemberMapper.takebackReasonView(seqKey)); 
		
	}//takebackReasonView
	//---------------------------------------------------------------------------------------//
	//반품등 사유수정 (takebackReasonModify)
	public void takebackReasonModify(HttpServletRequest request, Model model) {
		
		int seqKey=Integer.parseInt(request.getParameter("seqKey"));
		String content=request.getParameter("Modifycontent");
		
		model.addAttribute("reasonModifySuccess",nonmemberMapper.takebackReasonModify(seqKey,content));
		
	}//takebackReasonModify
	//---------------------------------------------------------------------------------------//
	//==================================비회원 장바구니=========================================//
	//---------------------------------------------------------------------------------------//
	//비회원 카트 추가(nonmemberCartAdd)
	public void nonmemberCartAdd(HttpServletRequest request, HttpSession session) {
		
		int productKey=Integer.parseInt(request.getParameter("productKey"));
		int quantity=Integer.parseInt(request.getParameter("quantity"));
		
	  	//세션 설정
	  	ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList");
	  	ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");
	    // productList 속성명이 없을 경우 새로 만듬
	  	if(productKeyList == null) {
	      // ArrayList 객체를 생성하여 setAttribute로 해당 속성에 list값을 지정
	  		productKeyList = new ArrayList();
	  		quantityList = new ArrayList();
	  		session.setAttribute("productKeyList", productKeyList);
	  		session.setAttribute("quantityList", quantityList);
	  	}
	  	else {
	  		
	  		for(int i=0;i<productKeyList.size();i++) {
	  			int pKey=(Integer)productKeyList.get(i);
	  			//같은상품이 들어올 경우
	  			if(pKey==productKey) {
	  				quantityList.set(i, ((Integer)quantityList.get(i))+quantity);
	  				return; // 수량만 증가시키고 바로 리턴
	  			}//if
	  		}//for
	  	}//else
	  	productKeyList.add(productKey);
	  	quantityList.add(quantity);
		   
	}//nonmemberCartAdd
	//---------------------------------------------------------------------------------------//
	//비회원 장바구니 목록 불러오기(nonmemberCartList)
	public void nonmemberCartList(HttpSession session, Model model) {
		
		ArrayList<ProductVo>productList=new ArrayList<ProductVo>(); //어레이리스트 선언(제품정보를 담는)
		
    	ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList"); //세션의 제품키리스트를 받아옴
    	ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");//세션의 수량 리스트를 받아옴
    	if(productKeyList==null && quantityList==null) {
    		return;
    	}
    	for(int i=0;i<productKeyList.size();i++) {
    		int productKey=(Integer)productKeyList.get(i);
    		ProductVo pVo=productService.getDetail(productKey);
    		productList.add(pVo);
    	}
    	model.addAttribute("productList",productList);
    	model.addAttribute("quantityList",quantityList);
	}//nonmemberCartList 
	//---------------------------------------------------------------------------------------//
	//비회원 장바구니 목록 중 한개삭제(nonmemberCartDel)
	public String nonmemberCartDel(HashMap<String, String> reqMap,HttpSession session) {
		
		int index=Integer.parseInt(reqMap.get("index"));
		ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList");
		ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");
		productKeyList.remove(index);
		quantityList.remove(index);
		
		return "ok";
	}//nonmemberCartDel
	//---------------------------------------------------------------------------------------//
	//수량수정(quantityModify)
	public String quantityModify(HashMap<String, String> reqMap,HttpSession session) {
		
		int quantity=Integer.parseInt(reqMap.get("quantity"));
		int num=Integer.parseInt(reqMap.get("num"));
		
		ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");
		quantityList.set(num, quantity);
		
		return "ok";
	}//quantityModify
	//---------------------------------------------------------------------------------------//
	//바로구매(buyNow)
	public String buyNow(HashMap<String, String> reqMap, HttpSession session) {
		
		int index=Integer.parseInt(reqMap.get("index")); // 인덱스를 받아온다.
		ArrayList<Integer> buyList = (ArrayList<Integer>)session.getAttribute("buyList"); // 인덱스를 담을 리스트 선언
		buyList=new ArrayList();
		session.setAttribute("buyList", buyList); //리스트를 세션에 담는다.
		buyList.add(index);
		
		return "ok";
	}//buyNow
	//---------------------------------------------------------------------------------------//
    //여러가지구매(orderCart)
	public void orderCart(HttpServletRequest request, HttpSession session) {
		
		
		ArrayList<Integer> buyList = (ArrayList<Integer>)session.getAttribute("buyList");
		buyList=new ArrayList();
		session.setAttribute("buyList", buyList);
		String[] cartList = request.getParameterValues("chk");
		for(int i=0;i<cartList.length;i++) {
			buyList.add(Integer.parseInt(cartList[i]));
		}
	}//orderCart
	//---------------------------------------------------------------------------------------//
	//=======================================결제=============================================//
	//---------------------------------------------------------------------------------------//
	//상세페이지에서 바로구매(detailBuyNow)
	public String detailBuyNow(HashMap<String, String> reqMap, HttpSession session) {
		
		int productKey=Integer.parseInt(reqMap.get("productKey"));//상품코드
		int quantity=Integer.parseInt(reqMap.get("quantity")); // 수량
		ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList");
	  	ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");
	  	ArrayList<Integer> buyList = (ArrayList<Integer>)session.getAttribute("buyList");
	    // productList 속성명이 없을 경우 새로 만듬
	  	if(productKeyList == null) {
	      // ArrayList 객체를 생성하여 setAttribute로 해당 속성에 list값을 지정
	  		productKeyList = new ArrayList();
	  		quantityList = new ArrayList();
	  		session.setAttribute("productKeyList", productKeyList);
	  		session.setAttribute("quantityList", quantityList);
	  	}
	  	buyList=new ArrayList();// buyList는 따로 새로선언
	  	session.setAttribute("buyList", buyList);
	  	
	  	productKeyList.add(productKey);
	  	quantityList.add(quantity);
	  	int index=productKeyList.size()-1;
	  	buyList.add(index);
		
		return "ok";
	}//detailBuyNow
	//---------------------------------------------------------------------------------------//
    //결제페이지(nonmemberPayment)
	public void nonmemberPayment(HttpSession session,Model model) {
		
		ArrayList<ProductVo>productList=new ArrayList<ProductVo>(); //어레이리스트 선언(제품정보를 담는)
		ArrayList<Integer>paymentQuantity=new ArrayList<Integer>(); //어레이리스트 선언(수량을 담는)
		
    	ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList"); //세션의 제품키리스트를 받아옴
    	ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");//세션의 수량 리스트를 받아옴
    	ArrayList<Integer> buyList = (ArrayList<Integer>)session.getAttribute("buyList");
    	
    	for(int i=0;i<productKeyList.size();i++) {
    		for(int j=0;j<buyList.size();j++) {
    			if(i==buyList.get(j)) { //인덱스와 같으면
    				paymentQuantity.add(quantityList.get(i));
    				int productKey=(Integer)productKeyList.get(i);
    				ProductVo pVo=productService.getDetail(productKey);
    				productList.add(pVo);
    			}
    			
    		}
    	}
    	model.addAttribute("productList",productList);
    	model.addAttribute("quantity",paymentQuantity);
	}//nonmemberPayment
	//====================================관리자 전용==========================================//
	//adminNonmemberOrderListAll(주문내역 얻어오기)
	public void adminNonmemberOrderListAll(Model model, int orderPage, String order, String search) {
			String sqlOrder="";
			//정렬값 분기
			switch(order) {
				case "order_number" :
					sqlOrder="ORDER BY o."+order+" DESC";
					int limit=10;//1페이지 = 게시글10개
					int orderListCount = nonmemberMapper.orderListSearchCount(search);
					//페이지수 계산(메소드 재활용)
					int orderStartRow=ProductService.pageCal(orderListCount, limit, orderPage, model);
					
					//화면에 뿌려지는 변수
					model.addAttribute("allCount", orderListCount);
				    model.addAttribute("orderList", nonmemberMapper.orderListAll(orderStartRow,search,sqlOrder));
				    model.addAttribute("search",search);
				    model.addAttribute("order",order);
					return;
				case "product_name" :
					sqlOrder="ORDER BY o."+order+" ASC";
					break;
				case "status" :
					sqlOrder="ORDER BY p."+order+" ASC";
					break;
			}
			
			int limit=10;//1페이지 = 게시글10개
			int orderListCount = nonmemberMapper.orderListSearchCount(search);
			//페이지수 계산(메소드 재활용)
			int orderStartRow=ProductService.pageCal(orderListCount, limit, orderPage, model);
			
			
			//화면에 뿌려지는 변수
			model.addAttribute("allCount", orderListCount);
		    model.addAttribute("orderList", nonmemberMapper.orderListAll(orderStartRow,search,sqlOrder));
		    model.addAttribute("search",search);
		    model.addAttribute("order",order);
	  
	}//productListAll
	//---------------------------------------------------------------------------------------//
	//비회원 주문 갯수 구하기
	public int nonmemberOrderCount(String search) {
		return nonmemberMapper.orderStateSearchCount(search);
	}//nonmemberOrderCount
	//---------------------------------------------------------------------------------------//
	//반품 등 사유 답변달기(adminReplyWrite)
	public void adminReplyWrite(HttpServletRequest request, Model model) {
		
		int seqKey=Integer.parseInt(request.getParameter("seqKey"));
		String reply=request.getParameter("reply");
		model.addAttribute("reasonSuccess",nonmemberMapper.reasonReplyWrite(reply,seqKey)); 
	}//adminReplyWrite
	//---------------------------------------------------------------------------------------//
	//반품 등 사유 답변수정(adminReplyModify)
	public void adminReplyModify(HttpServletRequest request, Model model) {
		
		int seqKey=Integer.parseInt(request.getParameter("seqKey"));
		String replyModify=request.getParameter("replyModify");
		model.addAttribute("reasonSuccess",nonmemberMapper.reasonReplyModify(replyModify,seqKey)); 
	}//adminReplyModify
	
  	  
}
