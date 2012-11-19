package com.focustech.portfolio.domain;


import javax.persistence.Transient;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Portfolio {
	@NotNull
	String ticker;
	@Transient
	double current_price;

	@NotNull
	@Min(1)
	@NumberFormat(style = Style.NUMBER)
	int quantity;

	
}
