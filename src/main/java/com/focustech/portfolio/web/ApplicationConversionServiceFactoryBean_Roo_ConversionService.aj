// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.focustech.portfolio.web;

import com.focustech.portfolio.domain.Portfolio;
import com.focustech.portfolio.service.PortfolioService;
import com.focustech.portfolio.web.ApplicationConversionServiceFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    @Autowired
    PortfolioService ApplicationConversionServiceFactoryBean.portfolioService;
    
    public Converter<Portfolio, String> ApplicationConversionServiceFactoryBean.getPortfolioToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<com.focustech.portfolio.domain.Portfolio, java.lang.String>() {
            public String convert(Portfolio portfolio) {
                return new StringBuilder().append(portfolio.getTicker()).append(' ').append(portfolio.getCurrent_price()).append(' ').append(portfolio.getQuantity()).toString();
            }
        };
    }
    
    public Converter<Long, Portfolio> ApplicationConversionServiceFactoryBean.getIdToPortfolioConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, com.focustech.portfolio.domain.Portfolio>() {
            public com.focustech.portfolio.domain.Portfolio convert(java.lang.Long id) {
                return portfolioService.findPortfolio(id);
            }
        };
    }
    
    public Converter<String, Portfolio> ApplicationConversionServiceFactoryBean.getStringToPortfolioConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, com.focustech.portfolio.domain.Portfolio>() {
            public com.focustech.portfolio.domain.Portfolio convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), Portfolio.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getPortfolioToStringConverter());
        registry.addConverter(getIdToPortfolioConverter());
        registry.addConverter(getStringToPortfolioConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}
