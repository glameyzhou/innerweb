package com.glamey.framework.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class FileUtils {
	public static void mkdirs(String file) {
		if (StringUtils.isBlank(file)) {
			return;
		}
		mkdirs(new File(file));
	}

	public static void mkdirs(File f) {
		if (!f.exists())
			f.mkdirs();
	}

	public static Map<String, String> readContact(String filePath) {
		Map<String, String> map = new HashMap<String, String>();
		try {
			BufferedReader br = new BufferedReader(new FileReader(filePath));
			String line = "";
			while ((line = br.readLine()) != null) {
				if ((!StringUtils.isNotBlank(line))
						|| (line.indexOf("=") <= -1))
					continue;
				map.put(line.split("=")[0], line.split("=")[1]);
			}

			br.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}
}