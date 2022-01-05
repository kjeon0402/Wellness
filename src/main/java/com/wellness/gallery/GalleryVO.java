package com.wellness.gallery;

import java.util.Date;

import lombok.Data;


//gallery_idx	int
//member_idx	int
//tour_idx	int
//package_idx	int
//gallery_write_time	date
//gallery_title	varchar(255)
//gallery_content	varchar(1000)
//gallery_deleted	char(1)
//gallery_count	int
@Data
public class GalleryVO {
	private int gallery_idx;
	private int member_idx;
	private int tour_idx;
	private int package_idx;
	private String gallery_write_time;
	private String gallery_title;
	private String gallery_content;
	private String gallery_deleted;
	private int gallery_count;
	
	
	private String gallery_writer;
}
