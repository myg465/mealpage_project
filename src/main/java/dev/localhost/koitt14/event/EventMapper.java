package dev.localhost.koitt14.event;

import java.sql.Date;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import dev.localhost.koitt14.product.WishListVo;

@Mapper
public interface EventMapper {
	
	// 이벤트 전체 리스트
	public ArrayList<EventVo> eventList(int startRow, int limit);
	// 이벤트 전체 리스트 개수
	public int getEventListCount();
	
	// 이벤트 검색
	public ArrayList<EventVo> eventSearch(String searchLikeSql, int startRow, int limit);
	// 이벤트 검색 리스트 개수
	public int getEventSearchCount(String searchLikeSql);
	
	// 위시 리스트(찜한 상품) 정보 가져오기
	public ArrayList<WishListVo> getWishList(int accountKey);
	
	// 이벤트 상세보기
	public EventVo eventView(int seqKey);
	
	// 관리자단
	// 관리자단 이벤트 작성
	public int eventWrite(String title, String content, Date startDate, Date endDate, 
			String titleImageFileName, String contentImageFileName, int accountKey);
	
	// 관리자단 이벤트 수정 페이지
	public EventVo eventModifyView(int seqKey);
	
	// 관리자단 이벤트 수정
	public int eventModify(String title, String titleImageFileName, String content, String contentImageFileName,
			  Date startDate, Date endDate, int accountKey, int seqKey);
	
	// 관리자단 이벤트 삭제
	public int eventDelete(int seqKey);
	
	
//  public ArrayList<EventVo> readList();
//  public EventVo readRow(String key);
//  public void writeRow(String value);
//  public void modifyRow(String key, String value);
//  public void deleteRow(String key);
}
