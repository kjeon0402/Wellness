package com.wellness.sms;

public class SmsVO {
	private int Random_Number;

	public SmsVO(int random_Number) {
		Random_Number = random_Number;
	}

	public SmsVO() {
		
	}

	public int getRandom_Number() {
		return Random_Number;
	}

	public void setRandom_Number(int random_Number) {
		Random_Number = random_Number;
	}
}
