package com.wellness.gallery;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.wellness.common.Paging;
import com.wellness.main.ImageSvc;
import com.wellness.main.ImageVO;
import com.wellness.main.VideoSvc;
import com.wellness.main.VideoVO;

@Controller
public class GalleryController {
	
	@Autowired
	GallerySvc galleryService;
	@Autowired
	ImageSvc imageService;
	@Autowired
	VideoSvc videoService;
	@Autowired
	CommentSvc commentService;
	
	@RequestMapping(value = "gallery_list")
	public String gallery_list(ModelMap modelMap, Paging pag,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, 
			String search_keyword) {
		
		if(search_keyword == null || search_keyword == "") {
			int total = galleryService.countContentsGallery();
			
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
			
			
			// 갤러리 테이블 불러오기 시작 ################################
			List<GalleryVO> gVOList = galleryService.getGalleryAll(pag);
			modelMap.addAttribute("gVOList", gVOList);
			// 갤러리 테이블 불러오기 완료 ################################
			
			// 이미지 테이블 불러오기 시작 ################################
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			List<VideoVO> videoVOList = new ArrayList<VideoVO>();
			for(int i = 0; i < gVOList.size(); i++) {
				List<ImageVO> imgVOListForGallery = imageService.getGalleryImage(gVOList.get(i));
				List<VideoVO> videoVOListForGallery = videoService.getGalleryVideo(gVOList.get(i));
				if(imgVOListForGallery != null) {
					imgVOList.addAll(imgVOListForGallery);
				}
				if(videoVOListForGallery != null) {
					videoVOList.addAll(videoVOListForGallery);
				}
			}
			modelMap.addAttribute("imgVOList", imgVOList);
			modelMap.addAttribute("videoVOList", videoVOList);
			// 이미지 테이블 불러오기 완료 ################################
			
			// 갤러리 테이블 총갯수 ################################
			int cntGalleryAll = galleryService.getGalleryAllForCount();
			modelMap.addAttribute("gVOListCnt", cntGalleryAll);
			// 갤러리 테이블 총갯수 ################################
		}else {
			int total = galleryService.countContentsGalleryBySearch(search_keyword);
			
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
			
			
			// 갤러리 테이블 불러오기 시작 ################################
			List<GalleryVO> gVOList = galleryService.getSearchGalleryAll(pag);
			modelMap.addAttribute("gVOList", gVOList);
			// 갤러리 테이블 불러오기 완료 ################################
			
			// 이미지 테이블 불러오기 시작 ################################
			List<ImageVO> imgVOList = new ArrayList<ImageVO>();
			List<VideoVO> videoVOList = new ArrayList<VideoVO>();
			for(int i = 0; i < gVOList.size(); i++) {
				List<ImageVO> imgVOListForGallery = imageService.getGalleryImage(gVOList.get(i));
				List<VideoVO> videoVOListForGallery = videoService.getGalleryVideo(gVOList.get(i));
				if(imgVOListForGallery != null) {
					imgVOList.addAll(imgVOListForGallery);
				}
				if(videoVOListForGallery != null) {
					videoVOList.addAll(videoVOListForGallery);
				}
			}
			modelMap.addAttribute("imgVOList", imgVOList);
			modelMap.addAttribute("videoVOList", videoVOList);
			// 이미지 테이블 불러오기 완료 ################################
			
			// 갤러리 테이블 총갯수 ################################
			int cntGalleryAll = galleryService.getGalleryAllForCount();
			modelMap.addAttribute("gVOListCnt", cntGalleryAll);
			// 갤러리 테이블 총갯수 ################################
		}
		
		return "view/gallery_list";
	}
	
