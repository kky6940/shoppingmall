package com.ezen.haha.product;

import java.util.ArrayList;

public interface Service {

	void productinsert(int snum, String sname, String stype, int su, int price, String ssize, String fname,
			String intro);

	ArrayList<ProductDTO> productout();

	ArrayList<ProductDTO> detailview(int snum);

	void basketinsert(int snum, String sname, String stype, int guestbuysu, int totprice, String ssize, String image);

	ArrayList<BasketDTO> basketout(int snum);

}
