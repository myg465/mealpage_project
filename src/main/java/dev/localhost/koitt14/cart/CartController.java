package dev.localhost.koitt14.cart;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class CartController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private CartService cartService;

  // 장바구니 목록 출력
  @GetMapping("/cart")
  public String getList (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/nonmember/cartList";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    cartService.getList(model);

    return "/mypage/cart";
  }

  // 장바구니 수량 변경 (ajax 응답)
  @ResponseBody
  @PostMapping("/cart/update")
  public HashMap<String, String> updateCart (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return cartService.updateCart(reqMap);
  }
  
  // 장바구니 상품 삭제 (ajax 응답)
  @ResponseBody
  @PostMapping("/cart/delete")
  public HashMap<String, String> deleteCart (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return cartService.deleteCart(reqMap);
  }
}
