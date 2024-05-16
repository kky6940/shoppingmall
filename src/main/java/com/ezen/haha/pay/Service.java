package com.ezen.haha.pay;

import java.util.ArrayList;

import com.ezen.haha.product.BasketDTO;
import com.ezen.haha.product.ProductDTO;
import com.ezen.haha.product.ProductreviewDTO;

public interface Service {

	ArrayList<PayDTO> payout(int partner_order_id1, String partner_user_id);

	void payinsert(String tid1, int partner_order_id1, String partner_user_id, String payment_method_type, String item_name, int quantity1, int totprice, String approved_at, String snum, String address, String name, String tel, String email, String drequest, int paystate, String payment);

	void productsuupdate(int snum, int quantity1);

	ArrayList<PayDTO> paysearch(String tid);

	String email(String id);

	void bankinsert(String id, String name, String address, String tel, String email, String payment, String snum,
			String sname, int paynum, int totprice, String payEndTime, String paystate, PayDTO dto);

	ArrayList<BasketDTO> basketInfo(String basket);

	void productsuupdate(BasketDTO aa);

	void basketDelete(String basket);

	void couponUpdate(String id, String string);

	void pointUpdate(String id, int usePoint, int savePoint);

	void insertorderid(PayDTO paydto);

	void updatepaylist(String tid1);

	void payinfoupdate(String guestbuysu, int partner_order_id1);

	void pointRefund(String id);

	void rankUpdate(String id, int totalPrice);

	int totalPrice(String id);

	

}
