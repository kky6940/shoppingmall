package com.ezen.haha.pay;

import java.util.ArrayList;

import com.ezen.haha.product.BasketDTO;
import com.ezen.haha.product.ProductDTO;
import com.ezen.haha.product.ProductreviewDTO;

public interface Service {

	ArrayList<PayDTO> payout(int partner_order_id1, String partner_user_id);

	void payinsert(String tid1, int partner_order_id1, String partner_user_id, String payment_method_type, String item_name, int quantity1, int totprice, String approved_at, int snum, String address, String name, String tel, String email, String drequest, int paystate);

	void productsuupdate(int snum, int quantity1);

	ArrayList<PayDTO> paysearch(String tid);

	void deletepaylist(String tid1);

	String email(String id);

	void bankinsert(String id, String name, String address, String tel, String email, String payment, String snum,
			String sname, int paynum, int totprice);

	ArrayList<BasketDTO> basketInfo(String basket);

	void productsuupdate(BasketDTO aa);

	void basketDelete(String basket);

	void couponUpdate(String id, String string);

	void pointUpdate(String id, int usePoint, int savePoint);

	void insertorderid(PayDTO paydto);

	

}
