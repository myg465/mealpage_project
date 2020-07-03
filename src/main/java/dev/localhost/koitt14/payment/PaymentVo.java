package dev.localhost.koitt14.payment;

import java.sql.Timestamp;

public class PaymentVo {
  private int seqKey;

  private String ordererName;
  private String ordererAddressZipcode;
  private String ordererAddressNew;
  private String ordererAddressOld;
  private String ordererAddressDetail;
  private String ordererAddressExtra;
  private String ordererEmail;
  private String ordererPhone;

  private String recipientName;
  private String recipientAddressZipcode;
  private String recipientAddressNew;
  private String recipientAddressOld;
  private String recipientAddressDetail;
  private String recipientAddressExtra;
  private String recipientPhone;
  private String recipientRequest;
  
  private int amountTotal;
  private int amountDelivery;
  private int amountDiscountCoupon;
  private int amountDiscountPoint;
  private int amountFinal;

  private String method;
  private String detail;
  private String status;
  private Timestamp paidDate;
  private Timestamp createdDate;
  private Timestamp modifiedDate;

  private int accountKey;

  public PaymentVo() {}

  public PaymentVo(int seqKey, String ordererName, String ordererAddressZipcode, String ordererAddressNew,
      String ordererAddressOld, String ordererAddressDetail, String ordererAddressExtra, String ordererEmail,
      String ordererPhone, String recipientName, String recipientAddressZipcode, String recipientAddressNew,
      String recipientAddressOld, String recipientAddressDetail, String recipientAddressExtra, String recipientPhone,
      String recipientRequest, int amountTotal, int amountDelivery, int amountDiscountCoupon, int amountDiscountPoint,
      int amountFinal, String method, String detail, String status, Timestamp paidDate, Timestamp createdDate,
      Timestamp modifiedDate, int accountKey) {
    this.seqKey = seqKey;
    this.ordererName = ordererName;
    this.ordererAddressZipcode = ordererAddressZipcode;
    this.ordererAddressNew = ordererAddressNew;
    this.ordererAddressOld = ordererAddressOld;
    this.ordererAddressDetail = ordererAddressDetail;
    this.ordererAddressExtra = ordererAddressExtra;
    this.ordererEmail = ordererEmail;
    this.ordererPhone = ordererPhone;
    this.recipientName = recipientName;
    this.recipientAddressZipcode = recipientAddressZipcode;
    this.recipientAddressNew = recipientAddressNew;
    this.recipientAddressOld = recipientAddressOld;
    this.recipientAddressDetail = recipientAddressDetail;
    this.recipientAddressExtra = recipientAddressExtra;
    this.recipientPhone = recipientPhone;
    this.recipientRequest = recipientRequest;
    this.amountTotal = amountTotal;
    this.amountDelivery = amountDelivery;
    this.amountDiscountCoupon = amountDiscountCoupon;
    this.amountDiscountPoint = amountDiscountPoint;
    this.amountFinal = amountFinal;
    this.method = method;
    this.detail = detail;
    this.status = status;
    this.paidDate = paidDate;
    this.createdDate = createdDate;
    this.modifiedDate = modifiedDate;
    this.accountKey = accountKey;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getOrdererName() {
    return ordererName;
  }

  public void setOrdererName(String ordererName) {
    this.ordererName = ordererName;
  }

  public String getOrdererAddressZipcode() {
    return ordererAddressZipcode;
  }

  public void setOrdererAddressZipcode(String ordererAddressZipcode) {
    this.ordererAddressZipcode = ordererAddressZipcode;
  }

  public String getOrdererAddressNew() {
    return ordererAddressNew;
  }

  public void setOrdererAddressNew(String ordererAddressNew) {
    this.ordererAddressNew = ordererAddressNew;
  }

  public String getOrdererAddressOld() {
    return ordererAddressOld;
  }

  public void setOrdererAddressOld(String ordererAddressOld) {
    this.ordererAddressOld = ordererAddressOld;
  }

  public String getOrdererAddressDetail() {
    return ordererAddressDetail;
  }

  public void setOrdererAddressDetail(String ordererAddressDetail) {
    this.ordererAddressDetail = ordererAddressDetail;
  }

  public String getOrdererAddressExtra() {
    return ordererAddressExtra;
  }

  public void setOrdererAddressExtra(String ordererAddressExtra) {
    this.ordererAddressExtra = ordererAddressExtra;
  }

  public String getOrdererEmail() {
    return ordererEmail;
  }

  public void setOrdererEmail(String ordererEmail) {
    this.ordererEmail = ordererEmail;
  }

  public String getOrdererPhone() {
    return ordererPhone;
  }

  public void setOrdererPhone(String ordererPhone) {
    this.ordererPhone = ordererPhone;
  }

  public String getRecipientName() {
    return recipientName;
  }

  public void setRecipientName(String recipientName) {
    this.recipientName = recipientName;
  }

  public String getRecipientAddressZipcode() {
    return recipientAddressZipcode;
  }

  public void setRecipientAddressZipcode(String recipientAddressZipcode) {
    this.recipientAddressZipcode = recipientAddressZipcode;
  }

  public String getRecipientAddressNew() {
    return recipientAddressNew;
  }

  public void setRecipientAddressNew(String recipientAddressNew) {
    this.recipientAddressNew = recipientAddressNew;
  }

  public String getRecipientAddressOld() {
    return recipientAddressOld;
  }

  public void setRecipientAddressOld(String recipientAddressOld) {
    this.recipientAddressOld = recipientAddressOld;
  }

  public String getRecipientAddressDetail() {
    return recipientAddressDetail;
  }

  public void setRecipientAddressDetail(String recipientAddressDetail) {
    this.recipientAddressDetail = recipientAddressDetail;
  }

  public String getRecipientAddressExtra() {
    return recipientAddressExtra;
  }

  public void setRecipientAddressExtra(String recipientAddressExtra) {
    this.recipientAddressExtra = recipientAddressExtra;
  }

  public String getRecipientPhone() {
    return recipientPhone;
  }

  public void setRecipientPhone(String recipientPhone) {
    this.recipientPhone = recipientPhone;
  }

  public String getRecipientRequest() {
    return recipientRequest;
  }

  public void setRecipientRequest(String recipientRequest) {
    this.recipientRequest = recipientRequest;
  }

  public int getAmountTotal() {
    return amountTotal;
  }

  public void setAmountTotal(int amountTotal) {
    this.amountTotal = amountTotal;
  }

  public int getAmountDelivery() {
    return amountDelivery;
  }

  public void setAmountDelivery(int amountDelivery) {
    this.amountDelivery = amountDelivery;
  }

  public int getAmountDiscountCoupon() {
    return amountDiscountCoupon;
  }

  public void setAmountDiscountCoupon(int amountDiscountCoupon) {
    this.amountDiscountCoupon = amountDiscountCoupon;
  }

  public int getAmountDiscountPoint() {
    return amountDiscountPoint;
  }

  public void setAmountDiscountPoint(int amountDiscountPoint) {
    this.amountDiscountPoint = amountDiscountPoint;
  }

  public int getAmountFinal() {
    return amountFinal;
  }

  public void setAmountFinal(int amountFinal) {
    this.amountFinal = amountFinal;
  }

  public String getMethod() {
    return method;
  }

  public void setMethod(String method) {
    this.method = method;
  }

  public String getDetail() {
    return detail;
  }

  public void setDetail(String detail) {
    this.detail = detail;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public Timestamp getPaidDate() {
    return paidDate;
  }

  public void setPaidDate(Timestamp paidDate) {
    this.paidDate = paidDate;
  }

  public Timestamp getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Timestamp createdDate) {
    this.createdDate = createdDate;
  }

  public Timestamp getModifiedDate() {
    return modifiedDate;
  }

  public void setModifiedDate(Timestamp modifiedDate) {
    this.modifiedDate = modifiedDate;
  }

  public int getAccountKey() {
    return accountKey;
  }

  public void setAccountKey(int accountKey) {
    this.accountKey = accountKey;
  }
}
