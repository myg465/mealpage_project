package dev.localhost.koitt14.inquiry;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class InquiryService {
  // 페이지 당 게시물 출력 수 (최소 2 이상)
  int rowsPerPage = 10;
  // 게시판 하단에 표시되는 이동 가능 페이지 수
  int pageSet = 5;

  @Autowired
  private InquiryMapper inquiryMapper;

  // 목록 읽기
  public void readList(int page, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = inquiryMapper.getCount(accountKey);
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("inquiryList", inquiryMapper.readList(accountKey, offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("count", count);
  }

  // 게시물 읽기
  public void readInquiry(int key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("inquiry", inquiryMapper.readInquiry(accountKey, key));
  }
  
  // 검색결과 목록 표시
  public void searchList(String type, String keyword, int page, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = 0;

    switch (type) {
      case "title":
        model.addAttribute("inquiryList", inquiryMapper.searchTitleList(accountKey, "%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchTitleCount(accountKey, "%" + keyword + "%");      
        break;
      case "content":
        model.addAttribute("inquiryList", inquiryMapper.searchContentList(accountKey, "%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchContentCount(accountKey, "%" + keyword + "%");      
        break;
      default:
        model.addAttribute("inquiryList", inquiryMapper.searchReplyList(accountKey, "%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchReplyCount(accountKey, "%" + keyword + "%");      
        break;
    }

    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("type", type);
    model.addAttribute("keyword", keyword);
    model.addAttribute("count", count);
  }

  // 게시물 쓰기
  @SuppressWarnings("deprecation")
  public String writeInquiry(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    String category = "";
    String title = "";
    String content = "";
    String filename = "";
    String result = "pass";

    // 업로드 가능한 파일 최대용량: 1MB
    int size = 1024 * 1024 * 1;

    try{
      String path = request.getRealPath("/files/inquiry");
      MultipartRequest multiReq = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());

      category = multiReq.getParameter("category");
      title = multiReq.getParameter("title");
      content = multiReq.getParameter("content");
      
      Enumeration<?> file = multiReq.getFileNames();
      String fileStr = (String) file.nextElement();      
      filename = multiReq.getFilesystemName(fileStr);  

      inquiryMapper.writeInquiry(category, title, content, filename, accountKey);

    } catch(Exception e) {
      String message = e.getMessage();

      // 용량 한도를 초과한 파일을 올린 경우
      if (message.contains("limit")) {
        result = "limit";
      } else {
        result = "fail";
      }
    }

    return result;
  }

  // 게시물 수정
  @SuppressWarnings("deprecation")
  public void modifyInquiry(int page, int key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    MultipartRequest multiReq = null;

    try {
      String path = request.getRealPath("/files/inquiry");
      // 업로드 가능한 파일 최대용량: 1MB
      int size = 1024 * 1024 * 1;
  
      multiReq = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());    
    } catch (Exception e) {
      e.printStackTrace();
    }

    String category = multiReq.getParameter("category");
    String title = multiReq.getParameter("title");
    String content = multiReq.getParameter("content");
    String attached = multiReq.getParameter("attached");
    String filename = "";
    
    switch (attached) {
      case "hold":
        filename = multiReq.getParameter("filename");
        break;    
      case "delete":
        filename = null;
        break;
      case "change":
        Enumeration<?> file = multiReq.getFileNames();
        String fileStr = (String) file.nextElement();      
        filename = multiReq.getFilesystemName(fileStr);
    }

    inquiryMapper.modifyInquiry(category, title, content, filename, accountKey, key);
    model.addAttribute("page", page);
    model.addAttribute("key", key);
  }

  // 게시물 삭제
  public void deleteInquiry(int key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    inquiryMapper.deleteInquiry(accountKey, key);
  }

  /* 관리자 페이지용 메소드 시작*/
  // 목록 읽기
  public void readListByAdmin(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = inquiryMapper.getAllCount();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("inquiryList", inquiryMapper.readAllList(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }

  // 게시물 읽기
  public void readInquiryByAdmin(int key, Model model) {
    model.addAttribute("inquiry", inquiryMapper.readInquiryByAdmin(key));
  }

  // 검색결과 목록 표시
  public void searchAllList(String type, String keyword, int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = 0;

    switch (type) {
      case "title":
        model.addAttribute("inquiryList", inquiryMapper.searchTitleListByAdmin("%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchTitleCountByAdmin("%" + keyword + "%");      
        break;
      case "content":
        model.addAttribute("inquiryList", inquiryMapper.searchContentListByAdmin("%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchContentCountByAdmin("%" + keyword + "%");      
        break;
      default:
        model.addAttribute("inquiryList", inquiryMapper.searchNameListByAdmin("%" + keyword + "%", offset, rowsPerPage));
        count = inquiryMapper.getSearchNameCountByAdmin("%" + keyword + "%");      
        break;
    }

    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("type", type);
    model.addAttribute("keyword", keyword);
  }

  // 게시물 삭제
  public void deleteInquiryByAdmin(int key, Model model) {
    inquiryMapper.deleteInquiryByAdmin(key);
  }

  // 게시물 답변하기
  public void replyInquiry(int key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    String reply = request.getParameter("reply");

    inquiryMapper.replyInquiry(reply, key);
  }

  // 게시물 답변 수정
  public void modifyReply(int key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    String reply = request.getParameter("reply");

    inquiryMapper.modifyReply(reply, key);
  }

  // 게시물 답변 삭제
  public void deleteReply(int key) {
    inquiryMapper.deleteReply(key);
  }

  // 답변상태 count를 가져오는 메소드
  public int getReplyStatusCount(String status) {
    int allCount = inquiryMapper.getAllCount();
    int noReplyCount = inquiryMapper.getNoReplyCount();
    int count = -1;

    switch (status) {
      case "답변대기":
        count = noReplyCount;
        break;
      case "답변완료":
        count = allCount - noReplyCount;
    }
  
    return count;
  } 
}
