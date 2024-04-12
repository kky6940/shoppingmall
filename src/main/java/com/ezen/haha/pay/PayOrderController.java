package com.ezen.haha.pay;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class PayOrderController {
	@Autowired
	SqlSession sqlSession;
	
	// 환불 결정 화면으로 가기
    @RequestMapping(value = "/paycancel")
	public String paycancel(HttpServletRequest request, Model mo) {
    	String tid = request.getParameter("tid");
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<PayDTO> list = ss.paysearch(tid);
		mo.addAttribute("list", list);
    	
		return "paycancel";
	}
    
}
