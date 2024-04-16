package com.ezen.haha.qna;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.haha.mypage.CouponDTO;
import com.ezen.haha.qna.PageDTO;





@Controller
public class QnaController {
	@Autowired
	SqlSession sqlSession;

	String imagepath = "C:\\이젠디지탈12\\spring\\shoppingmall-master.zip_expanded\\shoppingmall-master\\src\\main\\webapp\\image";
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	
	//고객센터 main
	@RequestMapping(value = "/qnahome")
	public String qna1() {
		
		return "qnahome";
	}
	
	//공지사항
	@RequestMapping(value = "/notice")
	public String qna2(HttpServletRequest request, com.ezen.haha.qna.PageDTO dto , Model mo) {
		String nowPage=request.getParameter("nowPage");
        String cntPerPage=request.getParameter("cntPerPage");
		Service ss = sqlSession.getMapper(Service.class);
		
		int total=ss.total();
		if(nowPage==null && cntPerPage == null) {
			nowPage="1";
			cntPerPage="7";
		}
		else if(nowPage==null) {
			nowPage="1";
		}
		else if(cntPerPage==null) {
			cntPerPage="7";
		}
		
		dto = new com.ezen.haha.qna.PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		mo.addAttribute("paging",dto);
		mo.addAttribute("list", ss.noticeout(dto.getStart(),dto.getEnd()));
		
		return "noticepage";
	}
	//공지사항 글쓰기(관리자만 가능해야함)
	@RequestMapping(value = "/noticeinput")
	public String qna3() {
		
		return "noticeinputform";
	}
	
	//공지사항 글쓰기 DB에 저장 (로그인한 관리자만 작성할 수 있게 해야함)
	@RequestMapping(value = "/noticesave", method = RequestMethod.POST)
	public String qna4(MultipartHttpServletRequest mul) throws IllegalStateException, IOException {
		String bid = mul.getParameter("bid");
		String btype = mul.getParameter("btype");
		String btitle = mul.getParameter("btitle");
		String bcontent = mul.getParameter("bcontent");
		String bcode = mul.getParameter("bcode");
		List<String> filename = new ArrayList<>();
		
		List<MultipartFile> fileList = mul.getFiles("bpicture");
	    for (MultipartFile mf : fileList) {
	        String originalfilename = mf.getOriginalFilename();
	        String extension = FilenameUtils.getExtension(originalfilename);
	        String uuid = UUID.randomUUID().toString();
	        String newfilename = uuid + "_" + System.currentTimeMillis() + "." + extension;
	        String fname = filesave(newfilename, mf.getBytes(), originalfilename);
	        
	        filename.add(fname); // 파일 이름을 리스트에 추가 ㄱㄱ
	    }
	    // 파일 이름 리스트를 쉼표로 구분하여 문자열로 변환해줌
	    String fname = String.join(",", filename);

	    Service ss = sqlSession.getMapper(Service.class);
	    ss.noticeinsert(bid, btype, btitle, bcontent, fname, bcode);
	    
	    return "redirect:/notice";
	}
	
	private String filesave(String newfilename, byte[] bytes, String originalfilename) throws IOException {
		String filePath = imagepath + "\\" + newfilename; 
		File file = new File(filePath);
		FileOutputStream fos = new FileOutputStream(file);
		fos.write(bytes);
		fos.close();
		return newfilename;
	}
	
