package com.wellness.notice;


import lombok.Data;

//notice_idx	int
//notice_title	varchar(255)
//notice_wirter	varchar(255)
//notice_write_time	date
//notice_content	varchar(1000)
//notice_deleted	char(1)
//notice_count	int
//notice_file	varchar(1000)
@Data
public class NoticeVO {
	private int notice_idx;
	private String notice_title;
	private String notice_writer;
	private String notice_write_time;
	private String notice_content;
	private String notice_deleted;
	private int notice_count;
	private String notice_file;
}
