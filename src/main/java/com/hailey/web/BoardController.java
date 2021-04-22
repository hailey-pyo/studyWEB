package com.hailey.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hailey.service.BoardService;
import com.hailey.util.FileSave;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	
	@Autowired
	private FileSave fileSave;
	
	@Autowired
	private ServletContext servletContext;
	
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
	
	@RequestMapping(value="/boardDetail")
	public ModelAndView boardDetail(@RequestParam HashMap<String, Object> map, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("boardDetail");
		ArrayList<HashMap<String, Object>> comments = boardService.comments(map);
		HashMap<String, Object> detail = boardService.boardDetail(map);

		if (map.containsKey("act")) {
			if (map.get("act").equals("del")) {
				boardService.delboard(map);	
				mv.setViewName("redirect:/board?key="+map.get("key"));
			}else if (map.get("act").equals("write")) {
				mv = new ModelAndView("write");
				detail.put("secret", map.get("secret"));
				detail.put("key", map.get("key"));
				mv.addObject("map", detail);
				return mv;
			}
		} else {
				mv.addObject("detail", detail);
				mv.addObject("comments", comments);
				HttpSession session = request.getSession();
				if (session.getAttribute("member_no") != null) {
					map.put("member_no", session.getAttribute("member_no"));
					int goodcheck = boardService.goodcheck(map);
					mv.addObject("goodcheck", goodcheck);		
				}
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
	public String writeA(@RequestParam HashMap<String, Object> map, HttpServletRequest request, MultipartFile file) {
		//System.out.println(map.get("secret")); //on, null
		if (!map.containsKey("secret")) {
			map.put("secret", 'N');
		}else {
			map.put("secret", 'Y');
		}
		
		if (map.containsKey("board_no")) {
			boardService.editA(map);			
			
			
			return "redirect:/boardDetail?board_no="+map.get("board_no");
		}else {
			HttpSession session = request.getSession();
			map.put("member_no", session.getAttribute("member_no"));
			if (map.get("key").equals("free")) {
				map.put("board_type_no", 1);
			}else if (map.get("key").equals("qna")) {
				map.put("board_type_no", 2);				
			}
			
			//파일올리기
			String realPath = servletContext.getRealPath("resources/");
			map.put("realPath", realPath);
			if (file.getOriginalFilename() != null && file.getSize() > 0) {
				String realFileName = fileSave.save(realPath + "upload", file);
				map.put("board_file", realFileName);
				map.put("board_file_origin", file.getOriginalFilename());
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
	
	@GetMapping(value="/blame")
	public String blame(@RequestParam HashMap<String, Object> map, HttpServletRequest request) {
		HttpSession session = request.getSession();
		map.put("member_no", session.getAttribute("member_no"));
		boardService.blame(map);
		return "redirect:/boardDetail?board_no="+map.get("board_no");
	}
	
	@PostMapping(value="/good")
	public void good(@RequestParam HashMap<String, Object> map, HttpServletResponse response) throws IOException {
		int goodcheck = boardService.goodcheck(map);
	
		if(goodcheck == 0) {
			boardService.goodinsert(map);
			goodcheck = 1;
		} else {
			boardService.gooddelete(map);
			goodcheck = 0;
		}

			JSONObject good = new JSONObject();
			good.put("goodcheck", goodcheck);
			good.put("goodcount", boardService.boardDetail(map).get("board_likes"));
			String jsonInfo = good.toJSONString();
			PrintWriter out = response.getWriter();
			out.print(jsonInfo);
	}
	
}
