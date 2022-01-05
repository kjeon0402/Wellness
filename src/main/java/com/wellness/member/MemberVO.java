package com.wellness.member;

import java.sql.Date;

import lombok.Data;

//member_idx	int
//member_userid	varchar(255)
//member_password	varchar(255)
//member_name	varchar(255)
//member_phone	varchar(255)
//member_post	varchar(255)
//member_address	varchar(255)
//member_address_detail	varchar(255)
//member_email	varchar(255)
//member_belong	varchar(255)
//member_job	varchar(255)
//member_grade	int
//member_join_date	date
//member_drop_date	date
@Data
public class MemberVO {
	private int member_idx;
	private String member_userid;
	private String member_password;
	private String member_name;
	private String member_phone;
	private String member_post;
	private String member_address;
	private String member_address_detail;
	private String member_email;
	private String member_belong;
	private String member_job;
	private int member_grade;
	private Date member_join_date;
	private Date member_drop_date;
	
}
