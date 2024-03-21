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
	
	
	@RequestMapping(value = "/")
	public String membership1() {
		
		return "main";
	}
	//����ȭ��
	@RequestMapping(value = "/main")
	public String membership2() {
		
		return "main";
	}
	
	//ȸ������
	@RequestMapping(value = "/membershipjoin2")
	public String membership3() {
		
		return "membershipjoin2";
	}
	
	//���̵� �ߺ�Ȯ��
	@ResponseBody
	@RequestMapping(value = "/idcheckgogo")
	public String membership4(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		Service ss = sqlSession.getMapper(Service.class);
	     System.out.println(id);
	      return ss.id_check(id);
	   }
	
	//ȸ������ ����
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
	
	//�α������â ����
	@RequestMapping(value = "/login")
	public String membership6() {
		
		return "logininput";
	}
	
	//�α���
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
				hs.setAttribute("loginstate", true);
				hs.setMaxInactiveInterval(3000);
				return "redirect:/main";
			}
			else {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter printw = response.getWriter();
				printw.print("<script> alert('���̵�� ��й�ȣ�� Ʋ���̽��ϴ�. �ٽ� Ȯ�����ּ���!'); window.location.href='logininput'; </script>");
			}
			return null;
		}
		
		//�α׾ƿ�
		@RequestMapping(value = "/logout")
		public String membership8(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HttpSession hs = request.getSession();
			hs.removeAttribute("membership");
			hs.setAttribute("loginstate", false);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('�α׾ƿ� �Ǿ����ϴ�.'); window.location.href='main'; </script>");
			return null;
		}
}
