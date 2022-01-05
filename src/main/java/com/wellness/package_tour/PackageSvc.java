package com.wellness.package_tour;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;
import com.wellness.main.GetLikeCntVO;
import com.wellness.main.WishListVO;
import com.wellness.reserve.ReserveVO;
import com.wellness.tour.TourVO;

@Service
public class PackageSvc {
	
	@Autowired SqlSessionTemplate sqlSession;

	public PackageVO getPackageInfo(ReserveVO reserveVO) {
		return sqlSession.selectOne("getPackageInfo", reserveVO);
	}

	public List<PackageVO> getPackage(Object obj) {
		return sqlSession.selectList("getPackage", obj);
	}

	public int getLikePackageIdx(PackageVO pVO) {
		return sqlSession.selectOne("getLikePackageIdx", pVO);
	}

	public PackageVO getPopularPackage(GetLikeCntVO getLikeCntVO) {
		return sqlSession.selectOne("getPopularPackage", getLikeCntVO);
	}

	public PackageVO getDetailPackage(Object obj) {
		return sqlSession.selectOne("getDetailPackage", obj);
	}

	public List<PackageVO> getPackageByTourname(TourVO tourVO) {
		return sqlSession.selectList("getPackageByTourname", tourVO);
	}

	public PackageVO getPackageInfoByWish(WishListVO wishListVO) {
		return sqlSession.selectOne("getPackageInfoByWish", wishListVO);
	}

	public PackageVO getDetailPackageForReserve(ReserveVO rVO) {
		return sqlSession.selectOne("getDetailPackageForReserve", rVO);
	}

	public void plusCnt(PackageVO pVO) {
		sqlSession.update("plusCnt", pVO);
	}

	public PackageVO minusCnt(ReserveVO rVO) {
		return sqlSession.selectOne("minusCnt", rVO);
	}

	public void changeCnt(PackageVO pVO) {
		sqlSession.update("changeCnt", pVO);
	}

	public int countContentsPackageNature() {
		return sqlSession.selectOne("countContentsPackageNature");
	}

	public int countContentsPackageOcean() {
		return sqlSession.selectOne("countContentsPackageOcean");
	}

	public int countContentsPackageStory() {
		return sqlSession.selectOne("countContentsPackageStory");
	}

	public int countContentsPackageNatureBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsPackageNatureBySearch", search_keyword);
	}

	public List<PackageVO> getSearchPackage(Paging pag) {
		return sqlSession.selectList("getSearchPackage", pag);
	}

	public int countContentsPackageOceanBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsPackageOceanBySearch", search_keyword);
	}

	public int countContentsPackageStoryBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsPackageStoryBySearch", search_keyword);
	}

}
