package com.glamey.innerweb.test;

import com.glamey.innerweb.test.designmodel.Singleton;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class GlameyChild extends Glamey {
    public GlameyChild(){
        System.out.println("child 构造函数。。。");
    }
    {
        System.out.println("child 无修饰符的构造函数。。。");
    }
    static {
        System.out.println("child 静态构造函数。。。");
    }

    public void test(){
        System.out.println("child test方法");
    }

    public static void main(String[] args) {
        GlameyChild gc = new GlameyChild();
        gc.test();


        System.out.println(Singleton.getInstance());
    }
}
