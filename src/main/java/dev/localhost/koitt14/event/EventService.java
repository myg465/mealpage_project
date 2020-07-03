package dev.localhost.koitt14.event;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dev.localhost.koitt14.product.WishListVo;

@SuppressWarnings("all")
@Service
public class EventService {
  @Autowired
  private EventMapper eventMapper;

  // 이벤트 전체리스트 및 페이징
  public void eventList(Model model) {
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int eventState = Integer.parseInt(model.asMap().get("eventState").toString());
	  
	  //페이징
	  int page = 1;
	  int limit = 5;
	  
	  if(nowPage != 1) {
		  page = nowPage;
	  }
	  
	  // 이벤트 게시글 수
	  int listCount = eventMapper.getEventListCount();

	  // 최대 페이지 수
	  int maxPage = (int)((double)listCount/limit+0.95);
	  
	  // 처음페에지
	  int startPage = ((int)((double)page/10+0.9)-1)*10+1;
	  
	  // 마지막 페이지
	  int endPage = maxPage;
	  if(endPage > startPage + 10 -1) {
		  endPage = startPage + 10 -1;
	  }
	  
	  int startRow = (page-1)*limit;
	  
	  model.addAttribute("page", page);
	  model.addAttribute("maxPage", maxPage);
	  model.addAttribute("startPage", startPage);
	  model.addAttribute("endPage", endPage);
	  
	  ArrayList<EventVo> list = eventMapper.eventList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("eventList", list);
	  
	  model.addAttribute("eventState", eventState);
	  
  }
  
