package com.hailey.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hailey.dao.LoginDAO;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;
	
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		return loginDAO.login(map);
	}

}
