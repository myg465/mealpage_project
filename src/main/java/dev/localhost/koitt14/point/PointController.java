package dev.localhost.koitt14.point;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class PointController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private PointService pointService;

  // read
  @GetMapping("/point")
  public String getList (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    pointService.getAddList(model);
    pointService.getUsedList(model);

    return "mypage/point";
  }
}
