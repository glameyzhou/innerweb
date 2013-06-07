package com.glamey.innerweb.test.designmodel;

import org.apache.log4j.PropertyConfigurator;

/**
 * 典型的单例模式
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
public class Singleton {
    private static Singleton instance = null ;
    private Singleton(){
    }
    /**
     * 使用双锁
     * @return
     */
    public static Singleton getInstance(){
        if(instance == null){
            synchronized (Singleton.class){
                if(instance == null){
                    instance = new Singleton();
                }
            }
        }
        return instance ;
    }
}
