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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.haha.membership.MembershipDTO;
import com.ezen.haha.pay.PayDTO;
import com.ezen.haha.product.ProductDTO;
import com.ezen.haha.product.ProductreviewDTO;
import com.ezen.haha.qna.QnaDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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

		if (id == null) {
			hs.setAttribute("loginstate", false);
		}

		boolean loginstate = (boolean) hs.getAttribute("loginstate");
		
		if (loginstate) {
			System.out.println("111");
			Service ss = sqlSession.getMapper( Service.class);
			ArrayList<MembershipDTO> list = ss.mypageview(id);
			ArrayList<PayDTO> list2 = ss.payoutviewmonth(id); 
			mo.addAttribute("list", list);
			mo.addAttribute("list2", list2);
			return "mypagemain";
		} else {
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

		Service ss = sqlSession.getMapper( Service.class);
		ArrayList<CouponDTO> list = ss.couponview(id);
		mo.addAttribute("list", list);

		return "couponview";
	}

	// 관리자페이지에서 결재 목록 보기 화면으로
	@RequestMapping(value = "/payoutview")
	public String payoutview(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id.equals("admin"))
		{
			 Service ss = sqlSession.getMapper( Service.class);
			ArrayList<PayDTO> list = ss.payoutviewall();
			mo.addAttribute("list", list);

			return "payout";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('잘못된 접근입니다.'); window.location.href='./login'; </script>");
			printw.close();
			hs.removeAttribute("id");
			hs.setAttribute("loginstate", false);
			return "redirect:/login";
		}

		
	}

	// 마이페이지에서 결재 목록 보기 화면으로
	@RequestMapping(value = "/guestpayoutview")
	public String guestpayoutview(HttpServletRequest request, Model mo) {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");

		 Service ss = sqlSession.getMapper( Service.class);
		ArrayList<PayDTO> list = ss.guestpayoutview(id);
		mo.addAttribute("list", list);

		return "payout";
	}
	
	// 관리자 페이지로 가기
	@RequestMapping(value = "/adminpagemain")
	public String adminpage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");

		if (id.equals("admin")) {
			return "adminpagemain";
		} 
		else 
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('잘못된 접근입니다.'); window.location.href='./login'; </script>");
			printw.close();
			hs.removeAttribute("id");
			hs.setAttribute("loginstate", false);
			return "redirect:/login";
		}
	}

	// 관리자 페이지에서 회원 목록 보기 화면으로
	@RequestMapping(value = "/memberviewall")
	public String memberviewall(HttpServletRequest request, Model mo) {
		 Service ss = sqlSession.getMapper( Service.class);
		ArrayList<MembershipDTO> list = ss.memberviewall();
		mo.addAttribute("list", list);

		return "memberviewall";
	}

	// 마이페이지 환불 내역 보기
	@RequestMapping(value = "/refundview")
	public String refundview(HttpServletRequest request, Model mo) {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		 Service ss = sqlSession.getMapper( Service.class);
		ArrayList<MembershipDTO> list = ss.refundview(id);
		mo.addAttribute("list", list);

		return "payout";
	}
	
	// 마이페이지 나의 상품 리뷰 보기
	@RequestMapping(value = "/myproductreview")
	public String myproductreview(HttpServletRequest request, Model mo) {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		 Service ss = sqlSession.getMapper( Service.class);
		ArrayList<ProductreviewDTO> list = ss.myproductreview(id);
		mo.addAttribute("list", list);
		

		return "myproductreview";
	}
	
	// 나의 상품 리뷰에서 리뷰한 상품 보기
	@RequestMapping(value = "/reviewproductview")
	public String reviewproductview(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		int snum = Integer.parseInt(request.getParameter("snum"));
		String sname = request.getParameter("sname");
		
		 Service ss = sqlSession.getMapper( Service.class);
		ArrayList<ProductDTO> list = ss.detailview(snum,sname);
		mo.addAttribute("list", list);
		
		
		// 상품 리뷰 출력 추가
		ArrayList<ProductreviewDTO> list1 = ss.productreviewout(snum,sname);
		mo.addAttribute("list1", list1);
		
		if(list==null || list.isEmpty() || list1==null || list1.isEmpty())
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('해당 상품은 존재하지 않습니다.'); window.history.back(); </script>");
			printw.close();
			return null;
		}
		else 
		{
			return "detailview";
		}
		
	}
	
	// 마이페이지 주소지 목록 가져오기
	@RequestMapping(value = "/mypageaddresslist",method = RequestMethod.GET)
	public String mypageaddresslist(HttpServletRequest request, Model mo) {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		com.ezen.haha.product.Service ss = sqlSession.getMapper(com.ezen.haha.product.Service.class);
		ArrayList<AddressListDTO> list = ss.addresslistout(id);
		
		mo.addAttribute("list", list);
		
		return "mypageaddresslist";
	}	
	
	// 주소 목록 추가 페이지
		@RequestMapping(value = "/addressinput")
		public String addressInput(HttpServletRequest request) {

			return "addressInput";
		}
		// 주소 목록 추가 
		@RequestMapping(value = "/addressSave")
		public String addressSave(HttpServletRequest request, HttpServletResponse response) throws IOException {
			HttpSession hs = request.getSession();
			String id = (String) hs.getAttribute("id");
			String addressname = request.getParameter("addressname");
			String name = request.getParameter("name");
			String tel = "010-"+ request.getParameter("tel1") + "-" + request.getParameter("tel2");
			String address = request.getParameter("postcode")+","+request.getParameter("address1")+","+ 
							request.getParameter("address2");
			Service ss = sqlSession.getMapper(Service.class);
			
			System.out.println(id);
			System.out.println(addressname);
			System.out.println(name);
			System.out.println(tel);
			System.out.println(address);
			
			ss.addressInsert(id,addressname,name,tel,address);
			

			  String script = "<script>";
			    script += "window.opener.location.reload();"; // 부모 창 리로드
			    script += "window.close();"; // 팝업 창 닫기
			    script += "window.opener.location.href='./mypageaddresslist';"; // 부모 창 리다이렉트
			    script += "</script>";

			    response.setContentType("text/html;charset=utf-8");
			    PrintWriter printw = response.getWriter();
			    printw.print(script);
			    printw.close();
			    return null;
	}	
		// 주소 목록 삭제 페이지
		@ResponseBody
		@RequestMapping(value = "/adderessDelete")
		public String adderessDelete(HttpServletRequest request) {
			Service ss = sqlSession.getMapper(Service.class);
			int addressnum = Integer.parseInt(request.getParameter("addressnum"));
			ss.addressDelete(addressnum);
			
			
			return "mypageaddresslist";
		}
		
		
}
