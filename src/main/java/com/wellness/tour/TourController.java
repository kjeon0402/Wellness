package com.wellness.tour;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wellness.common.Paging;
import com.wellness.main.GetLikeCntVO;
import com.wellness.main.HashTagSvc;
import com.wellness.main.HashTagVO;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.WishListSvc;
import com.wellness.main.WishListVO;
import com.wellness.member.MemberVO;

@Controller
public class TourController {

	@Autowired
	TourSvc tourService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	HashTagSvc hashTagService;
	@Autowired
	WishListSvc wishListService;
	
	@RequestMapping(value = "tour_list_nature")
	public String tour_list_nature(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourNature();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutNature(pag);
			modelMap.addAttribute("natureList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageNature(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("natureImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourNatureBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutNature(pag);
			modelMap.addAttribute("natureList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageNature(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("natureImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_nature";
	}
	
	@RequestMapping(value = "tour_list_nature_popular")
	public String tour_list_nature_popular(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourNature();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutNature(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("natureList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageNature(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("natureImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourNatureBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutNature(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("natureList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageNature(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("natureImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_nature";
	}
	
	@RequestMapping(value = "tour_list_ocean")
	public String tour_list_ocean(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourOcean();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '오션레저' 받기
			List<TourVO> tVOList = tourService.getAllAboutOcean(pag);
			modelMap.addAttribute("oceanList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageOcean(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("oceanImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourOceanBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '오션레저' 받기
			List<TourVO> tVOList = tourService.getSearchAboutOcean(pag);
			modelMap.addAttribute("oceanList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageOcean(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("oceanImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_ocean";
	}
	
	@RequestMapping(value = "tour_list_ocean_popular")
	public String tour_list_ocean_popular(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourOcean();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutOcean(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("oceanList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageOcean(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("oceanImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourOceanBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutOcean(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("oceanList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageOcean(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("oceanImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_ocean";
	}
	
	@RequestMapping(value = "tour_list_cosmetic")
	public String tour_list_cosmetic(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourCosmetic();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '뷰티&헬스스파' 받기
			List<TourVO> tVOList = tourService.getAllAboutCosmetic(pag);
			modelMap.addAttribute("cosmeticList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageCosmetic(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("cosmeticImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourCosmeticBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '뷰티&헬스스파' 받기
			List<TourVO> tVOList = tourService.getSearchAboutCosmetic(pag);
			modelMap.addAttribute("cosmeticList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageCosmetic(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("cosmeticImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_cosmetic";
	}
	
	@RequestMapping(value = "tour_list_cosmetic_popular")
	public String tour_list_cosmetic_popular(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourCosmetic();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutCosmetic(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("cosmeticList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageCosmetic(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("cosmeticImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourCosmeticBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutCosmetic(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("cosmeticList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageCosmetic(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("cosmeticImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_cosmetic";
	}
	
	@RequestMapping(value = "tour_list_meal")
	public String tour_list_meal(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourMeal();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '영양식당' 받기
			List<TourVO> tVOList = tourService.getAllAboutMeal(pag);
			modelMap.addAttribute("mealList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageMeal(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("mealImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourMealBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '영양식당' 받기
			List<TourVO> tVOList = tourService.getSearchAboutMeal(pag);
			modelMap.addAttribute("mealList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageMeal(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("mealImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_meal";
	}
	
	@RequestMapping(value = "tour_list_meal_popular")
	public String tour_list_meal_popular(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keword) {
		
		if(search_keword == null || search_keword == "") {
			int total = tourService.countContentsTourMeal();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutMeal(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("mealList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageMeal(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("mealImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourMealBySearch(search_keword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutMeal(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("mealList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageMeal(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("mealImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_meal";
	}
	
	@RequestMapping(value = "tour_list_hotel")
	public String tour_list_hotel(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourHotel();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '호텔리조트' 받기
			List<TourVO> tVOList = tourService.getAllAboutHotel(pag);
			modelMap.addAttribute("hotelList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageHotel(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("hotelImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourHotelBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '호텔리조트' 받기
			List<TourVO> tVOList = tourService.getSearchAboutHotel(pag);
			modelMap.addAttribute("hotelList", tVOList);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				ImageVO imageVO = imageService.getImageHotel(tVOList.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("hotelImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_hotel";
	}
	
	@RequestMapping(value = "tour_list_hotel_popular")
	public String tour_list_hotel_popular(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = tourService.countContentsTourHotel();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getAllAboutHotel(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("hotelList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageHotel(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("hotelImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = tourService.countContentsTourHotelBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "10";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			
			modelMap.addAttribute("paging", pag);
			
			// tour category '자연교감' 받기
			List<TourVO> tVOList = tourService.getSearchAboutHotel(pag);
//		modelMap.addAttribute("natureList", tVOList);
			int[] likeCnt = new int[tVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCnt(tVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < tVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(tVOList.get(i).getTour_idx());
				glcVO.setName(tVOList.get(i).getTour_name());
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
			for(int i = 0; i < glcVOList.size(); i++) {
				System.out.println("glcVOList[" + i + "].tour_idx : " + glcVOList.get(i).getIdx());
				System.out.println("glcVOList[" + i + "].tour_name : " + glcVOList.get(i).getName());
				System.out.println("glcVOList[" + i + "].like_cnt : " + glcVOList.get(i).getLike_cnt());
			}
			// 정렬된(인기순) 순서대로 저장
			List<TourVO> popularTVO = new ArrayList<TourVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				TourVO tVO = tourService.getPopularTour(glcVOList.get(i));
				popularTVO.add(tVO);
			}
			modelMap.addAttribute("hotelList", popularTVO);
			
			// img 받기
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < popularTVO.size(); i++) {
				ImageVO imageVO = imageService.getImageHotel(popularTVO.get(i));
				imgVOList.add(imageVO);
			}
			modelMap.addAttribute("hotelImgList", imgVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLike(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/tour_list_hotel";
	}
	
	@RequestMapping(value = "tour_detail", method = RequestMethod.GET)
	public String tour_detail(String category, int no, ModelMap modelMap) {
		// Tour table 정보 저장 시작 #############################################
		// 관광지 카테고리 정하기
		String tourCategory = "";
		if(category.equals("nature")) {
			tourCategory = "자연교감";
		}else if(category.equals("ocean")) {
			tourCategory = "오션레저";
		}else if(category.equals("cosmetic")) {
			tourCategory = "뷰티&헬스스파";
		}else if(category.equals("meal")) {
			tourCategory = "영양식당";
		}else if(category.equals("hotel")) {
			tourCategory = "호텔리조트";
		}
		// sql로 던져줄 VO 생성
		TourVO tVO = new TourVO();
		tVO.setTour_category(tourCategory);
		tVO.setTour_idx(no);
		// sql query
		TourVO detailVO = tourService.getDetailTour(tVO);
		modelMap.addAttribute("detailVO", detailVO);
		// Tour table 정보 저장 완료 #############################################
		
		// image table 정보 저장 시작 #############################################
		List<ImageVO> imgVOList = imageService.getDetailTourImage(detailVO);
		if(imgVOList.size() == 0) {
			ImageVO imgVO = new ImageVO();
			imgVO.setImg_path("sample_image.svg");
			modelMap.addAttribute("detailImgVO", imgVO);
		}else {
			modelMap.addAttribute("detailImgVOList", imgVOList);
		}
		// image table 정보 저장 완료 #############################################
		
		// hash_tag table 정보 저장 시작 #########################################
		List<HashTagVO> hashVOList = hashTagService.getDetailTourHash(detailVO);
		modelMap.addAttribute("detailHashVO", hashVOList);
		// hash_tag table 정보 저장 완료 #########################################
		
		
		return "view/tour_detail";
	}
	
	// 좋아요 ajax
	@RequestMapping(value = "ajax_tour_list_like_plus", method = {RequestMethod.GET})
	@ResponseBody
	public void like_up(@RequestParam("tour_title") String tour_title, @RequestParam("member_idx") int member_idx) {
		TourVO tVO = new TourVO();
		tVO.setTour_name(tour_title);
		int tour_idx = tourService.getLikeTourIdx(tVO);
		
		System.out.println("tour_idx : " + tour_idx);
		
		WishListVO wlVO = new WishListVO();
		wlVO.setMember_idx(member_idx);
		wlVO.setWish_big_category("tour");
		wlVO.setWish_small_category(tour_idx);
		
		wishListService.addWishList(wlVO);
	}
	
	@RequestMapping(value = "ajax_tour_list_like_minus", method = {RequestMethod.GET})
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
}
