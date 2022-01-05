package com.wellness.event_wellness;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;

@Service
public class Event_wellnessSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int addEventWellness(Event_wellnessVO e_wVO) {
		return sqlSession.insert("addEventWellness", e_wVO);
	}

	public int getEventWellnessThisIdx(Event_wellnessVO e_wVO) {
		return sqlSession.selectOne("getEventWellnessThisIdx", e_wVO);
	}

	public List<Event_wellnessVO> getAllEventWellness(Paging pag) {
		return sqlSession.selectList("getAllEventWellness", pag);
	}

	public Event_wellnessVO getDetailEventWellness(Object obj) {
		return sqlSession.selectOne("getDetailEventWellness", obj);
	}

	public int plusDetailEventWellnessCount(Event_wellnessVO e_wVO) {
		return sqlSession.update("plusDetailEventWellnessCount", e_wVO);
	}

	public int modifyEventWellnessPost(Event_wellnessVO ewVO) {
		return sqlSession.update("modifyEventWellnessPost", ewVO);
	}

	public int countContentsEventWellness() {
		return sqlSession.selectOne("countContentsEventWellness");
	}

	public int countContentsEventWellnessBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsEventWellnessBySearch", search_keyword);
	}

	public List<Event_wellnessVO> getSearchEventWellness(Paging pag) {
		return sqlSession.selectList("getSearchEventWellness", pag);
	}
}
