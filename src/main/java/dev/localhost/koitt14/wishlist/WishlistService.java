package dev.localhost.koitt14.wishlist;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.cart.CartProductVo;

@Service
public class WishlistService {
  @Autowired
  private WishlistMapper wishlistMapper;

  public void getList(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("wishlistList", wishlistMapper.readList(accountKey));
  }

  public WishlistVo selectWishlistByProduct(int productKey, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    return wishlistMapper.selectWishlistByProduct(productKey, accountKey);
  }

  public CartProductVo selectWishlistProduct(String key) {
    return wishlistMapper.selectWishlistProduct(key);
  }

  public void insertWishlist(int productKey, int quantity, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    wishlistMapper.insertWishlist(quantity, productKey, accountKey);
  }

  public HashMap<String, String> updateWishlist(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();
    int quantity = Integer.parseInt(reqMap.get("quantity"));
    int key = Integer.parseInt(reqMap.get("key"));

    wishlistMapper.updateWishlist(quantity, key);
    resMap.put("result", "pass");

    return resMap;
  }

  // 오버로딩
  public void updateWishlist(int key, int quantity) {
    wishlistMapper.updateWishlist(quantity, key);
  }

  public HashMap<String, String> deleteWishlist(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    String key = reqMap.get("key");
    wishlistMapper.deleteWishlist(key);
    resMap.put("result", "pass");

    return resMap;
  }
}
