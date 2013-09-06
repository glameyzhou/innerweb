package com.glamey.library.test.thread;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class UnSafeSeqTest {
    private int count ;
    private int getCount(){
        return count ++ ;
    }


    class ThreadTest extends Thread{
        @Override
        public void run() {
            System.out.println(getCount());
        }
    }


    public void test() {
        for (int i = 0; i < 10 ; i++) {
            for (int j = 0; j < 100 ; j++) {
                ThreadTest test = new ThreadTest();
                test.start();
            }
        }
    }

    public static void main(String[] args) {
        UnSafeSeqTest seq = new UnSafeSeqTest();
        seq.test();
    }
}
