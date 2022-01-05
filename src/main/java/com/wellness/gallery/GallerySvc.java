package com.wellness.gallery;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;

@Service
public class GallerySvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<GalleryVO> getCntBest() {
		return sqlSession.selectList("getCntBest");
	}

	public void addGallery(GalleryVO gVO) {
		sqlSession.insert("addGallery", gVO);
	}

	public int getThisIdx(GalleryVO gVO) {
		return sqlSession.selectOne("getThisIdx", gVO);
	}

	public List<GalleryVO> getGalleryAll(Paging pag) {
		return sqlSession.selectList("getGalleryAll", pag);
	}

	public GalleryVO getDetailGallery(Object obj) {
		return sqlSession.selectOne("getDetailGallery", obj);
	}

	public int plusDetailGalleryCount(GalleryVO gVO) {
		return sqlSession.update("plusDetailGalleryCount", gVO);
	}

	public int modifyPost(GalleryVO gVO) {
		return sqlSession.update("modifyPost", gVO);
	}

	public void deletegallery(Object objGIdx) {
		sqlSession.delete("deletegallery", objGIdx);
	}

	public int countContentsGallery() {
		return sqlSession.selectOne("countContentsGallery");
	}

	public int getGalleryAllForCount() {
		return sqlSession.selectOne("getGalleryAllForCount");
	}

	public int countContentsGalleryBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsGalleryBySearch", search_keyword);
	}

	public List<GalleryVO> getSearchGalleryAll(Paging pag) {
		return sqlSession.selectList("getSearchGalleryAll", pag);
	}
	
}
