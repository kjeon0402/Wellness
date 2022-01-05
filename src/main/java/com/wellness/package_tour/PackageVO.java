package com.wellness.package_tour;

import java.sql.Date;

import lombok.Data;


//package_idx	int
//package_name	varchar(255)
//package_price	int
//tour_name1	varchar(255)
//tour_name2	varchar(255)
//tour_name3	varchar(255)
//tour_name4	varchar(255)
//tour_name5	varchar(255)
//number_of_reservation	int
//max_num	int
//package_category	varchar(255)
//package_start_date	date
//package_end_date	date
//package_intro	varchar(1000)
//package_schedule	varchar(1000)
//package_thumbnail	varchar(1000)
//package_add_date	date
@Data
public class PackageVO {
	private int package_idx;
	private String package_name;
	private int package_price;
	private String tour_name1;
	private String tour_name2;
	private String tour_name3;
	private String tour_name4;
	private String tour_name5;
	private int number_of_reservation;
	private int max_num;
	private String package_category;
	private String package_start_date;
	private String package_end_date;
	private String package_intro;
	private String package_schedule;
	private String package_thumbnail;
	private String package_add_date;
}
