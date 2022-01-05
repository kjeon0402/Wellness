package com.wellness.reserve;

import java.sql.Date;

import lombok.Data;

@Data
public class MyReserveVO {
	private int reserve_idx;
	private String package_name;
	private Date reserve_date;
	private int package_price;
	private String paycheck;
}
