package com.hailey.web;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hailey.service.BoardService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping(value="/board")
	public ModelAndView boardlist(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = null;
		if (map.containsKey("act")) {
			if (map.get("act").equals("write")) {
				mv = new ModelAndView("write");
				map.put("board_no", 0);
				mv.addObject("map", map);

				return mv;
			}
		}
		mv = new ModelAndView("board");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		int pageNo = 1;
		int listScale = 10;
		int pageScale = 10;
		
		if (map.containsKey("pageNo")) {
			pageNo = Integer.parseInt((String) map.get("pageNo"));
		}
		
	
		paginationInfo.setCurrentPageNo(pageNo);
		paginationInfo.setRecordCountPerPage(listScale);
		paginationInfo.setPageSize(pageScale);
		
		int startPage = paginationInfo.getFirstRecordIndex();
		int lastPage = paginationInfo.getRecordCountPerPage();
		
		map.put("startPage", startPage);
		map.put("lastPage", lastPage);
		
		//전체 글 수 boardList
		ArrayList<HashMap<String, Object>> boardList =  boardService.boardList(map);
		//전체 게시물 수 
		int totalList = boardService.boardListCount(map);
		paginationInfo.setTotalRecordCount(totalList);
				
		mv.addObject("pageNo", pageNo);
		mv.addObject("boardList", boardList);
		mv.addObject("totalList", totalList);
		mv.addObject("paginationInfo", paginationInfo);
		
		return mv;
	}
	
	@GetMapping(value="/boardDetail")
	public ModelAndView boardDetail(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView("boardDetail");
		ArrayList<HashMap<String, Object>> comments = boardService.comments(map);
		HashMap<String, Object> detail = boardService.boardDetail(map);
		
		if (map.containsKey("act")) {
			if (map.get("act").equals("del")) {
				boardService.delboard(map);	
				mv.setViewName("redirect:/board?key="+map.get("key"));
			}else if (map.get("act").equals("write")) {
				mv = new ModelAndView("write");
				mv.addObject("map", detail);

				return mv;
			}
		} else {
			mv.addObject("detail", detail);
			mv.addObject("comments", comments);
		}
		
		return mv;			
	}
	
	@PostMapping(value="/writeComments")
	public ModelAndView writeComments(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView("writeComments");
		boardService.insertComments(map);
		mv.addObject("comments", boardService.comments(map));
		return mv;
	}
	@PostMapping(value="/editCommentsA")
	public ModelAndView editCommentsA(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView("writeComments");
		boardService.editComments(map);
		mv.addObject("comments", boardService.comments(map));
		return mv;
	}
	
	@GetMapping(value="/delComments")
	public String delComments(@RequestParam HashMap<String, Object> map) {
		boardService.delComments(map);
		return "redirect:/boardDetail?board_no="+map.get("board_no");
	}
	
	@PostMapping(value="/writeA")
	public String writeA(@RequestParam HashMap<String, Object> map, HttpServletRequest request) {
		if (map.containsKey("board_no")) {
			boardService.editA(map);			
			return "redirect:/boardDetail?board_no="+map.get("board_no");
		}else {
			HttpSession session = request.getSession();
			map.put("member_no", session.getAttribute("member_no"));
			System.out.println(map.get("key"));
			if (map.get("key").equals("free")) {
				map.put("board_type_no", 1);
			}else if (map.get("key").equals("qna")) {
				map.put("board_type_no", 2);				
			}
			boardService.writeA(map);				
			return "redirect:/board?key="+map.get("key");
		}	
	}
	
	@PostMapping(value="/cocommentsA")
	public ModelAndView cocommentsA(@RequestParam HashMap<String, Object> map, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("writeComments");
		HttpSession session = request.getSession();
		map.put("member_no", session.getAttribute("member_no"));
		
		boardService.insertComments(map);
		mv.addObject("comments", boardService.comments(map));
		return mv;
	}
}
