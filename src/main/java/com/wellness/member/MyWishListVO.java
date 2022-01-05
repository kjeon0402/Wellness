package com.wellness.member;

import lombok.Data;

@Data
public class MyWishListVO {
	private int member_idx;
	private int tour_idx;
	private String tour_name;
	private String tour_address;
	private String tour_tel;
	private String tour_operation;
	private String tour_fee;
	private String img_path;
	
	private String package_name;
	private String p_tour_name1;
	private String p_tour_name2;
	private String p_tour_name3;
	private String p_tour_name4;
	private String p_tour_name5;
	private int package_idx;
	private int package_price;
}
