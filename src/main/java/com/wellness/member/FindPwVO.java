package com.wellness.member;

import lombok.Data;

@Data
public class FindPwVO {
	private String member_userid;
	private String member_phone;
	private String member_email;
	private String member_email_domain;
}
