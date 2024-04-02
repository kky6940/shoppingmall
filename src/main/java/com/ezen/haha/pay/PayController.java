package com.ezen.haha.pay;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class PayController {

    @PostMapping("/payready")
    public ResponseEntity<?> createPayment() {
        String SECRET_KEY = "DEV226A8224918D673C8A5B24C0065F61B2FAD97"; // 시크릿 키
        String auth = "SECRET_KEY " + SECRET_KEY;

        ObjectMapper objectMapper = new ObjectMapper();

        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/ready";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/json");
        headers.set("Authorization", auth);

        Map<String, Object> requestBodyMap = new LinkedHashMap<>();
        requestBodyMap.put("cid", "TC0ONETIME");
        requestBodyMap.put("partner_order_id", "kor240401");
        requestBodyMap.put("partner_user_id", "qweqwe");
        requestBodyMap.put("item_name", "초코파이");
        requestBodyMap.put("quantity", 1);
        requestBodyMap.put("total_amount", 2200);
        requestBodyMap.put("tax_free_amount", 0);
        requestBodyMap.put("approval_url", "http://localhost:8668/success");
        requestBodyMap.put("fail_url", "http://localhost:8668/fail");
        requestBodyMap.put("cancel_url", "http://localhost:8668/cancel");

        String requestBody;
        try {
            requestBody = objectMapper.writeValueAsString(requestBodyMap);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("JSON 변환에 실패했습니다.");
        }
        System.out.println(auth);
        System.out.println(requestBodyMap);
        HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class);

        if (response.getStatusCode().is2xxSuccessful()) {
            // 받은 JSON 응답을 객체로 매핑하여 출력
            try {
                JsonNode root = objectMapper.readTree(response.getBody());
                String tid = root.get("tid").asText();
                String nextRedirectAppUrl = root.get("next_redirect_app_url").asText();
                String nextRedirectMobileUrl = root.get("next_redirect_mobile_url").asText();
                String nextRedirectPcUrl = root.get("next_redirect_pc_url").asText();
                String androidAppScheme = root.get("android_app_scheme").asText();
                String iosAppScheme = root.get("ios_app_scheme").asText();
                String createdAt = root.get("created_at").asText();

                System.out.println("tid: " + tid);
                System.out.println("next_redirect_app_url: " + nextRedirectAppUrl);
                System.out.println("next_redirect_mobile_url: " + nextRedirectMobileUrl);
                System.out.println("next_redirect_pc_url: " + nextRedirectPcUrl);
                System.out.println("android_app_scheme: " + androidAppScheme);
                System.out.println("ios_app_scheme: " + iosAppScheme);
                System.out.println("created_at: " + createdAt);

                return null;
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("JSON 파싱에 실패했습니다.");
            }
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("결제 생성에 실패했습니다.");
        }
    }

}
