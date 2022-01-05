package com.wellness.member;

import lombok.Data;

@Data
public class ChangePwVO {
	
	private String prepassword;
	private String newpassword;
	private int member_idx;
}
