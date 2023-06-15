package test.com.miniProject.reservation.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationVO {
	private int num;
	private String user_id;
	private int movie_num;
	private Date regdate;
	private String movie_date;
	private int mcount;
}
