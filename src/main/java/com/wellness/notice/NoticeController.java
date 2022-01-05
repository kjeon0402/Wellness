package com.wellness.notice;

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
import com.wellness.gallery.GalleryVO;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.VideoSvc;
import com.wellness.main.VideoVO;

@Controller
public class NoticeController {

	@Autowired
	NoticeSvc noticeService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	VideoSvc videoService;
	
	
	@RequestMapping(value = "notice")
	public String notice(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = noticeService.countContents();
			
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
			
			
			// 공지 글 불러오기 시작 ###################################################
			List<NoticeVO> nVOList = noticeService.getAllNotice(pag);
			modelMap.addAttribute("noticeList", nVOList);
			// 공지 글 불러오기 완료 ###################################################
		}else {
			int total = noticeService.countContentsBySearch(search_keyword);
			
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
			
			
			// 공지 글 불러오기 시작 ###################################################
			List<NoticeVO> nVOList = noticeService.getSearchNotice(pag);
			modelMap.addAttribute("noticeList", nVOList);
			// 공지 글 불러오기 완료 ###################################################
		}
		
		System.out.println("search_keyword : " + search_keyword);
		return "view/notice";
	}
	
	@RequestMapping(value = "notice_detail", method = RequestMethod.GET)
	public String notice_detail(int no, ModelMap modelMap) {
		// 공지 detail 불러오기 시작 ###############################################
		Object obj = no;
		NoticeVO nVO = noticeService.getDetailNotice(obj);
		// 해당 인덱스 갤러리의 조회수 올리기
		int cnt = nVO.getNotice_count();
		cnt = cnt + 1;
		nVO.setNotice_count(cnt);
		int row = noticeService.plusDetailNoticeCount(nVO);
		if(row != 0) {
			System.out.println("조회수 증가 성공");
		}else {
			System.out.println("조회수 증가 실패");
		}
		
		modelMap.addAttribute("noticeVO", nVO);
		// 공지 detail 불러오기 완료 ###############################################
		
		int lastIdx = noticeService.getLastIdx();
		modelMap.addAttribute("lastIdx", lastIdx);
		
		return "view/notice_detail";
	}

	@RequestMapping(value = "notice_write", method = RequestMethod.GET)
	public String notice_write_get() {
		return "view/notice_write";
	}

	@RequestMapping(value = "notice_write", method = RequestMethod.POST)
	public String notice_write_post(NoticeVO nVO, MultipartHttpServletRequest request) {
		
		
		
//		String rootUploadDir = "C:" + File.separator + "Wellness_space";
		String rootUploadDir = "Wellness_space";
		File dir = new File(rootUploadDir + File.separator + "noticeimg");
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
		
		nVO.setNotice_file(sysFileName);
		
		int row = noticeService.addNotice(nVO);
		System.out.println("row : " + row);
		if(row == 1) {
			System.out.println("공지사항 등록 성공");
			return "redirect:/notice";
		}else {
			System.out.println("공지사항 등록 실패");
			return "redirect:/notice";
		}
	}
	
	// 게시물 수정 양식
	@RequestMapping(value = "notice_modify", method = RequestMethod.GET)
	public String notice_modify_get(int no, ModelMap modelMap) {
		Object obj = no;
		NoticeVO nvo = noticeService.getDetailNotice(obj);
		modelMap.addAttribute("nvo", nvo);
		
		return "view/notice_modify";
	}
	
	// 게시물 수정 서브밋
	@RequestMapping(value = "notice_modify", method = RequestMethod.POST)
	public String notice_modify_post(NoticeVO nVO, MultipartFile[] i_file, HttpServletRequest request) {
		
		String nFile = noticeService.getNFile(nVO);
		
		// 초기화 버튼 눌렀었다면
		int clear_check = Integer.parseInt(request.getParameter("clear_check"));
		System.out.println("clear_check : " + clear_check);

//		int nIdx = nVO.getNotice_idx();
		Object objNIdx = nVO.getNotice_idx();

		if(clear_check == 1) {
			System.out.println("초기화 진입");
			noticeService.deletenoticefile(objNIdx);
		}else {
			nVO.setNotice_file(nFile);
		}
		
		
		String first_file = i_file[0].getOriginalFilename();
		
		System.out.println("ㅇㅇㅇㅇㅇㅇ" + first_file);
		
		if(first_file != "") {
				
//			String path = "C:\\Wellness_space\\";
			String path = "Wellness_space//";
			File dir = new File(path + "noticeimg");
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
					nVO.setNotice_file(sysFileName);
					// �̹���, ���� ���̺� �߰�
//					ImageVO imgVO = new ImageVO();
//					VideoVO videoVO = new VideoVO();
//					if(afterDot.equals(".jpg") || afterDot.equals(".jpeg") || afterDot.equals(".png") || afterDot.equals(".svg") || afterDot.equals(".gif")) {
//						imgVO.setImg_big_category("gallery");
//						imgVO.setImg_small_category(nIdx);
//						imgVO.setImg_path(sysFileName);
//						imageService.addImgFile(imgVO);
//					}else {
//						videoVO.setVideo_big_category("gallery");
//						videoVO.setVideo_small_category(gIdx);
//						videoVO.setVideo_path(sysFileName);
//						videoService.addVideoFile(videoVO);
//					}
					
				} catch (Exception e) {
					System.out.println("ERROR MSG : " + e);
					e.printStackTrace();
				}
			}
		}
		
		int row = noticeService.modifyNoticePost(nVO);
		if(row == 1) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return "redirect:/notice_detail?no=" + nVO.getNotice_idx(); 
	}
	
	// 내 게시글 선택 삭제
	@ResponseBody
	@RequestMapping(value = "delete_my_posting_notice", method = RequestMethod.POST)
	public String delete_my_posting_notice(HttpServletRequest request, ModelMap modelMap,
			@RequestParam(value = "check[]", defaultValue = "") List<String> check) {
		
		int cnt = 0;
		for(String c : check) {
			noticeService.deleteMyPostingNotice(c);
		}
//		for(String c : check) {
//			cnt = noticeService.deleteMyPostingCntNotice(c);
//			cnt = cnt + cnt;
//		}
		return String.valueOf(cnt);
	}
	
}
