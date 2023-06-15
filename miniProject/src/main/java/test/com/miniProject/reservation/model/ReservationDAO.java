package test.com.miniProject.reservation.model;

import java.util.List;

public interface ReservationDAO {

	public int insertOK(ReservationVO vo);

	public int updateOK(ReservationVO vo);

	public int deleteOK(ReservationVO vo);

	public List<ReservationVO> selectOne(ReservationVO vo);

}
