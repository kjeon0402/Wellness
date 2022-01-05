package com.wellness.tour;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wellness.common.Paging;
import com.wellness.main.GetLikeCntVO;
import com.wellness.main.WishListVO;
import com.wellness.package_tour.SearchPackageVO;

@Service
public class TourSvc {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<TourVO> getLocate() {
		return sqlSession.selectList("getLocate");
	}

	public List<TourVO> getAll() {
		return sqlSession.selectList("getAll");
	}

	public int getLikeCnt(GetLikeCntVO glcVO) {
		return sqlSession.selectOne("getLikeCnt", glcVO);
	}

	public TourVO getTopSix(GetLikeCntVO getLikeCntVO) {
		return sqlSession.selectOne("getTopSix", getLikeCntVO);
	}

	public List<TourVO> getAllAboutCategory(TourVO tVO) {
		return sqlSession.selectList("getAllAboutCategory", tVO);
	}

	public List<TourVO> getAllAboutNature(Paging pag) {
		return sqlSession.selectList("getAllAboutNature", pag);
	}

	public List<TourVO> getAllAboutOcean(Paging pag) {
		return sqlSession.selectList("getAllAboutOcean", pag);
	}

	public List<TourVO> getAllAboutCosmetic(Paging pag) {
		return sqlSession.selectList("getAllAboutCosmetic", pag);
	}

	public List<TourVO> getAllAboutMeal(Paging pag) {
		return sqlSession.selectList("getAllAboutMeal", pag);
	}

	public List<TourVO> getAllAboutHotel(Paging pag) {
		return sqlSession.selectList("getAllAboutHotel", pag);
	}

	public TourVO getDetailTour(TourVO tVO) {
		return sqlSession.selectOne("getDetailTour", tVO);
	}

	public int getLikeTourIdx(TourVO tVO) {
		return sqlSession.selectOne("getLikeTourIdx", tVO);
	}

	public TourVO getTourInfo(WishListVO wishListVO) {
		return sqlSession.selectOne("getTourInfo", wishListVO);
	}

	public TourVO getPopularTour(GetLikeCntVO getLikeCntVO) {
		return sqlSession.selectOne("getPopularTour", getLikeCntVO);
	}

	public TourVO getTourInfoAsPackage(Object objForTour) {
		return sqlSession.selectOne("getTourInfoAsPackage", objForTour);
	}

	public List<TourVO> getTourByLocate(SearchPackageVO spVO) {
		return sqlSession.selectList("getTourByLocate", spVO);
	}

	public int countContentsTourNature() {
		return sqlSession.selectOne("countContentsTourNature");
	}

	public int countContentsTourOcean() {
		return sqlSession.selectOne("countContentsTourOcean");
	}

	public int countContentsTourCosmetic() {
		return sqlSession.selectOne("countContentsTourCosmetic");
	}

	public int countContentsTourMeal() {
		return sqlSession.selectOne("countContentsTourMeal");
	}

	public int countContentsTourHotel() {
		return sqlSession.selectOne("countContentsTourHotel");
	}

	public int countContentsTourNatureBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsTourNatureBySearch", search_keyword);
	}

	public List<TourVO> getSearchAboutNature(Paging pag) {
		return sqlSession.selectList("getSearchAboutNature", pag);
	}

	public int countContentsTourOceanBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsTourOceanBySearch", search_keyword);
	}

	public List<TourVO> getSearchAboutOcean(Paging pag) {
		return sqlSession.selectList("getSearchAboutOcean", pag);
	}

	public int countContentsTourCosmeticBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsTourCosmeticBySearch", search_keyword);
	}

	public List<TourVO> getSearchAboutCosmetic(Paging pag) {
		return sqlSession.selectList("getSearchAboutCosmetic", pag);
	}

	public int countContentsTourMealBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsTourMealBySearch", search_keyword);
	}

	public List<TourVO> getSearchAboutMeal(Paging pag) {
		return sqlSession.selectList("getSearchAboutMeal", pag);
	}

	public int countContentsTourHotelBySearch(String search_keyword) {
		return sqlSession.selectOne("countContentsTourHotelBySearch", search_keyword);
	}

	public List<TourVO> getSearchAboutHotel(Paging pag) {
		return sqlSession.selectList("getSearchAboutHotel", pag);
	}



	
	
}
