package com.focustech.portfolio.service;

import java.util.List;

import org.springframework.roo.addon.layers.service.RooService;

import com.focustech.portfolio.domain.Portfolio;

@RooService(domainTypes = { com.focustech.portfolio.domain.Portfolio.class })
public interface PortfolioService {
	void getCurrentPrices(List<Portfolio> portfoliolist);
}
