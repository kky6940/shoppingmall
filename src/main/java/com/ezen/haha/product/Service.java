package com.ezen.haha.product;

import java.util.ArrayList;

import com.ezen.haha.membership.MembershipDTO;

public interface Service {

	void productinsert(int snum, String sname, String stype, int su, int price, String ssize, String fname,
			String intro, int best, String fname1, String fname2, String fname3);

	ArrayList<ProductDTO> productout(PageDTO dto);

	ArrayList<ProductDTO> detailview(int snum);

	void basketinsert(String id, int snum, String sname, String stype, int guestbuysu, int totprice, String ssize, String image);

	ArrayList<BasketDTO> basketout(String id, int start, int end);

	ArrayList<MembershipDTO> IDinformation(String id);

	void Productsellinsert(String id, String name, String tel, String email, String address, String image, int snum,
			String sname, String ssize, int guestbuysu, int totprice, String stype);

	void deleteproductsell();
	
	ArrayList<ProductSellDTO> productsellout();

	BasketDTO basketsell(int i);

	int total();

	int totalbasket(String id);

	void deletebasket(int i);

	int snumcheck(int snum, String ssize);

	

}
