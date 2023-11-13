package com.oracle.S202350102.service.yrService;

import org.springframework.stereotype.Service;

import com.oracle.S202350102.dao.yrDao.YrFollowingDao;
import com.oracle.S202350102.dto.Following;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YrFollowingServiceImpl implements YrFollowingService {
	private final YrFollowingDao yfid;

	// following 여부 판단
	public boolean isFollowing(Following fwi) {
		int result = yfid.selectFollowingYN(fwi);
		System.out.println("YrFollowingService isFollowing result -> " + result);
		if(result == 0) return false;	// following 값이 없다 / result = 0
		else			return true;	// following 값이 있다 / result = 1
	}
	
	@Override
	public int following(Following fwi) {
		int result = 0;
		if(this.isFollowing(fwi)) {	
			// isFollowing = true -> following 값 있다 -> 없애기
			yfid.deleteFollowing(fwi);
			result = 0;
		} else {										
			// isFollowing = false -> following 값 없다 -> 추가하기
			yfid.insertFollowing(fwi);
			result = 1;
		}
		System.out.println("YrFollowingService following result -> " + result);
		return result;
	}

}
