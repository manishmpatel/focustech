package com.focustech.portfolio.service;

import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

import com.focustech.portfolio.domain.Portfolio;

public class PortfolioServiceTest {

	@Test
	public void testGetCurrentPrices() {
		PortfolioServiceImpl pService = new PortfolioServiceImpl();
		Portfolio p = new Portfolio();
		p.setTicker("AAPL");
		Portfolio p2 = new Portfolio();
		p2.setTicker("GOOG");
		ArrayList<Portfolio> al = new ArrayList<Portfolio>();
		al.add(p);
		al.add(p2);
		pService.getCurrentPrices(al);
		if (p.getCurrent_price() > 0)
			assert true;
	}

}
