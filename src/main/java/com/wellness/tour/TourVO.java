package com.wellness.tour;

import lombok.Data;


//tour_idx	int
//tour_name	varchar(255)
//tour_category	varchar(255)
//tour_content	varchar(1000)
//tour_address	varchar(255)
//tour_address_deatil	varchar(255)
//tour_tel	varchar(255)
//tour_email	varchar(255)
//tour_site	varchar(255)
//tour_holiday	varchar(255)
//tour_transportation	varchar(255)
//tour_fee	varchar(255)
//tour_how	varchar(255)
//tour_operation	varchar(255)
//tour_promotion_link	varchar(1000)
//tour_able_language	varchar(255)
//tour_experience	varchar(255)
//tour_around	varchar(255)
@Data
public class TourVO {
	private int tour_idx;
	private String tour_name;
	private String tour_category;
	private String tour_content;
	private String tour_address;
	private String tour_address_detail;
	private String tour_tel;
	private String tour_email;
	private String tour_site;
	private String tour_holiday;
	private String tour_transportation;
	private String tour_fee1;
	private String tour_fee2;
	private String tour_fee3;
	private String tour_how;
	private String tour_operation1;
	private String tour_operation2;
	private String tour_operation3;
	private String tour_promotion_link;
	private String tour_able_language;
	private String tour_experience;
	private String tour_around;
}
