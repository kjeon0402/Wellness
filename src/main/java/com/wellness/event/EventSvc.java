package com.wellness.event;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;

@Service
public class EventSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int addEvent(EventVO eVO) {
		return sqlSession.insert("addEvent", eVO);
	}

	public int getEventThisIdx(EventVO eVO) {
		return sqlSession.selectOne("getEventThisIdx", eVO);
	}

	public List<EventVO> getAllEvent(Paging pag) {
		return sqlSession.selectList("getAllEvent", pag);
	}

	public EventVO getDetailEvent(Object obj) {
		return sqlSession.selectOne("getDetailEvent", obj);
	}

	public int plusDetailEventCount(EventVO eVO) {
		return sqlSession.update("plusDetailEventCount", eVO);
	}

	public int modifyEventPost(EventVO eVO) {
		return sqlSession.update("modifyEventPost", eVO);
	}

	public void deleteMyPostingEvent(String c) {
		sqlSession.delete("deleteMyPostingEvent", c);
	}

	public List<EventVO> getDoingEvent(Paging pag) {
		return sqlSession.selectList("getDoingEvent", pag);
	}

	public List<EventVO> getEndEvent(Paging pag) {
		return sqlSession.selectList("getEndEvent", pag);
	}

	public void settingN(EventVO eVO) {
		sqlSession.update("settingN", eVO);
	}
	public void settingY(EventVO eVO) {
		sqlSession.update("settingY", eVO);
	}
	public void settingE(EventVO eVO) {
		sqlSession.update("settingE", eVO);
	}

	public int countContentsEvent() {
		return sqlSession.selectOne("countContentsEvent");
	}

	public List<EventVO> getAllEventForHome() {
		return sqlSession.selectList("getAllEventForHome");
	}

	public int countContentsEventBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsEventBySearch", search_keyword);
	}

	public List<EventVO> getSearchEvent(Paging pag) {
		return sqlSession.selectList("getSearchEvent", pag);
	}

	public List<EventVO> getSearchDoingEvent(Paging pag) {
		return sqlSession.selectList("getSearchDoingEvent", pag);
	}

	public List<EventVO> getSearchEndEvent(Paging pag) {
		return sqlSession.selectList("getSearchEndEvent", pag);
	}
}
