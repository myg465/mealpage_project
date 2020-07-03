package dev.localhost.koitt14.productInquiry;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ProductInquiryMapper {
	
    //상품문의 얻기
	public ArrayList<ProductInquiryVo> productInquiryList(int seqKey, int inquiryStartRow);
	public int inquiryListCount(int seqKey);

	//상품문의 작성
	public int inquiryWrite(int accountKey,int productKey,String secret,String content);
	
	//상품문의수정뷰
	public ProductInquiryVo inquiryModifyView(int seqKey);
	
	//상품문의 수정
	public int inquiryModify(int seqKey,String secret,String content);
	
	//상품문의 삭제
	public int inquiryDelete(int seqKey);
	
	//=====================================관리자 전용============================================//
	
	//상품문의전체 얻기
	public ArrayList<ProductInquiryVo> inquiryListAll(int inquiryStartRow,String search,String sqlOrder);
	
	public int inquiryListSearchCount(String search); //검색카운트
	//답변달기
	public int replyInsert(int seqKey,String replyContent);
	//답변수정
	public int replyModify(int seqKey,String replyModify);
	
	//전체카운트
	public int inquiryCount(String status);
  
  
}
