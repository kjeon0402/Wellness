package com.wellness.gallery;

import lombok.Data;


//comment_idx	int
//comment_big_category	varchar(255)
//comment_small_category	int
//comment_writer	varchar(255)
//comment_content	varchar(1000)
//comment_date	date
@Data
public class CommentVO {
	private int comment_idx;
	private String comment_big_category;
	private int comment_small_category;
	private String comment_writer;
	private String comment_content;
	private String comment_date;
}
