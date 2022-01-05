package com.wellness.event;

import lombok.Data;

//event_homepage_idx	int
//event_homepage_title	varchar(255)
//event_homepage_writer	varchar(255)
//event_homepage_content	varchar(1000)
//event_homepage_write_time	date
//event_homepage_deleted	char(1)
//event_homepage_count	int
//event_homepage_do_doing	char(1)
//event_homepage_start_date	date
//event_homepage_end_date	date
@Data
public class EventVO {
	private int event_homepage_idx;
	private String event_homepage_title;
	private String event_homepage_writer;
	private String event_homepage_content;
	private String event_homepage_write_time;
	private String event_homepage_deleted;
	private int event_homepage_count;
	private String event_homepage_do_doing;
	private String event_homepage_start_date;
	private String event_homepage_end_date;
}
