package com.wellness.member;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.event.EventVO;
import com.wellness.event_wellness.Event_wellnessVO;
import com.wellness.gallery.GalleryVO;
import com.wellness.notice.NoticeVO;

@Service
public class MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public void join(MemberVO vo) {
		sqlSession.insert("join", vo);
	}

	public MemberVO login(MemberVO vo) {
		return sqlSession.selectOne("login", vo);
	}

	public int idCheck(String id) {
		return sqlSession.selectOne("idCheck", id);
	}

	public MemberVO findIdByEmail(FindIdVO vo) {
		return sqlSession.selectOne("findIdByEmail", vo);
	}

	public MemberVO findIdByPhone(FindIdVO vo) {
		return sqlSession.selectOne("findIdByPhone", vo);
	}

	public MemberVO findPwByEmailpw(FindPwVO vo) {
		return sqlSession.selectOne("findPwByEmailpw", vo);
	}

	public MemberVO findIdByPhonepw(FindPwVO vo) {
		return sqlSession.selectOne("findPwByPhonepw", vo);
	}

	public int changepw(ChangePwVO vo) {
		return sqlSession.update("changepw", vo);
	}

	public int changePersonnal(MemberVO vo) {
		return sqlSession.update("changePersonnal", vo);
	}

	public int findPwResult(ChangePwVO vo) {
		return sqlSession.update("findPwResult", vo);
	}
	
	public List<GalleryVO> mypostingList(GalleryVO vo) {
		return sqlSession.selectList("mypostingList", vo);
	}

	public void dropMember(MemberVO mvo) {
		sqlSession.delete("dropMember", mvo);
	}

	public void deleteMyPosting(String check) {
		sqlSession.delete("deleteMyPosting", check);
	}

	public int deleteMyPostingCnt(String check) {
		return sqlSession.selectOne("deleteMyPostingCnt", check);
	}

	public List<NoticeVO> mypostingNoticeList(NoticeVO vo) {
		return sqlSession.selectList("mypostingNoticeList", vo);
	}

	public List<EventVO> mypostingEventList(EventVO vo) {
		return sqlSession.selectList("mypostingEventList", vo);
	}

	public List<Event_wellnessVO> mypostingEventWellnessList(Event_wellnessVO vo) {
		return sqlSession.selectList("mypostingEventWellnessList", vo);
	}

	public List<GalleryVO> mypostingListAll() {
		return sqlSession.selectList("mypostingListAll");
	}

	public String getMemberId(GalleryVO gVO) {
		return sqlSession.selectOne("getMemberId", gVO);
	}

	public String Find_member(MemberVO mvo) {
		return sqlSession.selectOne("Find_member", mvo);
	}

	public MemberVO Find_member_pw(MemberVO mvo) {
		return sqlSession.selectOne("Find_member_pw", mvo);
	}

	public MemberVO findPwByPhone(FindPwVO vo) {
		return sqlSession.selectOne("findPwByPhone", vo);
	}

	public MemberVO findIdByEmailpw(FindPwVO vo) {
		return sqlSession.selectOne("findIdByEmailpw", vo);
	}
}
