package dev.localhost.koitt14.cart;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class CartService {
  @Autowired
  private CartMapper cartMapper;

  public void getList(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("cartList", cartMapper.readList(accountKey));
  }

  public CartVo selectCartByProduct(int productKey, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    return cartMapper.selectCartByProduct(productKey, accountKey);
  }

  public CartProductVo selectCartProduct(String key) {
    return cartMapper.selectCartProduct(key);
  }

  public void insertCart(int productKey, int quantity, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    cartMapper.insertCart(quantity, productKey, accountKey);
  }

  public HashMap<String, String> updateCart(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();
    int quantity = Integer.parseInt(reqMap.get("quantity"));
    int key = Integer.parseInt(reqMap.get("key"));

    cartMapper.updateCart(quantity, key);
    resMap.put("result", "pass");

    return resMap;
  }

  // 오버로딩
  public void updateCart(int key, int quantity) {
    cartMapper.updateCart(quantity, key);
  }

  public HashMap<String, String> deleteCart(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    String key = reqMap.get("key");
    cartMapper.deleteCart(key);
    resMap.put("result", "pass");

    return resMap;
  }
}
