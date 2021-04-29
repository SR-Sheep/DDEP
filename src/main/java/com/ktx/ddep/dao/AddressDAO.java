package com.ktx.ddep.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.ktx.ddep.util.SqlSessionUtil;
import com.ktx.ddep.vo.Address;

public interface AddressDAO {

	//210127 양 no로 address 정보 얻어오기
	public Address selectOne(int no);
		
	//2021-01-24 이소현
	public int insertAddress(Address address);
	
	//2021-02-03 17:55 양 주소 업데이트
	public int updateAddress(Address address);
	
	//21-02-02 이소현
	public List<String> selectSidoList();
	
	//21-02-02 이소현
	public List<String> selectGugunList(String sido); 
			
	//21-02-02 이소현
	public List<String> selectDongList(Address address);
			
	//2021-02-03 21:36 이소현 _ 
	public List<Map<String, Object>> selectSelectedLocationdMarketLsit(Address address); 
	
}//AddressDAO end
