package com.glamey.chec_cn.util;

import com.glamey.framework.utils.FileUtils;
import com.glamey.chec_cn.model.domain.UploadInfo;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * Date: 13-5-7
 * Time: 下午4:29
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class WebUploadUtils {
    @Resource
    private List<String> allowedUploadImages;

    public UploadInfo doUpload(HttpServletRequest request, HttpServletResponse response) {
        UploadInfo ui = new UploadInfo();
        ModelAndView modelAndView = new ModelAndView("common/message");
        try {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile multipartFile = multipartRequest.getFile("image");
            if(multipartFile == null){
                modelAndView.addObject("message", "请上传图片!");
                ui.setResultCode(1);
                ui.setModelAndView(modelAndView);
                return ui;
            }

            String originalFilename = multipartFile.getOriginalFilename();
            if(StringUtils.isBlank(originalFilename)){
                modelAndView.addObject("message", "请上传图片!");
                ui.setResultCode(1);
                ui.setModelAndView(modelAndView);
                return ui;
            }

            if (!isAllowed(originalFilename)) {
                modelAndView.addObject("message", "上传文件类型不符合,必须是以下几种<br/>" + this.allowedUploadImages.toString());
                ui.setResultCode(2);
                ui.setModelAndView(modelAndView);
                return ui;
            }

            String fileName = DateFormatUtils.format(new Date(), "yyyyMMddHHmmss") + "." + FilenameUtils.getExtension(originalFilename);
            @SuppressWarnings("deprecation")
            String basePath = request.getRealPath("/") + "/";
            String relativePath = "userfiles/upload/user-images/" + DateFormatUtils.format(new Date(), "yyyy-MM-dd").replaceAll("-", "/") + "/";
            FileUtils.mkdirs(basePath + relativePath);
            multipartFile.transferTo(new File(basePath + relativePath + fileName));
            ui.setFilePath(relativePath + fileName);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return ui;
    }

    /**
     * 检测上传的图片是否为指定格式
     *
     * @param fileName
     * @return false=不允许上传 true=允许上传
     */
    public boolean isAllowed(String fileName) {
        for (String suffix : this.allowedUploadImages) {
            if (StringUtils.equalsIgnoreCase(suffix,
                    FilenameUtils.getExtension(fileName))) {
                return true;
            }
        }
        return false;
    }
}
