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

import dev.localhost.koitt14.nonmember.NonmemberMapper;
import dev.localhost.koitt14.nonmember.NonmemberService;
import dev.localhost.koitt14.nonmemberPayment.NonmemberPaymentMapper;
import dev.localhost.koitt14.nonmemberPayment.NonmemberPaymentService;

@Controller
public class AdminController_NonmemberOrder {

	  //비회원 서비스
	  @Autowired
	  NonmemberService nonmemberService;
	  
	  //비회원 결제 서비스
	  @Autowired
	  NonmemberPaymentService nonmemberPaymentService;
	  
	  //비회원 매퍼(직접호출)
	  @Autowired
	  NonmemberMapper nonmemberMapper;
	  
	  //비회원 결제 매퍼 (직접호출)
	  @Autowired
	  NonmemberPaymentMapper nonmemberPaymentMapper;
	  
	  //---------------------------------------------------------------------------------------//
	  //비회원 주문 리스트 불러오기(개괄)(adminNonmemberOrderListAll)
	  @GetMapping({"/admin/order/nonmember",
				  "/admin/order/nonmember/{search_}/{order_}",
				  "/admin/order/nonmember/{search_}/{order_}/{orderPage_}"})
	  public String adminNonmemberOrderListAll(@PathVariable Optional<Integer> orderPage_,
			  					  @PathVariable Optional<String> order_,
			  					  @PathVariable Optional<String> search_,
			  					  @RequestParam(required = false, value = "searchtext") String search,
			  					  Model model) {
		  search=search_.isPresent() ? search_.get() : search;
		  if(search==null) search="All";
		  int orderPage=orderPage_.isPresent() ? orderPage_.get() : 1;
		  String order=order_.isPresent() ? order_.get() : "order_number";
		  
		  nonmemberService.adminNonmemberOrderListAll(model, orderPage, order, search);;
		  
		  return "admin/order_nonmemberList";
	  }//adminNonmemberOrderListAll
	  //---------------------------------------------------------------------------------------//
	  //비회원 주문 상세(adminNonmemberOrderDetail)
	  @GetMapping("/admin/order/nonmember/detail/{orderNumber}/{nonmemberName}")
	  public String adminNonmemberOrderDetail(@PathVariable("orderNumber") String orderNumber,@PathVariable("nonmemberName")String nonmemberName, Model model) {
		  
		  model.addAttribute("orderList",nonmemberMapper.nonmemberOrderListAll(nonmemberName, orderNumber, 0, 999)) ;
		  nonmemberPaymentService.paymentDetail(orderNumber,model);
		  
		  
		  return "admin/order_nonmemberDetail";
	  }//adminNonmemberOrderDetail
	  //---------------------------------------------------------------------------------------//
	  //입금일괄확인(ajax)(adminNonmemberDepositOk)
	  @ResponseBody
	  @PostMapping("/admin/order/nonmember/depositOk")
	  public HashMap<String, String> adminNonmemberDepositOk(@RequestBody HashMap<String, String> reqMap){
		  
		  HashMap<String, String> resMap = new HashMap<String, String>();
		  resMap.put("result", nonmemberPaymentService.depositOk(reqMap));
		  
		  return resMap;
	  }//adminNonmemberDepositOk
	  //---------------------------------------------------------------------------------------//
	  //일괄배송 처리뷰(adminNonmemberDeliAll)
	  @GetMapping("/admin/order/nonmember/deliAll/{orderNumber}")
	  public String adminNonmemberDeliAll(@PathVariable("orderNumber") String orderNumber, Model model) {
		  
		  model.addAttribute("orderNumber",orderNumber);
		  model.addAttribute("flag","All");
		  
		  return "admin/order_nonmemberDelivery";
	  }//adminNonmemberDeliAll
	  //---------------------------------------------------------------------------------------//
	  //개별배송 처리뷰(adminNonmemberDeliOne)
	  @GetMapping("/admin/order/nonmember/deliOne/{seqKey}")
	  public String adminNonmemberDeliOne( @PathVariable("seqKey") int seqKey, Model model) {
		  
		  model.addAttribute("seqKey",seqKey);
		  model.addAttribute("flag","One");
		  
		  return "admin/order_nonmemberDelivery";
	  }//adminNonmemberDeliOne
	  //---------------------------------------------------------------------------------------//
	  //일괄배송 처리(adminNonmemberDeliAllInsert)
	  @PostMapping("/admin/order/nonmember/deliAllInsert")
	  public String adminNonmemberDeliAllInsert(HttpServletRequest request, Model model) {
		  
		  nonmemberPaymentService.deliveryAll(request,model);
		  
		  return "admin/order_nonmemberDelivery";
	  }//adminNonmemberDeliAllInsert
	  //---------------------------------------------------------------------------------------//
	  //개별배송 처리(adminNonmemberDeliInsert)
	  @PostMapping("/admin/order/nonmember/deliInsert")
	  public String adminNonmemberDeliInsert(HttpServletRequest request, Model model) {
		  
		  nonmemberPaymentService.deliveryOne(request,model);
		  
		  return "admin/order_nonmemberDelivery";
	  }//adminNonmemberDeliInsert
	  //---------------------------------------------------------------------------------------//
	  //반품등 사유보기 및 답변달기뷰(adminNonmemberReasonView)
	  @GetMapping("/admin/order/nonmember/reasonView/{seqKey}")
	  public String adminNonmemberReasonView(@PathVariable("seqKey") int seqKey, Model model) {
		  
		  model.addAttribute("reason",nonmemberMapper.takebackReasonView(seqKey));
		  
		  return "admin/order_nonmemberReasonView";
	  }//adminNonmemberReasonView
	  //---------------------------------------------------------------------------------------//
	  //반품등 사유 답변달기(adminNonmemberReasonReplyWrite)
	  @PostMapping("/admin/order/nonmember/replyWrite")
	  public String adminNonmemberReasonReplyWrite(HttpServletRequest request, Model model) {
		  
		  nonmemberService.adminReplyWrite(request,model);
		  
		  return "admin/order_nonmemberReasonView";
	  }//adminNonmemberReasonReplyWrite
	  //---------------------------------------------------------------------------------------//
	  //반품등 사유 답변수정(adminNonmemberReasonReplyModify)
	  @PostMapping("/admin/order/nonmember/replyModify")
	  public String adminNonmemberReasonReplyModify(HttpServletRequest request, Model model) {
		  
		  nonmemberService.adminReplyModify(request,model);
		  
		  return "admin/order_nonmemberReasonView";
	  }//adminNonmemberReasonReplyModify
	  //---------------------------------------------------------------------------------------//
	  //반품등 승인(ajax)(adminNonmemberReturnApproval)
	  @ResponseBody
	  @PostMapping("/admin/order/nonmember/returnApproval")
	  public HashMap<String, String> adminNonmemberReturnApproval(@RequestBody HashMap<String, String> reqMap){
		  
		  HashMap<String, String> resMap = new HashMap<String, String>();
		  resMap.put("result", nonmemberPaymentService.returnApproval(reqMap));
		  
		  return resMap;
	  }//adminNonmemberReturnApproval
	  //---------------------------------------------------------------------------------------//
	  //반품등 완료(ajax)(adminNonmemberReturnSubmit)
	  @ResponseBody
	  @PostMapping("/admin/order/nonmember/returnSubmit")
	  public HashMap<String, String> adminNonmemberReturnSubmit(@RequestBody HashMap<String, String> reqMap){
		  
		  HashMap<String, String> resMap = new HashMap<String, String>();
		  resMap.put("result", nonmemberPaymentService.returnSubmit(reqMap));
		  
		  return resMap;
	  }//adminNonmemberReturnSubmit
	  //---------------------------------------------------------------------------------------//
	  //반품 등 거부처리뷰(adminNonmemberRejectView)
	  @GetMapping("/admin/order/nonmember/rejectView/{seqKey}/{status}")
	  public String adminNonmemberRejectView(@PathVariable("seqKey") int seqKey, @PathVariable("status") String status, Model model) {
		  
		  model.addAttribute("seqKey",seqKey);
		  model.addAttribute("status",status);
		  
		  return "admin/order_nonmemberRejectView";
	  }//adminNonmemberRejectView
	  //---------------------------------------------------------------------------------------//
	  //반품 등 거부(adminNonmemberReject)
	  @PostMapping("/admin/order/nonmember/reject")
	  public String adminNonmemberReject(HttpServletRequest request, Model model) {
		  
		  nonmemberPaymentService.returnReject(request,model);
		  
		  return "admin/order_nonmemberRejectView";
	  }//adminNonmemberReject
	  //---------------------------------------------------------------------------------------//
	  //교환발송처리뷰(adminNonmemberExchangeDeliView)
	  @GetMapping("/admin/order/nonmember/exchangeDeliView/{seqKey}/{status}")
	  public String adminNonmemberExchangeDeliView(@PathVariable("seqKey") int seqKey, @PathVariable("status") String status, Model model) {
		  
		  model.addAttribute("seqKey",seqKey);
		  model.addAttribute("status",status);
		  
		  return "admin/order_nonmemberExDeliView";
	  }//adminNonmemberExchangeDeliView
	  //---------------------------------------------------------------------------------------//
	  //교환발송처리
	  @PostMapping("/admin/order/nonmember/exchangeDeliInsert")
	  public String adminNonmemberExchangeDeliInsert(HttpServletRequest request, Model model) {
		  
		  nonmemberPaymentService.exchangeDelivery(request,model);
		  
		  return "admin/order_nonmemberExDeliView";
	  }
	  
	  
	
}
