package com.ezen.haha.mypage;

import java.util.ArrayList;

import com.ezen.haha.membership.MembershipDTO;
import com.ezen.haha.pay.PayDTO;
import com.ezen.haha.product.ProductDTO;
import com.ezen.haha.product.ProductreviewDTO;

public interface Service {

	ArrayList<MembershipDTO> mypageview(String id);

	ArrayList<CouponDTO> couponview(String id);

	ArrayList<PayDTO> payoutviewall();

	ArrayList<MembershipDTO> memberviewall();

	ArrayList<PayDTO> payoutviewmonth(String id);

	ArrayList<PayDTO> guestpayoutview(String id);

	ArrayList<MembershipDTO> refundview(String id);

	ArrayList<ProductreviewDTO> myproductreview(String id);
	
	ArrayList<ProductDTO> detailview(int snum, String sname);

	ArrayList<ProductreviewDTO> productreviewout(int snum, String sname);

	

}
