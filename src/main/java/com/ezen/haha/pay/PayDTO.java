package com.ezen.haha.pay;

public class PayDTO {
	String tid; // 결재고유번호
	String next_redirect_mobile_url; // 모바일 접속 시
	String next_redirect_pc_url; // pc 접속 시
	String partner_order_id; // 주문번호
	String partner_user_id; // 회원아이디
	String payment_method_type; // 결재 수단, CARD 혹은 MONEY
	String item_name; // 상품명
	int quantity; // 상품개수
	int total_amount; // 상품 총금액
	int tax_free_amount; // 비과세금액
	String pgtoken; // 클라이언트 결재 후 결제 최종 승인에 필요한 토큰
	String created_at; // 결제 준비 요청 시각
	String approved_at; // 결제 승인 시각
	
	public PayDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getNext_redirect_mobile_url() {
		return next_redirect_mobile_url;
	}
	public void setNext_redirect_mobile_url(String next_redirect_mobile_url) {
		this.next_redirect_mobile_url = next_redirect_mobile_url;
	}
	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}
	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}
	public String getPartner_order_id() {
		return partner_order_id;
	}
	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}
	public String getPartner_user_id() {
		return partner_user_id;
	}
	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	public int getTax_free_amount() {
		return tax_free_amount;
	}
	public void setTax_free_amount(int tax_free_amount) {
		this.tax_free_amount = tax_free_amount;
	}
	public String getPgtoken() {
		return pgtoken;
	}
	public void setPgtoken(String pgtoken) {
		this.pgtoken = pgtoken;
	}
	public String getPayment_method_type() {
		return payment_method_type;
	}
	public void setPayment_method_type(String payment_method_type) {
		this.payment_method_type = payment_method_type;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getApproved_at() {
		return approved_at;
	}
	public void setApproved_at(String approved_at) {
		this.approved_at = approved_at;
	}
	
}
