package dev.localhost.koitt14.product;

public class WishListVo {
 
	//기본생성자
	
	public WishListVo() {}
	
	//생성자
	
	public WishListVo(int seqKey, int quantity, int productKey, String detailImageFilename1) {
		super();
		this.seqKey = seqKey;
		this.quantity = quantity;
		this.productKey = productKey;
		this.detailImageFilename1 = detailImageFilename1;
	}

	private int seqKey; //일련번호
	private int quantity; //수량
	private int productKey; //제품코드
	private String detailImageFilename1; //제품썸네일(조인으로 가져옴)

	//getter and setter
	
	public int getSeqKey() {
		return seqKey;
	}
	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getProductKey() {
		return productKey;
	}
	public void setProductKey(int productKey) {
		this.productKey = productKey;
	}

	public String getDetailImageFilename1() {
		return detailImageFilename1;
	}

	public void setDetailImageFilename1(String detailImageFilename1) {
		this.detailImageFilename1 = detailImageFilename1;
	}
	
	
	
	
	
	
}
