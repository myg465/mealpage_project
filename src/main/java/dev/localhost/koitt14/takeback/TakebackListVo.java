package dev.localhost.koitt14.takeback;

import java.sql.Timestamp;

public class TakebackListVo {
  private String takebackNumber;
  private int takebackGroup;
  private int takebackPrice;
  private int takebackQuantity;
  private String productName;
  private String status;
  private Timestamp createdDate;
  private String takebackerName;
  private String id;

  public TakebackListVo() {}

  public TakebackListVo(String takebackNumber, int takebackGroup, int takebackPrice, int takebackQuantity, String productName,
      String status, Timestamp createdDate, String takebackerName, String id) {
    this.takebackNumber = takebackNumber;
    this.takebackGroup = takebackGroup;
    this.takebackPrice = takebackPrice;
    this.takebackQuantity = takebackQuantity;
    this.productName = productName;
    this.status = status;
    this.createdDate = createdDate;
    this.takebackerName = takebackerName;
    this.id = id;
  }

  public String getTakebackNumber() {
    return takebackNumber;
  }

  public void setTakebackNumber(String takebackNumber) {
    this.takebackNumber = takebackNumber;
  }

  public int getTakebackGroup() {
    return takebackGroup;
  }

  public void setTakebackGroup(int takebackGroup) {
    this.takebackGroup = takebackGroup;
  }

  public int getTakebackPrice() {
    return takebackPrice;
  }

  public void setTakebackPrice(int takebackPrice) {
    this.takebackPrice = takebackPrice;
  }

  public int getTakebackQuantity() {
    return takebackQuantity;
  }

  public void setTakebackQuantity(int takebackQuantity) {
    this.takebackQuantity = takebackQuantity;
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

  public String getTakebackerName() {
    return takebackerName;
  }

  public void setTakebackerName(String takebackerName) {
    this.takebackerName = takebackerName;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }
}
