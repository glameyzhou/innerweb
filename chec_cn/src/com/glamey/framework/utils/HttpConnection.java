package com.glamey.framework.utils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;

import org.apache.commons.lang.StringUtils;

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


    public static String getSource(String pageUrl) {
        StringBuffer source = new StringBuffer();
        try {
            URL url = new URL(pageUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            InputStream is = connection.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            String line;
            while ((line = br.readLine()) != null) {
                source.append(line).append(System.getProperty("line.separator"));
            }
            br.close();
            is.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return source.toString();
    }
}