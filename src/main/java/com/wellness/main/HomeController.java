package com.wellness.main;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellness.event.EventSvc;
import com.wellness.event.EventVO;
import com.wellness.gallery.GallerySvc;
import com.wellness.gallery.GalleryVO;
import com.wellness.member.MemberVO;
import com.wellness.tour.TourSvc;
import com.wellness.tour.TourVO;

@Controller
public class HomeController {
	
	@Autowired
	TourSvc tourService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	GallerySvc galleryService;
	@Autowired
	HashTagSvc hashTagService;
	@Autowired
	WishListSvc wishListService;
	@Autowired
	VideoSvc videoService;
	@Autowired
	EventSvc eventService;
	
	@RequestMapping(value = "home")
	public String home(HttpServletRequest request, ModelMap modelMap, HttpServletResponse response, HttpSession session) {
		
		// tour_address 받기 ########################################################
		List<TourVO> tVOList = tourService.getLocate();

		// tour_address 를 문자열 배열로 전환
		String[] locateArray = new String[tVOList.size()];
		for(int i = 0; i < tVOList.size(); i++) {
			locateArray[i] = tVOList.get(i).getTour_address();
		}
		
		// 문자열 배열에서 시 ~ 구 사이 ##구 or ##군 거르기
		String[] arrayGU = new String[locateArray.length];
		for(int i = 0; i < locateArray.length; i++) {
//			System.out.println("locateArray[" + i + "] : " + locateArray[i]);
			int start = locateArray[i].indexOf("시");
//			System.out.println("start : " + start);
			int end = 0;
			if(locateArray[i].indexOf("구") != -1) {
				end = locateArray[i].indexOf("구");
			}else if(locateArray[i].indexOf("군") != -1) {
				end = locateArray[i].indexOf("군");
			}
//			System.out.println("end : " + end);
			arrayGU[i] = locateArray[i].substring(start + 2, end + 1); 
		}
		
		// locate "구" 출력
//		for(int i = 0; i < arrayGU.length; i++) {
//			System.out.println("arrayGU[" + i + "] : " + arrayGU[i]);
//		}
		
		// 중복된 주소 제거
		HashSet<String> hashSet = new HashSet<String>(Arrays.asList(arrayGU));
		String[] resultGU = hashSet.toArray(new String[0]);
		
		// 결과값 출력
//		for(int i = 0; i < resultGU.length; i++) {
//			System.out.println("resultGU[" + i + "] : " + resultGU[i]);
//		}
		// ##구 ##군 주소값 세션 저장
		modelMap.addAttribute("locateList", resultGU);
		// tour_address 받기 END ######################################################
		
		// popular tourist 받기 ######################################################
		// 전체 목록 받기
		List<TourVO> tourVOList = tourService.getAll();
		int[] likeCnt = new int[tourVOList.size()];
		for(int i = 0; i < likeCnt.length; i++) {
			likeCnt[i] = wishListService.getLikeCnt(tourVOList.get(i));
		}
		List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
		for(int i = 0; i < tourVOList.size(); i++) {
			GetLikeCntVO glcVO = new GetLikeCntVO();
			glcVO.setIdx(tourVOList.get(i).getTour_idx());
			glcVO.setName(tourVOList.get(i).getTour_name());
			glcVO.setLike_cnt(likeCnt[i]);
			glcVOList.add(glcVO);
		}
		// 정렬 객체
		Comparator<GetLikeCntVO> comparator = new Comparator<GetLikeCntVO>() {
			public int compare(GetLikeCntVO o1, GetLikeCntVO o2) {
				return o2.getLike_cnt() - o1.getLike_cnt();
			}
		};
		// 정렬시작
		Collections.sort(glcVOList, comparator);
//		for(int i = 0; i < glcVOList.size(); i++) {
//			System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
//			System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
//			System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
//		}
		// TOP 6만 저장하기
		List<GetLikeCntVO> glcVOTopSix = new ArrayList<GetLikeCntVO>();
		for(int i = 0; i < 6; i++) {
			GetLikeCntVO gVO = new GetLikeCntVO();
			gVO = glcVOList.get(i);
			glcVOTopSix.add(gVO);
		}
		// top 6 세션저장
		modelMap.addAttribute("top_six_tourist", glcVOTopSix);
		// popular tourist 받기 END ##################################################
		
		// popular tourist image 받기 ###############################################
		List<ImageVO> topSixImage = new ArrayList<ImageVO>();
		for(int i = 0; i < 6; i++) {
			ImageVO getTopImage = imageService.getTopSixImage(glcVOTopSix.get(i));
			topSixImage.add(getTopImage);
		}
		modelMap.addAttribute("top_six_image", topSixImage);
		// popular tourist image 받기 END ###########################################
		
		// popular tourist hash tag 받기 ############################################
		List<HashTagVO> hashTagVOList = new ArrayList<HashTagVO>();
		for(int i = 0; i < glcVOTopSix.size(); i++) {
			List<HashTagVO> eachList = hashTagService.getHashTagForPopularTourist(glcVOTopSix.get(i));
			hashTagVOList.addAll(eachList);
		}
		for(int i = 0; i < hashTagVOList.size(); i++) {
			System.out.println("hashTagVOList["+i+"].tour_idx : " + hashTagVOList.get(i).getHash_tag_category());
			System.out.println("hashTagVOList["+i+"].content : " + hashTagVOList.get(i).getHash_tag_content());
		}
		modelMap.addAttribute("hashTagVOList", hashTagVOList);
		// popular tourist hash tag 받기 END ########################################
		
		// popular gallery 받기 #####################################################
		List<GalleryVO> galleryList = galleryService.getCntBest();
//		List<GalleryVO> galleryBestList = new ArrayList<GalleryVO>();
//		if(galleryList.size() != 0) {
//			if(galleryList.size() < 7) {
//				for(int i = 0; i < galleryList.size(); i++) {
//					GalleryVO galleryVO = new GalleryVO();
//					galleryVO = galleryList.get(i);
//					galleryBestList.add(galleryVO);
//				}
//			}else {
//				for(int i = 0; i < 6; i++) {
//					GalleryVO galleryVO = new GalleryVO();
//					galleryVO = galleryList.get(i);
//					galleryBestList.add(galleryVO);
//				}
//			}
//		}else {
//			System.out.println("갤러리 리스트 : 0개");
//		}
		
		modelMap.addAttribute("top_six_gallery", galleryList);
		// popular gallery 받기 END #################################################
		
		// popular gallery image 받기 ###############################################
		List<ImageVO> galleryBestImg = new ArrayList<ImageVO>();
		for(int i = 0; i < galleryList.size(); i++) {
			ImageVO imgVO = imageService.getGalleryImgBest(galleryList.get(i));
			if(imgVO != null) {
				galleryBestImg.add(imgVO);
			}
		}
		modelMap.addAttribute("top_six_gallery_img", galleryBestImg);
//		if(galleryList.size() != 0) {
//			if(galleryList.size() < 7) {
//				for(int i = 0; i < galleryList.size(); i++) {
//					ImageVO imgVO = imageService.getGalleryImgBest(galleryList.get(i));
//					galleryBestImg.add(imgVO);
//				}
//			}else {
//				for(int i = 0; i < 6; i++) {
//					ImageVO imgVO = imageService.getGalleryImgBest(galleryList.get(i));
//					galleryBestImg.add(imgVO);
//				}
//			}
//		}
		// popular gallery image 받기 END ###########################################
		
		// popular gallery video 받기 ################################################
		List<VideoVO> galleryBestVideo = new ArrayList<VideoVO>();
		for(int i = 0; i < galleryList.size(); i++) {
			VideoVO videoVO = videoService.getGalleryVideoBest(galleryList.get(i));
			if(videoVO != null) {
				galleryBestVideo.add(videoVO);
			}
		}
		modelMap.addAttribute("top_six_gallery_video", galleryBestVideo);
//		if(galleryBestList.size() != 0) {
//			if(galleryBestList.size() < 7) {
//				for(int i = 0; i < galleryBestList.size(); i++) {
//					VideoVO videoVO = videoService.getGalleryVideoBest(galleryBestList.get(i));
//					galleryBestVideo.add(videoVO);
//				}
//			}else {
//				for(int i = 0; i < 6; i++) {
//					VideoVO videoVO = videoService.getGalleryVideoBest(galleryBestList.get(i));
//					galleryBestVideo.add(videoVO);
//				}
//			}
//		}
		// popular gallery video END ################################################
		
		// 좋아요 정보 받기 시작 #########################################################
		if(session.getAttribute("member") != null) {
			MemberVO mVO = (MemberVO) session.getAttribute("member");
			List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
			modelMap.addAttribute("membersLike", wlVOList);
		}
		// 좋아요 정보 받기 완료 #########################################################
		
		// 이벤트 날짜 확인하고 진행/미진행/종료 자동 ######################################### 
		List<EventVO> eVOList = eventService.getAllEventForHome();
		for(EventVO eVO : eVOList) {
			Date now = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String formatNow = formatter.format(now);
			int nowDate = Integer.parseInt(formatNow.replace("-", ""));
			
			int startDate = Integer.parseInt(eVO.getEvent_homepage_start_date().replace("-", ""));
			int endDate = Integer.parseInt(eVO.getEvent_homepage_end_date().replace("-", ""));
			
			if(nowDate < startDate) {
				// 현재날짜가 시작날짜보다 작으면 n
				eventService.settingN(eVO);
			}else if(nowDate == startDate && nowDate <= endDate ) {
				// 현재날짜가 시작날짜와 같거나 종료날짜보다 작거나 같다면 y
				eventService.settingY(eVO);
			}else if(nowDate > endDate){
				// 현재날짜가 종료날짜보다 크다면 e
				eventService.settingE(eVO);
			}
			
		}
		// 이벤트 날짜 확인하고 진행/미진행/종료 자동 END ###################################### 
		
		return "view/home"; 
	}
	
//	@RequestMapping(value = "home_form_for_reservation", method = {RequestMethod.GET})
//	public String home_form_for_reservation(HttpServletRequest request) {
//		return null;
//	}
	
	
	
	
	// 좋아요 ajax
	@RequestMapping(value = "ajax_home_like_plus", method = {RequestMethod.GET})
	@ResponseBody
	public void like_up(@RequestParam("tour_title") String tour_title, @RequestParam("member_idx") int member_idx) {
		TourVO tVO = new TourVO();
		tVO.setTour_name(tour_title);
		int tour_idx = tourService.getLikeTourIdx(tVO);
		
		WishListVO wlVO = new WishListVO();
		wlVO.setMember_idx(member_idx);
		wlVO.setWish_big_category("tour");
		wlVO.setWish_small_category(tour_idx);
		
		wishListService.addWishList(wlVO);
	}
	
	@RequestMapping(value = "ajax_home_like_minus", method = {RequestMethod.GET})
	@ResponseBody
	public void like_down(@RequestParam("tour_title") String tour_title, @RequestParam("member_idx") int member_idx) {
		TourVO tVO = new TourVO();
		tVO.setTour_name(tour_title);
		int tour_idx = tourService.getLikeTourIdx(tVO);
		
		WishListVO wlVO = new WishListVO();
		wlVO.setMember_idx(member_idx);
		wlVO.setWish_big_category("tour");
		wlVO.setWish_small_category(tour_idx);
		
		wishListService.deleteWishList(wlVO);
	}
	
	
	@RequestMapping(value = "privacy_rule")
	public String privacy_rule() {
		return "view/privacy_rule";
	}
	@RequestMapping(value = "use_rule")
	public String use_rule() {
		return "view/use_rule";
	}
}
