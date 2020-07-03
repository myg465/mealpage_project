package dev.localhost.koitt14.nonmember;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.localhost.koitt14.product.ProductMapper;

@Controller
public class NonmemberController {
  
  //비회원 서비스
  @Autowired
  private NonmemberService nonmemberService;
  //비회원 매퍼(바로호출)
  @Autowired
  private NonmemberMapper nonmemberMapper;
  //제품 매퍼(바로호출)
  @Autowired
  private ProductMapper productMapper;
  
  //---------------------------------------------------------------------------------------//
  //비회원 로그인 처리(ajax응답)
  @ResponseBody
  @PostMapping("nonmember/login")
  public HashMap<String, String> nonmemberLogin(@RequestBody HashMap<String, String> reqMap, HttpSession session){
	  
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  //로그인 메소드 호출
	  resMap.put("result", nonmemberService.nonmemberLogin(reqMap,session));
	  
	  
	  
	  return resMap;
  }//nonmemberLogin
  //---------------------------------------------------------------------------------------//
  //비회원 로그아웃
  @GetMapping("nonmember/logout")
  public String nonmemberLogout(HttpSession session) {
	  
	  session.removeAttribute("nonmemberName");
	  session.removeAttribute("orderNumber");
	  
	  return "redirect:/account/login";
  }
  //---------------------------------------------------------------------------------------//
  //===================================비회원 장바구니========================================//
  //---------------------------------------------------------------------------------------//
  //장바구니 추가(nonmemberCartAdd)
  @PostMapping("/nonmember/cartAdd")
  public String nonmemberCartAdd(RedirectAttributes redirect, HttpServletRequest request, 
		  						 HttpSession session) {
	  
	  //돌려보낼 주소를 위한 제품키 추출
	  String productKey=request.getParameter("productKey");
	  nonmemberService.nonmemberCartAdd(request,session);
	  
	  //리다이렉트시 표시할 변수를 담는다.
	  redirect.addAttribute("productFlag","nmCart");
	  
	  return "redirect:/product/detail/"+productKey;
  }//nonmemberCartAdd
  //---------------------------------------------------------------------------------------//
  //장바구니 리스트(nonmemberCartList)
  @GetMapping("/nonmember/cartList")
  public String nonmemberCartList(HttpSession session, Model model) {
	  
	  nonmemberService.nonmemberCartList(session,model);
	  
	  return "nonmember/cartList";
  }//nonmemberCartList
  //---------------------------------------------------------------------------------------//
  //장바구니 목록중 특정삭제(nonmemberCartDel)
  @ResponseBody
  @PostMapping("/nonmember/cartDel")
  public HashMap<String, String> nonmemberCartDel(@RequestBody HashMap<String, String> reqMap,HttpSession session) throws Exception {
	  
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  resMap.put("result", nonmemberService.nonmemberCartDel(reqMap,session)) ;
	  
	  return resMap;
  }//nonmemberCartDel
  //---------------------------------------------------------------------------------------//
  //장바구니 수량수정(quantityModify)
  @ResponseBody
  @PostMapping("/nonmember/quantityModify")
  public HashMap<String, String> quantityModify(@RequestBody HashMap<String, String> reqMap,HttpSession session) throws Exception {
	  
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  resMap.put("result", nonmemberService.quantityModify(reqMap,session)) ;
	  
	  return resMap;
  }//quantityModify
  //---------------------------------------------------------------------------------------//
  //바로구매(buyNow)
  @ResponseBody
  @PostMapping("/nonmember/buyNow")
  public HashMap<String, String> buyNow(@RequestBody HashMap<String, String> reqMap,HttpSession session) throws Exception {
	  session.removeAttribute("buyList");
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  resMap.put("result", nonmemberService.buyNow(reqMap,session)) ;
	  
	  return resMap;
  }//buyNow
  //---------------------------------------------------------------------------------------//
  //주문으로 넘기기(여러개)(orderCart)
  @PostMapping("/nonmember/orderCart")
  public String orderCart(HttpServletRequest request, HttpSession session) {
	  session.removeAttribute("buyList");
	  nonmemberService.orderCart(request,session);
	  
	  return "redirect:/nonmemberPayment/payment";
  }//orderCart
  
  
  //---------------------------------------------------------------------------------------//
  //===================================비회원 주문내역========================================//
  //---------------------------------------------------------------------------------------//
  //비회원 주문내역(개괄)(nonmember_oerdercheck)
  @GetMapping("/nonmember/ordercheck")
  public String nonmember_oerdercheck(Model model,HttpSession session) {
	  
	  nonmemberService.nonmemberOrderListTotal(model,session);
	  
	  return "nonmember/ordercheck";
  }//nonmemberOrdercheck(변수가 다름) - 다른 메뉴에서 돌아올때(오버로딩)
  //---------------------------------------------------------------------------------------//
  //비회원 주문내역(상세)(nonmember_oerdercheck)
  @GetMapping("/nonmember/ordercheck/{page}/{listStat}")
  public String nonmember_oerdercheck(
		  							  @PathVariable("page") int page, 
		  							  @PathVariable("listStat") int listStat,
		  							  Model model,HttpSession session) {
	  	  	  
	  
	  model.addAttribute("page", page);
	  model.addAttribute("listStat", listStat);
	    
	  nonmemberService.nonmemberOrderListAll(model,session);
	  
	  return "nonmember/ordercheck";
  }//nonmemberOrdercheck(오버로딩)
  //---------------------------------------------------------------------------------------//
  //비회원 주문내역 상세보기(nonmemberDeliveryView)
  @GetMapping("/nonmember/deliveryView/{seqKey}")
  public String nonmemberDeliveryView(@PathVariable("seqKey") int seqKey, Model model) {
	  
	  nonmemberService.nonmemberDeliveryView(seqKey,model);
	  
	  return "nonmember/deliveryView";
  }//nonmemberDeliveryView
  //---------------------------------------------------------------------------------------//
  //=======================================반품교환 내역======================================//
  //---------------------------------------------------------------------------------------//
  //비회원반품교환내역(nonmemberTakebackStateList)
  @GetMapping("/nonmember/takebackStateList")
  public String nonmemberTakebackStateList(Model model,HttpSession session) {
	  
	  nonmemberService.takebackStateList(model, session);
	  
	  return "nonmember/takebackStateList";
  }//nonmemberTakebackStateList
  //---------------------------------------------------------------------------------------//
  //비회원반품교환내역(상세)(nonmemberTakebackStateList)
  @GetMapping("/nonmember/takebackStateList/{page}/{listStat}")
  public String nonmemberTakebackStateList(@PathVariable("page") int page, 
		  								   @PathVariable("listStat") int listStat,
		  							       Model model,HttpSession session) {
	  	  	  
	  model.addAttribute("listStat", listStat);
	    
	  nonmemberService.takebackStateListAll(page,listStat,model,session);
	  
	  return "nonmember/takebackStateList";
  }//nonmemberOrdercheck(오버로딩)
  //---------------------------------------------------------------------------------------//
  //비회원 반품내역 상세보기(nonmemberRefundView)
  @GetMapping("/nonmember/refundView/{seqKey}")
  public String nonmemberRefundView(@PathVariable("seqKey") int seqKey, Model model) {
	  
	  nonmemberService.nonmemberRefundView(seqKey,model);
	  
	  return "nonmember/refundView";
  }//nonmemberDeliveryView
  //---------------------------------------------------------------------------------------//
  //비회원 반품 등 신청뷰
  @GetMapping("/nonmember/takebackWriteView/{status}/{seqKey}")
  public String nomemberTakebackWriteView(@PathVariable("status")String status,@PathVariable("seqKey")String seqKey, Model model) {
	  
	  model.addAttribute("seqKey",seqKey);
	  model.addAttribute("status",status);
	  
	  return "nonmember/takebackWriteView";
  }//nomemberTakebackWriteView
  //---------------------------------------------------------------------------------------//
  //비회원 반품 등 신청
  @PostMapping("/nonmember/takebackWrite")
  public String nomemberTakebackWrite(HttpServletRequest request, Model model) {
	  
	  nonmemberService.takebackWrite(request, model);
	  
	  return "nonmember/takebackWriteView";
  }//nomemberTakebackWrite
  //---------------------------------------------------------------------------------------//
  //비회원 바로취소(ajax -> 오류나서 매핑방식 변경)
  @ResponseBody
  @RequestMapping(value = "/nonmember/cancel", method = RequestMethod.POST)
  public HashMap<String, String> nonmemberOrderCancel(@RequestBody HashMap<String, String> reqMap) throws Exception {
	  
	  int seqKey=Integer.parseInt(reqMap.get("seqKey"));
	  int productKey=Integer.parseInt(reqMap.get("productKey"));
	  int quantity=Integer.parseInt(reqMap.get("quantity"));
	  
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  if(nonmemberMapper.orderStateChange(seqKey, "취소완료")==1 && nonmemberMapper.takebackWrite(seqKey, " ")==1) {
		  productMapper.stockUp(quantity, productKey);
		  resMap.put("result", "ok");
	  }
	  
	  return resMap;
  }//nonmemberOrderCancel
  //---------------------------------------------------------------------------------------//
  //비회원 수취확인(deliverOk)(ajax -> 오류나서 매핑방식 변경)
  @ResponseBody
  @RequestMapping(value = "/nonmember/deliveryOk", method = RequestMethod.POST)
  public HashMap<String, String> nonmemberDeliverOk(@RequestBody HashMap<String, String> reqMap) throws Exception {
	  
	  int seqKey=Integer.parseInt(reqMap.get("seqKey"));
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  if(nonmemberMapper.orderStateChange(seqKey, "배송완료")==1) {
		  resMap.put("result", "ok");
	  }
	  
	  return resMap;
  }//nonmemberDeliverOk
  //---------------------------------------------------------------------------------------//
  //비회원 구매확정(buyOk)(ajax -> 오류나서 매핑방식 변경)
  @ResponseBody
  @RequestMapping(value = "/nonmember/buyOk", method = RequestMethod.POST)
  public HashMap<String, String> buyOk(@RequestBody HashMap<String, String> reqMap) throws Exception {
	  
	  int seqKey=Integer.parseInt(reqMap.get("seqKey"));
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  if(nonmemberMapper.orderStateChange(seqKey, "구매확정")==1) {
		  resMap.put("result", "ok");
	  }
	  
	  return resMap;
  }//nonmemberDeliverOk
  //---------------------------------------------------------------------------------------//
  //비회원 반품 등 신청사유 열람(takebackReasonView)
  @GetMapping("/nonmember/takebackReasonView/{seqKey}")
  public String nonmemberTakebackReasonView(@PathVariable("seqKey")int seqKey, Model model) {
	  
	  nonmemberService.takebackReasonView(seqKey, model);
	  
	  return "nonmember/takebackReason";
  }//takebackReasonView
  //---------------------------------------------------------------------------------------//
  //비회원 반품 등 신청사유 수정(takebackReasonModify)
  @PostMapping("/nonmember/takebackReasonModify")
  public String takebackReasonModify(HttpServletRequest request, Model model) {
	  
	  nonmemberService.takebackReasonModify(request,model);
	  
	  return "nonmember/takebackReason";
  }//takebackReasonModify
  //---------------------------------------------------------------------------------------//
  //=======================================결제=============================================//
  //---------------------------------------------------------------------------------------//
  //상세페이지에서 바로구매(detailBuyNow)
  @ResponseBody
  @PostMapping("/nonmember/detailBuyNow")
  public HashMap<String, String> detailBuyNow(@RequestBody HashMap<String, String> reqMap, HttpSession session) throws Exception {
	  session.removeAttribute("buyList");
	  HashMap<String, String> resMap = new HashMap<String, String>();
	  resMap.put("result", nonmemberService.detailBuyNow(reqMap,session)) ;
	  
	  return resMap;
  }//detailBuyNow
  //---------------------------------------------------------------------------------------//
  //결제페이지(nonmemberPayment)
  @GetMapping("/nonmemberPayment/payment")
  public String nonmemberPayment(HttpSession session,Model model) {
	  
	  nonmemberService.nonmemberPayment(session,model);
	  
	  return "nonmemberPayment/payment";
  }//nonmemberPayment
  
  
  
  
}
