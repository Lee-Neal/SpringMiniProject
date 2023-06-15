package test.com.miniProject.reservation.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ReservationDAOimpl implements ReservationDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public ReservationDAOimpl() {
		System.out.println("ReservationDAOimpl()...");
	}

	@Override
	public int insertOK(ReservationVO vo) {
		log.info("insertOK()..." + vo);
		int flag = sqlSession.insert("R_INSERT", vo);
		
		return flag;
	}

	@Override
	public int updateOK(ReservationVO vo) {
		log.info("updateOK()..." + vo);
		int flag = sqlSession.insert("R_UPDATE", vo);
		
		return flag;
	}

	@Override
	public int deleteOK(ReservationVO vo) {
		log.info("deleteOK()..." + vo);
		int flag = sqlSession.insert("R_DELETE", vo);
		
		return flag;
	}

	@Override
	public List<ReservationVO> selectOne(ReservationVO vo) {
		log.info("selectOneimpl()..." + vo);
		
		List<ReservationVO> vos = sqlSession.selectList("R_SELECTONE",vo);
		log.info("selectOneimpl()..." + vos);

		return vos;
	}

}


