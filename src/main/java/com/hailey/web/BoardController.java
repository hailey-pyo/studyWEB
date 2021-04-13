package com.hailey.web;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hailey.service.BoardService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping(value="/board")
	public ModelAndView boardlist(@RequestParam HashMap<String, Object> map) {
		ModelAndView mv = new ModelAndView("board");
		
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
		
		System.out.println(totalList);
		
		mv.addObject("pageNo", pageNo);
		mv.addObject("boardList", boardList);
		mv.addObject("totalList", totalList);
		mv.addObject("paginationInfo", paginationInfo);
		
		return mv;
	}
}
