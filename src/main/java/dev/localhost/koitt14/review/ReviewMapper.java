package dev.localhost.koitt14.review;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewMapper {
	
    //일반리뷰
	public ArrayList<ReviewVo> reviewList(int seqKey, int reviewStartRow);
	public int reviewListCount(int seqKey);
	
	//평점얻기
	public int gradeAvg(int seqKey);
	
	//배송상태 얻기
	public HashMap<String, String> status(int seqKey, int accountKey);
	
	//리뷰작성
	public int reviewWrite(int accountKey,int productKey,int grade,String content,String imageFileName);
	
	//리뷰작성시 상태변경
	public void reviewStatusChange(int accountKey,int productKey);
	
	//리뷰수정뷰
	public ReviewVo reviewModifyView(int seqKey);
	
	//리뷰 수정
	public int reviewModify(int seqKey,int grade,String content,String imageFileName);
	
	//리뷰 삭제
	public int reviewDelete(int seqKey);
	
	//=====================================관리자 전용============================================//
	
	//리뷰전체 얻기
	public ArrayList<ReviewVo> reviewListAll(int reviewStartRow,String search,String sqlOrder);
	public int reviewListSearchCount(String search); //검색카운트
  
  
}
