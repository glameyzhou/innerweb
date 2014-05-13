package com.glamey.chec_cn.util;

import com.glamey.chec_cn.model.domain.Post;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import javax.servlet.http.HttpServletRequest;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

public class XMLUtils {

    public static void buildXML(List<Post> list, HttpServletRequest request) {
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + (request.getServerPort() == 80 ? "" : request.getServerPort()) + request.getContextPath();

        Document document = DocumentHelper.createDocument();
        Element rootElement = document.addElement("data");
        Element channel = rootElement.addElement("channel");

        for (Post post : list) {
            String pic = post.getFocusImage();
            if (StringUtils.isBlank(pic))
                continue;

            Element item = channel.addElement("item");
            Element link = item.addElement("link");
            link.addText(basePath + "/post-" + post.getCategoryType() + "-" + post.getCategoryId() + "-" + post.getId() + ".htm");

            Element image = item.addElement("image");
            if (StringUtils.isNotBlank(pic) && pic.startsWith("http")) {
                image.addText(pic);
            } else {
                if (pic.startsWith("/chec_cn"))
                    image.addText(request.getScheme() + ":" + request.getServerName() + (request.getServerPort() == 80 ? "" : request.getServerPort()) + pic);
                else
                    image.addText(basePath + pic);
            }
            Element title = item.addElement("title");
            title.addText(post.getTitle());
        }

        Element config = rootElement.addElement("config");

        Element roundCorner = config.addElement("roundCorner");
        roundCorner.addText("0");
        Element autoPlayTime = config.addElement("autoPlayTime");
        autoPlayTime.addText("3");
        Element isHeightQuality = config.addElement("isHeightQuality");
        isHeightQuality.addText("false");
        Element blendMode = config.addElement("blendMode");
        blendMode.addText("normal");
        Element transDuration = config.addElement("transDuration");
        transDuration.addText("1");
        Element windowOpen = config.addElement("windowOpen");
        windowOpen.addText("_self");
        Element btnSetMargin = config.addElement("btnSetMargin");
        btnSetMargin.addText("auto 5 5 auto");
        Element btnDistance = config.addElement("btnDistance");
        btnDistance.addText("20");
        Element titleBgColor = config.addElement("titleBgColor");
        titleBgColor.addText("0xff6600");
        Element titleTextColor = config.addElement("titleTextColor");
        titleTextColor.addText("0xffffff");
        Element titleBgAlpha = config.addElement("titleBgAlpha");
        titleBgAlpha.addText(".75");
        Element titleMoveDuration = config.addElement("titleMoveDuration");
        titleMoveDuration.addText("1");
        Element btnAlpha = config.addElement("btnAlpha");
        btnAlpha.addText("0.7");
        Element btnTextColor = config.addElement("btnTextColor");
        btnTextColor.addText("0xffffff");
        Element btnDefaultColor = config.addElement("btnDefaultColor");
        btnDefaultColor.addText("0x1B3433");
        Element btnHoverColor = config.addElement("btnHoverColor");
        btnHoverColor.addText("0xff9900");
        Element btnFocusColor = config.addElement("btnFocusColor");
        btnFocusColor.addText("0xff6600");
        Element changImageMode = config.addElement("changImageMode");
        changImageMode.addText("click");
        Element isShowBtn = config.addElement("isShowBtn");
        isShowBtn.addText("true");
        Element isShowTitle = config.addElement("isShowTitle");
        isShowTitle.addText("true");
        Element scaleMode = config.addElement("scaleMode");
        scaleMode.addText("noBorder");
        Element transform = config.addElement("transform");
        transform.addText("blur");
        Element isShowAbout = config.addElement("isShowAbout");
        isShowAbout.addText("true");
        Element titleFont = config.addElement("titleFont");
        titleFont.addText("微软雅黑");

        OutputFormat opf = new OutputFormat("\t", true, "UTF-8");
        opf.setTrimText(true);
        XMLWriter writer;
        try {
            String file = request.getRealPath("/") + "res/front/chec_cn/flash/bcastr4.xml";
            writer = new XMLWriter(new FileOutputStream(file), opf);
            writer.write(document);
            writer.close();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
