package com.wellness.reserve;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wellness.main.HashTagVO;
import com.wellness.main.ImageVO;
import com.wellness.package_tour.PackageSvc;
import com.wellness.package_tour.PackageVO;
import com.wellness.tour.TourSvc;
import com.wellness.tour.TourVO;

@Controller
public class ReserveController {

	@Autowired
	PackageSvc packageService;
	@Autowired
	TourSvc tourService;
	@Autowired
	ReserveSvc reserveService;
	
	@RequestMapping(value = "reserve", method = RequestMethod.GET)
	public String reserve_get(int package_idx, ModelMap modelMap) {
		Object obj = package_idx;
		PackageVO pVO = packageService.getDetailPackage(obj); 
		modelMap.addAttribute("pVO", pVO);
		
		String tourname1 = pVO.getTour_name1();
		Object objForTour = tourname1;
		TourVO tVO = tourService.getTourInfoAsPackage(objForTour);
		modelMap.addAttribute("tVO", tVO);
		
		return "view/reserve";
	}
	@RequestMapping(value = "reserve_tourname", method = RequestMethod.GET)
	public String reserve_tourname(int no, String tourname, ModelMap modelMap) {
		Object obj = no;
		PackageVO pVO = packageService.getDetailPackage(obj); 
		modelMap.addAttribute("pVO", pVO);
		
//		String tourname1 = pVO.getTour_name1();
		Object objForTour = tourname;
		TourVO tVO = tourService.getTourInfoAsPackage(objForTour);
		modelMap.addAttribute("tVO", tVO);
		
		return "view/reserve";
	}
	@RequestMapping(value = "reserve", method = RequestMethod.POST)
	public String reserve_post(ReserveVO rVO, ModelMap modelMap) {
		
		int row = reserveService.addReserve(rVO);
		
		PackageVO pVO = packageService.getDetailPackageForReserve(rVO);
		
		pVO.setNumber_of_reservation(pVO.getNumber_of_reservation() + rVO.getReserve_count());
		
		packageService.plusCnt(pVO);
		
		if(row != 0) {
			System.out.println("예약 성공");
		}else {
			System.err.println("예약 실패");
		}
		
		return "redirect:/my_reserve";
	}
}
