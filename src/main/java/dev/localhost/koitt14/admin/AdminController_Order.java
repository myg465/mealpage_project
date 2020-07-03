package dev.localhost.koitt14.admin;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.order.OrderService;
import dev.localhost.koitt14.takeback.TakebackService;

// 관리자 페이지 - 회원주문관리
@Controller
public class AdminController_Order {
  @Autowired
  AccountService accountService;

  @Autowired
  OrderService orderService;

  @Autowired
  TakebackService takebackService;

  // 주문 목록 읽기
  @GetMapping({"/admin/order/user", "/admin/order/user/{page}"})
  public String getOrderList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;
    orderService.getListByAdmin(page, model);

    return "admin/order_user";
  }

  // 주문상태별 주문목록 읽기
  @GetMapping({"/admin/order/user/status/{status}", "/admin/order/user/status/{status}/{page}"})
  public String statusList (HttpServletRequest request, Model model, @PathVariable("status") String status, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    int page = param1.isPresent() ? param1.get() : 1;

    if (status.equals("기타")) {
      orderService.etcList(page, model);
    } else {
      orderService.statusList(status, page, model);
    }
    
    return "admin/order_user";
  }

  // 검색 폼 대응
  @PostMapping("/admin/order/user/search")
  public String searchOrder (HttpServletRequest request) throws UnsupportedEncodingException {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    String searchType = request.getParameter("searchType") + "/";
    String searchText = URLEncoder.encode(request.getParameter("searchText"), "UTF-8");

    return "redirect:/admin/order/user/search/" + searchType + searchText + "/1";
  }

  // 검색결과 목록 읽기
  @GetMapping({"/admin/order/user/search/{type}/{keyword}/{page}"})
  public String searchList (HttpServletRequest request, Model model, @PathVariable("type") String type, @PathVariable("keyword") String keyword, @PathVariable("page") int page) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.searchList(type, keyword, page, model);
    
    return "admin/order_userSearch";
  }

  // 주문 상세 조회
  @GetMapping("/admin/order/user/{page}/detail/{orderNumber}")
  public String orderDetail (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 주문취소 처리
  @GetMapping("/admin/order/user/{page}/cancel/{orderNumber}")
  public String cancelOrder (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.cancelOrderByAdmin(orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 주문 결제비용 입금 처리
  @GetMapping("/admin/order/user/{page}/paid/{orderNumber}")
  public String confirmPaidOrder (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updatePaidStatusByAdmin("결제완료", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 입금확인 취소 처리
  @GetMapping("/admin/order/user/{page}/cancelPayment/{orderNumber}")
  public String cancelPaidOrder (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updatePaidStatusByAdmin("입금대기", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 배송준비 시작 처리
  @GetMapping("/admin/order/user/{page}/readyDelivery/{orderNumber}")
  public String readyDelivery (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("배송준비중", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 배송준비 취소 처리
  @GetMapping("/admin/order/user/{page}/cancelDelivery/{orderNumber}")
  public String cancelDelivery (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("결제완료", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 배송 시작 처리
  @GetMapping("/admin/order/user/{page}/startDelivery/{orderNumber}")
  public String startDelivery (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("배송중", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 배송중 취소 처리
  @GetMapping("/admin/order/user/{page}/stopDelivery/{orderNumber}")
  public String stopDelivery (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("배송준비중", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }  

  // 배송완료
  @GetMapping("/admin/order/user/{page}/deliveryOk/{orderNumber}")
  public String deliveryOk (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("배송완료", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }  

  // 배송완료 취소
  @GetMapping("/admin/order/user/{page}/deliveryNg/{orderNumber}")
  public String deliveryNg (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updateStatusByAdmin("배송중", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 환불확인 처리
  @GetMapping("/admin/order/user/{page}/refund/{orderNumber}")
  public String refundOrder (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updatePaidStatusByAdmin("환불완료", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 환불확인 취소 처리
  @GetMapping("/admin/order/user/{page}/cancelRefund/{orderNumber}")
  public String cancelRefund (HttpServletRequest request, Model model, @PathVariable("page") int page, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    orderService.updatePaidStatusByAdmin("환불대기", orderNumber);

    orderService.getOrderDetailByAdmin(orderNumber, model);
    model.addAttribute("page", page);
    model.addAttribute("orderNumber", orderNumber);
 
    return "admin/order_userDetail";
  }

  // 교환/반품 대응 폼
  @GetMapping("/admin/order/takeback/{orderNumber}")
  public String getTakeback (HttpServletRequest request, Model model, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    takebackService.selectTakebackByAdmin(orderNumber, model);
 
    return "admin/order_userTakebackReply";
  }

  // 교환/반품 대응 처리
  @PostMapping("/admin/order/takeback/{key}")
  public String postTakeback (HttpServletRequest request, Model model, @PathVariable("key") String key) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    model.addAttribute("request", request);
    takebackService.replyTakeback(key, model);

    return "admin/order_userTakebackReplyOk";
  }
  
}
