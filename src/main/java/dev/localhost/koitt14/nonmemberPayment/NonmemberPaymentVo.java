package dev.localhost.koitt14.nonmemberPayment;

import java.sql.Timestamp;

public class NonmemberPaymentVo {

	  public NonmemberPaymentVo(int seqKey, String ordererName, String ordererAddressZipcode, String ordererAddressNew,
			String ordererAddressOld, String ordererAddressDetail, String ordererAddressExtra, String ordererEmail,
			String ordererPhone, String recipientName, String recipientAddressZipcode, String recipientAddressNew,
			String recipientAddressOld, String recipientAddressDetail, String recipientAddressExtra,
			String recipientPhone, String recipientRequest, int amountTotal, int amountDelivery, int amountFinal,
			String method, String detail, String status, Timestamp paidDate, Timestamp createdDate,
			Timestamp modifiedDate) {
		super();
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
		this.amountFinal = amountFinal;
		this.method = method;
		this.detail = detail;
		this.status = status;
		this.paidDate = paidDate;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
	}
	  
	  
	int seqKey;
	  
	  String ordererName; // 주문자
	  String ordererAddressZipcode;
	  String ordererAddressNew;
	  String ordererAddressOld;
	  String ordererAddressDetail;
	  String ordererAddressExtra;
	  String ordererEmail;
	  String ordererPhone;
	  
	  String recipientName; // 수취자
	  String recipientAddressZipcode;
	  String recipientAddressNew;
	  String recipientAddressOld;
	  String recipientAddressDetail;
	  String recipientAddressExtra;
	  String recipientPhone;
	  String recipientRequest; // 배송 시 요구사항
	  
	  int amountTotal; // 총주문금액
	  int amountDelivery; // 배송비
	  int amountFinal; // 최종 결제금액
	  
	  String method; // 결제수단
	  String detail; // 결제내용 상세
	  String status; // 결제상태
	  Timestamp paidDate; // 결제일
	  Timestamp createdDate;
	  Timestamp modifiedDate;
	  
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
	  
	  
	
}
