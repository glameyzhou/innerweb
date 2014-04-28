package com.glamey.chec_cn.util;

/**
 * Created by zy
 */
public enum UploadType {

    IMAGE("image"), FLASH("flash"), PDF("pdf");
    public String code;

    UploadType(String code) {
        this.code = code;
    }

    public static void main(String[] args) {
        for (UploadType uploadType : UploadType.values())
            System.out.println(uploadType.code);
    }
}
