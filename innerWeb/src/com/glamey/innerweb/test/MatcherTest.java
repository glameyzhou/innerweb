package com.glamey.innerweb.test;

import org.springframework.util.PatternMatchUtils;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class MatcherTest {
    public static void main(String[] args) {
        System.out.println(PatternMatchUtils.simpleMatch("*hell*","helloWorld"));
        System.out.println(PatternMatchUtils.simpleMatch("*message/message-list.htm*","message/message-list.htm"));
        System.out.println("result=" + PatternMatchUtils.simpleMatch("*message/message-list.htm**message/message-list.htm*","message/message-list.htm"));
    }
}
