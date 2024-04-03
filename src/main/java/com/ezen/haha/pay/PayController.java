package com.ezen.haha.pay;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class PayController {
	PayDTO dto = new PayDTO();
	// 카카오페이 단건결재 API를 통한 결재 진행(https://developers.kakaopay.com/docs/payment/online/single-payment)
	// 카카오페이 단건결재를 하기 위해선 크게 두가지 과정이 있다.(결재 요청 -> 결재 승인 요청)    
	// 결재 요청
    @PostMapping("/payready") // 데이터값 POST 지정, 카카오 서버는 POST 자료만 받는다고 명시되어 있었다.
    public ResponseEntity<String> createPayment(HttpServletRequest request, @RequestBody Map<String, String> formData) throws UnsupportedEncodingException {
    	HttpSession hs = request.getSession();
		String id = (String) hs.getAttribute("id");
		String sname = formData.getOrDefault("sname", "");
		String snum = formData.getOrDefault("snum", ""); // 카카오 partner_order_id 는 String 타입을 받기에 String 타입으로 snum 지정
		int guestbuysu = Integer.parseInt(formData.getOrDefault("guestbuysu", "")); 
		int totprice = Integer.parseInt(formData.getOrDefault("totprice", "")); 
		
        String SECRET_KEY = "DEV226A8224918D673C8A5B24C0065F61B2FAD97"; // 시크릿(secret_key(dev)) 키(테스트용 키)
        String auth = "SECRET_KEY " + SECRET_KEY; // 앞에 "SECRET_KEY " 를 써줘야 카카오 서버가 시크릿 키를 인식함

        ObjectMapper objectMapper = new ObjectMapper();

        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/ready"; // 카카오 단건결제 결재 '요청' 링크

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/json"); // 본문 형식을 JSON 으로 변경, 안하면 카카오 서버가 인식을 못한다.(API 문서에도 명시되어 있음)
        headers.set("Authorization", auth); // 카카오 서버 시크릿 키 인증 틀

        Map<String, Object> requestBodyMap = new LinkedHashMap<>();
        // 아래는 카카오 결재 API 가 결재 요청에 요구하는 필수 데이터들, 아래 이외의 데이터도 추가해서 넣을 수 있다.(API 문서 참조)
        requestBodyMap.put("cid", "TC0ONETIME"); // 가맹점 id(String), 테스트 아이디 "TC0ONETIME" 입력
        requestBodyMap.put("partner_order_id", snum); // 가맹점 주문번호(String), 임의대로 입력(여기선 상품번호 사용)
        requestBodyMap.put("partner_user_id", id); // 가맹점 회원 id(String)
        requestBodyMap.put("item_name", sname); // 상품명(String)
        requestBodyMap.put("quantity", guestbuysu); // 상품 개수(int)
        requestBodyMap.put("total_amount", totprice); // 상품 총 금액(int)
        requestBodyMap.put("tax_free_amount", 0); // 상품 비과세 금액(int)
        requestBodyMap.put("approval_url", "http://localhost:8668/success"); // 결재 성공 시 리다이렉트 링크(String)
        requestBodyMap.put("fail_url", "http://localhost:8668/fail"); // 결재 실패 시 리다이렉트 링크(String)
        requestBodyMap.put("cancel_url", "http://localhost:8668/cancel"); // 결재 취소 시 리다이렉트 링크(String)

        String requestBody;
        try {
            requestBody = objectMapper.writeValueAsString(requestBodyMap); // 카카오 서버에 json 형식으로 보내줘야 하기에 타입을 변경
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("JSON 변환에 실패했습니다.");
        }
        
        HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers); // 위에 쓴 정보들을 가지고 카카오 서버에 요청
        
        RestTemplate restTemplate = new RestTemplate(); // 카카오 서버에 요청하고 그 결과물을 받기 위한 코드
        // 한글 인코딩, 안하면 카카오 결재창에서 상품명이 ?로 뜬다.
        List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
        StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter(StandardCharsets.UTF_8);
        stringHttpMessageConverter.setWriteAcceptCharset(false);
        messageConverters.add(stringHttpMessageConverter);
        restTemplate.setMessageConverters(messageConverters);
        // 한글 인코딩 end
        
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class); // 받은 자료들을 response에 저장

        if (response.getStatusCode().is2xxSuccessful()) { // response가 true 라면 아래 실행
            // 받은 JSON 응답을 객체로 매핑하여 출력
            try {
                JsonNode root = objectMapper.readTree(response.getBody()); // 카카오 서버에서 받은 자료들을 JSON 문자열(JsonNode)로 변경
                String tid = root.get("tid").asText(); // 결재 고유 번호, 카카오 서버에서 자체 생성된 번호이며 결재 승인 요청에서 사용
                String nextRedirectAppUrl = root.get("next_redirect_app_url").asText(); // 요청한 클라이언트(Client)가 모바일 앱일 경우 -> 카카오톡 결제 페이지 Redirect URL
                String nextRedirectMobileUrl = root.get("next_redirect_mobile_url").asText(); // 요청한 클라이언트가 모바일 웹일 경우
                String nextRedirectPcUrl = root.get("next_redirect_pc_url").asText(); // 요청한 클라이언트가 PC 웹일 경우
                String androidAppScheme = root.get("android_app_scheme").asText(); // 카카오페이 결제 화면으로 이동하는 Android 앱 스킴(Scheme) - 내부 서비스용
                String iosAppScheme = root.get("ios_app_scheme").asText(); // 카카오페이 결제 화면으로 이동하는 iOS 앱 스킴 - 내부 서비스용
                String createdAt = root.get("created_at").asText(); // 결제 준비 요청 시간
                
                dto.setTid(tid); // 결재 승인 요청에서 사용할 정보를 DTO에 저장
                dto.setPartner_order_id(snum);
                dto.setPartner_user_id(id);
                
                return ResponseEntity.ok(nextRedirectPcUrl); // PC에서 결재를 진행할 것이기에 nextRedirectPcUrl 링크 사용
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("JSON 파싱에 실패했습니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("결제 생성에 실패했습니다.");
        }
    }
    
    // 이 중간에 QR 코드가 뜨고 클라이언트가 결재 과정을 진행한다.(카카오 서버에서 직접 처리하는 과정이라 관여할 부분은 없음)
    
    // 결재 승인 요청
    @GetMapping("/success")
    public ModelAndView payapprove(@RequestParam("pg_token") String pgToken, ModelAndView mv) throws IOException {
    	// 결재 요청 이후 클라이언트가 결재를 진행하고 성공하면 카카오 서버에서 /success?pg_token= 형식의 pg_token 을 리다이렉트로 보내준다.
    	// 그 /success?pg_token= 리다이렉트를 맵핑(/success)으로 받고 @RequestParam("pg_token") 을 사용하여 토큰 정보를 따로 받아준다.
    	// 이후 pg_token과 tid 및 요구 필수 데이터들을 카카오 서버에 보내어 최종적으로 결재 승인 요청을 진행하고 결재 완료 결과물을 받는다. 
    	String tid = dto.getTid(); 
    	String snum = dto.getPartner_order_id();
    	String id = dto.getPartner_user_id();
		
        String SECRET_KEY = "DEV226A8224918D673C8A5B24C0065F61B2FAD97"; 
        String auth = "SECRET_KEY " + SECRET_KEY; 

        ObjectMapper objectMapper = new ObjectMapper();

        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/approve"; // 카카오 단건결제 결재 '승인' 링크

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/json"); 
        headers.set("Authorization", auth); 

        Map<String, Object> requestBodyMap = new LinkedHashMap<>();
        // 아래는 카카오 결재 API 가 결재 승인 요청에 요구하는 필수 데이터들
        requestBodyMap.put("cid", "TC0ONETIME"); // 가맹점 id(String), 테스트 아이디 "TC0ONETIME" 입력
        requestBodyMap.put("tid", tid); // 결재 고유 번호
        requestBodyMap.put("partner_order_id", snum); // 가맹점 주문번호(String), 임의대로 입력(여기선 상품번호 사용)
        requestBodyMap.put("partner_user_id", id); // 가맹점 회원 id(String)
        requestBodyMap.put("pg_token", pgToken); // 결제승인 요청을 인증하는 토큰(String), 위에서 진행한 결재 요청 이후 클라이언트가 결재를 진행하면 토큰이 리다이렉트로 돌아온다.

        String requestBody1 = null;
        try {
            requestBody1 = objectMapper.writeValueAsString(requestBodyMap); 
        } catch (JsonProcessingException e) {
            e.printStackTrace();
//            return "JSON 변환에 실패했습니다.";
        }
        
        HttpEntity<String> requestEntity = new HttpEntity<>(requestBody1, headers); 

        RestTemplate restTemplate = new RestTemplate(); 
     // 한글 인코딩, 안하면 카카오 결재창에서 상품명이 ?로 뜬다.
        List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
        StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter(StandardCharsets.UTF_8);
        stringHttpMessageConverter.setWriteAcceptCharset(false);
        messageConverters.add(stringHttpMessageConverter);
        restTemplate.setMessageConverters(messageConverters);
     // 한글 인코딩 end
        
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class); 
       
        if (response.getStatusCode().is2xxSuccessful()) {
        	JsonNode root = objectMapper.readTree(response.getBody());
        	// 결재 완료 결과물을 카카오 서버에서 받아옴
        	String aid = root.get("aid").asText(); // 요청 고유 번호, 승인/취소가 구분된 결제번호
        	String tid1 = root.get("tid").asText(); // 결제 고유 번호, 승인/취소가 동일한 결제번호
        	String cid = root.get("cid").asText();
        	String partner_order_id = root.get("partner_order_id").asText(); // 가맹점 주문번호(String), 임의대로 입력(여기선 상품번호 사용)
        	int partner_order_id1 = Integer.parseInt(partner_order_id); // 상품 번호 String을 int로 변환
        	String partner_user_id = root.get("partner_user_id").asText();
        	String payment_method_type = root.get("payment_method_type").asText(); // 결재 수단, CARD 혹은 MONEY(테스트 단계에선 CARD 만 가능해 보인다.)  
        	String item_name = root.get("item_name").asText();
//        	String item_code = root.get("item_code").asText(); // 상품 코드, 위 partner_order_id 에서 상품 코드를 대체해서 썼기에 여기선 null 값이 온다.
        	String quantity = root.get("quantity").asText();
        	int quantity1 = Integer.parseInt(quantity);
        	String created_at = root.get("created_at").asText(); // 결제 준비 요청 시각
        	String approved_at = root.get("approved_at").asText(); // 결제 승인 시각
        	
        	// 클라이언트에게 보여줄 부분만 가져오기
        	dto.setTid(tid1);
        	dto.setPartner_order_id(partner_order_id); // 카카오 서버로 보내기 위해 String 타입으로 DTO를 지정했기에 String으로 넣음
        	dto.setPartner_user_id(partner_user_id);
        	dto.setPayment_method_type(payment_method_type);
        	dto.setItem_name(item_name);
        	dto.setQuantity(quantity1);
        	dto.setCreated_at(created_at);
        	dto.setApproved_at(approved_at);
        	
        	// return "redirect:/이동경로" 을 하면 알 수 없는 이유로 화면이 이동하지 않는 문제가 발생(이동이 안되고 그냥 출력문으로 출력됨)
        	// 부득이하게 ModelAndView 를 사용하여 화면 이동
        	mv.addObject("dto", dto);
        	mv.setViewName("woman2");
        	return mv;
        	
        }
        else
        {
//        	return "결제를 실패했습니다.";
        }
		return mv;
   
    }    
    
}
