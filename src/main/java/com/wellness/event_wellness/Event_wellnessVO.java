package com.wellness.event_wellness;

import lombok.Data;


//event_wellness_idx	int
//tour_idx	int
//event_wellness_title	varchar(255)
//event_wellness_writer	varchar(255)
//event_wellness_content	varchar(1000)
//event_wellness_write_time	date
//event_wellness_deleted	char(1)
//event_wellness_count	int
@Data
public class Event_wellnessVO {
	private int event_wellness_idx;
	private int tour_idx;
	private String event_wellness_title;
	private String event_wellness_writer;
	private String event_wellness_content;
	private String event_wellness_write_time;
	private String event_wellness_deleted;
	private int event_wellness_count;
}
