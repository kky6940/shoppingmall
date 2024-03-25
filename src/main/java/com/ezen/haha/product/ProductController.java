package com.ezen.haha.product;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.haha.membership.MembershipDTO;


@Controller
public class ProductController {
	@Autowired
	SqlSession sqlSession;
	
	String imagepath = "C:\\이젠디지탈12\\spring\\shoppingmall-master.zip_expanded\\shoppingmall-master\\src\\main\\webapp\\image";
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	// 상품 입력 화면으로
	@RequestMapping(value = "/productinput")
	public String productinput() {
		
		return "productinput";
	}
	
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
	public String productout(HttpServletRequest request, PageDTO dto, Model mo) {
		String nowPage=request.getParameter("nowPage");
        String cntPerPage=request.getParameter("cntPerPage");
        Service ss = sqlSession.getMapper(Service.class);
        
        int total=ss.total();
    
        if(nowPage==null && cntPerPage == null) {
           nowPage="1";
           cntPerPage="5";
        }
        else if(nowPage==null) {
           nowPage="1";
        }
        else if(cntPerPage==null) {
           cntPerPage="5";
        }      
       
	    dto = new PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		
		mo.addAttribute("paging",dto);
		mo.addAttribute("list", ss.productout(dto));
		
		return "productout";
	}
	
	// 상품 클릭 시 상품 내용 화면으로 가기
	@RequestMapping(value = "/detailview")
	public String detailview(HttpServletRequest request, Model mo) {
		int snum = Integer.parseInt(request.getParameter("snum"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<ProductDTO> list = ss.detailview(snum);
		mo.addAttribute("list", list);
		return "detailview";
	}
	
	// 상품 내용 창에서 장바구니 DB 저장
	@RequestMapping(value = "/basket")
	public String basket(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 로그인 시 id 가져오기
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null)
		{
			int snum = Integer.parseInt(request.getParameter("snum"));
			String sname = request.getParameter("sname");
			String stype = request.getParameter("stype");
			int guestbuysu = Integer.parseInt(request.getParameter("guestbuysu"));
			int totprice = Integer.parseInt(request.getParameter("totprice"));
			String ssize = request.getParameter("ssize");
			String image = request.getParameter("image");
			
			Service ss = sqlSession.getMapper(Service.class);
			ss.basketinsert(id,snum,sname,stype,guestbuysu,totprice,ssize,image);
			
			
			return "redirect:/basketout";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그인이 필요합니다.'); window.location.href='./login'; </script>");
		}
		
		return null;
		
	}
	
	// DB 저장한 장바구니 출력
	@RequestMapping(value = "/basketout")
	public String basketout(HttpServletRequest request, PageDTO dto, Model mo, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null) {
			String nowPage=request.getParameter("nowPage");
	        String cntPerPage=request.getParameter("cntPerPage");
	        System.out.println(nowPage+"\t"+cntPerPage);
	        Service ss = sqlSession.getMapper(Service.class);

	        int total=ss.totalbasket();
	    
	        if(nowPage==null && cntPerPage == null) {
	           nowPage="1";
	           cntPerPage="5";
	        }
	        else if(nowPage==null) {
	           nowPage="1";
	        }
	        else if(cntPerPage==null) {
	           cntPerPage="5";
	        }      
	       
	        dto = new PageDTO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
	        
	        mo.addAttribute("paging",dto);
			mo.addAttribute("list", ss.basketout(id,dto.getStart(),dto.getEnd()));
			return "basketout";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그인이 필요합니다.'); window.location.href='./login'; </script>");
		}
		
		return null;
	}
	
	// 장바구니에서 체크박스 선택 후 구매확인 화면으로 이동
	@RequestMapping(value = "/basketsell", method = RequestMethod.POST)
	public String basketsell(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		Service ss = sqlSession.getMapper(Service.class);
		ss.deleteproductsell(); // 구매 창을 누를 때마다 DB에 담긴 주문 정보 초기화(delete), 안하면 이전 주문정보를 전부 불러옴, 나중에 지금까지 구매했던 구매목록을 보고 싶다면 초기화 전에 다른 DB테이블을 따로 만들어서 저장하거나 다른 방법을 찾아야 할 것 같음
		
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null) // 로그인 중이라면
		{
			String [] items = request.getParameterValues("item"); // 체크박스로 선택한 목록 번호를 가져옴
			int [] basketnum = null;
			
			if(items != null)
			{
				basketnum = new int[items.length];
				for(int i=0; i<items.length; i++)
				{
					basketnum[i] = Integer.parseInt(items[i]);
				}
			}

			ArrayList<BasketDTO> list = new ArrayList<>(); 
			for (int i = 0; i < basketnum.length; i++) {
			    list.add(ss.basketsell(basketnum[i]));
			}
			
			mo.addAttribute("list", list);
			
			return "basketsellout";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그인이 필요합니다.'); window.location.href='./login'; </script>");
		}
		
		return null;
	
	}
	
	// 상품 내용 화면에서 즉시 구매 클릭, 장바구니 화면에서 구매 클릭 시 구매확인 화면으로 이동
	@RequestMapping(value = "/productsell", method = RequestMethod.POST)
	public String productsell(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		Service ss = sqlSession.getMapper(Service.class);
		ss.deleteproductsell(); // 구매 창을 누를 때마다 DB에 담긴 주문 정보 초기화(delete), 안하면 이전 주문정보를 전부 불러옴, 나중에 지금까지 구매했던 구매목록을 보고 싶다면 초기화 전에 다른 DB테이블을 따로 만들어서 저장하거나 다른 방법을 찾아야 할 것 같음
			
		String image = request.getParameter("image");
		int snum = Integer.parseInt(request.getParameter("snum"));
		String sname = request.getParameter("sname");
		String ssize = request.getParameter("ssize");
		int guestbuysu = Integer.parseInt(request.getParameter("guestbuysu"));
		int totprice = Integer.parseInt(request.getParameter("totprice"));
		String stype = request.getParameter("stype");
		
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id"); // 로그인 중일 시 id 값을 가져옴
		if(id != null)
		{
			ArrayList<MembershipDTO> IDlist = ss.IDinformation(id); // 구매 시 정보 입력을 위해 회원 정보를 가져옴
			MembershipDTO dto = IDlist.get(0); // IDlist에 기록된 첫번째 값을 불러옴
			String name = dto.getName();
			String tel = dto.getTel();
			String email = dto.getEmail();
			String address = dto.getAddress();
			
			// 개인 정보와 구매 정보를 DB 테이블(Productsell)에 입력
			ss.Productsellinsert(id,name,tel,email,address,image,snum,sname,ssize,guestbuysu,totprice,stype);
			ArrayList<ProductSellDTO> pslist = ss.productsellout();
			mo.addAttribute("list", pslist);
			
			return "productsellout";
		}
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('로그인이 필요합니다.'); window.location.href='./login'; </script>");
		}

		return null;
	}
	
}
