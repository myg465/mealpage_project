package dev.localhost.koitt14.nonmemberPayment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.nonmember.NonmemberMapper;
import dev.localhost.koitt14.payment.PaymentVo;
import dev.localhost.koitt14.product.ProductMapper;
import dev.localhost.koitt14.product.ProductVo;
@SuppressWarnings("all")
@Service
public class NonmemberPaymentService {

  //비회원 매퍼
  @Autowired
  private NonmemberMapper nonmemberMapper;
  //비회원페이 매퍼
  @Autowired
  private NonmemberPaymentMapper nonPaymentMapper;
  //상품매퍼
  @Autowired
  private ProductMapper productMapper;
  
  //-----------------------------------------------------------------------------------//
  //주문입력
  public void insertNonmemberOrder(Model model, HttpSession session) {
	  
    ArrayList<ProductVo>productList=new ArrayList<ProductVo>(); //어레이리스트 선언(제품정보를 담는)
    ArrayList<Integer>paymentQuantity=new ArrayList<Integer>(); //어레이리스트 선언(수량을 담는)
  
    ArrayList<Integer> productKeyList = (ArrayList<Integer>)session.getAttribute("productKeyList"); //세션의 제품키리스트를 받아옴
    ArrayList<Integer> quantityList = (ArrayList<Integer>)session.getAttribute("quantityList");//세션의 수량 리스트를 받아옴
    ArrayList<Integer> buyList = (ArrayList<Integer>)session.getAttribute("buyList"); //세션 - 주문리스트
    //재고수량 체크
    int stockCheckCount=0;
    for(int i=buyList.size()-1;i>=0;i--) {
		int buyli=buyList.get(i);
		int productKey=(Integer)productKeyList.get(buyli);
		int quantity=(Integer)quantityList.get(buyli);
		if(quantity>productMapper.stockCheck(productKey)) {
			stockCheckCount++;
		}
    }
    //재고수량 체크 통과
    if(stockCheckCount==0) {
		HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
		int paymentKey = paymentInsert(request);
	    // 주문번호 생성
	    LocalDateTime time = LocalDateTime.now();
	    DateTimeFormatter timeFormat1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String today = time.format(timeFormat1);
	    DateTimeFormatter timeFormat2 = DateTimeFormatter.ofPattern("yyyyMMdd");
	    String todayNum = time.format(timeFormat2);
	
	    int count = nonPaymentMapper.getOrderCount(today + "%") + 1001; // 몇번째주문인지 구한다.
	    String orderNumber = todayNum + "-" + count;
	
	    // DB 삽입
	    PaymentVo paymentVo = nonPaymentMapper.getPayment(paymentKey);
	    String status = paymentVo.getStatus();
	    String nonmemberName = request.getParameter("name");
	
		for(int i=buyList.size()-1;i>=0;i--) {
			int buyli=buyList.get(i);
			int productKey=(Integer)productKeyList.get(buyli);
			int quantity=(Integer)quantityList.get(buyli);
			paymentQuantity.add(quantity);
			ProductVo pVo=productMapper.detail(productKey);
			productList.add(pVo);
			int productPrice=pVo.getPrice();
			String productName=pVo.getName();
			//주문입력
			nonPaymentMapper.insertNonmemberOrder(nonmemberName, orderNumber, productName, productPrice, quantity, status, productKey, paymentKey);
			//장바구니에서 삭제
			productKeyList.remove(buyli);
			quantityList.remove(buyli);
			//상품에서 재고량 감소
			productMapper.stockDown(quantity, productKey);
		}
	    model.addAttribute("orderList", productList);
	    model.addAttribute("quantity",paymentQuantity);
	    model.addAttribute("paymentVo", paymentVo);
	    model.addAttribute("orderNumber", orderNumber);
	    model.addAttribute("today", today);
	    
    }
    //재고수량 체크 미통과
    else {
    	model.addAttribute("payCheck","fail");
    }
  }//insertNonmemberOrder
  //-----------------------------------------------------------------------------------//
  //결제입력
  public int paymentInsert(HttpServletRequest request) {
	  
	String ordererName = request.getParameter("name");
    String ordererAddressZipcode = request.getParameter("zipcode");    
    String ordererAddressNew = request.getParameter("roadAddress");
    String ordererAddressOld = request.getParameter("jibunAddress");
    String ordererAddressDetail = request.getParameter("detailAddress");
    String ordererAddressExtra = request.getParameter("extraAddress");
    String ordererEmail = request.getParameter("email");
    String ordererPhone = request.getParameter("phone");

    String recipientName = request.getParameter("destName");
    String recipientAddressZipcode = request.getParameter("destZipcode");    
    String recipientAddressNew = request.getParameter("destRoadAddress");
    String recipientAddressOld = request.getParameter("destJibunAddress");
    String recipientAddressDetail = request.getParameter("destDetailAddress");
    String recipientAddressExtra = request.getParameter("destExtraAddress");
    String recipientPhone = request.getParameter("destPhone");
    String recipientRequest = request.getParameter("destRequest");
    
    int amountTotal = Integer.parseInt(request.getParameter("totalPrice"));
    int amountDelivery = Integer.parseInt(request.getParameter("deliveryFee"));
    
    String method = request.getParameter("method");
    
    // finalAmount
    int amountFinal = Integer.parseInt(request.getParameter("finalAmount"));

    String status = "입금대기";
    String detail = "카카오뱅크 3333-16-4743882 김우혁";
    nonPaymentMapper.insertNonmemberPayment(
    	ordererName,ordererAddressZipcode,ordererAddressNew,ordererAddressOld,ordererAddressDetail,ordererAddressExtra,
    	ordererEmail,ordererPhone,recipientName,recipientAddressZipcode,recipientAddressNew,recipientAddressOld,
    	recipientAddressDetail,recipientAddressExtra,recipientPhone,recipientRequest,amountTotal,amountDelivery,
    	amountFinal,method,detail,status
      );

      return nonPaymentMapper.getNonmemberKey(ordererPhone);
	  
  }//paymentInsert
  //===================================관리자 전용========================================//
  //-----------------------------------------------------------------------------------//
  //결제정보 전체얻기
  public void paymentDetail(String orderNumber, Model model) {
	  
	  model.addAttribute("payment",nonPaymentMapper.getAdminPayment(orderNumber));
	  
  }//paymentDetail
  //-----------------------------------------------------------------------------------//
  //입금확인
  public String depositOk(HashMap<String, String> reqMap) {
	  
	  String orderNumber=reqMap.get("orderNumber");
	  if(nonPaymentMapper.depositOk(orderNumber)>0 && nonPaymentMapper.payDepositOk(orderNumber)==1) {
		  return "ok";
	  }
	  
	  return "no";
  }//depositOk
  //-----------------------------------------------------------------------------------//
  //일괄배송
  public void deliveryAll(HttpServletRequest request, Model model) {
	  
	  String status="배송중";
	  String orderNumber=request.getParameter("orderNumber");
	  String deliveryCompany=request.getParameter("deliveryCompany");
	  String trackingNumber=request.getParameter("trackingNumber");
	  
	  model.addAttribute("deliSuccess",nonPaymentMapper.deliveryAll(orderNumber, status, deliveryCompany, trackingNumber)); 
	  
  }//deliveryAll
  //-----------------------------------------------------------------------------------//
  //개별배송처리
  public void deliveryOne(HttpServletRequest request, Model model) {
	  
	  String status="배송중";
	  int seqKey=Integer.parseInt(request.getParameter("seqKey"));
	  String deliveryCompany=request.getParameter("deliveryCompany");
	  String trackingNumber=request.getParameter("trackingNumber");
	  
	  model.addAttribute("deliSuccess",nonPaymentMapper.deliveryOne(seqKey, status, deliveryCompany, trackingNumber)); 
	  
  }//delivery
  //-----------------------------------------------------------------------------------//
  //반품 등 승인
  public String returnApproval(HashMap<String, String> reqMap) {
	  
	  int seqKey=Integer.parseInt(reqMap.get("seqKey"));
	  String status=reqMap.get("status")+"승인";
	  if(nonmemberMapper.orderStateChange(seqKey, status)==1) {
		  return "ok";
	  }
	  
	  return "no";
  }//returnApproval
  //-----------------------------------------------------------------------------------//
  //반품 등 완료(returnSubmit)
  public String returnSubmit(HashMap<String, String> reqMap) {
	  
	  //값 가져오기
	  int seqKey=Integer.parseInt(reqMap.get("seqKey"));
	  String status=reqMap.get("status")+"완료";
	  int productKey=Integer.parseInt(reqMap.get("productKey"));
	  int productPrice=Integer.parseInt(reqMap.get("productPrice"));
	  int quantity=Integer.parseInt(reqMap.get("quantity"));
	  int total=productPrice*quantity; //총액계산
	  //상품 재고 원상복귀 
	  productMapper.stockUp(quantity, productKey);
	  //주문테이블 상태값 바꾸기
	  nonmemberMapper.orderStateChange(seqKey, status);
	  //환불테이블 검색
	  if(nonmemberMapper.nonmemberRefundView(seqKey)==null) {
		  //환불테이블 검색값이 없으면(최초환불)
		  nonPaymentMapper.refundFirst(status,seqKey,total);
	  }
	  else {
		  //환불테이블 검색값이 있으면(합산처리)
		  nonPaymentMapper.refundMulti(status,seqKey,total);
	  }
	  
	  return "ok";
  }//returnSubmit
  //-----------------------------------------------------------------------------------//
  //반품 등 거부처리(returnReject)
  public void returnReject(HttpServletRequest request, Model model) {
	  
	  int seqKey=Integer.parseInt(request.getParameter("seqKey"));
	  String status=request.getParameter("status")+"거절";
	  String rejectReason=request.getParameter("rejectReason");
	  int returnKey=nonmemberMapper.getReturnKey(seqKey); //반품신청테이블 고유번호 얻어오기
	  if(nonmemberMapper.orderStateChange(seqKey, status)==1) {
		  
		  model.addAttribute("rejectSuccess",nonmemberMapper.reasonReplyModify(rejectReason, returnKey));
		  
	  }
	  
  }//returnReject
  //-----------------------------------------------------------------------------------//
  //교환 배송 처리(exchangeDelivery)
  public void exchangeDelivery(HttpServletRequest request, Model model) {
	  
	  int seqKey=Integer.parseInt(request.getParameter("seqKey"));
	  String status="배송중";
	  String deliveryCompany=request.getParameter("deliveryCompany");
	  String trackingNumber=request.getParameter("trackingNumber");
	  
	  model.addAttribute("deliSuccess", nonPaymentMapper.deliveryOne(seqKey, status, deliveryCompany, trackingNumber));
  }
  
  
  
}//class
