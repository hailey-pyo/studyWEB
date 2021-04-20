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

	public HashMap<String, Object> boardDetail(HashMap<String, Object> map) {
		boardDAO.viewCountUp(map);
		return boardDAO.boardDetail(map);
	}

	public ArrayList<HashMap<String, Object>> comments(HashMap<String, Object> map) {
		return (ArrayList<HashMap<String, Object>>)boardDAO.comments(map);
	}

	public void delboard(HashMap<String, Object> map) {
		boardDAO.delboard(map);
	}

	public void insertComments(HashMap<String, Object> map) {
		boardDAO.insertComments(map);
	}

	public void editComments(HashMap<String, Object> map) {
		boardDAO.editComments(map);
	}

	public void delComments(HashMap<String, Object> map) {
		boardDAO.delComments(map);
	}

	public void writeA(HashMap<String, Object> map) {
		boardDAO.writeA(map);
	}

	public void editA(HashMap<String, Object> map) {
		boardDAO.editA(map);
	}

	public void blame(HashMap<String, Object> map) {
		boardDAO.blame(map);
	}

	public int goodcheck(HashMap<String, Object> map) {
		return boardDAO.goodcheck(map);
	}

	public void goodinsert(HashMap<String, Object> map) {
		boardDAO.goodinsert(map);
	}

	public void gooddelete(HashMap<String, Object> map) {
		boardDAO.gooddelete(map);
	}

}
