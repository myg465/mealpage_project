package dev.localhost.koitt14.admin;


import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.event.EventService;

@Controller
public class AdminController_Event {
  @Autowired
  AccountService accountService;
	
  @Autowired
  EventService eventService;
  
  // 관리자단 이벤트 리스트
  @GetMapping({"admin/event/event",
	  		   "admin/event/event/{nowPage_}/{eventState_}"})
  public String eventList(HttpServletRequest request,
		  				  @PathVariable Optional<Integer> nowPage_,
		  				  @PathVariable Optional<Integer> eventState_,
		  				  Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int eventState = eventState_.isPresent() ? eventState_.get() : 1;  
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("eventState", eventState);
	  
	  eventService.eventList(model);
	  
	  return "admin/board_event";
  }
  
  //관리자단 이벤트 검색
  @GetMapping({"admin/event/event/search",
	  			"admin/event/event/search/{nowPage_}/{eventState_}/{searchClassification_}/",		
		   		"admin/event/event/search/{nowPage_}/{eventState_}/{searchClassification_}/{searchInput_}"})
  public String eventSearch(HttpServletRequest request,
						  	@PathVariable Optional<Integer> nowPage_,
							@PathVariable Optional<Integer> eventState_,
							@PathVariable Optional<String> searchClassification_,
							@PathVariable Optional<String> searchInput_,
		  					Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  int eventState = eventState_.isPresent() ? eventState_.get() : 2;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("eventState", eventState);
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  model.addAttribute("request", request);
	  
	  eventService.eventSearch(model);
	  
	  
	  return "admin/board_event";
  }

  // 관리자단 이벤트 상세보기
  @GetMapping("admin/event/event/view/{seqKey}/{nowPage_}")
  public String eventView(HttpServletRequest request,
		  				  @PathVariable("seqKey") int seqKey,
		  				  @PathVariable Optional<Integer> nowPage_,
		  				  Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1; 
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("nowPage", nowPage);
	  
	  eventService.eventView(model);
	  
	  return "admin/board_eventView";
  }
  
  // 관리자단 이벤트 작성 페이지
  @GetMapping("admin/event/event/write/view")
  public String eventWriteView(HttpServletRequest request) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  return "admin/board_eventWrite";
  }
  
  // 관리자단 이벤트 작성
  @PostMapping("admin/event/event/write")
  public String eventWrite(HttpServletRequest request, RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  System.out.println("컨트롤단 집입");
	  
	  eventService.eventWrite(request, redirect);
	  
	  return "redirect:/admin/event/event";
  }
  
  // 관리자단 이벤트 수정 페이지
  @GetMapping("admin/event/event/modify/view/{seqKey}/{nowPage}")
  public String eventModiftView(HttpServletRequest request,
		  						@PathVariable("seqKey") int seqKey,
		  						@PathVariable("nowPage") int nowPage,
		  						Model model) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  eventService.eventModifyView(seqKey, nowPage, model);
	  
	  return "admin/board_eventModify";
  }
  
  // 관리자단 이벤트 수정
  @PostMapping("admin/event/event/modify/{seqKey}/{page}")
  public String eventModify(HttpServletRequest request,
		  					@PathVariable("seqKey") int seqKey,
		  					@PathVariable("page") int page,
		  					RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  eventService.eventModify(request, seqKey, redirect);
	  
	  return "redirect:/admin/event/event/view/" + seqKey + "/" + page;
  }
  
  // 관리자단 이벤트 삭제
  @GetMapping("admin/event/event/delete/{seqKey}/{titleImageFileName_}/{contentImageFileName_}")
  public String eventDelete(HttpServletRequest request,
		  					@PathVariable("seqKey") int seqKey,
		  					@PathVariable Optional<String> titleImageFileName_,
		  					@PathVariable Optional<String> contentImageFileName_,
		  					RedirectAttributes redirect) {
	  if (!accountService.checkAdmin(request)) return "/admin/unauthorized";
	  
	  String titleImageFileName = titleImageFileName_.isPresent() ? titleImageFileName_.get() : "titleNothing";
	  String contentImageFileName = contentImageFileName_.isPresent() ? contentImageFileName_.get() : "contentNothing";
	  
	  eventService.eventDelete(request, seqKey, titleImageFileName, contentImageFileName, redirect);
	  
	  return "redirect:/admin/event/event";
  }
  
}
