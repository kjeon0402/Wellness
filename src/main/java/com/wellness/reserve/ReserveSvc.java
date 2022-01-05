package com.wellness.reserve;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.member.MemberVO;

@Service
public class ReserveSvc {
	
	@Autowired SqlSessionTemplate sqlSession;

	public List<ReserveVO> getReserveList(MemberVO mvo) {
		return sqlSession.selectList("getReserveList", mvo);
	}

	public ReserveVO getReserveInfo(ReserveVO rVOList) {
		return sqlSession.selectOne("getReserveInfo", rVOList);
	}

	public List<ReserveVO> getReserveinfo2(ReserveVO reserveVO) {
		return sqlSession.selectList("getReserveinfo2", reserveVO);
	}
	
	public void cancelReserve(String check) {
		sqlSession.update("cancelReserve", check);
	}

	public int cancelReserveCnt(String check) {
		return sqlSession.selectOne("cancelReserveCnt", check);
	}

	public int addReserve(ReserveVO rVO) {
		return sqlSession.insert("addReserve", rVO);
	}

	public List<ReserveVO> getReserveListAll() {
		return sqlSession.selectList("getReserveListAll");
	}

	public void confirmReserve(String c) {
		sqlSession.update("confirmReserve", c);
	}

	public void cancelConfirmReserve(String c) {
		sqlSession.update("cancelConfirmReserve", c);
	}

	public ReserveVO getReserveForCancle(String c) {
		return sqlSession.selectOne("getReserveForCancle", c);
	}
}
