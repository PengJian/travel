package com.fnst.travel.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fnst.travel.model.TravelRoute;
import com.fnst.travel.service.EmployeeRouteManager;
import com.fnst.travel.service.TravelRouteManager;

public class InitRouteUtil {
	private static TravelRouteManager travelRouteManager = (TravelRouteManager) new ClassPathXmlApplicationContext(
			"applicationContext.xml").getBean("travelRouteManager");
	private static EmployeeRouteManager employeeRouteManager = (EmployeeRouteManager) new ClassPathXmlApplicationContext(
	"applicationContext.xml").getBean("employeeRouteManager");

	public static void loadRoute(ServletContext application) {
		application.removeAttribute("Routes");
		List<TravelRoute> list = travelRouteManager.searchCurrentOpenRoute();
		Map<Integer, Route> routes = new LinkedHashMap<Integer, Route>();
		for (TravelRoute route : list) {
			//System.err.println(route.getName()+""+route.getId());
			Route route2 = new Route(route.getId(), route.getMaxAmount(),
					route.getName(), employeeRouteManager.getTravelSumByRouteId(route.getId()));
			routes.put(route.getId(), route2);
		}
		application.setAttribute("Routes", routes);
		List<TravelRoute> list2 = travelRouteManager.searchCurrentActvieBatchOffRoute();
		List<OffRoute> list3 = new ArrayList<OffRoute>();
		for(TravelRoute route:list2){
			list3.add(new OffRoute(route.getId(), route.getName()));
		}
		application.setAttribute("offRoutes", list3);
	}
}
