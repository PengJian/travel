package com.fnst.travel.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;

public class SpringContextListener extends ContextLoaderListener{

	@Override
	public WebApplicationContext initWebApplicationContext(
			ServletContext servletContext) {
		// TODO Auto-generated method stub
		return super.initWebApplicationContext(servletContext);
	}

}
