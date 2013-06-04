package com.glamey.innerweb.test;

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
	}

}
