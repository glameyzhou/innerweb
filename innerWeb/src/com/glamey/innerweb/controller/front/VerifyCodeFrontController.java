package com.glamey.innerweb.controller.front;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.glamey.innerweb.constants.Constants;

@Controller
public class VerifyCodeFrontController {
	protected static final Logger logger = Logger.getLogger(VerifyCodeFrontController.class);
	@RequestMapping(value = "/verifyCode.htm", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView verifyCode(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("image/jpeg");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0L);
		try {
			int len = 4;
			int width = 60;
			int height = 20;
			BufferedImage image = new BufferedImage(width, height, 1);

			Graphics g = image.getGraphics();

			Random random = new Random();

			g.setColor(getRandColor(200, 250));
			g.fillRect(0, 0, width, height);

			g.setFont(new Font("Times New Roman", 0, 18));

			g.setColor(getRandColor(160, 200));
			for (int i = 0; i < 155; i++) {
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				int xl = random.nextInt(12);
				int yl = random.nextInt(12);
				g.drawLine(x, y, x + xl, y + yl);
			}

			String sRand = "";
			for (int i = 0; i < len; i++) {
				String rand = String.valueOf(random.nextInt(10));
				sRand = sRand + rand;

				g.setColor(new Color(20 + random.nextInt(110), 20 + random
						.nextInt(110), 20 + random.nextInt(110)));

				g.drawString(rand, 13 * i + 6, 16);
			}

			HttpSession session = request.getSession();
			session.setAttribute(Constants.VERIFYCODE, sRand);

			g.dispose();

			ServletOutputStream responseOutputStream = response
					.getOutputStream();

			ImageIO.write(image, "JPEG", responseOutputStream);

			responseOutputStream.flush();
			responseOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	Color getRandColor(int fc, int bc) {
		Random random = new Random();
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
	}
}