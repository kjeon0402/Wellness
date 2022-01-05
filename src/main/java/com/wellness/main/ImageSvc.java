package com.wellness.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.event.EventVO;
import com.wellness.event_wellness.Event_wellnessVO;
import com.wellness.gallery.GalleryVO;
import com.wellness.notice.NoticeVO;
import com.wellness.tour.TourVO;

@Service
public class ImageSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ImageVO getTopSixImage(GetLikeCntVO getLikeCntVO) {
		return sqlSession.selectOne("getTopSixImage", getLikeCntVO);
	}

	public ImageVO getGalleryImgBest(GalleryVO galleryVO) {
		return sqlSession.selectOne("getGalleryImgBest", galleryVO);
	}

	public ImageVO getImageNature(TourVO tourVO) {
		return sqlSession.selectOne("getImageNature", tourVO);
	}

	public ImageVO getImageOcean(TourVO tourVO) {
		return sqlSession.selectOne("getImageOcean", tourVO);
	}

	public ImageVO getImageCosmetic(TourVO tourVO) {
		return sqlSession.selectOne("getImageCosmetic", tourVO);
	}

	public ImageVO getImageMeal(TourVO tourVO) {
		return sqlSession.selectOne("getImageMeal", tourVO);
	}

	public ImageVO getImageHotel(TourVO tourVO) {
		return sqlSession.selectOne("getImageHotel", tourVO);
	}

	public List<ImageVO> getDetailTourImage(TourVO detailVO) {
		return sqlSession.selectList("getDetailTourImage", detailVO);
	}

	public void addImgFile(ImageVO imgVO) {
		sqlSession.insert("addImgFile", imgVO);
	}

	public List<ImageVO> getGalleryImage(GalleryVO galleryVO) {
		return sqlSession.selectList("getGalleryImage", galleryVO);
	}

	public List<ImageVO> getDetailGalleryImg(GalleryVO gVO) {
		return sqlSession.selectList("getDetailGalleryImg", gVO);
	}

	public ImageVO getImageByTourIdx(TourVO tourVO) {
		return sqlSession.selectOne("getImageByTourIdx", tourVO);
	}

	public void addEventWellnessImg(ImageVO imgVO) {
		sqlSession.insert("addEventWellnessImg", imgVO);
	}

	public ImageVO getDetailEventWellnessImg(Event_wellnessVO e_wVO) {
		return sqlSession.selectOne("getDetailEventWellnessImg", e_wVO);
	}

	public void addEventImg(ImageVO imgVO) {
		sqlSession.insert("addEventImg", imgVO);
	}

	public ImageVO getEventImg(EventVO eventVO) {
		return sqlSession.selectOne("getEventImg", eventVO);
	}

	public ImageVO getDetailEventImg(EventVO eVO) {
		return sqlSession.selectOne("getDetailEventImg", eVO);
	}

	public List<ImageVO> getDetailPackageTourImg(TourVO tVO) {
		return sqlSession.selectList("getDetailPackageTourImg", tVO);
	}

	public List<ImageVO> getDetailNoticeImg(NoticeVO nvo) {
		return sqlSession.selectList("getDetailNoticeImg", nvo);
	}

	public String getEFile(EventVO eVO) {
		return sqlSession.selectOne("getEFile", eVO);
	}

	public void deleteeventfile(Object objEIdx) {
		sqlSession.delete("deleteeventfile", objEIdx);
	}

	public void updateEventImg(ImageVO eventImg) {
		sqlSession.update("updateEventImg", eventImg);
	}

	public void deleteeventwellnessfile(Object objEWIdx) {
		sqlSession.delete("deleteeventwellnessfile", objEWIdx);
	}





}
