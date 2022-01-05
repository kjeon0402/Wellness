package com.wellness.member;

import java.util.ArrayList;
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

import com.wellness.common.SHA256Util;
import com.wellness.event.EventVO;
import com.wellness.event_wellness.Event_wellnessVO;
import com.wellness.gallery.GalleryVO;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.WishListSvc;
import com.wellness.main.WishListVO;
import com.wellness.notice.NoticeVO;
import com.wellness.package_tour.PackageSvc;
import com.wellness.package_tour.PackageVO;
import com.wellness.reserve.MyReserveVO;
import com.wellness.reserve.ReserveSvc;
import com.wellness.reserve.ReserveVO;
import com.wellness.tour.TourSvc;
import com.wellness.tour.TourVO;

@Controller
public class MemberController {

	@Autowired
	MemberService ms;
	@Autowired
	WishListSvc ws;
	@Autowired
	TourSvc ts;
	@Autowired
	ImageSvc is;
	@Autowired
	PackageSvc ps;
	@Autowired
	ReserveSvc rs;
	
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String join() {
		return "view/join";
	}
	
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String join(HttpServletRequest request, MemberVO vo) {
		// 비밀번호 암호화 해시처리
		String password = vo.getMember_password();
		String encryption = SHA256Util.SHA256(password);
		vo.setMember_password(encryption);
		
		// 이메일 @ 이하 붙이기
		String email = vo.getMember_email() + "@" + request.getParameter("email_domain");
		vo.setMember_email(email);
		
		ms.join(vo);
		return "redirect:/login";
	}
	
	@RequestMapping(value = "idCheck", method = RequestMethod.POST)
	public @ResponseBody String idCheck(HttpServletRequest request, ModelMap modelMap,
			@RequestParam(value = "id", defaultValue = "") String id) {
		// 아이디 정규식 체크 비동기
		boolean regular = true;
		int check = 1;

		for (int i = 0; i < id.length(); i++) {
			String sub = id.substring(i, i + 1);
			char c = sub.charAt(0);

			if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9')) {

			} else {
				regular = false;
			}
		}

		if (id.length() >= 3 && id.length() <= 16) {

		} else {
			regular = false;
		}

		if (regular == true) {
			check = ms.idCheck(id);
		} else {
			check = 1;
		}
		
