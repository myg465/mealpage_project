package dev.localhost.koitt14.coupon;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class CouponController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private CouponService couponService;

  // 목록 읽기
  @GetMapping("/coupon")
  public String getList (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    couponService.updateDisable(model);
    couponService.getList(model);
    couponService.getCouponCount(model);
    
    return "mypage/coupon";
  }
}
