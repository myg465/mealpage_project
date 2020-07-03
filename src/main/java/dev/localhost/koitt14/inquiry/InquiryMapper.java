package dev.localhost.koitt14.inquiry;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InquiryMapper {
  // 목록 출력
  public ArrayList<InquiryListVo> readList(Object accountKey, int offset, int rowsPerPage);
  public int getCount(Object accountKey);

  // 검색목록 출력
  public ArrayList<InquiryListVo> searchTitleList(Object accountKey, String keyword, int offset, int rowsPerPage);
  public int getSearchTitleCount(Object accountKey, String keyword);

  public ArrayList<InquiryListVo> searchContentList(Object accountKey, String keyword, int offset, int rowsPerPage);
  public int getSearchContentCount(Object accountKey, String keyword);

  public ArrayList<InquiryListVo> searchReplyList(Object accountKey, String keyword, int offset, int rowsPerPage);
  public int getSearchReplyCount(Object accountKey, String keyword);

  // 게시물 읽기
  public InquiryVo readInquiry(Object accountKey, int key);

  // 게시물 쓰기
  public void writeInquiry(String category, String title, String content, String filename, Object accountKey);

  // 게시물 수정
  public void modifyInquiry(String category, String title, String content, String filename, Object accountKey, int key);

  public void deleteInquiry(Object accountKey, int key);

  /* 관리자 페이지용 메소드 시작 */
  // 목록 출력
  public ArrayList<InquiryAccountListVo> readAllList(int offset, int rowsPerPage);
  public int getAllCount();
  public int getNoReplyCount();
  
  // 게시물 읽기
  public InquiryAccountVo readInquiryByAdmin(int key);

  // 검색목록 출력
  public ArrayList<InquiryAccountListVo> searchNameListByAdmin(String keyword, int offset, int rowsPerPage);
  public int getSearchNameCountByAdmin(String keyword);

  public ArrayList<InquiryAccountListVo> searchTitleListByAdmin(String keyword, int offset, int rowsPerPage);
  public int getSearchTitleCountByAdmin(String keyword);

  public ArrayList<InquiryAccountListVo> searchContentListByAdmin(String keyword, int offset, int rowsPerPage);
  public int getSearchContentCountByAdmin(String keyword);

  // 게시물 삭제
  public void deleteInquiryByAdmin(int key);

  // 게시물 답변하기
  public void replyInquiry(String reply, int key);

  // 게시물 답변 수정
  public void modifyReply(String reply, int key);

  // 게시물 답변 삭제
  public void deleteReply(int key);
}
