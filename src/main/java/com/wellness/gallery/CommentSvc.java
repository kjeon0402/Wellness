package com.wellness.gallery;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentSvc {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int addComment(CommentVO vo) {
		return sqlSession.insert("addComment", vo);
	}

	public List<CommentVO> getDetailGalleryCmt(GalleryVO gVO) {
		return sqlSession.selectList("getDetailGalleryCmt", gVO);
	}

	public int modifyComment(CommentVO vo) {
		return sqlSession.update("modifyComment", vo);
	}

	public int deleteComment(CommentVO vo) {
		return sqlSession.delete("deleteComment", vo);
	}
	
	
}
