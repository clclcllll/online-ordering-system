package com.cugb.javaee.utils;

import javax.servlet.http.Part;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class FileUploadUtil {

    /**
     * 从 Part 对象中读取文本数据
     * @param part Part 对象，代表表单中的字段
     * @return 字段的文本值
     * @throws IOException 如果读取时发生错误
     */
    public static String getPartValue(Part part) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), StandardCharsets.UTF_8));
        StringBuilder value = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            value.append(line);
        }
        return value.toString().trim();
    }
}
