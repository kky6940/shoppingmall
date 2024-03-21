package com.ezen.haha.product;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Controller
public class ProductController {
	@Autowired
	SqlSession sqlSession;
	
	String imagepath = "C:\\이젠디지탈12\\spring\\shoppingmall-master.zip_expanded\\shoppingmall-master\\src\\main\\webapp\\WEB-INF\\image";
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	// 상품 입력 화면으로
	@RequestMapping(value = "/productinput")
	public String productinput() {
		
		return "productinput";
	}
	a
	// 상품 입력 후 DB에 저장
	@RequestMapping(value = "/productsave", method = RequestMethod.POST)
	public String productsave(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		int snum = Integer.parseInt(mul.getParameter("snum"));
		String sname = mul.getParameter("sname");
		String stype = mul.getParameter("stype");
		int su = Integer.parseInt(mul.getParameter("su"));
		int price = Integer.parseInt(mul.getParameter("price"));
		String ssize = mul.getParameter("ssize");
		
		MultipartFile mf = mul.getFile("image");
		String fname = mf.getOriginalFilename();
		mf.transferTo(new File(imagepath+"\\"+fname));
		
		String intro = mul.getParameter("intro");
		
		Service ss = sqlSession.getMapper(Service.class);
		ss.productinsert(snum,sname,stype,su,price,ssize,fname,intro);
		
		return "redirect:/main";
	}
	
	// DB 데이터 가져온 후 출력 화면으로 가기
	@RequestMapping(value = "/productout")
	public String productout(Model mo) {
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<ProductDTO> list = ss.productout();
		mo.addAttribute("list", list);
		return "productout";
	}
	
	// 상품 클릭 시 상품 내용(구매) 화면으로 가기
	@RequestMapping(value = "/detailview")
	public String detailview(HttpServletRequest request, Model mo) {
		int snum = Integer.parseInt(request.getParameter("snum"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<ProductDTO> list = ss.detailview(snum);
		mo.addAttribute("list", list);
		return "detailview";
	}
	
	// 상품 내용(구매) 창에서 장바구니로 가기
	@RequestMapping(value = "/basket")
	public String basket(HttpServletRequest request, Model mo) {
		int snum = Integer.parseInt(request.getParameter("snum"));
		String sname = request.getParameter("sname");
		String stype = request.getParameter("stype");
		int guestbuysu = Integer.parseInt(request.getParameter("guestbuysu"));
		int totprice = Integer.parseInt(request.getParameter("totprice"));
		String ssize = request.getParameter("ssize");
		// 아이디 가져오기 필요
		
		String image = request.getParameter("image");
		
		Service ss = sqlSession.getMapper(Service.class);
		
		// 아이디 insert 추가 필요
		ss.basketinsert(snum,sname,stype,guestbuysu,totprice,ssize,image);
		
		// snum 을 id 로 변경 필요
		ArrayList<BasketDTO> list = ss.basketout(snum);
		mo.addAttribute("list", list);
		
		return "basketout";
	}
	
}
