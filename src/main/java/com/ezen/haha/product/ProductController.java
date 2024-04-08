package com.ezen.haha.product;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
		String stype = mul.getParameter("stype");
		String color = mul.getParameter("color");
		String sname = mul.getParameter("sname");
		int su = Integer.parseInt(mul.getParameter("su"));
		int price = Integer.parseInt(mul.getParameter("price"));
		String ssize = mul.getParameter("ssize");
		String intro = mul.getParameter("intro");
		int best = Integer.parseInt(mul.getParameter("best"));
		String fname = "";
		
		 List<MultipartFile> fileList = mul.getFiles("image");

         for (MultipartFile mf : fileList) {
             String originFileName = mf.getOriginalFilename(); // 원본 파일 명
             fname = fname + ", " +originFileName;

             System.out.println("originFileName : " + originFileName);
         
             String safeFile = imagepath + originFileName;
             
             mf.transferTo(new File(safeFile));
		

         }
		

		Service ss = sqlSession.getMapper(Service.class);
		ss.productinsert(snum,sname,stype,su,price,ssize,color,fname,intro,best);
		
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
		
		// 상품 리뷰 출력 추가
		ArrayList<ProductreviewDTO> list1 = ss.productreviewout(snum);
		mo.addAttribute("list1", list1);
		return "detailview";
	}
	
	// 상품 내용 창에서 장바구니 DB 저장
	@RequestMapping(value = "/basket")
	public String basket(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 로그인 시 id 가져오기
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null) // 로그인 체크
		{
			Service ss = sqlSession.getMapper(Service.class);
			String sname = request.getParameter("sname");
			String color = request.getParameter("color");
			Integer snum = ss.colorsnumsearch(sname,color); // 색상에 맞는 상품의 상품코드 가져오기
			
			if(snum!=null) // 색상에 맞는 상품이 있는지 체크(사용자는 어드민 출력 화면이 아니라 상품 내용 화면에서 색상을 선택하고 넘어가기 때문에 따로 체크해야함)
			{
				String stype = request.getParameter("stype");
				int guestbuysu = Integer.parseInt(request.getParameter("guestbuysu"));
				int su = Integer.parseInt(request.getParameter("su"));
				int price = Integer.parseInt(request.getParameter("price"));
				int totprice = Integer.parseInt(request.getParameter("totprice"));
				
				String ssize = request.getParameter("ssize");
				String image = request.getParameter("image");
				
				int jaegocheck = ss.jaegocheck(snum,ssize,color,guestbuysu); // 상품 존재 유무 및 재고 체크
				int snumcheck = ss.snumcheck(snum,ssize,color); // 장바구니 중복 체크
				
				if(jaegocheck!=0) // 상품 재고 체크
				{
					if(snumcheck==0) // 장바구니 중복 체크
					{
						ss.basketinsert(id,snum,sname,stype,guestbuysu,price,totprice,ssize,image,color);
						return "redirect:/basketout";
					}
					else
					{
						response.setContentType("text/html;charset=utf-8");
						PrintWriter printw = response.getWriter();
						printw.print("<script> alert('중복된 제품이 장바구니에 있습니다.'); window.location.href='./basketout'; </script>");
						printw.close();
						return null;
					}
				}
				else
				{
					response.setContentType("text/html;charset=utf-8");
					PrintWriter printw = response.getWriter();
					printw.print("<script> alert('해당 상품의 재고가 없습니다.'); window.history.back(); </script>");
					printw.close();
					return null;
				}
			}
			else
			{
				response.setContentType("text/html;charset=utf-8");
				PrintWriter printw = response.getWriter();
				printw.print("<script> alert('해당 색상의 상품이 존재하지 않습니다.'); window.history.back(); </script>");
				printw.close();
				return null;
			}
			
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
	
	// DB 저장한 장바구니 출력
	@RequestMapping(value = "/basketout")
	public String basketout(HttpServletRequest request, PageDTO dto, Model mo, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null) {
			String nowPage=request.getParameter("nowPage");
	        String cntPerPage=request.getParameter("cntPerPage");
	        
	        Service ss = sqlSession.getMapper(Service.class);

	        int total=ss.totalbasket(id);
	    
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
			printw.close();
			return "redirect:./login";
		}
		
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
			String [] reguestbuysu = request.getParameterValues("guestbuysu"); // 장바구니에서 수정한 수량을 가져옴
			String [] retotprice = request.getParameterValues("totprice"); // 장바구니에서 수정한 총 가격을 가져옴
			int [] basketnum = null;
			int [] guestbuysu = null;
			int [] totprice = null;
			
			if(items != null)
			{
				basketnum = new int[items.length]; // basketnum 배열 초기화, 안하면 널포인트 에러가 뜬다.
				guestbuysu = new int[reguestbuysu.length];
		        totprice = new int[retotprice.length];
		        
				for(int i=0; i<items.length; i++)
				{
					basketnum[i] = Integer.parseInt(items[i]); // int 타입으로 전환
					guestbuysu[i] = Integer.parseInt(reguestbuysu[i]);
					totprice[i] = Integer.parseInt(retotprice[i]);
				}
			}
			
			ArrayList<BasketDTO> list = new ArrayList<>(); 
			for (int i = 0; i < basketnum.length; i++) {
				ss.updatebasket(guestbuysu[i],totprice[i],basketnum[i]);// 장바구니에서 수정한 수량, 총 가격 업데이트
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
			printw.close();
			return "redirect:./login";
		}
	
	}
	
	// 상품 내용 화면에서 즉시 구매 클릭 시 구매확인 화면으로 이동
	@RequestMapping(value = "/productsell", method = RequestMethod.POST)
	public String productsell(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		Service ss = sqlSession.getMapper(Service.class);
		ss.deleteproductsell(); // 구매 창을 누를 때마다 DB에 담긴 주문 정보 초기화(delete), 안하면 이전 주문정보를 전부 불러옴, 나중에 지금까지 구매했던 구매목록을 보고 싶다면 초기화 전에 다른 DB테이블을 따로 만들어서 저장하거나 다른 방법을 찾아야 할 것 같음
			
		String image = request.getParameter("image");
		int snum = Integer.parseInt(request.getParameter("snum"));
		String sname = request.getParameter("sname");
		String ssize = request.getParameter("ssize");
		String color = request.getParameter("color");
		int guestbuysu = Integer.parseInt(request.getParameter("guestbuysu"));
		int totprice = Integer.parseInt(request.getParameter("totprice"));
		String stype = request.getParameter("stype");
		
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id"); // 로그인 중일 시 id 값을 가져옴
		
		int jaegocheck = ss.jaegocheck(snum,ssize,color,guestbuysu); // 상품 존재 유무 및 재고 체크
		if(jaegocheck!=0) // 상품 재고 체크
		{
			if(id != null) // 로그인 유무 체크
			{
				ArrayList<MembershipDTO> IDlist = ss.IDinformation(id); // 구매 시 정보 입력을 위해 회원 정보를 가져옴
				MembershipDTO dto = IDlist.get(0); // IDlist에 기록된 첫번째 값을 불러옴
				String name = dto.getName();
				String tel = dto.getTel();
				String email = dto.getEmail();
				String address = dto.getAddress();
				
				// 개인 정보와 구매 정보를 DB 테이블(Productsell)에 입력
				ss.Productsellinsert(id,name,tel,email,address,image,snum,sname,ssize,guestbuysu,totprice,stype,color);
				ArrayList<ProductSellDTO> pslist = ss.productsellout();
				mo.addAttribute("list", pslist);
				
				return "productsellout";
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
		else
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('해당 상품의 재고가 없습니다.'); window.history.back(); </script>");
			printw.close();
			return null;
		}
			
	}
	
	// 장바구니 목록 선택 후 삭제
	@RequestMapping(value = "/basketdelete")
	public String basketdelete(HttpServletRequest request) {
		String [] items = request.getParameterValues("item"); // 체크박스로 선택한 목록 번호를 가져옴
		int [] basketnum = null;
		
		if(items != null && items.length > 0)
		{
			basketnum = new int[items.length];
			for(int i=0; i<items.length; i++)
			{
				basketnum[i] = Integer.parseInt(items[i]);
			}
		}
		
		Service ss = sqlSession.getMapper(Service.class);
		for (int i = 0; i < basketnum.length; i++) {
			ss.deletebasket(basketnum[i]);
		}
		return "redirect:/basketout";
	}
	
	// 상품 내용 화면에서 상품 삭제하기
	@RequestMapping(value = "/deleteproduct")
	public String deleteproduct(HttpServletRequest request) {
		int snum = Integer.parseInt(request.getParameter("snum"));
		Service ss = sqlSession.getMapper(Service.class);
		ss.deleteproduct(snum);
		
		return "redirect:/productout";
	}
	
	// 상품 내용 화면에서 상품 수정 화면으로 가기
	@RequestMapping(value = "/updateproductview")
	public String updateproductview(HttpServletRequest request, Model mo) {
		int snum = Integer.parseInt(request.getParameter("snum"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<ProductDTO> list = ss.updateproductview(snum);
		mo.addAttribute("list", list);
		
		return "updateproductview";
	}	
		
	// 상품 수정 화면에서 받은 데이터로 상품 정보 수정하기
	@RequestMapping(value = "/updateproduct", method = RequestMethod.POST)
	public String updateproduct(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		int snum = Integer.parseInt(mul.getParameter("snum"));
		int newsnum = Integer.parseInt(mul.getParameter("newsnum"));
		String sname = mul.getParameter("sname");
		String stype = mul.getParameter("stype");
		String color = mul.getParameter("color");
		int su = Integer.parseInt(mul.getParameter("su"));
		int price = Integer.parseInt(mul.getParameter("price"));
		String ssize = mul.getParameter("ssize");
		String intro = mul.getParameter("intro");
		int best = Integer.parseInt(mul.getParameter("best"));
		
		String image = mul.getParameter("image");
		String sideimage1 = mul.getParameter("sideimage1");
		String sideimage2 = mul.getParameter("sideimage2");
		String sideimage3 = mul.getParameter("sideimage3");
		
		Service ss = sqlSession.getMapper(Service.class);
		
		// 이미지 업데이트, 어떤 이미지는 수정 입력하고 어떤 이미지는 입력 안하는 경우가 있기에 if문으로 하나하나 나눠야했음
		MultipartFile mf = mul.getFile("newimage");
		String fname = mf.getOriginalFilename();
		if(mf.getOriginalFilename().equals("")) // 메인이미지 수정 입력을 하지 않았다면
		{
			ss.updateproductmainimage(newsnum,sname,stype,su,price,ssize,color,image,intro,best,snum); // 기존 이미지 업데이트
		}
		else
		{
			mf.transferTo(new File(imagepath+"\\"+fname));
			fname = mf.getOriginalFilename();
			ss.updateproductmainimage(newsnum,sname,stype,su,price,ssize,color,fname,intro,best,snum); // 새 이미지 업데이트
		}
		
		MultipartFile mf1 = mul.getFile("newsideimage1");
		String fname1 = mf1.getOriginalFilename();
		if(mf1.getOriginalFilename().equals(""))
		{
			ss.updateproductsideimage1(sideimage1,snum);
		}
		else
		{
			mf1.transferTo(new File(imagepath+"\\"+fname1));
			fname1 = mf1.getOriginalFilename();
			ss.updateproductsideimage1(fname1,snum);
		}
				
		MultipartFile mf2 = mul.getFile("newsideimage2");
		String fname2 = mf2.getOriginalFilename();
		if(mf2.getOriginalFilename().equals(""))
		{
			ss.updateproductsideimage2(sideimage2,snum);
		}
		else
		{
			mf2.transferTo(new File(imagepath+"\\"+fname2));
			fname2 = mf2.getOriginalFilename();
			ss.updateproductsideimage1(fname2,snum);
		}
		
		MultipartFile mf3 = mul.getFile("newsideimage3");
		String fname3 = mf3.getOriginalFilename();
		if(mf3.getOriginalFilename().equals(""))
		{
			ss.updateproductsideimage3(sideimage3,snum);
		}
		else
		{
			mf3.transferTo(new File(imagepath+"\\"+fname3));
			fname3 = mf3.getOriginalFilename();
			ss.updateproductsideimage3(fname3,snum);
		}

		return "redirect:/productout";
	}

	// 구매창 주소 수정 화면으로
	@RequestMapping(value = "/updateaddress")
	public String updateaddress() {
		
		return "updateaddress";
	}
	
	// 구매창 이름 수정 화면으로
	@RequestMapping(value = "/updatename")
	public String updatename() {
		
		return "updatename";
	}
	
	// 구매창 연락처 수정 화면으로
	@RequestMapping(value = "/updatetel")
	public String updatetel() {
		
		return "updatetel";
	}
	// 구매창 이메일 수정 화면으로
	@RequestMapping(value = "/updateemail")
	public String updateemail() {
		
		return "updateemail";
	}
	
	// 상품 리뷰 입력 화면으로
	@RequestMapping(value = "/productreviewinput")
	public String productreviewinput(HttpServletRequest request, Model mo, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null) // 로그인 유무 체크
		{
			int snum = Integer.parseInt(request.getParameter("snum"));
			
			// 리뷰 쓰기 전 해당 상품을 구입했는지 체크
			// 상품 구입 후 상품 구입 목록을 저장하는 DB를 후에 따로 만들어 체크해야함
			// 지금은 상품 리뷰 DB(productreview)에서 자체 체크 
			Service ss = sqlSession.getMapper(Service.class);
			Integer productbuy = ss.productbuysearch(id,snum);
			if(productbuy == null || productbuy != 1)
			{
				response.setContentType("text/html;charset=utf-8");
				PrintWriter printw = response.getWriter();
				printw.print("<script> alert('상품 구입 기록이 없습니다.'); window.history.back(); </script>");
				printw.close();
				return null;
				
			}
			else
			{
				mo.addAttribute("snum", snum);
				return "productreviewinput";
			}
			
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
	
	// 상품 리뷰 입력 후 DB에 저장
	@RequestMapping(value = "/productreviewsave", method = RequestMethod.POST)
	public String productreviewsave(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		HttpSession hs = mul.getSession();
		String id = (String) hs.getAttribute("id"); 
		String btitle = mul.getParameter("btitle");
		int snum = Integer.parseInt(mul.getParameter("snum"));
		String bcontent = mul.getParameter("bcontent");
		int productrank = Integer.parseInt(mul.getParameter("productrank"));
		
		MultipartFile mf = mul.getFile("bpicture");
		String fname = mf.getOriginalFilename();
		mf.transferTo(new File(imagepath+"\\"+fname));
		
		Service ss = sqlSession.getMapper(Service.class);
		ss.productreviewsave(snum,id,btitle,bcontent,fname,productrank);
		
		return "redirect:/productout";
	}
	// 수량 체크
	@ResponseBody
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String stockcheck(HttpServletRequest request) {
		int snum =  Integer.parseInt(request.getParameter("snum"));
		String ssize = request.getParameter("ssize");
		
		Service ss = sqlSession.getMapper(Service.class);

		return ss.stockcheck(snum,ssize);
	}
}
