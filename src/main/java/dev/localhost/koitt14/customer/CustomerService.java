package dev.localhost.koitt14.customer;

import java.io.File;
import java.io.IOException;
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

import dev.localhost.koitt14.util.EmailSender;

@SuppressWarnings("all")
@Service
public class CustomerService {
  @Autowired
  private CustomerMapper customerMapper;
  
  @Autowired
  private EmailSender emailSender;

  // 공지사항 전체 리스트
  public void noticeList(Model model) {
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int nomalOrSearch = Integer.parseInt(model.asMap().get("nomalOrSearch").toString());
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
	  if(nowPage != 1) {
		  page = nowPage;
	  }
	  
	  // 전체 게시글 수
	  int listCount = customerMapper.getNoticeListCount();
	  
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
	  
	  ArrayList<CustomerNoticeVo> list = customerMapper.noticeList(startRow, limit);
	  int listSize = list.size(); 
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("noticelist", list);
	  
	  model.addAttribute("nomalOrSearch", nomalOrSearch);
	  
  }
  
  // 공지사항 검색
  public void noticeSearch(Model model) {
	  
	  HttpServletRequest request = (HttpServletRequest)model.asMap().get("request");
	  
	  String searchClassification = request.getParameter("searchClassification");
	  String searchInput = request.getParameter("searchInput");
	  
	  if (searchClassification == null) {
		  searchClassification = model.asMap().get("searchClassification").toString();
		  searchInput = model.asMap().get("searchInput").toString();
	  }
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int nomalOrSearch = Integer.parseInt(model.asMap().get("nomalOrSearch").toString());
	  
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
	  
	  int listCount = customerMapper.getNoticeSearchCount(searchLikeSql);
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  
	  ArrayList<CustomerNoticeVo> list = customerMapper.noticeSearch(searchLikeSql, startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("noticelist", list);
	  
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("nomalOrSearch", nomalOrSearch);
  }
  
  // 공지사항 상세보기
  public void noticeView(Model model) {
	  
	  int seqKey = Integer.parseInt(model.asMap().get("seqKey").toString()); 
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  
	  CustomerNoticeVo customerNoticeVo = customerMapper.noticeView(seqKey);
	  
	  //개행문자를 <br>로 만들어 화면단에서 출력시 한줄로 나오는것을 방지
	  String content = customerNoticeVo.getContent().replace("\n", "<br/>");
	  customerNoticeVo.setContent(content);
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("customerNoticeVo", customerNoticeVo);
	  
	  
	  int rnum = customerMapper.getRnum(seqKey);
	  
	  // 페이징
//	  int page = 1;
	  int limit = 10;
	  
	  int page_=(rnum/limit) + 1;
	  
	  int page = nowPage;
	  
	  if(nowPage == page_) {
		  page = (rnum/limit) + 1;
	  }
	  	  	  
	  // 전체 게시글 수
	  int listCount = customerMapper.getNoticeListCount();
	  
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
	  
	  ArrayList<CustomerNoticeVo> list = customerMapper.noticeList(startRow, limit);
	  int listSize = list.size(); 
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("noticelist", list);
  }
  
  // 관리자단공지사항
  // 관리자단 공지사항 작성
  public void noticeWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String path_= session.getServletContext().getRealPath("");
	  String path = path_ + "files/customer/notice";
	  
	  int size = 1024 * 1024 * 1; //1Mbyte
	  
	  try {
		MultipartRequest multi = new MultipartRequest(request, path, size, 
												"UTF-8", new DefaultFileRenamePolicy());
		
		String title = multi.getParameter("adminNoticeWriteTitle");
		String content = multi.getParameter("adminNoticeWriteContent");
		
		Enumeration files = multi.getFileNames();
		String fileName = (String)files.nextElement();
		String imageFileName = multi.getFilesystemName(fileName);
		
		int insertCheck = customerMapper.noticeWrite(title, content, imageFileName, accountKey);
		
		redirect.addAttribute("insertCheck", insertCheck);
		
	  } catch (IOException e) {
		  e.printStackTrace();
	  }
  }
  
