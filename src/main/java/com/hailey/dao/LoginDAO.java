package com.hailey.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO {
	
	@Autowired
	private SqlSession sqlSession;

	public HashMap<String, Object> login(HashMap<String, Object> map) {
		return sqlSession.selectOne("login.login", map);
	}
	


}
