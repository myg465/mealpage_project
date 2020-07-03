package dev.localhost.koitt14.wishlist;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class WishlistController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private WishlistService wishlistService;

  // 찜한 상품 출력
  @GetMapping("/wishlist")
  public String getList (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/nonmember/cart";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    wishlistService.getList(model);

    return "/mypage/wishlist";
  }

  // 찜한 상품 수량 변경 (ajax 응답)
  @ResponseBody
  @PostMapping("/wishlist/update")
  public HashMap<String, String> updateWishlish (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return wishlistService.updateWishlist(reqMap);
  }
  
  // 찜한 상품 삭제 (ajax 응답)
  @ResponseBody
  @PostMapping("/wishlist/delete")
  public HashMap<String, String> deleteWishlista (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return wishlistService.deleteWishlist(reqMap);
  }
}
