package com.focustech.portfolio.service;

import java.util.List;

import org.springframework.roo.addon.layers.service.RooService;

import com.focustech.portfolio.domain.Portfolio;
import com.focustech.portfolio.domain.PortfolioTotal;

@RooService(domainTypes = { com.focustech.portfolio.domain.Portfolio.class })
public interface PortfolioService {
	void getCurrentPrices(List<Portfolio> portfoliolist);
	PortfolioTotal getPortfolioTotal(List<Portfolio> portfoliolist);
	double getCurrentPrice(String ticker);
}
