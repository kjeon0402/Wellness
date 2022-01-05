package com.wellness.main;

import lombok.Data;


//wish_list_idx	int
//member_idx	int
//wish_big_category	varchar(100)
//wish_small_category	int
@Data
public class WishListVO {
	
	private int wish_list_idx;
	private int member_idx;
	private String wish_big_category;
	private int wish_small_category;
}
