package dev.localhost.koitt14.nonmember;

import java.sql.Timestamp;

public class NonmemberOrderVo {
  
	private int seqKey;
	private String nonmemberName;
	private String orderNumber;
	private String productName;
	private int productPrice;
	private int quantity;
	private String status;
	private String deliveryCompany;
	private String trackingNumber;
	private Timestamp createdDate;
	private int productKey;
	private int nonmemberPaymentKey;
	
	public NonmemberOrderVo() {
		
	}
	
	public NonmemberOrderVo(int seqKey, String nonmemberName, String orderNumber,
							String productName, int productPrice, int quantity,
							String status, String deliveryCompany, String trackingNumber,
							Timestamp createdDate, int productKey, int nonmemberPaymentKey) {
		this.seqKey = seqKey;
		this.nonmemberName = nonmemberName;
		this.orderNumber = orderNumber;
		this.productName = productName;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.status = status;
		this.deliveryCompany = deliveryCompany;
		this.trackingNumber = trackingNumber;
		this.createdDate = createdDate;
		this.productKey = productKey;
		this.nonmemberPaymentKey = nonmemberPaymentKey;
	}

	public int getSeqKey() {
		return seqKey;
	}

	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}

	public String getNonmemberName() {
		return nonmemberName;
	}

	public void setNonmemberName(String nonmemberName) {
		this.nonmemberName = nonmemberName;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
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

	public int getNonmemberPaymentKey() {
		return nonmemberPaymentKey;
	}

	public void setNonmemberPaymentKey(int nonmemberPaymentKey) {
		this.nonmemberPaymentKey = nonmemberPaymentKey;
	}
	
	
}
