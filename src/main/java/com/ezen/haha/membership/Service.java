package com.ezen.haha.membership;

public interface Service {

	String id_check(String id);

	void membersave(String id, String pw, String name, String tel, String email, String pid,String address);

	MembershipDTO logingo(String id, String pw);

}
