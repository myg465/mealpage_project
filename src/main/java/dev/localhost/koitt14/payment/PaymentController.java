package dev.localhost.koitt14.payment;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.coupon.CouponService;
import dev.localhost.koitt14.order.OrderService;

@Controller
public class PaymentController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private CouponService couponService;

  @Autowired
  private OrderService orderService;

  @Autowired
  private PaymentService paymentService;

  // 주문/결제 폼
  @GetMapping("/payment")
  public String getPayment (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    couponService.updateDisable(model);
    paymentService.getOrderFromCart(model);

    return "payment/payment";
  }

  // 주문/결제 처리
  @PostMapping("/payment")
  public String postPayment (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";
    model.addAttribute("request", request);
    
    int paymentKey = paymentService.insertPayment(model);
    orderService.insertOrder("cart", paymentKey, model);

    return "payment/confirmation";
  }

  // 장바구니에서 주문/결제할 상품목록 받기 (AJAX 응답)
  @ResponseBody
  @PostMapping("/payment/senditem")
  public HashMap<String, String> receiveItems (@RequestParam(value="orderItems[]") String[] orderItems, HttpServletRequest request) throws Exception {
    HttpSession session = request.getSession();
    session.setAttribute("orderItems", orderItems);

    HashMap<String, String> resMap = new HashMap<String, String>();
    resMap.put("result", "pass");

    return resMap;
  }

  // 주문자 주소 - 회원정보 반영 처리
  @ResponseBody
  @PostMapping("/payment/update")
  public HashMap<String, String> updateDestination (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return accountService.updateDestination(reqMap, request);
  }

  // 찜한 상품 - 주문/결제 폼
  @GetMapping("/payment/wishlist")
  public String getWishlist (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    paymentService.getOrderFromWishlist(model);

    return "payment/payment";
  }

  // 주문/결제 처리
  @PostMapping("/payment/wishlist")
  public String postWishlist (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    
    int paymentKey = paymentService.insertPayment(model);
    orderService.insertOrder("wishlist", paymentKey, model);

    return "payment/confirmation";
  }
}
