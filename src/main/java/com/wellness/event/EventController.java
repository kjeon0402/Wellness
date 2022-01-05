package com.wellness.event;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellness.common.Paging;
import com.wellness.event_wellness.Event_wellnessVO;
import com.wellness.gallery.GalleryVO;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.VideoSvc;
import com.wellness.main.VideoVO;
import com.wellness.notice.NoticeVO;

@Controller
public class EventController {
	
	@Autowired
	EventSvc eventService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	VideoSvc videoService;
	
	@RequestMapping(value = "event")
	public String event(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		
		if(search_keyword == null || search_keyword == "") {
			int total = eventService.countContentsEvent();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			
			List<EventVO> eVOList = eventService.getAllEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
		}else {
			int total = eventService.countContentsEventBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			modelMap.addAttribute("paging", pag);
			
			
			List<EventVO> eVOList = eventService.getSearchEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
			
		}
		
		return "view/event";
	}
	@RequestMapping(value = "event_doing")
	public String event_doing(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = eventService.countContentsEvent();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			
			List<EventVO> eVOList = eventService.getDoingEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
		}else {
			int total = eventService.countContentsEventBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			modelMap.addAttribute("paging", pag);
			
			
			List<EventVO> eVOList = eventService.getSearchDoingEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
		}
		
