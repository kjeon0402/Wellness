package com.wellness.main;

import lombok.Data;

//img_idx	int
//img_big_category	varchar(255)
//img_small_category	int
//img_path	varchar(1000)
@Data
public class ImageVO {
	private int img_idx;
	private String img_big_category;
	private int img_small_category;
	private String img_path;
}
