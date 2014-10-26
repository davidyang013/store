package com.yu.store.sys.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * @author Kingking Yu
 * 
 */
public class Tools {

	//转码
	public static String encoder(String str) {

		String res = null;

		if (null == str || "".equals(str.trim())) {
			return null;
		}

		try {
			res = new String(str.getBytes("ISO8859_1"), "UTF8");
		} catch (Exception e) {
		}

		return res;
	}

	//判断字符串是否有效
	public static boolean isValid(String s) {

		if (s == null || s.trim().equals("")) {
			return false;
		}
		return true;
	}

	//比较两个字符串大小
	public static int compareTwoStr(String str1, String str2) {

		if (!isValid(str1) || !isValid(str2)) {
			return -1;
		}
		BigDecimal objstr1 = new BigDecimal(str1);
		BigDecimal objstr2 = new BigDecimal(str2);
		return objstr1.compareTo(objstr2);
	}

	// 实现日期加若干天的方法
	public static String addDay(String s, int n, String pattern) {

		try {
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);

			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(s));
			cd.add(Calendar.DATE, n);
			return sdf.format(cd.getTime());

		} catch (Exception e) {
			return null;
		}
	}

	// 实现日期加若干天的方法
	public static String addMonth(String s, int n, String pattern) {

		try {
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);

			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(s));
			cd.add(Calendar.MONTH, n);

			return sdf.format(cd.getTime());

		} catch (Exception e) {
			return null;
		}
	}

	//判断是否为中文字符
	public static boolean isCharCN(char c) {
		
		if (String.valueOf(c).getBytes().length > 1) {
			return true;
		}
		return false;
	}

	//从字符串左起截取length长度的字符串
	public static String leftSubstr(String str, int len) {
		
		if (str == null || str.getBytes().length < len) {
			return str;
		}

		StringBuffer buff = new StringBuffer(len);
		char[] cs = new char[len];

		if (str.length() < len)
			str.getChars(0, str.length(), cs, 0);
		else
			str.getChars(0, len, cs, 0);

		len = len - 1;
		int i = 0;
		int lenc = 0;
		while (lenc < len) {
			if (isCharCN(cs[i])) {
				lenc = lenc + 2;
			} else {
				lenc = lenc + 1;
			}
			buff.append(cs[i]);
			i++;
		}
		if (lenc == len) {
			if (isCharCN(cs[i])) {
				buff.append('_');
			} else {
				buff.append(cs[i]);
			}
		}
		return buff.toString();
	}

	//以传入参数格式化一个字符串,按照0.0000格式传递
	public static String formatStr(String str, String numInitial) {

		str = isValid(str) ? str : "0";
		int scale = (numInitial.length() - 2) > 0 ? numInitial.length() - 2 : 0;

		return formatStr(str, scale);
	}

	//以传入参数不同格式化一个字符串
	public static String formatStr(String str, int num) {

		str = isValid(str) ? str : "0";
		BigDecimal objBigDecimalFirst = new BigDecimal(str);
		return objBigDecimalFirst.setScale(num, BigDecimal.ROUND_HALF_UP)
				.toString();
	}
	
	//以传入参数不同格式化一个字符串
	public static double formatStr(double val, int num) {

		BigDecimal objBigDecimalFirst = new BigDecimal(String.valueOf(val));
		return objBigDecimalFirst.setScale(num, BigDecimal.ROUND_HALF_UP)
				.doubleValue();
	}

	//使用指定字符右补定长字符串
	public static String rightMendStrLen(String s, int l, char c) {

		char[] cs = new char[l];
		for (int i = 0; i < l; i++) {
			cs[i] = c;
		}

		if (s == null) {
			return new String(cs);
		}

		int len = s.length();
		if (len == 0) {
			return String.valueOf(cs);
		}

		int lenc = s.getBytes().length;
		if (lenc > l) {
			return leftSubstr(s, l);
		}

		if (len < lenc) {
			l = l - (lenc - len);
		}

		StringBuffer str = new StringBuffer(l + lenc);
		str.append(s).append(cs);

		return str.substring(0, l);
	}

	//将钱数转换成字符串
	public static String money2Str(double money, int sc) {

		double formatDouble = 0.0;
		int scale = sc < 0 ? 0 : sc;
		formatDouble = formatStr(money, scale);
		String formatStr = rightMendStrLen("###,##0.", 8 + scale, '0');
		DecimalFormat f = new DecimalFormat(formatStr);
		return f.format(formatDouble);
	}

}
