package com.focustech.portfolio.web;

import java.util.ArrayList;
import java.util.List;

import com.focustech.portfolio.domain.Portfolio;
import com.focustech.portfolio.domain.PortfolioTotal;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping("/portfolios")
@Controller
@RooWebScaffold(path = "portfolios", formBackingObject = Portfolio.class)
public class PortfolioController {
	

	@RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid Portfolio portfolio, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, portfolio);
            return "portfolios/create";
        }
        uiModel.asMap().clear();
        portfolioService.savePortfolio(portfolio);
        
        return "redirect:/portfolios/" + encodeUrlPathSegment(portfolio.getId().toString(), httpServletRequest);
    }

	@RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            List<Portfolio> portfoliolist = portfolioService.findPortfolioEntries(firstResult, sizeNo);
            portfolioService.getCurrentPrices(portfoliolist);
            uiModel.addAttribute("portfolios", portfoliolist);
            float nrOfPages = (float) portfolioService.countAllPortfolios() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
        	List<Portfolio> portfoliolist = portfolioService.findAllPortfolios();
            uiModel.addAttribute("portfolios", portfoliolist);
        	portfolioService.getCurrentPrices(portfoliolist);
        }
        List<Portfolio> portfoliolist = portfolioService.findAllPortfolios();
        PortfolioTotal portfolioTotal = portfolioService.getPortfolioTotal(portfoliolist);
       
        
        uiModel.addAttribute("portfolioTotal",portfolioTotal);
        return "portfolios/list";
    }
}
