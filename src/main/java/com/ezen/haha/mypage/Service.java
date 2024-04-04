package com.ezen.haha.mypage;

import java.util.ArrayList;

import com.ezen.haha.membership.MembershipDTO;

public interface Service {

	ArrayList<MembershipDTO> mypageview(String id);

	ArrayList<CouponDTO> couponview(String id);

}
