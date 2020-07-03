package dev.localhost.koitt14.order;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class OrderController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private OrderService orderService;

  // 주문/배송 목록 조회
  @GetMapping({"/order", "/order/{page}"})
  public String orderList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    int page = param1.isPresent() ? param1.get() : 1;
    orderService.getList(page, model);

    return "mypage/order";
  }

  // 주문/배송 상세 조회
  @GetMapping("/order/detail/{orderNumber}")
  public String orderDetail (HttpServletRequest request, Model model, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    orderService.getOrderDetail(orderNumber, model);
 
    return "mypage/orderDetail";
  }

  // 주문/배송 취소
  @GetMapping("/order/cancel/{orderNumber}")
  public String cancelOrder (HttpServletRequest request, Model model, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    orderService.cancelOrder(orderNumber, model);
 
    return "mypage/orderCancelOk";
  }

  // 구매확정
  @GetMapping("/order/confirm/{orderNumber}")
  public String confirmOrder (HttpServletRequest request, Model model, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    orderService.confirmOrder(orderNumber, model);
 
    return "mypage/orderConfirmOk";
  }
}
