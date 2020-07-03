package dev.localhost.koitt14.nonmember;

import java.sql.Timestamp;

public class NonmemberPayAndOrderVo {

	public NonmemberPayAndOrderVo() {}
	
	
	public NonmemberPayAndOrderVo(String productName, int productPrice, int quantity, String trackingNumber,
			String deliveryCompany, Timestamp createdDate, String recipientName, String recipientPhone,
			String recipientAddressNew, String recipientAddressOld, String recipientAddressDetail,
			String recipientRequest, String method, String status, int amountDelivery, int amountFinal) {
		this.productName = productName;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.trackingNumber = trackingNumber;
		this.deliveryCompany = deliveryCompany;
		this.createdDate = createdDate;
		this.recipientName = recipientName;
		this.recipientPhone = recipientPhone;
		this.recipientAddressNew = recipientAddressNew;
		this.recipientAddressOld = recipientAddressOld;
		this.recipientAddressDetail = recipientAddressDetail;
		this.recipientRequest = recipientRequest;
		this.method = method;
		this.status = status;
		this.amountDelivery = amountDelivery;
		this.amountFinal = amountFinal;
	}

	//------------주문테이블--------------
	String productName; //주문상품명
	int productPrice; //주문했던 당시의 상품가격
	int quantity; //주문수량
	String trackingNumber; //송장번호(배송보냈을때만 표시)
	String deliveryCompany; //배송택배사
	Timestamp createdDate; //주문일
	//------------결제테이블--------------
	String recipientName; //수령자이름
	String recipientPhone; //수령자 핸드폰번호
	String recipientAddressNew; //수령지 신주소
	String recipientAddressOld; //수령지 구주소
	String recipientAddressDetail; //수령지 상세주소
	String recipientRequest; //배송시 요청사항
	String method; //결제수단
	String status; //결제상태
	int amountDelivery; // 배송비
	int amountFinal; //총결제금액
	
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
	public String getTrackingNumber() {
		return trackingNumber;
	}
	public void setTrackingNumber(String trackingNumber) {
		this.trackingNumber = trackingNumber;
	}
	public String getDeliveryCompany() {
		return deliveryCompany;
	}
	public void setDeliveryCompany(String deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getRecipientPhone() {
		return recipientPhone;
	}
	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
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
	public String getRecipientRequest() {
		return recipientRequest;
	}
	public void setRecipientRequest(String recipientRequest) {
		this.recipientRequest = recipientRequest;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	
	
}
