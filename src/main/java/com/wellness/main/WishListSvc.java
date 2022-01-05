package com.wellness.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.member.MemberVO;
import com.wellness.package_tour.PackageVO;
import com.wellness.tour.TourVO;

@Service
public class WishListSvc {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getLikeCnt(TourVO tourVO) {
		return sqlSession.selectOne("getLikeCnt", tourVO);
	}

	public int getLikeCntAboutCateogry(TourVO tourVO) {
		return sqlSession.selectOne("getLikeCntAboutCateogry", tourVO);
	}

	public void addWishList(WishListVO wlVO) {
		sqlSession.insert("addWishList", wlVO);
	}

	public void deleteWishList(WishListVO wlVO) {
		sqlSession.delete("deleteWishList", wlVO);
	}

	public List<WishListVO> getMemberLike(MemberVO mVO) {
		return sqlSession.selectList("getMemberLike", mVO);
	}
	
	public List<WishListVO> getWishList(MemberVO mVO) {
		return sqlSession.selectList("getWishList", mVO);
	}

	public List<WishListVO> getMemberLikePackage(MemberVO mVO) {
		return sqlSession.selectList("getMemberLikePackage", mVO);
	}

	public int getLikeCntPackage(PackageVO packageVO) {
		return sqlSession.selectOne("getLikeCntPackage", packageVO);
	}

	public List<WishListVO> getWishListPackage(MemberVO mVO) {
		return sqlSession.selectList("getWishListPackage", mVO);
	}
}
