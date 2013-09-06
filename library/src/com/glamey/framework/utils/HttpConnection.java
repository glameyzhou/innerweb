package com.glamey.framework.utils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.apache.commons.lang.StringUtils;

import com.glamey.innerweb.model.dto.ChinaWeather;
import com.glamey.innerweb.model.dto.weatherinfo;
import com.google.gson.Gson;

public class HttpConnection {
    public static String sendPost(String url, String body) {
        if (StringUtils.isBlank(body)) {
            body = "";
        }
        String response = "";
        try {
            URL requestURL = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) requestURL
                    .openConnection();
            conn.setRequestMethod("POST");
            conn.addRequestProperty("Server", "glamey");
            conn.setReadTimeout(new Integer(50000).intValue());
            conn.setDoInput(true);
            byte[] bodyData = body.getBytes();
            if ((bodyData != null) && (bodyData.length > 0)) {
                conn.setDoOutput(true);
                OutputStream oStream = conn.getOutputStream();
                oStream.write(bodyData);
                oStream.flush();
            }
            int httpResponseCode = conn.getResponseCode();
            if (httpResponseCode == 200) {
                InputStream iStream = conn.getInputStream();
                ByteArrayOutputStream baos = new ByteArrayOutputStream(10240);
                byte[] buf = new byte[1024];
                int readLen;
                while ((readLen = iStream.read(buf)) != -1) {
                    baos.write(buf, 0, readLen);
                }
                response = baos.toString("GBK");
                baos.close();
                iStream.close();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
            response = "";
        } catch (ProtocolException e) {
            e.printStackTrace();
            response = "";
        } catch (IOException e) {
            e.printStackTrace();
            response = "";
        }
        return response;
    }
}