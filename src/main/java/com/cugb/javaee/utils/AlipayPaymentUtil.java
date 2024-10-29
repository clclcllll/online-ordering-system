package com.cugb.javaee.utils;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.AlipayApiException;
import com.alipay.api.request.AlipayTradePagePayRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AlipayPaymentUtil {
    public static void processPayment(String outTradeNo, String totalAmount, String subject, HttpServletResponse response) {
        // 初始化 AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(
                "https://openapi-sandbox.dl.alipaydev.com/gateway.do", // 沙箱网关
                "9021000141660943", // 应用ID
                "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCkyh8s6j5mlRXQskfZBAdfLjYe48AslR49hs0GDttULSMR0FbhXhMPSi1kroIBY973FSGhHwgzVhn7xc9UvmRvG+/zfiY8N3qbuvL9w0n832Y2sLInaA0a6SpZYoQJndLqcFZBcq+6IlpbXMtmjp3CwLvFJPIRSajgeRvSz8VOmR6N7MEQAun0Fn2/XneeoKx1vlxpk5qe5rtw7UgRY2X2vlsyyc/y+byFH3fNiu7EiDbbxQtgX5Zw0JJCRBsbTCghs9a7giD8p45AeQhWtOhOhx7yEpsKfVCdEAMFNrXzndmdMDUE3qzpha6yumhrNYuv+hUeC5piABSEuU0geNO/AgMBAAECggEAA7qbJ/4I+XNIMhfGrm975zh5ewt2Tsv1CjlhrFBrwCThVUbcoG7riX4JNu0H/hYPdpHg1++G1PqOzfa08Vr5lNYSAPWK0fQDb0C0vO9NXk6D1pr6/Q9KtKAwGCO1jy4mFq4CFasNtO2QE98urxxtD3ojBZwHakK7cpDrA0M2WMfu2XS4JvPcq2qTHccxNS3/pGiCgjsMddsnDrLuAKDLOpfSFh5IGJ6omS9+ypLnm8kKHGaGlX77ijiLYv+PTNjn1BwKlCnEFHGaU84R5omy+IS6q+k7TtyUJi8k5FbWoYZxMPqUrAGtTWaHh1gJKyXFd6bT6uJQB3eO0nZphQ87uQKBgQDr9vTVVCKBu8I+fo4E4Dh33xH5hP4wyloFYjeiUGNAKAH+89uIhV972tO0fShW0pipAoclzic98R9ZCXZefxUTslrW3+0J5Q9T7Ym1wlBuNGXLL+oDR9u2gGOa2HnbqD+E5AXRGJ3211HF9x2jSDSOE7YD7K0sxQ4phHdOdv/FFQKBgQCyyBFdNDFCikhqsXvdiINWhmuqv7f9yODLJKKJsVO40Mx4OKcfDSYKJKtmbk0oI4oR1ExmWB72wk9p+wOLK3TvUYGeorraSusgXDAbaHFV/H2l0QVXArGnceYMxhLS+0I+CXmDEPYVsN9WBm7vvjPO7d2aellDtCXT3bFW9q2SgwKBgHd6dD4Qe+h0ycYbDo4pem435UIStSK/UxWmxcTKL3csytXtZBucbNyp0MhzFxnfSK1LOmNKH1Sd4uGSiP0QG/v9M0HZ4IxCD6DPhgsieNdUcLaRbEx89iNSnxyowAsZBhCj5M4bSODT5fP3TGqBBRtrn54dGRKyNJmRGVgBqUCBAoGBAKN/L9IKzxnJGJzqHxrjoyjX2VLX7c2bjWh54mMF1kjoOnWfacaN4cHY8x7DtLAGgFf5zLyzze1gmfuT4RO+9DuAUIfgzfygExMO+7e09iDqvYWM99Mw1YMKOJZp9gEYYuYVCBkCw+nmTPiA/acmTH7rLYP+a+/sqcNttKaRBP89AoGBALNiEajXxyQgqCsQxKBXkHdT/FQAUHFcYT/acfg4+V2yHV5lIBRdMs9qSjufyWKTs2HGJVGDlOD7VbQa94QlWqQQ54cpF65HnY9E91b9fp2RkMJ1EfhXWc47yc+wLN7CX9Zq/YkZfyUQ8O5u7i429hMAmM3A2voxyWEI8IQezBDR", // 应用私钥
                "json",
                "UTF-8",
                "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu87VCUjzIJK5N1Yzn3sIY2WUYm1IvgGnAkAzf0gGjC0dB/swxsS2ZBRAGe/sPxmnXTkQbsUFy2V8G+42fdfqMyaivH+wX1ibHm+l43W0fe3zzSXBQm8KU5UDO2oECX1uDnIifMl1htTTgWi9U2REUYUtCb0L/gB3bExFQ++aE71mu1/sfZx25v8qugx+/btk6umq/kfnTZ3LFt/4Swc6BLEmSlKAWGI/KYV6bn2vAldjVTA/dVXF+S1NlEMIITHOvnAzHiiYqe6g3Q34s3De4/MEc+gkTbMGEu8Ev6EvwcJO2IXgcD7LII2ViHEO1rauHduUFi2JaqM9QR2+2Z/BaQIDAQAB", // 支付宝公钥
                "RSA2" // 签名类型
        );

        // 创建 API 请求对象
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setReturnUrl("http://localhost:8080/returnUrl");
        request.setNotifyUrl("http://localhost:8080/notifyUrl");

        // 设置业务参数
        request.setBizContent("{" +
                "\"out_trade_no\":\"" + outTradeNo + "\"," +
                "\"total_amount\":\"" + totalAmount + "\"," +
                "\"subject\":\"" + subject + "\"," +
                "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        try {
            // 发起请求并获取响应表单
            String form = alipayClient.pageExecute(request).getBody();

            // 将表单内容直接写入响应，以便在浏览器中显示并提交
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(form);
            response.getWriter().flush();
        } catch (AlipayApiException | IOException e) {
            e.printStackTrace();
        }
    }
}