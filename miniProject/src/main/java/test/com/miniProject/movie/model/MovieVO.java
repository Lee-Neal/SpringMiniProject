package test.com.miniProject.movie.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieVO {
    private int mnum;
    private String title;
    private String director;
    private String mainActor;
    private String allActor;
    private int runtime;
    private Date opendate;
    private String genre;
    private String story_summ;

}
