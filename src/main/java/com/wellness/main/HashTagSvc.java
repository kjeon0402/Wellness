package com.wellness.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.tour.TourVO;


@Service
public class HashTagSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<HashTagVO> getHashTagForPopularTourist(GetLikeCntVO getLikeCntVO) {
		return sqlSession.selectList("getHashTagForPopularTourist", getLikeCntVO);
	}

	public List<HashTagVO> getDetailTourHash(TourVO detailVO) {
		return sqlSession.selectList("getDetailTourHash", detailVO);
	}

	public List<HashTagVO> getDetailPackageTourHash(TourVO tVO) {
		return sqlSession.selectList("getDetailPackageTourHash", tVO);
	}


}
