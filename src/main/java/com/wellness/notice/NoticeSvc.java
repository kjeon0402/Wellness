package com.wellness.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;

@Service
public class NoticeSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int addNotice(NoticeVO nVO) {
		return sqlSession.insert("addNotice", nVO);
	}

	public List<NoticeVO> getAllNotice(Paging pag) {
		return sqlSession.selectList("getAllNotice", pag);
	}

	public NoticeVO getDetailNotice(Object obj) {
		return sqlSession.selectOne("getDetailNotice", obj);
	}

	public int plusDetailNoticeCount(NoticeVO nVO) {
		return sqlSession.update("plusDetailNoticeCount", nVO);
	}

	public int getLastIdx() {
		return sqlSession.selectOne("getLastIdx");
	}

	public void deletenoticefile(Object objNIdx) {
		sqlSession.update("deletenoticefile", objNIdx);
	}

	public int modifyNoticePost(NoticeVO nVO) {
		return sqlSession.update("modifyNoticePost", nVO);
	}

	public String getNFile(NoticeVO nVO) {
		return sqlSession.selectOne("getNFile", nVO);
	}

	public void deleteMyPostingNotice(String c) {
		sqlSession.delete("deleteMyPostingNotice", c);
	}

	public int countContents() {
		return sqlSession.selectOne("countContents");
	}

	public int countContentsBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsBySearch", search_keyword);
	}

	public List<NoticeVO> getSearchNotice(Paging pag) {
		return sqlSession.selectList("getSearchNotice", pag);
	}


	
}
