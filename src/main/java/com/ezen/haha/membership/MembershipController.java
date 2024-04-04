package com.ezen.haha.membership;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;




@Controller
public class MembershipController {
	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(MembershipController.class);
	
	
	
	//회원가입
	@RequestMapping(value = "/membershipjoin2")
	public String membership3() {
		
		return "membershipjoin2";
	}
	
	//아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "/idcheckgogo")
	public String membership4(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Service ss = sqlSession.getMapper(Service.class);
	     System.out.println(id);
	      return ss.id_check(id);
	   }
	
	//회원가입 저장
	@RequestMapping(value = "/membershipsave")
	public String membership5(HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String pid = request.getParameter("pid");
		String address = request.getParameter("address1") + " " + request.getParameter("address2");
		
		Service ss = sqlSession.getMapper(Service.class);
		ss.membersave(id,pw,name,tel,email,pid,address);
		return "redirect:/main";
	}
	
	//로그인출력창 ㄱㄱ
	@RequestMapping(value = "/login")
	public String membership6() {
		
		return "logininput";
	}
	
	//로그인
		@RequestMapping(value = "/logingoing")
		public String membership7(HttpServletRequest request, HttpServletResponse response) throws IOException {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			Service ss = sqlSession.getMapper(Service.class);
			MembershipDTO dto = ss.logingo(id,pw);
			if(dto!=null)
			{
				HttpSession hs = request.getSession();
				hs.setAttribute("membership", dto);
				hs.setAttribute("id", id);
				hs.setAttribute("loginstate", true);
				hs.setMaxInactiveInterval(3000);
				return "redirect:/main";
			}
			else {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter printw = response.getWriter();
				printw.print("<script> alert('아이디랑 비밀번호가 틀리셨습니다. 다시 확인해주세요!'); window.location.href='logininput'; </script>");
				printw.close();
			}
			return null;
		}
		
		//로그아웃
		@RequestMapping(value = "/logout")
		public String membership8(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HttpSession hs = request.getSession();
			hs.removeAttribute("membership");
			hs.removeAttribute("id");
			hs.setAttribute("loginstate", false);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그아웃 되었습니다.'); window.location.href='main'; </script>");
			printw.close();
			return null;
		}
}
