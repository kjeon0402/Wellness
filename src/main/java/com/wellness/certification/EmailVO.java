package com.wellness.certification;

public class EmailVO {

	private int Random_Number;
	
	public EmailVO(int random_Number) {
		Random_Number = random_Number;
	}
	public EmailVO() {}
	
	public int getRandom_Number() {
		return Random_Number;
	}
	
	public void setRandom_Number(int random_Number) {
		Random_Number = random_Number;
	}
}
