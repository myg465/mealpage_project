package dev.localhost.koitt14.customer;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {
	
	// 공지사항 전체 리스트 가져오기
	public ArrayList<CustomerNoticeVo> noticeList(int startRow, int limit);
	// 공지사항 전체 리스트 개수
	public int getNoticeListCount();
	// 공지사항 검색 결과 리스트 가져오기
	public ArrayList<CustomerNoticeVo> noticeSearch(String searchLikeSql, int startRow, int limit);
	// 공지사항 검색 결과 리스트 개수
	public int getNoticeSearchCount(String searchLikeSql);
	
	// 공지사항 상세 보기
	public CustomerNoticeVo noticeView(int seqKey);
	// 공지사항 상세 보기 시 하단 리스트 출력에 필요한 rnum
	public int getRnum(int seqKey);
	
	// 관리자단 공지사항
	// 관리자단 공지사항 쓰기
	public int noticeWrite(String title, String content, String imageFileName, int accountKey);
	// 관리자단 공지사항 수정페이지
	public CustomerNoticeVo noticeModifyView(int seqKey);
	// 관리자단 공지사항 수정
	public int noticeModify(String title, String content, String imageFileName, int accountKey, int seqKey);
	// 관리자단 공지사항 삭제
	public int noticeDelete(int seqKey);
	
	
	//---------------------------------------------------------------------------------------
	
	// 비회원 1:1 문의 작성
	public int nonmemberInquiryWrite(String name, String email, String tell, 
									String title, String content, String imageFileName);
	
	// 관리자단
	// 관리자단 비회원 1:1 문의 리스트
	public ArrayList<CustomerNonmemberInquiryVo> nonmemberInquriyList(int startRow, int limit);
	// 관리자단 비회원 1:1 문의 리스트 개수
	public int getNonmemberInquriyListCount();
	// 관리자단 비회원 1:1 문의 검색 리스트
	public ArrayList<CustomerNonmemberInquiryVo> nonmemberInquirySearch(String searchLikeSql, int startRow, int limit);
	// 관리자단 비회원 1:1 문의 검색 리스트 개수
	public int getNonmemberInquirySearchCount(String searchLikeSql);
	// 관리자단 비회원 1:1 문의 상세보기
	public CustomerNonmemberInquiryVo nonmemberInquiryView(int seqKey);
	// 관리자단 비회원 1:1 문의 답변하기
	public int nonmemberInquiryReply(String reply, int seqKey);
	// 관리자단 비회원 1:1 문의 삭제
	public int nonmemberInquiryDelete(int seqKey);
	
	// 관리자단 메인페이지
	// 메인페이지 비회원 1:1 문의 답변대기 개수
	public int getNonmemberInquiryNoRepeyCount();
	
	//---------------------------------------------------------------------------------------
	
	// FAQ 전체 리스트
	public ArrayList<CustomerFaqVo> faqList(int startRow, int limit);
	// FAQ 전체 리스트 개수
	public int getFaqListCount();
	// FAQ 카테고리별 리스트
	public ArrayList<CustomerFaqVo> faqCategoryList(String category, int startRow, int limit);
	// FAQ 카테고리별 리스트 개수
	public int getFaqCategoryListCount(String category);
	// FAQ 검색
	public ArrayList<CustomerFaqVo> faqSearch(String searchLikeSql, int startRow, int limit);
	// FAQ 검색 리스트 개수
	public int getFaqSearchCount(String searchLikeSql);
	
	// 관리자단 FAQ
	// 관리자단 FAQ 상세보기
	public CustomerFaqVo faqAdminView(int seqKey);
	// 관리자단 FAQ 작성
	public int faqWrite(String category, String question, String answer, int accountKey);
	// 관리자단 FAQ 수정 페이지
	public CustomerFaqVo faqModifyView(int seqKey);
	// 관리자단 FAQ 수정
	public int faqModify(String category, String question, String answer, int accountKey, int seqKey);
	// 관리자단 FAQ 삭제
	public int faqDelete(int seqKey);
	
	//---------------------------------------------------------------------------------------
	
	// 이용안내
	public ArrayList<CustomerGuideVo> guide();
	
	// 관리자단 이용안내
	// 관리자단 이용안내 리스트
	public ArrayList<CustomerGuideVo> guideList(int startRow, int limit);
	// 관리자단 이용안내 리스트 개수
	public int getGuideListCount();
	// 관리자단 이용안내 검색
	public ArrayList<CustomerGuideVo> guideSearch(String searchLikeSql, int startRow, int limit);
	// 관리자단 이용안내 검색 리스트 개수
	public int getGuideSearchCount(String searchLikeSql);
	// 관리자단 이용안내 상세보기
	public CustomerGuideVo guideView(int seqKey);
	// 관리자단 이용안내 작성
	public int guideWrite(String title, String content, int accountKey);
	// 관리자단 이용안내 수정 페이지
	public CustomerGuideVo guideModifyView(int seqKey);
	// 관리자단 이용안내 수정
	public int guideModify(String title, String content, int accountKey, int seqKey);
	// 관리자단 이용안내 삭제
	public int guideDelete(int seqkey);
	
	
}
