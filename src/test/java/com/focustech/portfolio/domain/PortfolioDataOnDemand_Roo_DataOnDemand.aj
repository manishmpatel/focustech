// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.focustech.portfolio.domain;

import com.focustech.portfolio.domain.Portfolio;
import com.focustech.portfolio.domain.PortfolioDataOnDemand;
import com.focustech.portfolio.service.PortfolioService;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect PortfolioDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PortfolioDataOnDemand: @Component;
    
    private Random PortfolioDataOnDemand.rnd = new SecureRandom();
    
    private List<Portfolio> PortfolioDataOnDemand.data;
    
    @Autowired
    PortfolioService PortfolioDataOnDemand.portfolioService;
    
    public Portfolio PortfolioDataOnDemand.getNewTransientPortfolio(int index) {
        Portfolio obj = new Portfolio();
        setPurchase_price(obj, index);
        setQuantity(obj, index);
        setTicker(obj, index);
        return obj;
    }
    
    public void PortfolioDataOnDemand.setPurchase_price(Portfolio obj, int index) {
        double purchase_price = new Integer(index).doubleValue();
        obj.setPurchase_price(purchase_price);
    }
    
    public void PortfolioDataOnDemand.setQuantity(Portfolio obj, int index) {
        int quantity = index;
        if (quantity < 1) {
            quantity = 1;
        }
        obj.setQuantity(quantity);
    }
    
    public void PortfolioDataOnDemand.setTicker(Portfolio obj, int index) {
        String ticker = "ticker_" + index;
        obj.setTicker(ticker);
    }
    
    public Portfolio PortfolioDataOnDemand.getSpecificPortfolio(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Portfolio obj = data.get(index);
        Long id = obj.getId();
        return portfolioService.findPortfolio(id);
    }
    
    public Portfolio PortfolioDataOnDemand.getRandomPortfolio() {
        init();
        Portfolio obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return portfolioService.findPortfolio(id);
    }
    
    public boolean PortfolioDataOnDemand.modifyPortfolio(Portfolio obj) {
        return false;
    }
    
    public void PortfolioDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = portfolioService.findPortfolioEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Portfolio' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Portfolio>();
        for (int i = 0; i < 10; i++) {
            Portfolio obj = getNewTransientPortfolio(i);
            try {
                portfolioService.savePortfolio(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
