package com.wellness.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.gallery.GalleryVO;
import com.wellness.notice.NoticeVO;

@Service
public class VideoSvc {

	@Autowired
	SqlSessionTemplate sqlSession;

	public void addVideoFile(VideoVO videoVO) {
		sqlSession.insert("addVideoFile", videoVO);
	}

	public List<VideoVO> getGalleryVideo(GalleryVO galleryVO) {
		return sqlSession.selectList("getGalleryVideo", galleryVO);
	}

	public List<VideoVO> getDetailGalleryVideo(GalleryVO gVO) {
		return sqlSession.selectList("getDetailGalleryVideo", gVO);
	}

	public VideoVO getGalleryVideoBest(GalleryVO galleryVO) {
		return sqlSession.selectOne("getGalleryVideoBest", galleryVO);
	}

}
