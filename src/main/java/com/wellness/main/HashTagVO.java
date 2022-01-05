package com.wellness.main;

import lombok.Data;


//hash_tag_idx	int
//hash_tag_category	int
//hash_tag_content	varchar(255)
@Data
public class HashTagVO {
	private int hash_tag_idx;
	private int hash_tag_category;
	private String hash_tag_content;
}
