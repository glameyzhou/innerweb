package com.glamey.innerweb.test;

import java.util.Stack;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class StackTest {

    public static void main(String[] args) {
        Stack s = new Stack();
        s.add("a");
        s.add("b");
        s.add("c");
        s.add("d");
        s.add("e");

        /*for (Object o : s) {
            System.out.println(o);
        }*/

        System.out.println(s.peek());
        System.out.println(s.pop());

        for (Object o : s) {
            System.out.println(o);
        }
    }
}
