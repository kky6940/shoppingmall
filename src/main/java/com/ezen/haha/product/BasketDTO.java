package com.ezen.haha.product;

import com.ezen.haha.membership.MembershipDTO;

public class BasketDTO {
	String id,psize,color;
	int basketnum,snum,guestbuysu;
	
	ProductDTO productdto;
	MembershipDTO membershipdto;
	
	public BasketDTO() {}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPsize() {
		return psize;
	}

	public void setPsize(String psize) {
		this.psize = psize;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getBasketnum() {
		return basketnum;
	}

	public void setBasketnum(int basketnum) {
		this.basketnum = basketnum;
	}

	public ProductDTO getProductdto() {
		return productdto;
	}
	
	public void setProductdto(ProductDTO productdto) {
		this.productdto = productdto;
	}
	public int getSnum() {
		return snum;
	}

	public void setSnum(int snum) {
		this.snum = snum;
	}

	public int getGuestbuysu() {
		return guestbuysu;
	}

	public void setGuestbuysu(int guestbuysu) {
		this.guestbuysu = guestbuysu;
	}

	public MembershipDTO getMembershipdto() {
		return membershipdto;
	}

	public void setMembershipdto(MembershipDTO membershipdto) {
		this.membershipdto = membershipdto;
	}


}
	