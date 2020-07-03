package dev.localhost.koitt14.admin;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.customer.CustomerService;
import dev.localhost.koitt14.inquiry.InquiryService;
import dev.localhost.koitt14.nonmember.NonmemberService;
import dev.localhost.koitt14.order.OrderMapper;
import dev.localhost.koitt14.order.OrderService;
import dev.localhost.koitt14.productInquiry.ProductInquiryService;

@Service
public class AdminService {
  
	@Autowired
	private InquiryService inquiryService;
	  
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private ProductInquiryService productInquiryService;
  
	@Autowired
	private OrderService orderService;
	
	@Autowired 
	private OrderMapper orderMapper;
	
	@Autowired NonmemberService nomemberService;
	
	public void adminMain(Model model) {
		
		// 회원 1:1 문의 개수
		int userInquiryWatingForAnswer = inquiryService.getReplyStatusCount("답변대기");
	    int userInquiryAnswerCompleted = inquiryService.getReplyStatusCount("답변완료");
	    int userInquiryTotal = userInquiryWatingForAnswer + userInquiryAnswerCompleted;
	    
	    model.addAttribute("userInquiryWatingForAnswer", userInquiryWatingForAnswer);
	    model.addAttribute("userInquiryAnswerCompleted", userInquiryAnswerCompleted);
	    model.addAttribute("userInquriyTotal", userInquiryTotal);
	    
	    
	    // 비회원 1:1 문의 개수
	    int nonmemeberInquiryWatingForAnswer = customerService.getNonmemberInquiryReplyCount("답변대기");
	    int nonmemeberInquiryAnswerCompleted = customerService.getNonmemberInquiryReplyCount("답변완료");
	    int nonmemberInquiryTotal = nonmemeberInquiryWatingForAnswer + nonmemeberInquiryAnswerCompleted;
	    
	    model.addAttribute("nonmemeberInquiryWatingForAnswer", nonmemeberInquiryWatingForAnswer);
	    model.addAttribute("nonmemeberInquiryAnswerCompleted", nonmemeberInquiryAnswerCompleted);
	    model.addAttribute("nonmemberInquiryTotal", nonmemberInquiryTotal);
	    
	    
	    // 제품문의(질문과 답변)
	    int productInquiryWatingForAnswer = productInquiryService.inquiryCount("reply");
	    int productInquiryAnswerCompleted = productInquiryService.inquiryCount("noReply");
	    int productInquiryTotal = productInquiryWatingForAnswer + productInquiryAnswerCompleted;
	    
	    model.addAttribute("productInquiryWatingForAnswer", productInquiryWatingForAnswer);
	    model.addAttribute("productInquiryAnswerCompleted", productInquiryAnswerCompleted);
	    model.addAttribute("productInquiryTotal", productInquiryTotal);
	    
	    
	    // 회원 주문상태
	    int userOrderTotal = orderMapper.getUserOrderCountByAdmin();
	    int userOrderPaymentCompleted = orderService.getStatusCount("결제완료");
	    int userOrderPreparingForDelivery = orderService.getStatusCount("배송준비중");
	    int userOrderShipping = orderService.getStatusCount("배송중");
	    int userOrderDeliveryCompleted = orderService.getStatusCount("배송완료");
	    int userOrderConfirmPurchase = orderService.getStatusCount("구매확정");
	    int userOrderExchangeRequest = orderService.getStatusCount("교환요청");
	    int userOrderReturnRequest = orderService.getStatusCount("반품요청");
	    int userOrderWaitForRefund = orderService.getStatusCount("환불대기");
	    int userOrderEtc = userOrderTotal - (userOrderPaymentCompleted + userOrderPreparingForDelivery +
	    				   					 userOrderShipping + userOrderDeliveryCompleted +
	    				   					 userOrderConfirmPurchase + userOrderExchangeRequest + 
	    				   					 userOrderReturnRequest + userOrderWaitForRefund);
	    
	    model.addAttribute("userOrderTotal", userOrderTotal);
	    model.addAttribute("userOrderPaymentCompleted", userOrderPaymentCompleted);
	    model.addAttribute("userOrderPreparingForDelivery", userOrderPreparingForDelivery);
	    model.addAttribute("userOrderShipping", userOrderShipping);
	    model.addAttribute("userOrderDeliveryCompleted", userOrderDeliveryCompleted);
	    model.addAttribute("userOrderConfirmPurchase", userOrderConfirmPurchase);
	    model.addAttribute("userOrderExchangeRequest", userOrderExchangeRequest);
	    model.addAttribute("userOrderReturnRequest", userOrderReturnRequest);
	    model.addAttribute("userOrderWaitForRefund", userOrderWaitForRefund);
	    model.addAttribute("userOrderEtc", userOrderEtc);
	    
	    //비회원 주문상태
	    int nonmemberOrderTotal = nomemberService.nonmemberOrderCount("All");
	    int nonmemberOrderDepositWaiting = nomemberService.nonmemberOrderCount("입금대기");
	    int nonmemberOrderPreparingForDelivery = nomemberService.nonmemberOrderCount("배송준비중");
	    int nonmemberOrderShipping = nomemberService.nonmemberOrderCount("배송중");
	    int nonmemberOrderDeliveryCompleted = nomemberService.nonmemberOrderCount("배송완료");
	    int nonmemberOrderConfirmPurchase = nomemberService.nonmemberOrderCount("구매확정");
	    int nonmemberOrderExchangeRequest = nomemberService.nonmemberOrderCount("교환신청");
	    int nonmemberOrderReturnRequest = nomemberService.nonmemberOrderCount("반품신청");
	    int nonmemberOrderWaitForRefund = nomemberService.nonmemberOrderCount("반품승인") +
	    								  nomemberService.nonmemberOrderCount("환불승인") +
	    								  nomemberService.nonmemberOrderCount("취소승인");
	    int nonmemberOrderEtc = nonmemberOrderTotal - (nonmemberOrderDepositWaiting + nonmemberOrderPreparingForDelivery +
	    											   nonmemberOrderShipping + nonmemberOrderDeliveryCompleted + 
	    											   nonmemberOrderConfirmPurchase + nonmemberOrderExchangeRequest +
	    											   nonmemberOrderReturnRequest + nonmemberOrderWaitForRefund);
	    
	    model.addAttribute("nonmemberOrderTotal", nonmemberOrderTotal);
	    model.addAttribute("nonmemberOrderDepositWaiting", nonmemberOrderDepositWaiting);
	    model.addAttribute("nonmemberOrderPreparingForDelivery", nonmemberOrderPreparingForDelivery);
	    model.addAttribute("nonmemberOrderShipping", nonmemberOrderShipping);
	    model.addAttribute("nonmemberOrderDeliveryCompleted", nonmemberOrderDeliveryCompleted);
	    model.addAttribute("nonmemberOrderConfirmPurchase", nonmemberOrderConfirmPurchase);
	    model.addAttribute("nonmemberOrderExchangeRequest", nonmemberOrderExchangeRequest);
	    model.addAttribute("nonmemberOrderReturnRequest", nonmemberOrderReturnRequest);
	    model.addAttribute("nonmemberOrderWaitForRefund", nonmemberOrderWaitForRefund);
	    model.addAttribute("nonmemberOrderEtc", nonmemberOrderEtc);
	    
	}
	
}
