package dev.localhost.koitt14.takeback;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class TakebackController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private TakebackService takebackService;

  // 교환/반품 목록 조회
  @GetMapping({"/takeback", "/takeback/{page}"})
  public String takebackList (HttpServletRequest request, Model model, @PathVariable("page") Optional<Integer> param1) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    int page = param1.isPresent() ? param1.get() : 1;
    takebackService.getList(page, model);

    return "mypage/takeback";
  }

  // 교환/반품 사유 작성 폼
  @GetMapping("/takeback/write/{status}/{orderNumber}")
  public String getTakeback (HttpServletRequest request, Model model, @PathVariable("status") String status, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    switch (status) {
      // 배송중 반품
      case "early-return":
      // 배송완료 반품
      case "return":
      // 배송완료 교환
      case "replace":
        model.addAttribute("status", status);        
        break;  
      default:
        return "redirect:/error/404";
    }

    model.addAttribute("orderNumber", orderNumber);

    return "mypage/takebackWrite";
  }

  // 교환/반품 처리
  @PostMapping("/takeback/{status}/{orderNumber}")
  public String postTakeback (HttpServletRequest request, Model model, @PathVariable("status") String status, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    switch (status) {
      // 배송중 반품
      case "early-return":
        status = "반품요청(배송중)";
        break;
      // 배송완료 반품
      case "return":
        status = "반품요청";
        break;
      // 배송완료 교환
      case "replace":
        status = "교환요청";
        break;  
      default:
        return "redirect:/error/404";
    }

    model.addAttribute("request", request);
    takebackService.takebackOrder(status, orderNumber, model);

    return "mypage/takebackWriteOk";
  }

  // 교환/반품 요청 취소
  @GetMapping("/takeback/cancel/{orderNumber}")
  public String cancelTakeback (HttpServletRequest request, Model model, @PathVariable("orderNumber") String orderNumber) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    takebackService.cancelTakeback(orderNumber, model);

    return "mypage/takebackCancelOk";
  }

  // 교환/반품 사유 읽기
  @GetMapping("/takeback/read/{key}")
  public String readTakeback (HttpServletRequest request, Model model, @PathVariable("key") String key) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    takebackService.selectTakeback(key, model);

    return "mypage/takebackRead";
  }
}
