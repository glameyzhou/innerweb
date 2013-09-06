package com.glamey.library.test.thread;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 原子数字
 *
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class SafeSeqTest {

    private final static AtomicInteger integer = new AtomicInteger(0);

    private static List<Integer> list = Collections.synchronizedList(new ArrayList<Integer>(100));

    public static int getInteger(){
        return integer.getAndIncrement() ;
    }

    /*public static void main(String[] args) {
        System.out.println(getInteger());
    }*/


    static class ThreadTest extends Thread {
        @Override
        public void run() {
            list.add(integer.incrementAndGet());
        }
    }


    public static void main(String[] args) {
        for(int i = 0 ; i < 100 ; i ++){
            for(int j = 0 ; i < 100 ; i ++){ // 100个并发，其实只有一个可以访问，其他的都会失败或者等待状态。
                ThreadTest test = new ThreadTest();
                test.start();
            }
        }

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

//        Collections.sort(list,Collections.reverseOrder()); 倒序排列
        /*默认正续排列*/
        Arrays.sort(list.toArray());
        System.out.println(list.size());
        for(int i : list){
            System.out.println(i);
        }


    }

}
