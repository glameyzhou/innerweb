package com.glamey.library.test.thread;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadTest extends Thread {
	private static ExecutorService executor = Executors.newFixedThreadPool(5);

	@Override
	public void run() {
		executor.execute(new Runnable() {
			@Override
			public void run() {
				System.out.println("....");
			}
		});
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        for(int i= 0 ; i < 10000 ; i ++){
            ThreadTest test = new ThreadTest();
            test.start();
        }
    }

}
