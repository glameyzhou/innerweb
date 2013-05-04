package com.glamey.framework.utils.tld;

import java.util.List;
import org.apache.commons.lang.StringUtils;
import com.glamey.framework.utils.StringTools;


public class StringTld {
    /**
     *
     * @param source
     * @param end
     * @param append
     * @return
     */
	public static String substringAppend(String source, Integer end,String append) {
		return StringTools.substring(source, end.intValue(), append);
	}

	public static String substring(String source, Integer end) {
		return StringTools.substring(source, end.intValue());
	}

	public static String encoder(String source) {
		return StringTools.encoder(source);
	}

	public static String decoder(String source) {
		return StringTools.decoder(source);
	}

	public static boolean isContainsInList(String source, List<String> list) {
		if ((StringUtils.isBlank(source)) || (list == null)
				|| (list.size() == 0)) {
			return false;
		}
		return list.contains(source);
	}
}