package com.wellness.main;

import lombok.Data;


//video_idx	int
//video_big_category	varchar(255)
//video_small_category	int
//video_path	varchar(1000)
@Data
public class VideoVO {
	private int video_idx;
	private String video_big_category;
	private int video_small_category;
	private String video_path;
}
