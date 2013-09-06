package com.glamey.library.test;


import com.glamey.library.test.thread.ThreadTest;

/**
 * Created with IntelliJ IDEA. User: zy To change this template use File |
 * Settings | File Templates.
 */
public class MatcherTest {

	/*
	 * public static void main(String[] args) {
	 * System.out.println(PatternMatchUtils.simpleMatch("*hell*","helloWorld"));
	 * System
	 * .out.println(PatternMatchUtils.simpleMatch("*message/message-list.htm*"
	 * ,"message/message-list.htm")); System.out.println("result=" +
	 * PatternMatchUtils
	 * .simpleMatch("*message/message-list.htm**message/message-list.htm*"
	 * ,"message/message-list.htm")); // ExecutorService executor =
	 * Executors.newFixedThreadPool(10); }
	 */
	public static void main(String[] args) {
		for(int i = 0 ; i < 10 ; i ++){
			ThreadTest test = new ThreadTest();
			test.start();
		}
		
		synchronized (MatcherTest.class) {
			
		}
	}
}
