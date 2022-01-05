package com.wellness.reserve;

import java.sql.Date;

import lombok.Data;

@Data
public class ReserveVO {
	private int reservation_idx;
	private int member_idx;
	private int package_idx;
	private String paycheck;
	private Date reserve_date;
	private Date reserve_theday;
	private int reserve_count;
	private String member_name;
	private String member_userid;
	private String member_phone;
	private String member_email;
	private int sum_price;
	private String package_name;
}
