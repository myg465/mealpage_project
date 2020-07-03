package dev.localhost.koitt14.event;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class EvectController {
  @Autowired
  private EventService eventService;
  
  @GetMapping({"event/event",
  			   "event/event/{nowPage_}/{eventState_}"})
  public String event(@PathVariable Optional<Integer> nowPage_,
		  			  @PathVariable Optional<Integer> eventState_,
		  			  HttpSession session, Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // eventSate => 1 : normal, 2 : search
	  int eventState = eventState_.isPresent() ? eventState_.get() : 1;
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("eventState", eventState);
	  
	  eventService.getWishList(session, model);
	  eventService.eventList(model);
	  
	  return "event/event";
  }
  
  @GetMapping({"event/eventSearch",
	  		   "event/eventSearch/{nowPage_}/{eventState_}/{searchClassification_}/",		
	  		   "event/eventSearch/{nowPage_}/{eventState_}/{searchClassification_}/{searchInput_}"})
  public String eventSearch(HttpServletRequest request,
		  					@PathVariable Optional<Integer> nowPage_,
		  					@PathVariable Optional<Integer> eventState_,
		  					@PathVariable Optional<String> searchClassification_,
		  					@PathVariable Optional<String> searchInput_,
		  					Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  // eventSate => 1 : normal, 2 : search
	  int eventState = eventState_.isPresent() ? eventState_.get() : 2;
	  String searchClassification = searchClassification_.isPresent() ? searchClassification_.get() : "title";
	  String searchInput = searchInput_.isPresent() ? searchInput_.get() : "";
	  
	  model.addAttribute("nowPage", nowPage);
	  model.addAttribute("eventState", eventState);
	  model.addAttribute("searchClassification", searchClassification);
	  model.addAttribute("searchInput", searchInput);
	  model.addAttribute("request", request);
	  
	  eventService.eventSearch(model);
	  
	  return "event/event";
  }
  
  @GetMapping("event/eventView/{seqKey}/{nowPage_}") 
  public String eventView(@PathVariable("seqKey") int seqKey,
		  				  @PathVariable Optional<Integer> nowPage_,
		  				  Model model) {
	  
	  int nowPage = nowPage_.isPresent() ? nowPage_.get() : 1;
	  
	  model.addAttribute("seqKey", seqKey);
	  model.addAttribute("nowPage", nowPage);
	  
	  eventService.eventView(model);
	  
	  return "event/eventView";
  }
}
