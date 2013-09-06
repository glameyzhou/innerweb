package com.glamey.library.test;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class Glamey {
    public Glamey(){
        System.out.println("构造函数。。。");
    }
    {
        System.out.println("无修饰符的构造函数。。。");
    }
    static {
        System.out.println("静态构造函数。。。");
    }

    public void test(){
        System.out.println("test方法");
    }

    public static void main(String[] args) {
        Glamey glamey = new Glamey();
        glamey.test();
    }
}
