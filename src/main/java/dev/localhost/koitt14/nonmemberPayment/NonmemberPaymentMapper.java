package dev.localhost.koitt14.nonmemberPayment;

import org.apache.ibatis.annotations.Mapper;

import dev.localhost.koitt14.payment.PaymentVo;

@Mapper
public interface NonmemberPaymentMapper {
  
  public void insertNonmemberPayment(String ordererName,String ordererAddressZipcode,String ordererAddressNew,String ordererAddressOld,String ordererAddressDetail,String ordererAddressExtra,
		  String ordererEmail,String ordererPhone,String recipientName,String recipientAddressZipcode,String recipientAddressNew,String recipientAddressOld,
		  String recipientAddressDetail,String recipientAddressExtra,String recipientPhone,String recipientRequest,int amountTotal,int amountDelivery,
	      int amountFinal,String method,String detail,String status); //결제입력
  public int getNonmemberKey(String ordererPhone); //결제일련번호
  public Integer getOrderCount(String date); // 주문번호 생성 시 사용
  public PaymentVo getPayment(int paymentKey); //결제정보 얻기
  public PaymentVo getAdminPayment(String orderNumber); //결제정보 얻기(관리자)
  //결재 입력
  public void insertNonmemberOrder(String nonmemberName, String orderNumber, String productName, int productPrice, int quantity, String status, int productKey, int paymentKey);
  //==========================관리자 전용================================//
  public int depositOk(String orderNumber);// 입금확인(주문테이블)
  public int payDepositOk(String orderNumber);//입금확인 (결제테이블)
  public int deliveryAll(String orderNumber, String status, String deliveryCompany, String trackingNumber);//일괄배송처리
  public int deliveryOne(int seqKey, String status, String deliveryCompany, String trackingNumber);//개별배송처리
  public int refundFirst(String status, int seqKey, int total); // 최초 환불처리시
  public int refundMulti(String status, int seqKey, int total); // 두번이상 환불처리시
  
}