	@RequestMapping(value = "gallery_write", method = RequestMethod.GET)
	public String gallery_write_get() {
		return "view/gallery_write";
	}
	@RequestMapping(value = "gallery_write", method = RequestMethod.POST)
	public String gallery_write_post(GalleryVO gVO, MultipartFile[] g_file) {
		// 갤러리 객체 확인
		System.out.println("gVO.member_idx : " + gVO.getMember_idx());
		System.out.println("gVO.gallery_title : " + gVO.getGallery_title());
		System.out.println("gVO.gallery_content : " + gVO.getGallery_content());

//		String path = "C:\\Wellness_space\\";
		String path = "Wellness_space//";
		File dir = new File(path + "gallery_file");
		if(!dir.exists()) {
			dir.mkdirs();
		}

		System.out.println("g_file.length : " + g_file.length);

		// 갤러리 테이블 추가
		galleryService.addGallery(gVO);
		
		// 추가된 갤러리 컬럼 idx 값 받기
		int gIdx = galleryService.getThisIdx(gVO);

		for(int i = 0; i < g_file.length; i++) {
			String originalFileName = g_file[i].getOriginalFilename();
			long fileSize = g_file[i].getSize();
			
			System.out.println("originalFileName : " + originalFileName);
			System.out.println("fileSize : " + fileSize);
			
			String afterDot = originalFileName.substring(originalFileName.indexOf("."));
			String sysFileName = UUID.randomUUID().toString() + afterDot;
			System.out.println("sysFileName : " + sysFileName);
			
			String saveFile = dir + File.separator + sysFileName;
			System.out.println("saveFile : " + saveFile);
			try {
				System.out.println("try 진입");
				// 파일저장
				g_file[i].transferTo(new File(saveFile));
				
				// 이미지, 비디오 테이블 추가
				ImageVO imgVO = new ImageVO();
				VideoVO videoVO = new VideoVO();
				if(afterDot.equals(".jpg") || afterDot.equals(".jpeg") || afterDot.equals(".png") || afterDot.equals(".svg") || afterDot.equals(".gif")) {
					imgVO.setImg_big_category("gallery");
					imgVO.setImg_small_category(gIdx);
					imgVO.setImg_path(sysFileName);
					imageService.addImgFile(imgVO);
				}else {
					videoVO.setVideo_big_category("gallery");
					videoVO.setVideo_small_category(gIdx);
					videoVO.setVideo_path(sysFileName);
					videoService.addVideoFile(videoVO);
				}
				
			} catch (Exception e) {
				System.out.println("ERROR MSG : " + e);
				e.printStackTrace();
			}
		}
		
		return "redirect:/gallery_list";
	}
	
	// 게시물 수정 양식
	@RequestMapping(value = "gallery_modify", method = RequestMethod.GET)
	public String gallery_modify(int no, ModelMap modelMap) {
		Object obj = no;
		GalleryVO gvo = galleryService.getDetailGallery(obj);
		modelMap.addAttribute("gvo", gvo);
		
		List<ImageVO> imgVOList = imageService.getDetailGalleryImg(gvo);
		if(imgVOList.size() != 0) {
			modelMap.addAttribute("imgVOList", imgVOList);
		}
		
		List<VideoVO> videoVOList = videoService.getDetailGalleryVideo(gvo);
		if(videoVOList.size() != 0) {
			modelMap.addAttribute("videoVOList", videoVOList);
		}
		
		return "view/gallery_modify";
	}
	
	// 게시물 수정 서브밋
	@RequestMapping(value = "gallery_modify", method = RequestMethod.POST)
	public String gallery_modify(GalleryVO gVO, MultipartFile[] g_file, HttpServletRequest request) {
		
		// 초기화 버튼 눌렀었다면
		int clear_check = Integer.parseInt(request.getParameter("clear_check"));
		System.out.println("clear_check : " + clear_check);

		int gIdx = gVO.getGallery_idx();
		Object objGIdx = gIdx;

		if(clear_check == 1) {
			System.out.println("초기화 진입");
			galleryService.deletegallery(objGIdx);
		}
		
		
		String first_file = g_file[0].getOriginalFilename();
		
		System.out.println("ㅇㅇㅇㅇㅇㅇ" + first_file);
		
		if(first_file != "") {
				
//			String path = "C:\\Wellness_space\\";
			String path = "Wellness_space//";
			File dir = new File(path + "gallery_file");
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			
			for(int i = 0; i < g_file.length; i++) {
				String originalFileName = g_file[i].getOriginalFilename();
				long fileSize = g_file[i].getSize();
				
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
					g_file[i].transferTo(new File(saveFile));
					
					// �̹���, ���� ���̺� �߰�
					ImageVO imgVO = new ImageVO();
					VideoVO videoVO = new VideoVO();
					if(afterDot.equals(".jpg") || afterDot.equals(".jpeg") || afterDot.equals(".png") || afterDot.equals(".svg") || afterDot.equals(".gif")) {
						imgVO.setImg_big_category("gallery");
						imgVO.setImg_small_category(gIdx);
						imgVO.setImg_path(sysFileName);
						imageService.addImgFile(imgVO);
					}else {
						videoVO.setVideo_big_category("gallery");
						videoVO.setVideo_small_category(gIdx);
						videoVO.setVideo_path(sysFileName);
						videoService.addVideoFile(videoVO);
					}
					
				} catch (Exception e) {
					System.out.println("ERROR MSG : " + e);
					e.printStackTrace();
				}
			}
		}
		
