package com.ktx.ddep.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktx.ddep.util.SqlSessionUtil;
import com.ktx.ddep.vo.PageVO;
import com.ktx.ddep.vo.Rcp;
@Repository
public class RcpsDAOImpl implements RcpsDAO {

	@Autowired
	private SqlSession session;

	// 210129 양 레시피 페이지로 모든 목록 불러오기
	@Override
	public List<Rcp> selectList(PageVO pageVO) {
		return session.selectList("rcps.selectList", pageVO);
	}

	// 0129 방 내가쓴 레시피
	@Override
	public List<Rcp> selectMyRcps(int memberNo) {
		return session.selectList("rcps.selectMyRcps", memberNo);
	}

	// 0130 방 임저레
	@Override
	public List<Rcp> selectTmpRcps(int memberNo) {
		return session.selectList("rcps.selectTmpRcps", memberNo);
	}

	// 0130 방 임저레 삭제
	@Override
	public int deleteTmpRcps(int tmpRcpNo) {
		return session.delete("rcps.deleteTmpRcps", tmpRcpNo);
	}

	// 김 0201
	public Rcp selectOne(int no) {

		return session.selectOne("rcps.selectOne", no);

	}// selectOne end

	// 0204 방 요리후기 평점 업데이트
	public int updateRcpAvg(Rcp rcp) {

		return session.delete("rcps.updateRcpAvg", rcp);

	}

	// 0204 방 스크랩 레시피
	public List<Rcp> selectSavedRcps(int memberNo) {

		return session.selectList("rcps.selectSavedRcps", memberNo);

	}

	// 0204 방 레시피 스크랩 횟수
	public int selectScrapCount(int rcpNo) {

		return session.selectOne("rcps.selectScrapCount", rcpNo);

	}

	// 0204 방 스크랩 레시피 삭제

	public int deleteSavedRcp(int rcpNo) {

		return session.delete("rcps.deleteSavedRcp", rcpNo);

	}

	// 21-02-09 07:58 양 레시피 스크랩 순으로 모든 목록 불러오기
	public List<Rcp> selectListByScrap(PageVO pageVO) {

		return session.selectList("rcps.selectListByScrap", pageVO);

	}

	// 21-02-09 07:59 양 레시피 스크랩 순으로 모든 목록 불러오기
	public List<Rcp> selectListByView(PageVO pageVO) {

		return session.selectList("rcps.selectListByView", pageVO);

	}

	// 21-02-13 15:59 양 키워드로 레시피 리스트 들고오기
	public List<Rcp> selectListByKeyword(PageVO pageVO) {
		return session.selectList("rcps.selectListByKeyword", pageVO);
	}

	// 21-02-13 18:11 양 검색 레시피 수 불러오기
	public int countRcps(String keyword) {
		return session.selectOne("rcps.countRcpsByKeyword", keyword);
	}
	
	@Override
	public int countRcps() {
		return session.selectOne("rcps.countRcps");
	}

	/* 21-02-14 19:34 양 조회수 업데이트 */
	public int updateViewCount(int no) {
		return session.update("rcps.updateViewCount", no);

	}

}
