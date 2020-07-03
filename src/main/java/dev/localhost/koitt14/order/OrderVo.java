package dev.localhost.koitt14.order;

import java.sql.Timestamp;

public class OrderVo {
  private int seqKey;
  private String orderNumber;
  private int orderGroup;
  private int orderPrice;
  private int orderQuantity;
  private String productName;
  private int productPrice;
  private int quantity;
  private String status;
  private String review;
  private String deliveryCompany;
  private String trackingNumber;
  private Timestamp createdDate;
  private int productKey;
  private int accountKey;
  private int userPaymentKey;

  public OrderVo() {}

  public OrderVo(int seqKey, String orderNumber, int orderGroup, int orderPrice, int orderQuantity, String productName,
      int productPrice, int quantity, String status, String review, String deliveryCompany, String trackingNumber,
      Timestamp createdDate, int productKey, int accountKey, int userPaymentKey) {
    this.seqKey = seqKey;
    this.orderNumber = orderNumber;
    this.orderGroup = orderGroup;
    this.orderPrice = orderPrice;
    this.orderQuantity = orderQuantity;
    this.productName = productName;
    this.productPrice = productPrice;
    this.quantity = quantity;
    this.status = status;
    this.review = review;
    this.deliveryCompany = deliveryCompany;
    this.trackingNumber = trackingNumber;
    this.createdDate = createdDate;
    this.productKey = productKey;
    this.accountKey = accountKey;
    this.userPaymentKey = userPaymentKey;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getOrderNumber() {
    return orderNumber;
  }

  public void setOrderNumber(String orderNumber) {
    this.orderNumber = orderNumber;
  }

  public int getOrderGroup() {
    return orderGroup;
  }

  public void setOrderGroup(int orderGroup) {
    this.orderGroup = orderGroup;
  }

  public int getOrderPrice() {
    return orderPrice;
  }

  public void setOrderPrice(int orderPrice) {
    this.orderPrice = orderPrice;
  }

  public int getOrderQuantity() {
    return orderQuantity;
  }

  public void setOrderQuantity(int orderQuantity) {
    this.orderQuantity = orderQuantity;
  }

  public String getProductName() {
    return productName;
  }

  public void setProductName(String productName) {
    this.productName = productName;
  }

  public int getProductPrice() {
    return productPrice;
  }

  public void setProductPrice(int productPrice) {
    this.productPrice = productPrice;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getReview() {
    return review;
  }

  public void setReview(String review) {
    this.review = review;
  }

  public String getDeliveryCompany() {
    return deliveryCompany;
  }

  public void setDeliveryCompany(String deliveryCompany) {
    this.deliveryCompany = deliveryCompany;
  }

  public String getTrackingNumber() {
    return trackingNumber;
  }

  public void setTrackingNumber(String trackingNumber) {
    this.trackingNumber = trackingNumber;
  }

  public Timestamp getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Timestamp createdDate) {
    this.createdDate = createdDate;
  }

  public int getProductKey() {
    return productKey;
  }

  public void setProductKey(int productKey) {
    this.productKey = productKey;
  }

  public int getAccountKey() {
    return accountKey;
  }

  public void setAccountKey(int accountKey) {
    this.accountKey = accountKey;
  }

  public int getUserPaymentKey() {
    return userPaymentKey;
  }

  public void setUserPaymentKey(int userPaymentKey) {
    this.userPaymentKey = userPaymentKey;
  }
}
