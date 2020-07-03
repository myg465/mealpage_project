package dev.localhost.koitt14.product;

public class ProductVo {
 
	//기본생성자
	
	public ProductVo() {}
	
	//생성자

	private int seqKey; //상품코드
	public ProductVo(int seqKey, String category1, String category2, String name, int price, int stock, int calorie,
			String type, String productor, String importer, String importDeclaration, String useByDate, String volume,
			String rawMaterials, String nutrients, String gmFood, String csPhone, String recommend, String newProduct,
			int salePercent, String detailImageFilename1, String detailImageFilename2, String detailImageFilename3,
			String contentText, String contentImageFilename) {
		super();
		this.seqKey = seqKey;
		this.category1 = category1;
		this.category2 = category2;
		this.name = name;
		this.price = price;
		this.stock = stock;
		this.calorie = calorie;
		this.type = type;
		this.productor = productor;
		this.importer = importer;
		this.importDeclaration = importDeclaration;
		this.useByDate = useByDate;
		this.volume = volume;
		this.rawMaterials = rawMaterials;
		this.nutrients = nutrients;
		this.gmFood = gmFood;
		this.csPhone = csPhone;
		this.recommend = recommend;
		this.newProduct = newProduct;
		this.salePercent = salePercent;
		this.detailImageFilename1 = detailImageFilename1;
		this.detailImageFilename2 = detailImageFilename2;
		this.detailImageFilename3 = detailImageFilename3;
		this.contentText = contentText;
		this.contentImageFilename = contentImageFilename;
	}

	private String category1; //대분류
	private String category2; //중분류
	private String name; //제품명-
	private int price; //가격
	private int stock; //재고수량
	private int calorie; //칼로리정보-
	private String type; //식품유형-
	private String productor; //생산자 및 소재지-
	private String importer; //수입자-
	private String importDeclaration; //수입신고필 정보-
	private String useByDate; //제조연원일 및 유통기한-
	private String volume; //포장단위별 용량(수량)-
	private String rawMaterials; //원재료명 및 함량-
	private String nutrients; //영양성분표시-
	private String gmFood; //유전자재조합 식품 여부-
	private String csPhone; //소비자상담 전화번호-
	private String recommend; //추천상품 여부
	private String newProduct; //신규상품 여부
	private int salePercent; //세일상품 여부 (할인율 0% = 세일상품 아님)
	private String detailImageFilename1; //상품 이미지 1 (썸네일)
	private String detailImageFilename2; //상품이미지2
	private String detailImageFilename3; //상품이미지3
	private String contentText; //상품상세설명
	private String contentImageFilename; //상세설명이미지
	
	//getter and setter
	
	public int getSeqKey() {
		return seqKey;
	}

	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}

	public String getCategory1() {
		return category1;
	}

	public void setCategory1(String category1) {
		this.category1 = category1;
	}

	public String getCategory2() {
		return category2;
	}

	public void setCategory2(String category2) {
		this.category2 = category2;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getCalorie() {
		return calorie;
	}

	public void setCalorie(int calorie) {
		this.calorie = calorie;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProductor() {
		return productor;
	}

	public void setProductor(String productor) {
		this.productor = productor;
	}

	public String getImporter() {
		return importer;
	}

	public void setImporter(String importer) {
		this.importer = importer;
	}

	public String getImportDeclaration() {
		return importDeclaration;
	}

	public void setImportDeclaration(String importDeclaration) {
		this.importDeclaration = importDeclaration;
	}

	public String getUseByDate() {
		return useByDate;
	}

	public void setUseByDate(String useByDate) {
		this.useByDate = useByDate;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getRawMaterials() {
		return rawMaterials;
	}

	public void setRawMaterials(String rawMaterials) {
		this.rawMaterials = rawMaterials;
	}

	public String getNutrients() {
		return nutrients;
	}

	public void setNutrients(String nutrients) {
		this.nutrients = nutrients;
	}

	public String getGmFood() {
		return gmFood;
	}

	public void setGmFood(String gmFood) {
		this.gmFood = gmFood;
	}

	public String getCsPhone() {
		return csPhone;
	}

	public void setCsPhone(String csPhone) {
		this.csPhone = csPhone;
	}

	public String getDetailImageFilename1() {
		return detailImageFilename1;
	}

	public void setDetailImageFilename1(String detailImageFilename1) {
		this.detailImageFilename1 = detailImageFilename1;
	}

	public String getDetailImageFilename2() {
		return detailImageFilename2;
	}

	public void setDetailImageFilename2(String detailImageFilename2) {
		this.detailImageFilename2 = detailImageFilename2;
	}

	public String getDetailImageFilename3() {
		return detailImageFilename3;
	}

	public void setDetailImageFilename3(String detailImageFilename3) {
		this.detailImageFilename3 = detailImageFilename3;
	}

	public String getContentText() {
		return contentText;
	}

	public void setContentText(String contentText) {
		this.contentText = contentText;
	}

	public String getContentImageFilename() {
		return contentImageFilename;
	}

	public void setContentImageFilename(String contentImageFilename) {
		this.contentImageFilename = contentImageFilename;
	}

	public String getRecommend() {
		return recommend;
	}

	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}

	public String getNewProduct() {
		return newProduct;
	}

	public void setNewProduct(String newProduct) {
		this.newProduct = newProduct;
	}

	public int getSalePercent() {
		return salePercent;
	}

	public void setSalePercent(int salePercent) {
		this.salePercent = salePercent;
	}
	
	
}
