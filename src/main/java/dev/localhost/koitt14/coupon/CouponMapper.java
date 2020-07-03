package dev.localhost.koitt14.coupon;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CouponMapper {
  public ArrayList<CouponVo> getAbleList(Object accountKey, String today);
  public ArrayList<CouponVo> getDisableList(Object accountKey, String today);
  public int getCouponCount(Object accountKey, String today);

  public void insertPriceCoupon(String name, int minimumPrice, int discountPrice, String startDate, String endDate, Object accountKey);
  public void insertPercentCoupon(String name, int minimumPrice, int discountPercent, String startDate, String endDate, Object accountKey);

  public void updateDisable(Object accountKey, String today);
  public void updateUsed(String key);

  /* 관리자용 메소드 시작*/
  public ArrayList<CouponAccountVo> getAbleListByAdmin(String today, int offset, int rowsPerPage);
  public ArrayList<CouponAccountVo> getDisableListByAdmin(String today, int offset, int rowsPerPage);
  public int getAbleCount(String today);
  public int getDisableCount(String today);
  public void updateDisableByAdmin(String today);
}
