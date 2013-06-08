/**
 * 
 */
package com.glamey.innerweb.test;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zy
 *
 */
public class ListIndexOf {

	private static Object[] elementData;
	
	private ListIndexOf(){
		elementData = new Object[10];
		for(int i = 0 ; i < 10 ; i ++){
			elementData [i] = "a" + i ;
		}
	}
	
	
	/**
	 * 
	 * @param obj
	 * @return
	 */
	public int indexOf(Object obj){
		int size = elementData.length ;
		if(obj == null){
			for(int i = 0 ; i < size ; i ++){
				if(elementData[i] == null){
					return i ;
				}
			}
		}
		else{
			for(int i = 0 ; i < size ; i ++){
				if(elementData[i].equals(obj)){
					return i ;
				}
			}
		}
		
		return -1 ;
	}
	/**
	 * 
	 * @param obj
	 * @return
	 */
	public int lastIndexOf(Object obj){
		int size = elementData.length ;
		if(obj == null){
		    for (int i = size-1; i >= 0; i--){
				if(elementData[i] == null){
					return i ;
				}
			}
		}
		else{
		    for (int i = size-1; i >= 0; i--){
				if(elementData[i].equals(obj)){
					return i ;
				}
			}
		}
		
		return -1 ;
	}
	
	public static void main(String[] args) {
		ListIndexOf lif = new ListIndexOf();
		String a = null ;
		System.out.println(lif.indexOf(a));
		System.out.println(lif.lastIndexOf(a));
		
		a = "a2" ;
		System.out.println(lif.indexOf(a));
		System.out.println(lif.lastIndexOf(a));
		
		Map<String,String> map = new HashMap<String,String>();
		map.containsKey(null);
		map.containsValue(null);
		map.get(null);
		
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		
		short s = 4 ;
		s += 4 ;
		System.out.println(s);
		
		float f = 3.4f;
		System.out.println(f);
	}
	
	public int overload(String a,int b){
		return 1 ;
	}
	public int overload(int a,int b){
		return 1 ;
	}
	public int overload(){
		return 1 ;
	}
}
