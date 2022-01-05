package com.wellness.event_wellness;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellness.common.Paging;
import com.wellness.event.EventVO;
import com.wellness.gallery.GalleryVO;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.VideoVO;

@Controller
public class Event_wellnessController {
	
	@Autowired
	Event_wellnessSvc e_wService;
	@Autowired
	ImageSvc imageService;
	
	@RequestMapping(value = "event_wellness")
	public String event_wellness(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = e_wService.countContentsEventWellness();
			
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
			
			
			List<Event_wellnessVO> e_wVOList = e_wService.getAllEventWellness(pag);
			modelMap.addAttribute("e_wVOList", e_wVOList);
		}else {
			int total = e_wService.countContentsEventWellnessBySearch(search_keyword);
			
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
			
			
			List<Event_wellnessVO> e_wVOList = e_wService.getSearchEventWellness(pag);
			modelMap.addAttribute("e_wVOList", e_wVOList);
		}
		
		return "view/event_wellness";
	}
	
	@RequestMapping(value = "event_wellness_detail")
	public String event_wellness_detail(int no, ModelMap modelMap) {
		Object obj = no;
		Event_wellnessVO e_wVO = e_wService.getDetailEventWellness(obj);
		ImageVO imgVO = imageService.getDetailEventWellnessImg(e_wVO);
		
		int cnt = e_wVO.getEvent_wellness_count();
		cnt = cnt + 1;
		
		e_wVO.setEvent_wellness_count(cnt);
		
		int row = e_wService.plusDetailEventWellnessCount(e_wVO);
		if(row != 0) {
			System.out.println("조회수 증가 성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
		modelMap.addAttribute("e_wVO", e_wVO);
		modelMap.addAttribute("imgVO", imgVO);
		
		return "view/event_wellness_detail";
	}
	
	@RequestMapping(value = "event_wellness_write", method = RequestMethod.GET)
	public String event_wellness_write_get() {
		return "view/event_wellness_write";
	}
	
	@RequestMapping(value = "event_wellness_write", method = RequestMethod.POST)
	public String event_wellness_write_post(Event_wellnessVO e_wVO, MultipartHttpServletRequest request) {
//		String rootUploadDir = "C:" + File.separator + "Wellness_space";
		String rootUploadDir = "Wellness_space";
		File dir = new File(rootUploadDir + File.separator + "eventwellnessimg");
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
		int row = e_wService.addEventWellness(e_wVO);
		System.out.println("row : " + row);
		
		int e_wIdx = e_wService.getEventWellnessThisIdx(e_wVO);
		
		ImageVO imgVO = new ImageVO();
		imgVO.setImg_big_category("event_wellness");
		imgVO.setImg_small_category(e_wIdx);
		imgVO.setImg_path(sysFileName);
		imageService.addEventWellnessImg(imgVO);
		
		
		if(row == 1) {
			System.out.println("웰니스 행사 등록 성공");
			return "redirect:/event_wellness";
		}else {
			System.out.println("웰니스 행사 등록 실패");
			return "redirect:/event_wellness";
		}
	}
	
	// 게시물 수정 양식
	@RequestMapping(value = "event_wellness_modify", method = RequestMethod.GET)
	public String event_wellness_modify_get(int no, ModelMap modelMap) {
		Object obj = no;
		Event_wellnessVO e_wvo = e_wService.getDetailEventWellness(obj);
		modelMap.addAttribute("e_wvo", e_wvo);
		
		ImageVO imgVO = imageService.getDetailEventWellnessImg(e_wvo);
		if(imgVO != null) {
			modelMap.addAttribute("imgVO", imgVO);
		}
		
		return "view/event_wellness_modify";
	}
	
	// 게시물 수정 서브밋
	@RequestMapping(value = "event_wellness_modify", method = RequestMethod.POST)
	public String event_wellness_modify_post(Event_wellnessVO ewVO, MultipartFile[] i_file, HttpServletRequest request) {
		// 초기화 버튼 눌렀었다면
		int clear_check = Integer.parseInt(request.getParameter("clear_check"));
		System.out.println("clear_check : " + clear_check);

		Object objEWIdx = ewVO.getEvent_wellness_idx();

		if(clear_check == 1) {
			System.out.println("초기화 진입");
			imageService.deleteeventwellnessfile(objEWIdx);
		}
		
		
		String first_file = i_file[0].getOriginalFilename();
		
		System.out.println("ㅇㅇㅇㅇㅇㅇ" + first_file);
		
		if(first_file != "") {
				
//			String path = "C:\\Wellness_space\\";
			String path = "Wellness_space//";
			File dir = new File(path + "eventwellnessimg");
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
					
					ImageVO eventWellnessImg = imageService.getDetailEventWellnessImg(ewVO);
					if(eventWellnessImg == null) {
						ImageVO dummyVO = new ImageVO();
						dummyVO.setImg_big_category("event_wellness");
						dummyVO.setImg_small_category(ewVO.getEvent_wellness_idx());
						dummyVO.setImg_path(sysFileName);
						imageService.addEventWellnessImg(dummyVO);
					}else {
						eventWellnessImg.setImg_path(sysFileName);
						imageService.updateEventImg(eventWellnessImg);
					}
				} catch (Exception e) {
					System.out.println("ERROR MSG : " + e);
					e.printStackTrace();
				}
			}
		}
		
		int row = e_wService.modifyEventWellnessPost(ewVO);
		if(row == 1) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return "redirect:/event_wellness_detail?no=" + ewVO.getEvent_wellness_idx(); 
	}
}
