package com.wellness.member;

import lombok.Data;

@Data
public class FindIdVO {
	private String member_name;
	private String member_phone;
	private String member_email;
	private String member_email_domain;
}
