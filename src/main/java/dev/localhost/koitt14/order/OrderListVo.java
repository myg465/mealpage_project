package dev.localhost.koitt14.order;

import java.sql.Timestamp;

public class OrderListVo {
  private String orderNumber;
  private int orderGroup;
  private int orderPrice;
  private int orderQuantity;
  private String productName;
  private String status;
  private Timestamp createdDate;
  private String ordererName;
  private String id;

  public OrderListVo() {}

  public OrderListVo(String orderNumber, int orderGroup, int orderPrice, int orderQuantity, String productName,
      String status, Timestamp createdDate, String ordererName, String id) {
    this.orderNumber = orderNumber;
    this.orderGroup = orderGroup;
    this.orderPrice = orderPrice;
    this.orderQuantity = orderQuantity;
    this.productName = productName;
    this.status = status;
    this.createdDate = createdDate;
    this.ordererName = ordererName;
    this.id = id;
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

  public String getOrdererName() {
    return ordererName;
  }

  public void setOrdererName(String ordererName) {
    this.ordererName = ordererName;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }
}
