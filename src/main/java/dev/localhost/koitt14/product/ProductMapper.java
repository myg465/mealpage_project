package dev.localhost.koitt14.product;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import dev.localhost.koitt14.admin.BannerVo;

@Mapper
public interface ProductMapper {
    //상품리스트 관련
	public ArrayList<ProductVo> productList(String category1, String category2, int startRow, int limit);
	public ArrayList<String> categoryList(String category1);
	public int listCount(String category1,String category2);
    //상세페이지 관련
	public ProductVo detail(int seqKey);
	//검색관련
	public ArrayList<ProductVo> productSearch(String productSearch, String orderSql, int startRow);
	public ArrayList<ProductVo> productHotSearch(String productSearch, int startRow);//인기순 검색
	public int searchListCount(String productSearch);
	
	//wishlist
	public ArrayList<WishListVo> getWishList(int accountKey);
	
	//메인페이지 관련
	public ArrayList<ProductVo> saleProduct();// 세일제품얻기
	public ProductVo newProduct();// 신제품 얻기
	public ArrayList<ProductVo> recommendProduct();// 추천제품 얻기
	public ArrayList<ProductVo> bestProduct(); //베스트 셀러 얻기
	public ArrayList<String> getBanner(String category);// 배너얻기
	
	//nav 관련
	public int navNum(); //1차메뉴 카운트 얻기
	public String[] navCategory1(); // 1차메뉴 리스트 얻기
	public ArrayList<String> navCategory2(String category1); //2차메뉴 리스트 얻기
	
	//재고 체크
	public int stockCheck(int seqKey);
	
	//결제시 재고감소
	public int stockDown(int quantity, int seqKey);
	
	//반품,취소,환불,교환시 재고증가
	public int stockUp(int quantity, int seqKey);
	
	//=====================================관리자 전용============================================//
	
	//상품전체 얻기
	public ArrayList<ProductVo> productListAll(int productStartRow,String search,String sqlOrder);
	public int productListSearchCount(String search); //검색카운트
	//상품등록
	public int productInsert(String category1,String category2,String name,int price,int stock,int calorie,String type,String volume,String importer,
						String importDeclaration,String productor,String useByDate,int salePercent,String rawMaterials,String nutrients,
						String gmFood,String csPhone,String recommend,String newProduct,String contentText,
						String detailImageFilename1,String detailImageFilename2,String detailImageFilename3,String contentImageFilename);
	//상품수정
	public int productModify(String category1,String category2,String name,int price,int stock,int calorie,String type,String volume,String importer,
						String importDeclaration,String productor,String useByDate,int salePercent,String rawMaterials,String nutrients,
						String gmFood,String csPhone,String recommend,String newProduct,String contentText,
						String detailImageFilename1,String detailImageFilename2,String detailImageFilename3,String contentImageFilename,int seqKey);
	//상품삭제
	public int productDelete(int seqKey);
	
	//배너전체리스트 얻기
	public ArrayList<BannerVo> getBannerList();
	
	//배너등록
	public int bannerInsert(String category,String filename);

	//배너수정뷰 얻기
	public BannerVo bannerModifyView(int seqKey);
	
	//배너수정
	public int bannerModify(String category, String filename, int seqKey);
	
	//배너삭제
	public int bannerDelete(int seqKey);
	
	
	
	
	
  
}