  // 관리자단 공지사항 수정 페이지
  public void noticeModifyView(int seqKey, Model model) {
	  
	  CustomerNoticeVo customerNoticeVo = customerMapper.noticeModifyView(seqKey);
	  
	  model.addAttribute("customerNoticeVo", customerNoticeVo);
  }
  
  // 관리자단 공지사항 수정
  public void noticeModify(HttpServletRequest request, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String path_ = session.getServletContext().getRealPath("");
	  String path = path_ + "files/customer/notice";
	  
	  int size = 1024 * 1024 * 1;	//1Mbyte
	  
	  try {
		MultipartRequest multi = new MultipartRequest(request, path, size, 
													"UTF-8", new DefaultFileRenamePolicy());
		int seqKey = Integer.parseInt(multi.getParameter("seqKey"));
		String originFileName = multi.getParameter("originFileName");
		String title = multi.getParameter("adminNoticeModifyTitle");
		String content = multi.getParameter("adminNoticeModifyContent");
		
		Enumeration files = multi.getFileNames();
		String name = (String)files.nextElement();
		String imageFileName = multi.getFilesystemName(name);
		
		// 수정을 통해 저장 할 이미지파일이 없는 경우 원래 파일이름으로 대체
		if(imageFileName==null || imageFileName.equals("")) {
			imageFileName = originFileName;
		}
		
		// 이미지 파일이 바뀌는경우 이전파일 삭제
		if(!(imageFileName.equals(originFileName))) {
			File f = new File(path + "/" + originFileName);
			f.delete();
		}
		
		int updateCheck = customerMapper.noticeModify(title, content, imageFileName, accountKey, seqKey);
		
		redirect.addAttribute("updateCheck", updateCheck);
	  } catch (IOException e) {
	  	e.printStackTrace();
	  }
	  
  }
  
  // 관리자단 공지사항 삭제
  public void noticeDelete(HttpServletRequest request, int seqKey, String imageFileName, RedirectAttributes redirect) {
	  String path_ = request.getSession().getServletContext().getRealPath("");
	  String path = path_ + "files/customer/notice";
	  
	  if(!(imageFileName.equals("nothing"))) {
		  File f = new File(path + "/" + imageFileName);
		  f.delete();
	  }
	  int deleteCheck = customerMapper.noticeDelete(seqKey);
	  
	  redirect.addAttribute("deleteCheck", deleteCheck);
  }
  
  
  
  
  
  
  //----------------------------------------------------------------------------------------
  
  // 비회원 1:1 문의 세션 정보 가져오기
  public void nonmemberInquiry(HttpSession session, Model model) {
	  int accountKey= 0;
	  
	  //세션의 회원번호 정보를 불러옴
	  Enumeration sessions = session.getAttributeNames();
	  while(sessions.hasMoreElements()) {
		  if(sessions.nextElement().toString().contains("accountKey")) {
			  accountKey = (int)session.getAttribute("accountKey");
		  }
		  else {
			  accountKey = 0;
		  }
	  }
	  
	  model.addAttribute("accountKey", accountKey);
  }
  
  // 비회원 1:1 문의 작성
  public void nonmemberInquiryWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  
	  String path_ = request.getSession().getServletContext().getRealPath("");
	  String path = path_ + "files/customer/nonmemberInquiry";	  
	  
	  int size = 1024 * 1024 * 1; // 1Mbyte
	  
	  try {
		MultipartRequest multi = new MultipartRequest(request, path, size, 
										"UTF-8", new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("nonmemberInquiryName");
		String emailHead = multi.getParameter("nonmemberInquiryEmailHead");
		String emailTail = multi.getParameter("nonmemberInquiryEmailTail");
		String email = emailHead + "@" + emailTail;
		String tell = multi.getParameter("nonmemberInquiryTell");
		String title = multi.getParameter("nonmemberInquiryTitle");
		String content = multi.getParameter("nonmemberInquiryContent");
		
		Enumeration files = multi.getFileNames();
		
		String fileName_ = (String)files.nextElement();
		String imageFileName = multi.getFilesystemName(fileName_);
		
		int insertCheck = customerMapper.nonmemberInquiryWrite(name, email, tell, title, content, imageFileName);
		
		redirect.addAttribute("insertCheck", insertCheck);
		
	  } catch (IOException e) {
		  e.printStackTrace();
	  }
	  
  }
  