		int row = galleryService.modifyPost(gVO);
		if(row == 1) {
			System.out.println("수정 성공");
		} else {
			System.out.println("수정 실패");
		}
		
		return "redirect:/gallery_detail?no=" + gVO.getGallery_idx(); 
	}
	
	
	@RequestMapping(value = "gallery_detail", method = RequestMethod.GET)
	public String gallery_detail_get(int no, ModelMap modelMap) {
		// 인덱스 값 쿼리에 사용하기 위한 오브젝트화
		Object obj = no;
		// 갤러리 정보 구하기
		GalleryVO gVO = galleryService.getDetailGallery(obj);
		// 해당 인덱스 갤러리의 조회수 올리기
		int cnt = gVO.getGallery_count();
		cnt = cnt + 1;
		gVO.setGallery_count(cnt);
		int row = galleryService.plusDetailGalleryCount(gVO);
		if(row != 0) {
			System.out.println("조회수 증가 성공");
		}else {
			System.out.println("조회수 증가 실패");
		}

		modelMap.addAttribute("gVO", gVO);
		
		// 해당 인덱스 갤러리의 이미지 구하기
		List<ImageVO> imgVOList = imageService.getDetailGalleryImg(gVO);
		if(imgVOList.size() != 0) {
			modelMap.addAttribute("imgVOList", imgVOList);
		}
		
		// 해당 인덱스 갤러리의 비디오 구하기
		List<VideoVO> videoVOList = videoService.getDetailGalleryVideo(gVO);
		if(videoVOList.size() != 0) {
			modelMap.addAttribute("videoVOList", videoVOList);
		}
		
		// 해당 인덱스 갤러리의 댓글 구하기
		List<CommentVO> cmtVOList = commentService.getDetailGalleryCmt(gVO);
		if(cmtVOList.size() != 0) {
			modelMap.addAttribute("cmtVOList", cmtVOList);
		}
		
		
		return "view/gallery_detail";
	}
	
	// 댓글 등록
	@RequestMapping(value = "gallery_detail", method = RequestMethod.POST)
	public String gallery_detail_post(CommentVO vo) {
		
		int row = commentService.addComment(vo);
		if(row != 0) {
			System.out.println("댓글 등록 성공");
		}else {
			System.out.println("댓글 등록 실패");
		}
		
		return "redirect:/gallery_detail?no=" + vo.getComment_small_category();
	}
	
	// 댓글 수정
	@RequestMapping(value = "comment_update", method = RequestMethod.POST)
	public String comment_update_post(CommentVO vo) {
		
		int row = commentService.modifyComment(vo);
		if(row != 0) {
			System.out.println("댓글 수정 성공");
		}else {
			System.out.println("댓글 수정 실패");
		}
		
		return "redirect:/gallery_detail?no=" + vo.getComment_small_category();
	}
	
	// 댓글 삭제
	@RequestMapping(value = "comment_delete", method = RequestMethod.POST)
	public String comment_delete_post(CommentVO vo) {
		
		int row = commentService.deleteComment(vo);
		if(row != 0) {
			System.out.println("댓글 삭제 성공");
		}else {
			System.out.println("댓글 삭제 실패");
		}
		
		return "redirect:/gallery_detail?no=" + vo.getComment_small_category();
	}
	
}
