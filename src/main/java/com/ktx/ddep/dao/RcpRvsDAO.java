package com.ktx.ddep.dao;

import java.util.List;

import com.ktx.ddep.vo.RcpRv;

public interface RcpRvsDAO {

	// 210129 양 선택된 요리후기 갯수 불러오기
	public int countSelectRv(int no);

	// 방 내가쓴 레시피에 달린 요리후기
	public List<RcpRv> selectRvsToMyRcps(int memberNo);

	// 방 내가쓴 요리후기
	public List<RcpRv> selectMyRvsToRcps(int memberNo);

	// 0203 방 요리후기 입력
	public int insertRcpRv(RcpRv rv);

	// 0204 방 레시피에 대한 요리후기 및 평점 가져오기
	public List<RcpRv> selectRvsForRcp(int opensRcpNo);

}
