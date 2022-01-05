package com.wellness.package_tour;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
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
import com.wellness.tour.TourSvc;
import com.wellness.tour.TourVO;

@Controller
public class PackageController {

	@Autowired
	PackageSvc packageService;
	@Autowired
	WishListSvc wishListService;
	@Autowired
	TourSvc tourService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	HashTagSvc hahsTagService;
	
	@RequestMapping(value = "package_list_nature")
	public String package_list_nature(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageNature();
			
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
			
			pag.setObj("자연교감형");
			List<PackageVO> pVOList = packageService.getPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageNatureBySearch(search_keyword);
			
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
			
			pag.setObj("자연교감형");
			pag.setSearch_keyword(search_keyword);
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/package_list";
	}
	@RequestMapping(value = "package_list_nature_pop")
	public String package_list_nature_pop(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageNature();
			
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
			
			pag.setObj("자연교감형");
			List<PackageVO> pVOList = packageService.getPackage(pag);
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageNatureBySearch(search_keyword);
			
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
			
			pag.setObj("자연교감형");
			pag.setSearch_keyword(search_keyword);
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag);
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/package_list";
	}
	
	@RequestMapping(value = "package_list_ocean")
	public String package_list_ocean(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageOcean();
			
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
			
			pag.setObj("해양체험형");
			
			List<PackageVO> pVOList = packageService.getPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageOceanBySearch(search_keyword);
			
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
			
			pag.setObj("해양체험형");
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		
		return "view/package_list";
	}
	@RequestMapping(value = "package_list_ocean_pop")
	public String package_list_ocean_pop(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageOcean();
			
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
			
			pag.setObj("해양체험형");
			
			List<PackageVO> pVOList = packageService.getPackage(pag); 
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageOceanBySearch(search_keyword);
			
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
			
			pag.setObj("해양체험형");
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag); 
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/package_list";
	}
	
	@RequestMapping(value = "package_list_story")
	public String package_list_story(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageStory();
			
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
			
			pag.setObj("스토리텔링형");
			
			List<PackageVO> pVOList = packageService.getPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageStoryBySearch(search_keyword);
			
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
			
			pag.setObj("스토리텔링형");
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag); 
			
			modelMap.addAttribute("pVOList", pVOList);
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/package_list";
	}
	@RequestMapping(value = "package_list_story_pop")
	public String package_list_story_pop(ModelMap modelMap, HttpSession session, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = packageService.countContentsPackageStory();
			
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
			
			pag.setObj("스토리텔링형");
			List<PackageVO> pVOList = packageService.getPackage(pag); 
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}else {
			int total = packageService.countContentsPackageStoryBySearch(search_keyword);
			
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
			
			pag.setObj("스토리텔링형");
			pag.setSearch_keyword(search_keyword);
			
			List<PackageVO> pVOList = packageService.getSearchPackage(pag); 
//		modelMap.addAttribute("pVOList", pVOList);
			int[] likeCnt = new int[pVOList.size()];
			for(int i = 0; i < likeCnt.length; i++) {
				likeCnt[i] = wishListService.getLikeCntPackage(pVOList.get(i));
			}
			List<GetLikeCntVO> glcVOList = new ArrayList<GetLikeCntVO>();
			for(int i = 0; i < pVOList.size(); i++) {
				GetLikeCntVO glcVO = new GetLikeCntVO();
				glcVO.setIdx(pVOList.get(i).getPackage_idx());
				glcVO.setName(pVOList.get(i).getPackage_name());
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
			List<PackageVO> popularPVO = new ArrayList<PackageVO>();
			for(int i = 0; i < glcVOList.size(); i ++) {
				PackageVO pVO = packageService.getPopularPackage(glcVOList.get(i));
				popularPVO.add(pVO);
			}
			modelMap.addAttribute("pVOList", popularPVO);
			
			// 좋아요 정보 받기 시작 #########################################################
			if(session.getAttribute("member") != null) {
				MemberVO mVO = (MemberVO) session.getAttribute("member");
				List<WishListVO> wlVOList = wishListService.getMemberLikePackage(mVO);
				modelMap.addAttribute("membersLike", wlVOList);
			}
			// 좋아요 정보 받기 완료 #########################################################
		}
		
		return "view/package_list";
	}
	
	@RequestMapping(value = "package_detail", method = RequestMethod.GET)
	public String package_detail(int no, ModelMap modelMap) {
		Object obj = no;
		PackageVO pVO = packageService.getDetailPackage(obj);
		modelMap.addAttribute("pVO", pVO);
		
		String tourname1 = pVO.getTour_name1();
		Object objForTour = tourname1;
		TourVO tVO = tourService.getTourInfoAsPackage(objForTour);
		modelMap.addAttribute("tVO", tVO);
		
		List<ImageVO> imgVOList = imageService.getDetailPackageTourImg(tVO);
		modelMap.addAttribute("imgVOList", imgVOList);
		
		List<HashTagVO> hVOList = hahsTagService.getDetailPackageTourHash(tVO);
		modelMap.addAttribute("hVOList", hVOList);
		
		return "view/package_detail";
	}
	@RequestMapping(value = "package_detail_tourname", method = RequestMethod.GET)
	public String package_detail_tourname(int no, String tourname, ModelMap modelMap) {
		Object obj = no;
		PackageVO pVO = packageService.getDetailPackage(obj);
		modelMap.addAttribute("pVO", pVO);
		
		Object objForTour = tourname;
		TourVO tVO = tourService.getTourInfoAsPackage(objForTour);
		modelMap.addAttribute("tVO", tVO);
		
		List<ImageVO> imgVOList = imageService.getDetailPackageTourImg(tVO);
		modelMap.addAttribute("imgVOList", imgVOList);
		
		List<HashTagVO> hVOList = hahsTagService.getDetailPackageTourHash(tVO);
		modelMap.addAttribute("hVOList", hVOList);
		
		return "view/package_detail";
	}
	
	// 좋아요 ajax
	@RequestMapping(value = "ajax_package_like_plus", method = {RequestMethod.GET})
	@ResponseBody
	public void like_up(@RequestParam("tour_title") String tour_title, @RequestParam("member_idx") int member_idx) {
		PackageVO pVO = new PackageVO();
		pVO.setPackage_name(tour_title);
		int package_idx = packageService.getLikePackageIdx(pVO);
			
		WishListVO wlVO = new WishListVO();
		wlVO.setMember_idx(member_idx);
		wlVO.setWish_big_category("package");
		wlVO.setWish_small_category(package_idx);
		
		wishListService.addWishList(wlVO);
	}
		
	@RequestMapping(value = "ajax_package_like_minus", method = {RequestMethod.GET})
	@ResponseBody
	public void like_down(@RequestParam("tour_title") String tour_title, @RequestParam("member_idx") int member_idx) {
		PackageVO pVO = new PackageVO();
		pVO.setPackage_name(tour_title);
		int package_idx = packageService.getLikePackageIdx(pVO);
		
		WishListVO wlVO = new WishListVO();
		wlVO.setMember_idx(member_idx);
		wlVO.setWish_big_category("tour");
		wlVO.setWish_small_category(package_idx);
		
		wishListService.deleteWishList(wlVO);
	}
	
	@RequestMapping(value = "home_form_for_reservation", method = RequestMethod.POST)
	public String home_form_for_reservation(SearchPackageVO spVO, ModelMap modelMap) {
//		System.out.println("date : " + spVO.getRsvdate());
//		String searchDate = spVO.getRsvdate().replace("-", "");
//		System.out.println("date : " + searchDate);
		// ##군, ##구 정보로 투어 구하기
		// xml like문 동적쿼리 CONCAT('%',#{},'%')
		modelMap.addAttribute("spVO", spVO);
		List<TourVO> tVOList = tourService.getTourByLocate(spVO);
		
//		for(int i = 0; i < tVOList.size(); i++) {
//			System.out.println("tVOList.get(" + i + ") : " + tVOList.get(i).getTour_name()); 
//		}
		// 패키지 구하기
		List<PackageVO> pVOList = new ArrayList<PackageVO>();
		for(int i = 0; i < tVOList.size(); i++) {
			// 투어 객체의 이름이 포함된 패키지 객체 구하기 where 절 or 사용
			List<PackageVO> pVOByTourName = new ArrayList<PackageVO>(); 
			pVOByTourName = packageService.getPackageByTourname(tVOList.get(i));
			pVOList.addAll(pVOByTourName);
		}
//		for(int i = 0; i < pVOList.size(); i++) {
//			System.out.println("test : " + pVOList.get(i).getPackage_idx());
//		}
//		System.out.println("pVOList : " + pVOList);

		// 검색된 인원수만큼 여분이 있는 패키지 구하기
		List<PackageVO> pVOListByCnt = new ArrayList<PackageVO>();
		for(int i = 0; i < pVOList.size(); i++) {
			int howMany = pVOList.get(i).getMax_num() - pVOList.get(i).getNumber_of_reservation();
			if(howMany >= spVO.getCnt()) {
				pVOListByCnt.add(pVOList.get(i));
			}
		}
//		System.out.println("pVOListByCnt : " + pVOListByCnt);
		// 검색된 날짜에 맞는 패키지 구하기
		List<PackageVO> pVOListByCntAndDate = new ArrayList<PackageVO>();
		for(int i = 0; i < pVOListByCnt.size(); i++) {
			int startDate = Integer.parseInt(pVOListByCnt.get(i).getPackage_start_date().replace("-", ""));
			int endDate = Integer.parseInt(pVOListByCnt.get(i).getPackage_end_date().replace("-", ""));
			int searchDate = Integer.parseInt(spVO.getRsvdate().replace("-", ""));

			if(searchDate >= startDate && searchDate <= endDate) {
				pVOListByCntAndDate.add(pVOListByCnt.get(i));
			}
		}
//		System.out.println("pVOListByCntAndDate : " + pVOListByCntAndDate);
//		
		modelMap.addAttribute("pVOList", pVOListByCntAndDate);
		
		return "view/package_list";
	}
	
}