	//제목 클릭 시 내용
	@RequestMapping(value = "/bcontentpage")
	public String qna5(HttpServletRequest request,Model mo) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<QnaDTO> list = ss.contentpage(bnum);
		mo.addAttribute("list", list);
		return "bcontentpage";
	}
	
	//공지사항삭제
	@ResponseBody
	@RequestMapping(value = "/noticedelete")
	public String qna6(HttpServletRequest request) {
	    int bnum = Integer.parseInt(request.getParameter("bnum"));
	    String originalbimg = request.getParameter("originalbimg");
	    deleteFile(originalbimg); // 이미지 파일 삭제

	    Service ss = sqlSession.getMapper(Service.class);
	    int deletecount = ss.notice_delete(bnum);
	    return (deletecount > 0) ? "success" : "failure";
	}
	
	private void deleteFile(String originalbimg) {
		if (originalbimg != null && !originalbimg.isEmpty()) {
			String imageName = originalbimg.substring(originalbimg.lastIndexOf("/") + 1);
			String img_allpath = imagepath + "\\" + imageName;
			File img = new File(img_allpath);
			if (img.exists() && img.delete()) {
				// 파일 삭제 성공
			} else {
				// 파일 삭제 실패
			}
		} else {
			// 파일이 없거나 이미 삭제된 경우
		}
	}
	
	//수정
	@RequestMapping(value = "/nmodify")
	public String qna7(HttpServletRequest request,Model mo) throws UnsupportedEncodingException {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<QnaDTO> list = ss.contentpage(bnum);
		mo.addAttribute("list", list);
		return "nmodifypage";
	}
	
	//수정하는 부분에서 전에 있던 사진삭제
	@ResponseBody
	@RequestMapping(value = "/imgdelete")
	public String qna8(HttpServletRequest request) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String originalbimg = request.getParameter("originalbimg");
		boolean hasimg = (originalbimg != null && !originalbimg.isEmpty());
		Service ss = sqlSession.getMapper(Service.class);
		int deletecount = 0;
		
		if (hasimg) {
			deleteFile(originalbimg); // 이미지 삭제
	        deletecount = ss.notice_deleteimg(bnum);
	    } else {
	        deletecount = ss.notice_deleteimg(bnum);
	    }

	    return (deletecount > 0) ? "success" : "failure";
	}
	
	//공지사항 수정 DB에 업데이트 (로그인한 관리자만 작성할 수 있게 해야함)
	@RequestMapping(value = "/noticemodify", method = RequestMethod.POST)
	public String qna9(MultipartHttpServletRequest mul, HttpServletResponse response) throws IllegalStateException, IOException {
	    int bnum = Integer.parseInt(mul.getParameter("bnum"));
	    String btype = mul.getParameter("btype");
	    String btitle = mul.getParameter("btitle");
	    String bcontent = mul.getParameter("bcontent");
	    List<String> filename = new ArrayList<>();

	    // 새로운 이미지 업로드
	    List<MultipartFile> fileList = mul.getFiles("bpicture");
	    for (MultipartFile mf : fileList) {
	        String originalfilename = mf.getOriginalFilename();
	        String extension = FilenameUtils.getExtension(originalfilename);
	        String uuid = UUID.randomUUID().toString();
	        String newfilename = uuid + "_" + System.currentTimeMillis() + "." + extension;
	        String fname = filesave(newfilename, mf.getBytes(), originalfilename);
	        filename.add(fname);
	    }
	    String fname = String.join(",", filename);

	    // 기존 이미지를 삭제
	    String originalbimg = mul.getParameter("originalbimg"); 
	    System.out.println("이미지 파일 이름 : " + originalbimg);
	    deleteFile(originalbimg);
	    
	    Service ss = sqlSession.getMapper(Service.class);

	    ss.noticeupdate(btype, btitle, bcontent, fname, bnum);
	    response.setContentType("text/html;charset=utf-8");
	    PrintWriter printw = response.getWriter();
	    printw.print("<script> alert('수정이 완료되었습니다.');</script>");
	    return "redirect:/notice";
	}
	
	//공지사항
	@RequestMapping(value = "/searchgogo")
	public String qna10(HttpServletRequest request, com.ezen.haha.qna.PageDTO dto , Model mo) {
		String keyword = request.getParameter("keyword");
		String nowPage=request.getParameter("nowPage");
		String cntPerPage=request.getParameter("cntPerPage");
		Service ss = sqlSession.getMapper(Service.class);
		
		int total=ss.totalserch(keyword);
		if(nowPage==null && cntPerPage == null) {
			nowPage="1";
			cntPerPage="7";
		}
		else if(nowPage==null) {
			nowPage="1";
		}
		else if(cntPerPage==null) {
			cntPerPage="7";
		}
		
		dto = new com.ezen.haha.qna.PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		mo.addAttribute("paging",dto);
		mo.addAttribute("list", ss.noticeserch(keyword,dto.getStart(),dto.getEnd()));
		
		return "noticepage";
	}
	
	//FAQ(자주묻는질문)page
	@RequestMapping(value = "/faq")
	public String qna11(HttpServletRequest request, com.ezen.haha.qna.PageDTO dto , Model mo) {
		String nowPage=request.getParameter("nowPage");
		String cntPerPage=request.getParameter("cntPerPage");
		Service ss = sqlSession.getMapper(Service.class);
		
		int total=ss.total();
		if(nowPage==null && cntPerPage == null) {
			nowPage="1";
			cntPerPage="7";
		}
		else if(nowPage==null) {
			nowPage="1";
		}
		else if(cntPerPage==null) {
			cntPerPage="7";
		}
		
		dto = new com.ezen.haha.qna.PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		mo.addAttribute("paging",dto);
		mo.addAttribute("list", ss.noticeout(dto.getStart(),dto.getEnd()));
		
		return "faqpage";
	}
	//FAQ(자주묻는질문) 글쓰기(관리자만 가능해야함)
	@RequestMapping(value = "/faqinput")
	public String qna12() {
		
		return "faqinputform";
	}
	
	// qna 게시판 화면 보기
	@RequestMapping(value = "/qna")
	public String qnapage(HttpServletRequest request, com.ezen.haha.qna.PageDTO dto , Model mo) {
		String nowPage=request.getParameter("nowPage");
        String cntPerPage=request.getParameter("cntPerPage");
		Service ss = sqlSession.getMapper(Service.class);
		
		int total=ss.total();
		if(nowPage==null && cntPerPage == null) {
			nowPage="1";
			cntPerPage="7";
		}
		else if(nowPage==null) {
			nowPage="1";
		}
		else if(cntPerPage==null) {
			cntPerPage="7";
		}
		
		dto = new com.ezen.haha.qna.PageDTO(total,Integer.parseInt(nowPage),Integer.parseInt(cntPerPage));
		mo.addAttribute("paging",dto);
		mo.addAttribute("list", ss.qnaout(dto.getStart(),dto.getEnd()));
		
		return "qnapage";
	}
	
	// qna 게시판 글쓰기 화면 보기
	@RequestMapping(value = "/qnainputform")
	public String qnainputform(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null)
		{
			return "qnainputform";
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

	//qna 글쓰기 DB에 저장 (로그인한 대상만 작성할 수 있게 해야함)
	@RequestMapping(value = "/qnasave", method = RequestMethod.POST)
	public String qnasave(MultipartHttpServletRequest mul, HttpServletResponse response) throws IllegalStateException, IOException {
		HttpSession hs = mul.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id != null)
		{
			String bid = mul.getParameter("bid");
			String btype = mul.getParameter("btype");
			String btitle = mul.getParameter("btitle");
			String bcontent = mul.getParameter("bcontent");
			
			List<String> filename = new ArrayList<>();
			
			List<MultipartFile> fileList = mul.getFiles("bpicture");
		    for (MultipartFile mf : fileList) {
		        String originalfilename = mf.getOriginalFilename();
		        String extension = FilenameUtils.getExtension(originalfilename);
		        String uuid = UUID.randomUUID().toString();
		        String newfilename = uuid + "_" + System.currentTimeMillis() + "." + extension;
		        String fname = filesave(newfilename, mf.getBytes(), originalfilename);
		        filename.add(fname); // 파일 이름을 리스트에 추가 ㄱㄱ
		    }
		    // 파일 이름 리스트를 쉼표로 구분하여 문자열로 변환해줌
		    String fname = String.join(",", filename);

		    Service ss = sqlSession.getMapper(Service.class);
		    ss.qnainsert(bid, btype, btitle, bcontent, fname);
		    
		    return "redirect:/qna";
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
	
	// qna 게시판 제목 클릭 시 내용
	@RequestMapping(value = "/qnacontentpage")
	public String qnacontentpage(HttpServletRequest request,Model mo) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String bid = request.getParameter("bid");
		String btitle = request.getParameter("btitle");
		int step = Integer.parseInt(request.getParameter("step"));
		Service ss = sqlSession.getMapper(Service.class);
		ArrayList<QnaDTO> list = ss.qnacontentpage(bnum,bid,step);
		mo.addAttribute("list", list);
		return "qnacontentpage";
	}
	
	// qna 게시판 답글 쓰기 화면으로
	@RequestMapping(value = "/qnacomment")
	public String qnacomment(HttpServletRequest request ,Model mo, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		int step = Integer.parseInt(request.getParameter("step"));
		
		System.out.println(bnum);
		System.out.println(step);
		
		HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		
		if(id.equals("admin"))
		{
			Service ss = sqlSession.getMapper(Service.class);
			ArrayList<QnaDTO> list = ss.commentinputview(bnum,step);
			mo.addAttribute("list", list);
			
			return "qnacommentinput";
		}
		else 
		{
			response.setContentType("text/html;charset=utf-8");
			PrintWriter printw = response.getWriter();
			printw.print("<script> alert('잘못된 접근입니다.'); window.history.back(); </script>");
			printw.close();
			return null;
			
		}
		
		
	}
	
	// qna 게시판 답글 DB에 저장
	@RequestMapping(value = "/qnacommentsave")
	public String qnacommentsave(HttpServletRequest request) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		int groups = Integer.parseInt(request.getParameter("groups"));
		int step = Integer.parseInt(request.getParameter("step"));
		int indent = Integer.parseInt(request.getParameter("indent"));
		String bid = request.getParameter("bid");
		String btype = request.getParameter("btype");
		String btitle = request.getParameter("btitle");
		String bcontent = request.getParameter("bcontent");
		
		Service ss = sqlSession.getMapper(Service.class);
		stepup(groups,step); // 새로운 답글을 달때 step만 증가하게 만듬
		step++; // re 답글을 달때마다 증가하게 만듬
		indent++; // re 답글을 달때마다 증가하게 만듬
		
		ss.qnacommentsave(bnum,bid,btype,btitle,bcontent,groups,step,indent);
		return "redirect:/qna";
	}
	
	// 새로운 답글을 달때 step만 증가하게 만듬
	private void stepup(int groups, int step) {
		Service ss = sqlSession.getMapper(Service.class);
		ss.stepup(groups,step);
		
	}
	
	
	

}
