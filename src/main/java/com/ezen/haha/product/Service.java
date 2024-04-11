package com.ezen.haha.product;

import java.util.ArrayList;

import com.ezen.haha.membership.MembershipDTO;

public interface Service {

	void productinsert(int snum, String sname, String stype, int su, int price, String ssize, String color, String fname,
			String intro, int best);

	ArrayList<ProductDTO> productout(PageDTO dto);

	ArrayList<ProductDTO> detailview(int snum);

	void basketinsert(String id, int snum, String sname, String stype, int guestbuysu, int price, int totprice, String ssize, String image, String color);

	ArrayList<BasketDTO> basketout(String id, int start, int end);

	ArrayList<MembershipDTO> IDinformation(String id);

	void Productsellinsert(String id, String name, String tel, String email, String address, String image, int snum,
			String sname, String ssize, int guestbuysu, int totprice, String stype, String color);

	void deleteproductsell();
	
	ArrayList<ProductSellDTO> productsellout();

	BasketDTO basketsell(int i);

	int total();

	int totalbasket(String id);

	void deletebasket(int i);

	int snumcheck(int snum, String ssize, String color);

	Integer colorsnumsearch(String sname, String color);

	void updatebasket(int i, int j, int k);

	void deleteproduct(int snum);

	ArrayList<ProductDTO> updateproductview(int snum);

	int jaegocheck(int snum, String ssize, String color, int guestbuysu);

	void updateproductmainimage(int newsnum, String sname, String stype, int su, int price, String ssize, String color,
			String image, String intro, int best, int snum);

	void updateproductsideimage1(String sideimage1, int snum);

	void updateproductsideimage2(String sideimage2, int snum);

	void updateproductsideimage3(String sideimage3, int snum);

	String countfind();

	void productreviewsave(int snum, String id, String btitle, String bcontent, String fname, int productrank);

	ArrayList<ProductreviewDTO> productreviewout(int snum);

	Integer productbuysearch(String id, int snum);

	String stockcheck(int snum, String ssize);

	int totalSearch(String stype);

	ArrayList<ProductDTO> searchout(String stype, int start, int end);

	

}
