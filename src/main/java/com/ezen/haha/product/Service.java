package com.ezen.haha.product;

import java.util.ArrayList;

import com.ezen.haha.membership.MembershipDTO;

public interface Service {

	void productinsert(int snum, String sname, String stype, int su, int price, String ssize, String fname,
			String intro);

	ArrayList<ProductDTO> productout();

	ArrayList<ProductDTO> detailview(int snum);

	void basketinsert(String id, int snum, String sname, String stype, int guestbuysu, int totprice, String ssize, String image);

	ArrayList<BasketDTO> basketout(String id);

	ArrayList<MembershipDTO> IDinformation(String id);

	void Productsellinsert(String id, String name, String tel, String email, String address, String image, int snum,
			String sname, String ssize, int guestbuysu, int totprice, String stype);

	void deleteproductsell();
	
	ArrayList<ProductSellDTO> productsellout();

}
