package com.hailey.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<HashMap<String, Object>> boardList(Map<String, Object> map) {
		return sqlSession.selectList("board.boardList", map);
	}
	public int boardListCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("board.boardListCount", map);
	}
	public HashMap<String, Object> boardDetail(HashMap<String, Object> map) {
		return sqlSession.selectOne("board.boardDetail", map);
	}
	public List<HashMap<String, Object>> comments(HashMap<String, Object> map) {
		return sqlSession.selectList("board.comments", map);
	}
	public void delboard(HashMap<String, Object> map) {
		sqlSession.update("board.delboard", map);
	}
	public void viewCountUp(HashMap<String, Object> map) {
		sqlSession.update("board.viewCountUp", map);
	}
	public void insertComments(HashMap<String, Object> map) {
		sqlSession.insert("board.insertComments", map);
	}
	public void editComments(HashMap<String, Object> map) {
		sqlSession.update("board.editComments", map);		
	}
	public void delComments(HashMap<String, Object> map) {
		sqlSession.update("board.delComments", map);
	}
	public void writeA(HashMap<String, Object> map) {
		sqlSession.insert("board.writeBoard", map);
	}
	public void editA(HashMap<String, Object> map) {
		sqlSession.update("board.editBoard", map);
	}

}