  // 이벤트 페이지 검색
  public void eventSearch(Model model) {
	  HttpServletRequest request = (HttpServletRequest)model.asMap().get("request");
	  
	  String searchClassification = request.getParameter("searchClassification");
	  String searchInput = request.getParameter("searchInput");
	  
	  if(searchClassification == null) {
		  searchClassification = model.asMap().get("searchClassification").toString();
		  searchInput = model.asMap().get("searchInput").toString();
	  }
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int eventState = Integer.parseInt(model.asMap().get("eventState").toString());
	  
	  String searchLikeSql = "";
	  
	  if(searchClassification.equals("title")) {
		searchLikeSql = "title like '%"+searchInput+"%'";
	  }
	  else if(searchClassification.equals("content")) {
		searchLikeSql = "content like '%"+searchInput+"%'"; 
	  }
	  else if(searchClassification.equals("all")) {
		searchLikeSql = "title like '%"+searchInput+"%' or content like '%"+searchInput+"%'";	  
	  }
	  
	  int listCount = eventMapper.getEventSearchCount(searchLikeSql);

	  //페이징
	  int page = 1;
	  int limit = 5;
	  
	  if(nowPage != 1) {
		  page = nowPage;
	  }
	  
	  // 최대 페이지 수
	  int maxPage = (int)((double)listCount/limit+0.95);
	  
	  // 처음페이지
	  int startPage = ((int)((double)page/10+0.9)-1)*10+1;
	  
	  // 마지막 페이지
	  int endPage = maxPage;
	  if(endPage>startPage+10-1) {
		  endPage = startPage+10-1;
	  }
	  
	  int startRow = (page-1)*limit;
	  
	  model.addAttribute("page", page);
	  model.addAttribute("maxPage", maxPage);
	  model.addAttribute("startPage", startPage);
	  model.addAttribute("endPage", endPage);
	  
	  ArrayList<EventVo> list = eventMapper.eventSearch(searchLikeSql, startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("eventList", list);
	  
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("eventState", eventState);
	  
  }
  
  // 이벤트 페이지의 위시리스트
  public void getWishList(HttpSession session, Model model) {
	  int accountKey = 0;
	  // 세션의 이름 정보를 가져옴
	  Enumeration sessions = session.getAttributeNames();
	  while(sessions.hasMoreElements()) {
		  // 세션에 accountKey가 있으면 세션의 값을 받음 아니면 0
		  if(sessions.nextElement().toString().contains("accountKey")) {
			  accountKey = (int)session.getAttribute("accountKey");
		  }
		  else {
			  accountKey=0;
		  }
	  }
	  
	  ArrayList<WishListVo> list = eventMapper.getWishList(accountKey);

	  model.addAttribute("wishList", list);
	  
	  model.addAttribute("accountKey", accountKey);
  }
  
  // 이벤트 상세보기
  public void eventView(Model model) {
	  int seqKey = Integer.parseInt(model.asMap().get("seqKey").toString());
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  
	  EventVo eventVo = eventMapper.eventView(seqKey);
	  
	  //개행문자를 <br>로 만들어 화면단에서 출력시 한줄로 나오는것을 방지
	  String content = eventVo.getContent().replace("\n", "<br/>");
	  eventVo.setContent(content);
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("eventView", eventVo);
	  
	  int page = 1;
	  int limit = 5;
	  
	  if(nowPage != 1) {
		  page = nowPage;
	  }
	  
	  int listCount = eventMapper.getEventListCount();
	  int maxPage =	(int)((double)listCount/limit+0.95);
	  int startPage = ((int)((double)page/10+0.9)-1)*10+1;
	  int endPage = maxPage;
	  if(endPage>startPage+10-1) {
		  endPage = startPage+10-1;
	  }
	  int startRow = (page-1)*limit;
	  
	  model.addAttribute("page", page);
	  model.addAttribute("maxPage", maxPage);
	  model.addAttribute("startPage", startPage);
	  model.addAttribute("endPage", endPage);
	  
	  ArrayList<EventVo> list = eventMapper.eventList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("eventList", list);
  }
  
  
  // 관리자단
  // 관리자단 이벤트 작성
  public void eventWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String path_ = session.getServletContext().getRealPath("");
	  String path = path_ + "files/event";
	  
	  int size = 1024 * 1024 * 1; // 1Mbyte
	  
	  try {
		MultipartRequest multi = new MultipartRequest(request, path, size, 
												"UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("adminEventWriteTitle");
		String content = multi.getParameter("adminEventWriteContent");
		Date startDate = Date.valueOf(multi.getParameter("adminEventWriteStartDate"));
		Date endDate = Date.valueOf(multi.getParameter("adminEventWriteEndDate"));
//		Timestamp startDate = Timestamp.valueOf(multi.getParameter("adminEventWriteStartDate"));
//		Timestamp endDate = Timestamp.valueOf(multi.getParameter("adminEventWriteEndDate"));
		
		Enumeration files = multi.getFileNames();
		String titleFileName = (String)files.nextElement();
		String titleImageFileName = multi.getFilesystemName(titleFileName);
		String contentFileName = (String)files.nextElement();
		String contentImageFileName = multi.getFilesystemName(contentFileName);
		
		int insertCheck = eventMapper.eventWrite(title, content, startDate, endDate, 
									titleImageFileName, contentImageFileName, accountKey);
		
		redirect.addAttribute("insertCheck", insertCheck);
		
	} catch (IOException e) {
		e.printStackTrace();
	}
  }

  // 관리자단 이벤트 수정 페이지
  public void eventModifyView(int seqKey, int nowPage, Model model) {
	  
	  EventVo eventVo = eventMapper.eventModifyView(seqKey);
	  
	  model.addAttribute("eventVo", eventVo);
	  model.addAttribute("page", nowPage);
  }
  
  // 관리자단 이벤트 수정
  public void eventModify(HttpServletRequest request, int seqKey, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String path_ = session.getServletContext().getRealPath("");
	  String path = path_ + "files/event";
	 
	  int size = 1024 * 1024 * 1; // 1Mbyte
	  
	  try {
		MultipartRequest multi = new MultipartRequest(request, path, size, 
										"UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("adminEventModifyTitle");
		String content = multi.getParameter("adminEventModifyContent");
		Date startDate = Date.valueOf(multi.getParameter("adminEventModifyStartDate"));
		Date endDate = Date.valueOf(multi.getParameter("adminEventModifyEndDate"));
		String originTitleFileName = multi.getParameter("originTitleFileName");
		String originCotentFileName = multi.getParameter("originCotentFileName");
		
		Enumeration files = multi.getFileNames();
		String titleFileName = (String)files.nextElement();
		String titleImageFileName = multi.getFilesystemName(titleFileName);
		String contentFileName = (String)files.nextElement();
		String contentImageFileName = multi.getFilesystemName(contentFileName);
		
		// 수정을 통해 저장 할 이미지파일이 없는 경우 원래 파일이름으로 대체
		if(titleImageFileName == null || titleImageFileName.equals("")) {
			titleImageFileName = originTitleFileName;
		}
		if(contentImageFileName == null || contentImageFileName.equals("")) {
			contentImageFileName = originCotentFileName;
		}
		
		// 이미지 파일이 바뀌는 경우 이전파일 삭제
		if(!(titleImageFileName.equals(originTitleFileName))){
			File f = new File(path + "/" + originTitleFileName);
			f.delete();
		}
		if(!(contentImageFileName.equals(originCotentFileName))) {
			File f = new File(path + "/" + originCotentFileName);
			f.delete();
		}
		
		int updateCheck = eventMapper.eventModify(title, titleImageFileName, content, contentImageFileName,
												  startDate, endDate, accountKey, seqKey);
		
		redirect.addAttribute("updateCheck", updateCheck);
		
	} catch (IOException e) {
		e.printStackTrace();
	}
  }
  
  
  // 관리자단 이벤트 삭제
  public void eventDelete(HttpServletRequest request, int seqKey, 
		  				  String titleImageFileName, String contentImageFileName,
		  				  RedirectAttributes redirect) {
	  String path_ = request.getSession().getServletContext().getRealPath("");
	  String path = path_ + "files/event";
	  
	  if(!(titleImageFileName.equals("titleNothing"))) {
		  File f = new File(path + "/" + titleImageFileName);
		  f.delete();
	  }
	  if(!(contentImageFileName.equals("contentNothing"))) {
		  File f = new File(path + "/" + contentImageFileName);
		  f.delete();
	  }
	  
	  int deleteCheck = eventMapper.eventDelete(seqKey);
	  
	  redirect.addAttribute("deleteCheck", deleteCheck);
  }
  
  
  
  
  
  
  
  
  
  
}
