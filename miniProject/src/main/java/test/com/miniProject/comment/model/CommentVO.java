package test.com.miniProject.comment.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentVO {

	private int cnum;
	private int mnum;
	private String content;
	private Date wdate;
	private String writer;
}
