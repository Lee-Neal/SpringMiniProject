package test.com.miniProject.reservation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import test.com.miniProject.reservation.model.ReservationDAO;
import test.com.miniProject.reservation.model.ReservationVO;

//@Component
@Service
@Slf4j
public class ReservationService {

	@Autowired
	ReservationDAO dao;

	public ReservationService() {
		log.info("ReservationService()...");
	}

	public int insertOK(ReservationVO vo) {
		return dao.insertOK(vo);
	}

	public int updateOK(ReservationVO vo) {
		return dao.updateOK(vo);
	}

	public int deleteOK(ReservationVO vo) {
		return dao.deleteOK(vo);
	}

	public List<ReservationVO> selectone(ReservationVO vo) {
		return dao.selectOne(vo);
	}
}
