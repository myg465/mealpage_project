package dev.localhost.koitt14.point;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class PointService {
  @Autowired
  private PointMapper pointMapper;

  // 포인트 적립내역을 가져오는 메소드
  public void getAddList(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("pointAddList", pointMapper.getAddList(accountKey));
  }

  // 포인트 사용내역을 가져오는 메소드
  public void getUsedList(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("pointUsedList", pointMapper.getUsedList(accountKey));
  }

  // 포인트 적립내역 기입 메소드
  public void insertAddPoint(String content, int point, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    pointMapper.insertAddPoint(content, point, accountKey);
  }

  // 포인트 사용내역 기입 메소드
  public void insertUsedPoint(String content, int point, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    pointMapper.insertUsedPoint(content, point, accountKey);
  }

  /* 관리자 페이지용 메소드 시작 */
  // 포인트 적립내역 기입 메소드
  public void insertAddPointByAdmin(String content, int point, int accountKey) {
    pointMapper.insertAddPoint(content, point, accountKey);
  }

  // 페이지 당 게시물 출력 수 (최소 2 이상)
  int rowsPerPage = 10;
  // 게시판 하단에 표시되는 이동 가능 페이지 수
  int pageSet = 5;

  // 포인트 적립내역을 가져오는 메소드
  public void getAddListByAdmin(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = pointMapper.getAddCount();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("pointAddList", pointMapper.getAddListByAdmin(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }

  // 포인트 사용내역을 가져오는 메소드
  public void getUsedListByAdmin(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = pointMapper.getUsedCount();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("pointUsedList", pointMapper.getUsedListByAdmin(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }
}
