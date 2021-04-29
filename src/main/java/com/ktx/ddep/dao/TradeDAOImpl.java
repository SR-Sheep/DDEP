package com.ktx.ddep.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ktx.ddep.util.SqlSessionUtil;
@Repository
public class TradeDAOImpl implements TradeDAO {
	@Autowired
	private SqlSession session;
	
	/* 02.01_ 오경택 거래되고 있는상품들*/
	public List<Map<String, Object>> selectTradeList(int timeNo) {
		return session.selectList("trades.tradeOn",timeNo);
	}
	
	// 0207 방 거래대기 상품들 (유저가 판매하는 경우)
	public List<Map<String, Object>> selectTradeWaitingAsSeller(int memberNo) {
		return session.selectList("trades.selectTradeWaitingAsSeller", memberNo);
	}
		
	// 0207 방 거래대기 상품들 (유저가 구매하는 경우)
	public List<Map<String, Object>> selectTradeWaitingAsBuyer(int memberNo) {
		return session.selectList("trades.selectTradeWaitingAsBuyer", memberNo);
	}
		
	// 0207 방 완료 상품들 (유저가 판매한 경우)
	public List<Map<String, Object>> selectTradeCompleteAsSeller(int memberNo) {
		return session.selectList("trades.selectTradeCompleteAsSeller", memberNo);
	}
		
	// 0207 방 완료 상품들 (유저가 판매한 경우)
	public List<Map<String, Object>> selectTradeCompleteAsBuyer(int memberNo) {
		return session.selectList("trades.selectTradeCompleteAsBuyer", memberNo);
	}

}