		return "view/event";
	}
	@RequestMapping(value = "event_end")
	public String event_end(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = eventService.countContentsEvent();
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			modelMap.addAttribute("paging", pag);
			
			
			
			List<EventVO> eVOList = eventService.getEndEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
		}else {
			int total = eventService.countContentsEventBySearch(search_keyword);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "12";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if(cntPerPage == null) {
				cntPerPage = "12";
			}
			
			pag = new Paging(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			pag.setSearch_keyword(search_keyword);
			modelMap.addAttribute("paging", pag);
			
			
			
			List<EventVO> eVOList = eventService.getSearchEndEvent(pag);
			modelMap.addAttribute("eVOList", eVOList);
			
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			for(int i = 0; i < eVOList.size(); i++) {
				ImageVO imgVO = imageService.getEventImg(eVOList.get(i));
				imgVOList.add(imgVO);
			}
			
			modelMap.addAttribute("imgVOList", imgVOList);
		}
		
		return "view/event";
	}
	
	@RequestMapping(value = "event_detail")
	public String event_detail(int no, ModelMap modelMap) {
		Object obj = no;
		EventVO eVO = eventService.getDetailEvent(obj);
		ImageVO imgVO = imageService.getDetailEventImg(eVO);
		
		int cnt = eVO.getEvent_homepage_count();
		cnt = cnt + 1;
		
		eVO.setEvent_homepage_count(cnt);
		
		int row = eventService.plusDetailEventCount(eVO);
		if(row != 0) {
			System.out.println("조회수 증가 성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
		modelMap.addAttribute("eVO", eVO);
		modelMap.addAttribute("imgVO", imgVO);
		
		return "view/event_detail";
	}
	
	@RequestMapping(value = "event_write", method = RequestMethod.GET)
	public String event_write_get() {
		return "view/event_write";
	}
	@RequestMapping(value = "event_write", method = RequestMethod.POST)
	public String event_write_post(EventVO eVO, MultipartHttpServletRequest request) {
		
		String rootUploadDir = "Wellness_space";
		File dir = new File(rootUploadDir + File.separator + "eventimg");
		if(!dir.exists()) {
			dir.mkdirs();
		}
		Iterator<String> iterator = request.getFileNames();
		int fileLoop = 0;
		String uploadFileName;
		MultipartFile mFile = null;
		String orgFileName = "";
		String sysFileName = "";
		
		while(iterator.hasNext()) {
			fileLoop++;
			uploadFileName = iterator.next();
			mFile = request.getFile(uploadFileName);
			orgFileName = mFile.getOriginalFilename();
			System.out.println("orgFileName : " + orgFileName);
			if(orgFileName.equals("")) {
				break;
			}
			String afterDot = orgFileName.substring(orgFileName.indexOf("."));
			System.out.println("afterDot : " + afterDot);
			if(orgFileName != null && orgFileName.length() != 0) {
				sysFileName = UUID.randomUUID().toString() + afterDot;
				System.out.println("sysFileName : " + sysFileName);
				try {
					mFile.transferTo(new File(dir + File.separator + sysFileName));
				}catch (Exception e) {
					System.out.println("ERROR MSG : " + e);
				}
			}
		}
		int row = eventService.addEvent(eVO);
		System.out.println("row : " + row);
		
		int eIdx = eventService.getEventThisIdx(eVO);
		
		ImageVO imgVO = new ImageVO();
		imgVO.setImg_big_category("event_homepage");
		imgVO.setImg_small_category(eIdx);
		imgVO.setImg_path(sysFileName);
		imageService.addEventImg(imgVO);
		
		
		if(row == 1) {
			System.out.println("이벤트 등록 성공");
			return "redirect:/event";
		}else {
			System.out.println("이벤트 등록 실패");
			return "redirect:/event";
		}
	}
	
	
	// 게시물 수정 양식
	@RequestMapping(value = "event_modify", method = RequestMethod.GET)
	public String event_modify_get(int no, ModelMap modelMap) {
		Object obj = no;
		EventVO evo = eventService.getDetailEvent(obj);
		modelMap.addAttribute("evo", evo);
		
		ImageVO imgVO = imageService.getDetailEventImg(evo);
		if(imgVO != null) {
			modelMap.addAttribute("imgVO", imgVO);
		}
		
		
		return "view/event_modify";
	}
	
	// 게시물 수정 서브밋
	@RequestMapping(value = "event_modify", method = RequestMethod.POST)
	public String event_modify_post(EventVO eVO, MultipartFile[] i_file, HttpServletRequest request) {
		// 초기화 버튼 눌렀었다면
		int clear_check = Integer.parseInt(request.getParameter("clear_check"));
		System.out.println("clear_check : " + clear_check);

		Object objEIdx = eVO.getEvent_homepage_idx();

		if(clear_check == 1) {
			System.out.println("초기화 진입");
			imageService.deleteeventfile(objEIdx);
		}
		
		
		String first_file = i_file[0].getOriginalFilename();
		
		System.out.println("ㅇㅇㅇㅇㅇㅇ" + first_file);
		
		if(first_file != "") {
				
//			String path = "C:\\Wellness_space\\";
			String path = "Wellness_space//";
			File dir = new File(path + "eventimg");
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			
			for(int i = 0; i < i_file.length; i++) {
				String originalFileName = i_file[i].getOriginalFilename();
				long fileSize = i_file[i].getSize();
				
				System.out.println("originalFileName : " + originalFileName);
				System.out.println("fileSize : " + fileSize);
				
				String afterDot = originalFileName.substring(originalFileName.indexOf("."));
				String sysFileName = UUID.randomUUID().toString() + afterDot;
				System.out.println("sysFileName : " + sysFileName);
				
				String saveFile = dir + File.separator + sysFileName;
				System.out.println("saveFile : " + saveFile);
				try {
					System.out.println("try ����");
					// ��������
					i_file[i].transferTo(new File(saveFile));
					
					ImageVO eventImg = imageService.getDetailEventImg(eVO);
					if(eventImg == null) {
						ImageVO dummyVO = new ImageVO();
						dummyVO.setImg_big_category("event_homepage");
						dummyVO.setImg_small_category(eVO.getEvent_homepage_idx());
						dummyVO.setImg_path(sysFileName);
						imageService.addEventImg(dummyVO);
					}else {
						eventImg.setImg_path(sysFileName);
						imageService.updateEventImg(eventImg);
					}
				} catch (Exception e) {
					System.out.println("ERROR MSG : " + e);
					e.printStackTrace();
				}
			}
		}
		
		int row = eventService.modifyEventPost(eVO);
		if(row == 1) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return "redirect:/event_detail?no=" + eVO.getEvent_homepage_idx(); 
	}
	
	// 내 게시글 선택 삭제
	@ResponseBody
	@RequestMapping(value = "delete_my_posting_event", method = RequestMethod.POST)
	public String delete_my_posting_event(HttpServletRequest request, ModelMap modelMap,
			@RequestParam(value = "check[]", defaultValue = "") List<String> check) {
			
		int cnt = 0;
		for(String c : check) {
			eventService.deleteMyPostingEvent(c);
		}
//			for(String c : check) {
//				cnt = noticeService.deleteMyPostingCntNotice(c);
//				cnt = cnt + cnt;
//			}
		return String.valueOf(cnt);
	}
	
}
