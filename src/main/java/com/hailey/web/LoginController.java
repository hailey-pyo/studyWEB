package com.hailey.web;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hailey.service.LoginService;

@Controller 
public class LoginController {
	
	
	
	 @Autowired LoginService loginService;
	 
	
	@GetMapping(value = "login")
	public String login() {
		return "login";
	}
	
	@PostMapping(value="login")
	public String loginAction(@RequestParam HashMap<String, Object> map, HttpServletRequest request) {
		if(map.containsKey("member_id") && map.containsKey("member_pw")) {
			HashMap<String, Object> map2 = loginService.login(map);
			
			if(map2 != null) {
				HttpSession session = request.getSession();
				session.setAttribute("member_nick", map2.get("member_nick"));
				session.setAttribute("member_no", map2.get("member_no"));
			}
		} 
		return "redirect:/";
		
	}
	
	@GetMapping(value="logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("member_nick") != null) {
			session.removeAttribute("member_nick");
		}
		if(session.getAttribute("member_no") != null) {
			session.removeAttribute("member_no");
		}
		return "redirect:/login";
	}
	
//	@GetMapping(value="/login/kakaologin", produces = "text/plain;charset=utf-8")
//	public @ResponseBody String kakaoLogin(String code) {
//		
//		RestTemplate rt = new RestTemplate();
//		
//		//HttpHeader 오브젝트 생성
//		HttpHeaders headers = new HttpHeaders();
//		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//		
//		//HttpBody 오브젝트 생성
//		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
//		params.add("grant_type", "authorization_code");
//		params.add("client_id", "07a4866764e4fbb516a852ed2f5f70f9");
//		params.add("redirect_uri", "http://localhost:8080/web/login/kakaologin");
//		params.add("code", code);
//		
//		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
//		HttpEntity<MultiValueMap<String,String>> kakaoTokenRequest =
//				new HttpEntity<MultiValueMap<String,String>>(params, headers); 
//		
//		//Http 요청하기 - Post방식으로 - 그리고 response 변수에 응답받음
//		ResponseEntity<String> response = rt.exchange(
//				"https://kauth.kakao.com/oauth/token",
//				HttpMethod.POST,
//				kakaoTokenRequest,
//				String.class				
//		);
//		return "카카오 인증 완료 - 토큰 요청에대한 응답: "+response.getBody();
//	}
	


	

}
