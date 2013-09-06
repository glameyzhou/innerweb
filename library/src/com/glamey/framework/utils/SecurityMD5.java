package com.glamey.framework.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SecurityMD5 {
	public static String crypt(String str) {
		if ((str == null) || (str.length() == 0)) {
			throw new IllegalArgumentException(
					"String to encript cannot be null or zero length");
		}
		StringBuffer hexString = new StringBuffer();
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte[] hash = md.digest();
			for (int i = 0; i < hash.length; i++)
				if ((0xFF & hash[i]) < 16)
					hexString.append("0" + Integer.toHexString(0xFF & hash[i]));
				else
					hexString.append(Integer.toHexString(0xFF & hash[i]));
		} catch (NoSuchAlgorithmException e) {
			throw new IllegalArgumentException("Can not find such a algorithm!");
		}
		return hexString.toString();
	}

	public static void main(String[] args) {
		System.out.println(crypt("admin"));
		System.out.println(crypt("soft"));
	}
}