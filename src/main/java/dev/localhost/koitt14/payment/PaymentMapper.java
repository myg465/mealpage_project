package dev.localhost.koitt14.payment;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
  public PaymentVo selectPayment(int key);

  public void insertPayment(
    String ordererName, String ordererAddressZipcode, String ordererAddressNew, String ordererAddressOld, String ordererAddressDetail, String ordererAddressExtra, String ordererEmail, String ordererPhone,
    String recipientName, String recipientAddressZipcode, String recipientAddressNew, String recipientAddressOld, String recipientAddressDetail, String recipientAddressExtra, String recipientPhone, String recipientRequest,
    int amountTotal, int amountDelivery, int amountDiscountCoupon, int amountDiscountPoint, int amountFinal,
    String method, String detail, String status, String paidDate, Object accountKey);

  public int getPaymentKey(Object accountKey);
  public int getNonmemberKey(String ordererPhone);

  public String getStatus(int paymentKey, Object accountKey);

  public void insertNonmemberPayment(
    String ordererName, String ordererAddressZipcode, String ordererAddressNew, String ordererAddressOld, String ordererAddressDetail, String ordererAddressExtra, String ordererEmail, String ordererPhone,
    String recipientName, String recipientAddressZipcode, String recipientAddressNew, String recipientAddressOld, String recipientAddressDetail, String recipientAddressExtra, String recipientPhone, String recipientRequest,
    int amountTotal, int amountDelivery, int amountFinal,
    String method, String detail, String status, String paidDate);

  public void updateStatus(String status, int paymentKey, Object accountKey);

  public void updateStatusByAdmin(String status, int paymentKey);
}
