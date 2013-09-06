/**
 * 
 */
package com.glamey.library.test;

/**
 * 
 * ABC交替打印10次。
 * 
 * 上一个对象暂停、释放对象锁，下一个线程唤醒继续。。。
 * 
 * @author zy
 *
 */
public class PrintNumThread implements Runnable {
	
	private String name ;
	private Object pre ;
	private Object self ;
	
	private PrintNumThread(String name ,Object pre,Object self){
		this.name = name ;
		this.pre = pre ;
		this.self = self ;
	}

	@Override
	public void run() {
		int count = 10 ;
		while (count > 0){
			synchronized (pre) {
				synchronized (self){
					System.out.println(name);
					count -- ;
					self.notify();
				}
				
				try {
					pre.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static void main(String[] args) {
		Object a = new Object();
		Object b = new Object();
		Object c = new Object();
		
		PrintNumThread pa = new PrintNumThread("A", c, a);
		PrintNumThread pb = new PrintNumThread("B", a, b);
		PrintNumThread pc = new PrintNumThread("C", b, c);
		
		new Thread(pa).start();
		new Thread(pb).start();
		new Thread(pc).start();
		
	}

}
