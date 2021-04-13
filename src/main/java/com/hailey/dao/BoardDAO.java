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

}