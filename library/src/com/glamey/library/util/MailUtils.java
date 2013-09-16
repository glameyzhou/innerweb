package com.glamey.library.util;

import com.glamey.library.constants.Constants;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class MailUtils {
    private static final Logger logger = Logger.getLogger(MailUtils.class);
    private JavaMailSender javaMailSender;
    private String encoding;
    private String title;
    private String from;

    public boolean send(Map<String, String> parameters) throws MessagingException {
        String content = "${MAIL_NICKNAME}，您好：<br/><br/>&nbsp;&nbsp;请点击下面的链接地址或者将下面的地址复制到浏览器完成注册。<br/><br/>${MAIL_ACTIVEURL}${MAIL_ACTIVE_RANDOM}<br/><br/><br/><font color=\"red\">此邮件为系统自动发送，请勿回复，多谢。</font>";
        MimeMessage msg = javaMailSender.createMimeMessage();
        MimeMessageHelper message = new MimeMessageHelper(msg, true, encoding);
        message.setSubject(title);
        message.setFrom(from);
        message.setTo(parameters.get(Constants.MAIL_TO));
        content = content.replace("${" + Constants.MAIL_NICKNAME + "}", parameters.get(Constants.MAIL_NICKNAME));
        content = content.replace("${" + Constants.MAIL_ACTIVE_URL + "}", parameters.get(Constants.MAIL_ACTIVE_URL));
        content = content.replace("${" + Constants.MAIL_ACTIVE_RANDOM + "}", parameters.get(Constants.MAIL_ACTIVE_RANDOM));
        message.setText(content, true); /*如果发的不是html内容去掉true参数*/
        message.setPriority(3);
        /*message.addInline("myLogo",new ClassPathResource("img/mylogo.gif"));
        message.addAttachment("myDocument.pdf", new ClassPathResource("doc/myDocument.pdf"));*/
        javaMailSender.send(msg);
        return true;
    }

    public JavaMailSender getJavaMailSender() {
        return javaMailSender;
    }

    public void setJavaMailSender(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    public String getEncoding() {
        return encoding;
    }

    public void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public static void main(String[] args) throws MessagingException {
        ApplicationContext content = new ClassPathXmlApplicationContext("/com/glamey/library/conf/application.xml");
        MailUtils mail = (MailUtils) content.getBean("libraryMail");

        Map<String, String> parameters = new HashMap<String, String>();
        parameters.put(Constants.MAIL_TO, "glamey@qq.com");
        parameters.put(Constants.MAIL_NICKNAME, "glamey");
        parameters.put(Constants.MAIL_ACTIVE_URL, "http://www.baidu.com?verifycode=");
        parameters.put(Constants.MAIL_ACTIVE_RANDOM, UUID.randomUUID().toString());
        System.out.println(mail.send(parameters));
    }
}