		return String.valueOf(check);
	}
	
	@RequestMapping(value = "mypage", method = RequestMethod.GET)
	public String mypage() {
		return "view/mypage";
	}
	
	@RequestMapping(value = "mypage", method = RequestMethod.POST)
	public String mypage(String mode, HttpServletRequest request, MemberVO vo) {
		MemberVO mypage = ms.login(vo);
		System.out.println("mode : " + mode);
		if(mypage == null && mode.equals("info")) {
			return "redirect:/mypage?mode=info";
		} else if(mypage != null && mode.equals("info")) {
			return "view/change_personnal";
		} else if(mypage == null && mode.equals("pw")) {
			return "redirect:/mypage?mode=pw";
		} else {
			return "view/change_pw";
		}
	}
	
	@RequestMapping(value = "find_id", method = RequestMethod.GET)
	public String find_id() {
		return "view/find_id";
	}
	
	@RequestMapping(value = "find_id", method = RequestMethod.POST)
	public String find_id(HttpServletRequest request, ModelMap modelMap, FindIdVO vo) {
		System.out.println("vo.member_name : " + vo.getMember_name());
		System.out.println("vo.member_email : " + vo.getMember_email());
		System.out.println("vo.member_email_domain : " + vo.getMember_email_domain());
		System.out.println("vo.member_phone : " + vo.getMember_phone());
		MemberVO mVO = new MemberVO();
		if(vo.getMember_email() != "") {
			String email = vo.getMember_email() + "@" + vo.getMember_email_domain();
			vo.setMember_email(email);
			mVO = ms.findIdByEmail(vo);
		}else {
			mVO = ms.findIdByPhone(vo);
		}
		
		
		if(mVO != null) {
			modelMap.addAttribute("findID", mVO.getMember_userid());
			return "view/login";
		}else {
			return "view/login_fail";
		}
	}
	
	@RequestMapping(value = "find_pw")
	public String find_pw() {
		return "view/find_pw";
	}
	
	@RequestMapping(value = "find_pw", method = RequestMethod.POST)
	public String find_pw(HttpServletRequest request, ModelMap modelMap, FindPwVO vo, HttpSession session) {
		
		MemberVO mVO = new MemberVO();
		if(vo.getMember_email() != "") {
			String email = vo.getMember_email() + "@" + vo.getMember_email_domain();
			vo.setMember_email(email);
			mVO = ms.findPwByEmailpw(vo);
			session.setAttribute("mvo", mVO);
		}else {
			mVO = ms.findIdByPhonepw(vo);
			session.setAttribute("mvo", mVO);
		}
		
		if(mVO != null) {
//			modelMap.addAttribute("findID", mVO.getMember_userid());
			return "redirect:/find_pw_result";
		}else {
			return "view/login_fail";
		}
		
		
		
//		MemberVO mvo = new MemberVO();
//		
//		String email = request.getParameter("email_id") + "@" + request.getParameter("email_domain");
//		vo.setMember_email(email);
//		vo.setMember_phone(request.getParameter("member_phone"));
//		System.out.println("email : " + email);
//		System.out.println("phone : " + request.getParameter("member_phone"));
//		
//		if(vo.getMember_email() != null) {
//			mvo = ms.findPwByEmailpw(vo);
//			session.setAttribute("mvo", mvo);
//		} else if(vo.getMember_phone() != null) {
//			mvo = ms.findIdByPhonepw(vo);
//			session.setAttribute("mvo", mvo);
//		}
		
//		modelMap.addAttribute("memberInfo", mvo);
//		System.out.println(mvo);
//		if(mvo != null) {
//			return "view/find_pw_result";
//		} else {
//			return "view/login_fail";
//		}
	}
	
	@RequestMapping(value = "find_pw_result", method = RequestMethod.GET)
	public String find_pw_result_get() {
		return "view/find_pw_result";
	}
	
	
	@RequestMapping(value = "find_pw_result", method = RequestMethod.POST)
	public String find_pw_result(HttpServletRequest request, ChangePwVO vo, HttpSession session) {
		
		MemberVO mVO = (MemberVO) session.getAttribute("mvo");
		vo.setMember_idx(mVO.getMember_idx());
		int row = ms.findPwResult(vo);
		
		if(row == 1) {
			System.out.println("비밀번호가 변경되었습니다.");
			session.removeAttribute("mvo");
			return "redirect:/home";
		} else {
			return "redirect:/find_pw";
		}
	}
	
	@RequestMapping(value = "login")
	public String login() {
		return "view/login";
	}
	
	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, MemberVO vo, HttpSession session) {
		MemberVO member = ms.login(vo);
		
		if(member == null) {
			return "view/login_fail";
		} else {
			session.setAttribute("member", member);
			return "redirect:/home";
		}
 	}
	
	// 로그아웃
	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		session.removeAttribute("member");
		return "redirect:/home";
	}
	
	// 회원정보 수정
	@RequestMapping(value = "change_personnal", method = RequestMethod.POST)
	public String change_personnal(HttpServletRequest request, MemberVO vo, HttpSession session) {
		String email = request.getParameter("email_id") + "@" + request.getParameter("email_domain");
		System.out.println("email : " + email);
		vo.setMember_email(email);
		
		int row = ms.changePersonnal(vo);
		System.out.println("row : " + row);
		
		if(row == 1) {
			session.removeAttribute("member");			
			return "redirect:/home";
		} else {
			return "redirect:/home";
		}
	}
	
	// 회원 탈퇴
	@RequestMapping(value = "drop_member", method = RequestMethod.POST)
	public String drop_member(HttpServletRequest request, HttpSession session) {
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		if(mvo != null) {
			ms.dropMember(mvo);
			session.removeAttribute("member");
			return "redirect:/home";
		} else {
			return "redirect:/home";
		}
	}
	
	// 비밀번호수정
	@RequestMapping(value = "change_pw", method = RequestMethod.POST)
	public String change_pw(HttpServletRequest request, ChangePwVO vo, HttpSession session) {
		System.out.println("vo_idx[member_idx] : " + vo.getMember_idx());
		System.out.println("vo_ppw[member_pw] : " + vo.getPrepassword());
		System.out.println("vo_npw[member_npw] : " + vo.getNewpassword());
		
		int row = ms.changepw(vo);
		
		if(row == 1) {
			System.out.println("비밀번호 변경 완료");
			session.removeAttribute("member");
			return "redirect:/home";
		}else {
			System.out.println("비밀번호 변경 실패");
			return "redirect:/home";
		}
	}
	
	// 내 관심목록
	@RequestMapping(value = "like_list")
	public String like_list(HttpSession session, ModelMap modelMap) {
		// 멤버 idx 구하기
		MemberVO mVO = (MemberVO) session.getAttribute("member");
		// 위시리스트 (투어 idx구하기)
		List<WishListVO> wVOList = ws.getWishList(mVO);
		// 투어 정보 구하기
		List<TourVO> tVOList = new ArrayList<TourVO>();
		for(int i = 0; i < wVOList.size(); i++) {
			TourVO tVO = ts.getTourInfo(wVOList.get(i));
			tVOList.add(tVO);
		}
		System.out.println("tVOList.size() : " + tVOList.size());
		for(int i = 0; i < tVOList.size(); i++) {
			System.out.println("tVOList["+ i + "].getTour_idx : " + tVOList.get(i).getTour_idx());
		}
		// 이미지 구하기
		// 0 			1			 2			 3
		// 11111		2222222		333333		999999
		// abcde		abcdefg		abcdef		abcdef
		List<ImageVO> imgVOList = new ArrayList<ImageVO>();
		for(int i = 0; i < tVOList.size(); i++) {
			ImageVO imgVO = is.getImageByTourIdx(tVOList.get(i));
			if(imgVO == null) {
				ImageVO dummyImgVO = new ImageVO();
				dummyImgVO.setImg_big_category("tour");
				dummyImgVO.setImg_small_category(tVOList.get(i).getTour_idx());
				dummyImgVO.setImg_path("none_img1.jpg");
				imgVOList.add(dummyImgVO);
			}else {
				imgVOList.add(imgVO);
			}
			
		}
//		System.out.println("imgVOList.size() : " + imgVOList.size());
//		for(int i = 0; i < imgVOList.size(); i++) {
//			if(imgVOList.get(i).getImg_path() == null) {
//				imgVOList.get(i).setImg_path("none_img1.jpg");
//			}
//			System.out.println("imgVOList[" + i + "].getImg_path : " + imgVOList.get(i).getImg_path());
//			System.out.println("imgVOList[" + i + "].getImg_small_category : " + imgVOList.get(i).getImg_small_category());
//			
//		}
		List<MyWishListVO> mwVOList = new ArrayList<MyWishListVO>();
		for(int i = 0; i < imgVOList.size(); i++) {
			MyWishListVO mwVO = new MyWishListVO();
			mwVO.setMember_idx(mVO.getMember_idx());
			mwVO.setImg_path(imgVOList.get(i).getImg_path());
			mwVO.setTour_address(tVOList.get(i).getTour_address() + 
					(tVOList.get(i).getTour_address_detail() != null ? tVOList.get(i).getTour_address_detail() : ""));
			mwVO.setTour_fee(tVOList.get(i).getTour_fee1());
			mwVO.setTour_name(tVOList.get(i).getTour_name());
			mwVO.setTour_operation(tVOList.get(i).getTour_operation1());
			mwVO.setTour_tel(tVOList.get(i).getTour_tel());
			mwVO.setTour_idx(tVOList.get(i).getTour_idx());
			System.out.println("mwVO : " + mwVO);
			mwVOList.add(mwVO);
		}
		modelMap.addAttribute("mwVOCnt", mwVOList.size());
		modelMap.addAttribute("mwVOList", mwVOList);
		
		return "view/like_list";
	}
	// 내 관심목록
	@RequestMapping(value = "like_list_package")
	public String like_list_package(HttpSession session, ModelMap modelMap) {
		// 멤버 idx 구하기
		MemberVO mVO = (MemberVO) session.getAttribute("member");
		// 위시리스트 (패키지 idx구하기)
		List<WishListVO> wVOList = ws.getWishListPackage(mVO);
		// 패키지 정보 구하기
		List<PackageVO> pVOList = new ArrayList<PackageVO>();
		for(int i = 0; i < wVOList.size(); i++) {
			PackageVO pVO = ps.getPackageInfoByWish(wVOList.get(i));
			pVOList.add(pVO);
		}
		
		List<MyWishListVO> mwVOList = new ArrayList<MyWishListVO>();
		for(int i = 0; i < pVOList.size(); i++) {
			MyWishListVO mwVO = new MyWishListVO();
			mwVO.setMember_idx(mVO.getMember_idx());
			mwVO.setImg_path(pVOList.get(i).getPackage_thumbnail());
			mwVO.setPackage_name(pVOList.get(i).getPackage_name());
			mwVO.setPackage_idx(pVOList.get(i).getPackage_idx());
			mwVO.setP_tour_name1(pVOList.get(i).getTour_name1());
			mwVO.setP_tour_name2(pVOList.get(i).getTour_name2());
			mwVO.setP_tour_name3(pVOList.get(i).getTour_name3());
			mwVO.setP_tour_name4(pVOList.get(i).getTour_name4());
			mwVO.setP_tour_name5(pVOList.get(i).getTour_name5());
			mwVO.setPackage_price(pVOList.get(i).getPackage_price());
			mwVOList.add(mwVO);
		}
		modelMap.addAttribute("mwVOCnt", mwVOList.size());
		modelMap.addAttribute("mwVOList", mwVOList);
		
		return "view/like_list";
	}
	
	// 나의 예약현황
	@RequestMapping(value = "my_reserve")
	public String my_reserve(ModelMap modelMap, HttpSession session) {
		MemberVO mVO = (MemberVO) session.getAttribute("member");
		if(mVO != null) {
			if(mVO.getMember_grade() == 3) {
				List<ReserveVO> rVOList = rs.getReserveListAll();
				
				modelMap.addAttribute("mpVOList", rVOList);
			}else {
				List<ReserveVO> rVOList = rs.getReserveList(mVO);
				
				modelMap.addAttribute("mpVOList", rVOList);
			}
		}else {
			return "view/my_reserve";
		}
		return "view/my_reserve";
	}
	
	// 내 예약 취소
	@ResponseBody
	@RequestMapping(value = "delete_my_reserve", method = RequestMethod.POST)
	public String cancelReserve(HttpSession session ,HttpServletRequest request, @RequestParam(value = "check[]", defaultValue = "") List<String> check) {
		
		MemberVO mVO = (MemberVO) session.getAttribute("member");
		
		int cnt = 0;
		
		if(mVO.getMember_grade() == 3) {
			for(String c : check) {
				rs.cancelConfirmReserve(c);
				ReserveVO rVO = rs.getReserveForCancle(c);
				PackageVO pVO = ps.minusCnt(rVO);
				pVO.setNumber_of_reservation(pVO.getNumber_of_reservation() - rVO.getReserve_count());
				ps.changeCnt(pVO);
			}
		}else {
			for(String c : check) {
				rs.cancelReserve(c);
			}
		}
//		for(String c : check) {
//			cnt = rs.cancelReserveCnt(c);
//			cnt = cnt + cnt;
//		}
		return String.valueOf(cnt);
	}
	
	// (관리자) 예약 완료 - 입금확인
	@ResponseBody
	@RequestMapping(value = "confirm_my_reserve", method = RequestMethod.POST)
	public String confirmReserve(HttpServletRequest request, @RequestParam(value = "check[]", defaultValue = "") List<String> check) {
		int cnt = 0;
		for(String c : check) {
			rs.confirmReserve(c);
		}
//		for(String c : check) {
//			cnt = rs.cancelReserveCnt(c);
//			cnt = cnt + cnt;
//		}
		return String.valueOf(cnt);
	}
	
	
	// 내 게시글 관리
	@RequestMapping(value = "my_posting")
	public String my_posting(ModelMap modelMap, HttpSession session) {
		GalleryVO vo = new GalleryVO();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		if(mvo.getMember_grade() == 3 ) {
			List<GalleryVO> mypostingList = ms.mypostingListAll();
			for(GalleryVO gVO : mypostingList) {
				String member_id = ms.getMemberId(gVO);
				gVO.setGallery_writer(member_id);
			}
			modelMap.addAttribute("mypostingList", mypostingList);
		}else {
			vo.setMember_idx(mvo.getMember_idx());
			List<GalleryVO> mypostingList = ms.mypostingList(vo);
			modelMap.addAttribute("mypostingList", mypostingList);
		}
		
		return "view/my_posting";
	}
	@RequestMapping(value = "my_posting_notice")
	public String my_posting_notice(ModelMap modelMap, HttpSession session) {
		NoticeVO vo = new NoticeVO();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		vo.setNotice_writer(mvo.getMember_name());
		
		List<NoticeVO> mypostingList = ms.mypostingNoticeList(vo);
		modelMap.addAttribute("mypostingList", mypostingList);
		
		return "view/my_posting_notice";
	}
	@RequestMapping(value = "my_posting_event")
	public String my_posting_event(ModelMap modelMap, HttpSession session) {
		EventVO vo = new EventVO();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		vo.setEvent_homepage_writer(mvo.getMember_name());
		
		List<EventVO> mypostingList = ms.mypostingEventList(vo);
		modelMap.addAttribute("mypostingList", mypostingList);
		
		return "view/my_posting_event";
	}
	@RequestMapping(value = "my_posting_event_wellness")
	public String my_posting_event_wellness(ModelMap modelMap, HttpSession session) {
		Event_wellnessVO vo = new Event_wellnessVO();
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		vo.setEvent_wellness_writer(mvo.getMember_name());
		
		List<Event_wellnessVO> mypostingList = ms.mypostingEventWellnessList(vo);
		modelMap.addAttribute("mypostingList", mypostingList);
		
		return "view/my_posting_event_wellness";
	}
	
	// 내 게시글 선택 삭제
	@ResponseBody
	@RequestMapping(value = "delete_my_posting", method = RequestMethod.POST)
	public String delete_my_posting(HttpServletRequest request, ModelMap modelMap,
			@RequestParam(value = "check[]", defaultValue = "") List<String> check) {
		
		int cnt = 0;
		for(String c : check) {
			ms.deleteMyPosting(c);
		}
		for(String c : check) {
			cnt = ms.deleteMyPostingCnt(c);
			cnt = cnt + cnt;
		}
		return String.valueOf(cnt);
	}
	
}
