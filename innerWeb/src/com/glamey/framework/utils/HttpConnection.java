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
			conn.addRequestProperty("Server", "BadBoy");
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
	
	public static void main(String[] args) {
		/*for(int i = 0 ; i < 999999999 ; i ++){
			String url = "http://www.luidea.com/plus/xinqing.php" ;
			String body = "uname=badBoy&action=save&msg=Sorry,buddy!some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test  <br><br>some test some testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome testsome test" ;
			System.out.println(sendPost(url, body));
		}*/
		
		
		URL requestURL;
		try {
			requestURL = new URL("http://yp.mo/zh/Macau-21051-SWEET%20HOME%20%E5%9B%9B%E7%B6%AD%E7%A9%BA%E6%B0%A3%E8%99%95%E7%90%86.html");
			HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
			InputStream is = conn.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String line ;
			while((line = br.readLine()) != null){
				System.out.println(line);
			}
			br.close();
			is.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}