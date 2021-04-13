package com.hailey.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hailey.dao.BoardDAO;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO boardDAO;

	public ArrayList<HashMap<String, Object>> boardList(Map<String, Object> map) {
		return (ArrayList<HashMap<String, Object>>) boardDAO.boardList(map);
	}

	public int boardListCount(HashMap<String, Object> map) {
		return boardDAO.boardListCount(map);
	}

}
