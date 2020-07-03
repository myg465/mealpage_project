package dev.localhost.koitt14.wishlist;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import dev.localhost.koitt14.cart.CartProductVo;

@Mapper
public interface WishlistMapper {
  public ArrayList<WishlistProductVo> readList(Object accountKey);
  public WishlistVo selectWishlistByProduct(int productKey, Object accountKey);
  public CartProductVo selectWishlistProduct(String key);

  public void insertWishlist(int productKey, int quantity, Object accountKey);
  public void updateWishlist(int quantity, int key);
  public void deleteWishlist(String key);
}