  // 관리자단
  // 관리자단 비회원 1:1 문의 리스트
  public void nonmemberInquiryList(int nowPage, int nonmemberInquiryState, Model model) {
	  
	  int listCount = customerMapper.getNonmemberInquriyListCount();
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerNonmemberInquiryVo> list = customerMapper.nonmemberInquriyList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("nonmemverInquiryList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("nonmemberInquiryState", nonmemberInquiryState);
	  
  }
  
  // 관리자단 비회원 1:1 문의 검색
  public void nonmemberInquirySearch(HttpServletRequest request, int nowPage, int nonmemberInquiryState,
		  							 String searchClassification_, String searchInput_, Model model) {
	  
	  String searchClassification = request.getParameter("searchClassification");
	  String searchInput = request.getParameter("searchInput");
	  
	  if(searchClassification == null) {
		  searchClassification = searchClassification_;
		  searchInput = searchInput_;
	  }
	  
	  String searchLikeSql = "";
	  
	  if(searchClassification.equals("name")) {
		  searchLikeSql = "name like '%"+searchInput+"%'";
	  }
	  else if(searchClassification.equals("title")) {
		  searchLikeSql = "title like '%"+searchInput+"%'";
	  }
	  else if(searchClassification.equals("content")) {
		  searchLikeSql = "content like '%"+searchInput+"%'"; 
	  }
	  else if(searchClassification.equals("all")) {
		  searchLikeSql = "title like '%"+searchInput+"%' or content like '%"+searchInput+"%'";	  
	  }
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
	  if(nowPage != 1) {
		  page = nowPage;
	  }
	  
	  int listCount = customerMapper.getNonmemberInquirySearchCount(searchLikeSql);
	  
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
	  
	  ArrayList<CustomerNonmemberInquiryVo> list = customerMapper.nonmemberInquirySearch(searchLikeSql, startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("nonmemverInquiryList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("nonmemberInquiryState", nonmemberInquiryState);
	  
  }
  
  // 관리자단 비회원 1:1 문의 상세보기
  public void nonmemberInquiryView(int seqKey, int nowPage, Model model) {
	  
	  CustomerNonmemberInquiryVo customerNonmemberInquiryVo = customerMapper.nonmemberInquiryView(seqKey);
	  
	  //개행문자를 <br>로 만들어 화면단에서 출력시 한줄로 나오는것을 방지
	  String content = customerNonmemberInquiryVo.getContent().replace("\n", "<br/>");
	  customerNonmemberInquiryVo.setContent(content);
	  if(customerNonmemberInquiryVo.getReply() !=null) {
		  String reply = customerNonmemberInquiryVo.getReply().replace("\n", "<br/>");
		  customerNonmemberInquiryVo.setReply(reply);
	  }
	  model.addAttribute("nonmemberInquiryAdminView", customerNonmemberInquiryVo);
	  model.addAttribute("seqKey", seqKey);
	  
	  ///////////////////////////////////////////////
	  
	  int listCount = customerMapper.getNonmemberInquriyListCount();
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerNonmemberInquiryVo> list = customerMapper.nonmemberInquriyList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("nonmemverInquiryList", list);
	  model.addAttribute("listSize", listSize);
  }
  
  // 관리자단 비회원 1:1 문의 답변하기
  public void nonmemberInquiryReply(HttpServletRequest request, int seqKey, RedirectAttributes redirect) {
	  String reply = request.getParameter("reply");
	  
	  int updateCheck = customerMapper.nonmemberInquiryReply(reply, seqKey);
	  
	  if(updateCheck == 1) {
		  CustomerNonmemberInquiryVo customerNonmemberInquiryVo = customerMapper.nonmemberInquiryView(seqKey);
		  
		  String mailTitle = "[밀페이지] - '" + customerNonmemberInquiryVo.getTitle() + "'로(으로) 문의하신 내용에 답변입니다.";
		  String mailContent_ = "[문의 하신 내용]\n";
		  mailContent_ = mailContent_ + customerNonmemberInquiryVo.getContent() + "\n";
		  mailContent_ = mailContent_ + "=========================================================\n";
		  mailContent_ = mailContent_ + "[답변]\n";
		  mailContent_ = mailContent_ + reply;
		  
		  String mailContent = mailContent_.replace("\n", "<br/>");
  	  
		  try {
			  emailSender.send(customerNonmemberInquiryVo.getEmail(), mailTitle, mailContent);
		  } catch (IOException e) {
			  e.printStackTrace();
		  }
	  }
	  
	  redirect.addAttribute("updateCheck", updateCheck);
	  
  }
  
  // 관리자단 비회원 1:1 문의 삭제
  public void nonmemberInquiryDelete(HttpServletRequest request, int seqKey, String fileName, RedirectAttributes redirect) {
	  String path_ = request.getSession().getServletContext().getRealPath("");
	  String path = path_ + "files/customer/nonmemberInquiry";
	  
	  if(!(fileName.equals("nothing"))) {
		  File f = new File(path + "/" + fileName);
		  f.delete();
	  }
	  int deleteCheck = customerMapper.nonmemberInquiryDelete(seqKey);
	  
	  redirect.addAttribute("deleteCheck", deleteCheck); 
	  
  }
  
  // 메인페이지
  // 메인페이지 답변대기, 답변완료 count
  public int getNonmemberInquiryReplyCount(String status) {
	  int totalCount = customerMapper.getNonmemberInquriyListCount();
	  int noReplyCount = customerMapper.getNonmemberInquiryNoRepeyCount();
	  int count = 0;
	  
	  if(status.equals("답변대기")) {
		  count = noReplyCount;
	  }
	  else {
		  count = totalCount - noReplyCount;
	  }
	  
	  return count;
  }
  
  
  
  
  
  
  
  //--------------------------------------------------------------------------------------
  // FAQ 전체 리스트
  public void faqList(Model model) {
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int faqState = Integer.parseInt(model.asMap().get("faqState").toString());
	  
	  int listCount = customerMapper.getFaqListCount();
	  
	// 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerFaqVo> list = customerMapper.faqList(startRow, limit);
	  
	  for(int i = 0; i < list.size(); i++) {
		  CustomerFaqVo f = (CustomerFaqVo)list.get(i);
		  String content = f.getContent().replace("\n", "<br/>");
		  f.setContent(content);
		  list.set(i, f);
	  }
	  int listSize = list.size();
	  
	  model.addAttribute("faqList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("faqState", faqState);
  }
  
  // FAQ 카테고리별 리스트
  public void faqCategoryList(Model model) {
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int faqState = Integer.parseInt(model.asMap().get("faqState").toString());
	  
	  String category_ = model.asMap().get("category").toString();
	  
	  String category = "";
	  
	  switch(category_) {
	  	case "account" :
	  		category = "회원관리";
	  		break;
	  		
	  	case "point" :
	  		category = "포인트/쿠폰";
	  		break;
	  		
	  	case "order" :
	  		category = "주문/결제";
	  		break;
	  		
	  	case "refund" :
	  		category = "환불/교환";
	  		break;
	  		
	  	case "shipping" :
	  		category = "배송";
	  		break;
	  		
	  	case "etc" :
	  		category = "기타";
	  		break;
	  }
	  
	  // 카타고리 리스트 개수
	  int listCount = customerMapper.getFaqCategoryListCount(category);
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerFaqVo> list = customerMapper.faqCategoryList(category, startRow, limit);
	  
	  for(int i = 0; i < list.size(); i++) {
		  CustomerFaqVo f = (CustomerFaqVo)list.get(i);
		  String content = f.getContent().replace("\n", "<br/>");
		  f.setContent(content);
		  list.set(i, f);
	  }
	  
	  int listSize = list.size();
	  
	  model.addAttribute("faqList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("category_", category_);
	  model.addAttribute("faqState", faqState);
  }
    
  // FAQ 검색
  public void faqSearch(Model model) {
	  HttpServletRequest request = (HttpServletRequest)model.asMap().get("request");
	  
	  String searchClassification = request.getParameter("searchClassification");
	  String searchInput = request.getParameter("searchInput");
	  
	  if (searchClassification == null) {
		  searchClassification = model.asMap().get("searchClassification").toString();
		  searchInput = model.asMap().get("searchInput").toString();
	  }
	  
	  int nowPage = Integer.parseInt(model.asMap().get("nowPage").toString());
	  int faqState = Integer.parseInt(model.asMap().get("faqState").toString());
	  
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
	  
	  
	  int listCount = customerMapper.getFaqSearchCount(searchLikeSql);
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerFaqVo> list = customerMapper.faqSearch(searchLikeSql, startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("listSize", listSize);
	  model.addAttribute("faqList", list);
	  
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("faqState", faqState);
  }
  
  
  
  // 관리자단
  // 관리자단 FAQ 상세보기
  public void faqAdminView(int seqKey, int nowPage, Model model) {
	  
	  CustomerFaqVo customerFaqVo = customerMapper.faqAdminView(seqKey);
	  
	  //개행문자를 <br>로 만들어 화면단에서 출력시 한줄로 나오는것을 방지
	  String content = customerFaqVo.getContent().replace("\n", "<br/>");
	  customerFaqVo.setContent(content);
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("faqAdminView", customerFaqVo);
	  
	  /////////////////////////////////////////////////////
	  
	  int listCount = customerMapper.getFaqListCount();
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerFaqVo> list = customerMapper.faqList(startRow, limit);
	  
	  for(int i = 0; i < list.size(); i++) {
		  CustomerFaqVo f = (CustomerFaqVo)list.get(i);
		  String content_ = f.getContent().replace("\n", "<br/>");
		  f.setContent(content_);
		  list.set(i, f);
	  }
	  int listSize = list.size();
	  
	  model.addAttribute("faqList", list);
	  model.addAttribute("listSize", listSize);
	  
	  
  }
  
  // 관리자단 FAQ 작성
  public void faqWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String category = request.getParameter("adminFaqWirteCategory");
	  String question = request.getParameter("adminFaqWriteQuestion");
	  String answer = request.getParameter("adminFaqWriteAnswer");
	  
	  int insertCheck = customerMapper.faqWrite(category, question, answer, accountKey);
	  
	  redirect.addAttribute("insertCheck", insertCheck);
	  
  }
  
  
  // 관리자단 FAQ 수정 페이지
  public void faqModifyView(int seqKey, int page, Model model) {
	  
	  CustomerFaqVo customerFaqVo = customerMapper.faqModifyView(seqKey);
	  
	  model.addAttribute("page", page);
	  model.addAttribute("customerFaqVo", customerFaqVo);
  }
  
  // 관리자단 FAQ 수정
  public void faqModify(HttpServletRequest request, int seqKey, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String category = request.getParameter("adminFaqModifyCategory");
	  String question = request.getParameter("adminFaqModifyQuestion");
	  String answer = request.getParameter("adminFaqModifyAnswer");
	  
	  int updateCheck = customerMapper.faqModify(category, question, answer, accountKey, seqKey);
	  
	  redirect.addAttribute("updateCheck", updateCheck);
  }
  
  // 관리자단 FAQ 삭제
  public void faqDelete(int seqKey, RedirectAttributes redirect) {
	  
	  int deleteCheck = customerMapper.faqDelete(seqKey);
	  
	  redirect.addAttribute("deleteCheck", deleteCheck);
  }
  
  
  //--------------------------------------------------------------------------------------
  // 이용안내
  public void guide(Model model) {
	  
	  ArrayList<CustomerGuideVo> list = customerMapper.guide();
	  
	  for(int i = 0; i < list.size(); i++) {
		  CustomerGuideVo g = (CustomerGuideVo)list.get(i);
		  String content = g.getContent().replace("\n", "<br/>");
		  g.setContent(content);
		  list.set(i, g);
	  }
	  
	  model.addAttribute("guideList", list);
  }
  
  // 관리자단
  // 관리자단 이용안내 리스트
  public void gudideList(int nowPage, int guideState, Model model) {
	  
	  int listCount = customerMapper.getGuideListCount();
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerGuideVo> list = customerMapper.guideList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("guideList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("guideState", guideState);
  }
  
  //관리자단 이용안내 검색
  public void guideSearch(HttpServletRequest request, int nowPage, int guideState, 
		  				  String searchClassification_, String searchInput_, Model model) {
	  
	  String searchClassification = request.getParameter("searchClassification");
	  String searchInput = request.getParameter("searchInput");
	  
	  if (searchClassification == null) {
		  searchClassification = searchClassification_;
		  searchInput = searchInput_;
	  }
	  
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
	  
	  int listCount = customerMapper.getGuideSearchCount(searchLikeSql);
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerGuideVo> list = customerMapper.guideSearch(searchLikeSql, startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("guideList", list);
	  model.addAttribute("listSize", listSize);
	  
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  
	  model.addAttribute("guideState", guideState);
  }
  
  // 관리자단 이용안내 상세보기
  public void guideAdminView(int seqKey, int nowPage, Model model) {
	  
	  CustomerGuideVo customerGuideVo = customerMapper.guideView(seqKey);
	  
	  //개행문자를 <br>로 만들어 화면단에서 출력시 한줄로 나오는것을 방지
	  String content = customerGuideVo.getContent().replace("\n", "<br/>");
	  customerGuideVo.setContent(content);
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("guideAdminView", customerGuideVo);
	  
			  
	  int listCount = customerMapper.getGuideListCount();
	  
	  // 페이징
	  int page = 1;
	  int limit = 10;
	  
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
	  
	  ArrayList<CustomerGuideVo> list = customerMapper.guideList(startRow, limit);
	  int listSize = list.size();
	  
	  model.addAttribute("guideList", list);
	  model.addAttribute("listSize", listSize);		  
			  
  }
  
  // 관리자단 이용안내 작성
  public void guideWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String title = request.getParameter("adminGuideWriteTitle");
	  String content = request.getParameter("adminGuideWriteContent");
	  
	  int insertCheck = customerMapper.guideWrite(title, content, accountKey);
	  
	  redirect.addAttribute("insertCheck", insertCheck);
  }
  
  // 관리자단 이용안내 수정 페이지
  public void guideModifyView(int seqKey, int nowPage, Model model) {
	  
	  CustomerGuideVo customerGuideVo = customerMapper.guideModifyView(seqKey);
	  
	  model.addAttribute("page", nowPage);
	  model.addAttribute("guideModifyView", customerGuideVo);
	  
  }
  
  // 관리자단 이용안내 수정
  public void quideModify(HttpServletRequest request, int seqKey, RedirectAttributes redirect) {
	  HttpSession session = request.getSession();
	  int accountKey = Integer.parseInt(session.getAttribute("accountKey").toString());
	  
	  String title = request.getParameter("adminGuideModifyTitle");
	  String content = request.getParameter("adminGuideModifyContent");
	  
	  int updateCheck = customerMapper.guideModify(title, content, accountKey, seqKey);
	  
	  redirect.addAttribute("updateCheck", updateCheck);
  }
  
  // 관리자단 이용안내 삭제
  public void guideDelete(int seqkey, RedirectAttributes redirect) {
	  
	  int deleteCheck = customerMapper.guideDelete(seqkey);
	  
	  redirect.addAttribute("deleteCheck", deleteCheck);
  }
  
  
  

}
