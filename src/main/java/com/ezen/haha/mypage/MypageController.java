package com.ezen.haha.mypage;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
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

import com.ezen.haha.membership.MembershipDTO;


@Controller
public class MypageController {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	// 마이페이지 화면으로 가기
	@RequestMapping(value = "/mypage")
	public String mypagemain(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if((boolean) hs.getAttribute("loginstate"))
		{
			Service ss = sqlSession.getMapper(Service.class);
			ArrayList<MembershipDTO> list = ss.mypageview(id);
			mo.addAttribute("list", list);
			return "mypagemain";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그인이 필요합니다.'); window.location.href='./login'; </script>");
			printw.close();
			return "redirect:./login";
		}
	}
	
	// 쿠폰 보기 화면으로 가기
	@RequestMapping(value = "/couponview")
	public String couponnum(HttpServletRequest request, Model mo) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<CouponDTO> list = ss.couponview(id);
		mo.addAttribute("list", list);
		
		return "couponview";
	}

}
