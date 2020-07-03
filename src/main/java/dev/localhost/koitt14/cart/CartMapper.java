package dev.localhost.koitt14.cart;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper {
  public ArrayList<CartProductVo> readList(Object accountKey);
  public CartVo selectCartByProduct(int productKey, Object accountKey);
  public CartProductVo selectCartProduct(String key);

  public void insertCart(int productKey, int quantity, Object accountKey);
  public void updateCart(int quantity, int key);
  public void deleteCart(String key);
}
