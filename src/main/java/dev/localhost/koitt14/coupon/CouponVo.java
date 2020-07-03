package dev.localhost.koitt14.coupon;

import java.sql.Timestamp;

public class CouponVo {
  private int seqKey;
  private String name;
  private int minimumPrice;
  private int discountPrice;
  private int discountPercent;
  private Timestamp startDate;
  private Timestamp endDate;
  private String status;
  private Timestamp createdDate;

  public CouponVo() {}

  public CouponVo(int seqKey, String name, int minimumPrice, int discountPrice, int discountPercent,
      Timestamp startDate, Timestamp endDate, String status, Timestamp createdDate) {
    this.seqKey = seqKey;
    this.name = name;
    this.minimumPrice = minimumPrice;
    this.discountPrice = discountPrice;
    this.discountPercent = discountPercent;
    this.startDate = startDate;
    this.endDate = endDate;
    this.status = status;
    this.createdDate = createdDate;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public int getMinimumPrice() {
    return minimumPrice;
  }

  public void setMinimumPrice(int minimumPrice) {
    this.minimumPrice = minimumPrice;
  }

  public int getDiscountPrice() {
    return discountPrice;
  }

  public void setDiscountPrice(int discountPrice) {
    this.discountPrice = discountPrice;
  }

  public int getDiscountPercent() {
    return discountPercent;
  }

  public void setDiscountPercent(int discountPercent) {
    this.discountPercent = discountPercent;
  }

  public Timestamp getStartDate() {
    return startDate;
  }

  public void setStartDate(Timestamp startDate) {
    this.startDate = startDate;
  }

  public Timestamp getEndDate() {
    return endDate;
  }

  public void setEndDate(Timestamp endDate) {
    this.endDate = endDate;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public Timestamp getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Timestamp createdDate) {
    this.createdDate = createdDate;
  }
}
