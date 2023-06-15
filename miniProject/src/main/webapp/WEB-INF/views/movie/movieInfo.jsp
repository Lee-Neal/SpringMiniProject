<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화</title>
<style>
.movieInfo__poster>img {
	width: 200px;
	height: 300px;
}
.profile>img{
	width: 100px;
	height: 100px;
}
.movieInfo {
	width: 650px;
	hiehgt: 330px;
	border: 1px solid black;
	display: flex;
	margin: 30px 0px 30px 30px;
}

.movieInfo__text {
	margin-left: 20px;
}

.movieInfo__text>div {
	margin-top: 10px;
}

.comment__tab {
	margin-left: 30px;
	width: 100px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	background-color: #DBDBDB;
}

.comment__table {
	width: 630px;
	height: 650px;
	margin: 20px 0px 0px 30px;
	border: 1px solid black;
	display: flex;
	flex-wrap: wrap;
	align-content: flex-start;
	justify-content: flex-start;
}

.comment__item {
	width: 300px;
	height: 200px;
	border: 1px solid black;
	display: flex;
	margin: 5px;
}

.leftTab {
	width: 100px;
	hiehgt: 180px;
	margin: 10px;
}

.profile {
	width: 100px;
	height: 100px;
	border: 1px solid black;
}

.userId, .rgeDate {
	margin-top: 5px;
	width: 100px;
	height: 30px;
	line-height: 30px;
	border: 1px solid gray;
}

.rightTab {
	width: 170px;
	height: 180px;
	margin-top: 10px;
}

.textArea {
	width: 170px;
	height: 160px;
	border: 1px solid black;
}

.modifierTab {
	width: 170px;
	height: 20px;
	line-height: 20px;
	display: flex;
	justify-content: flex-end;
	text-align:center;
}

.update {
	width: 40px;
}
.delete{
	width: 40px;
}
.comment__insert{
	width:630px;
	height:200px;
	margin:30px 0px 0px 30px;
	border:1px solid black;
	display:flex;
	flex-wrap: wrap;
	justify-content: space-evenly;
}
.inputBox{
	margin-top:15px;
	width:400px;
	height:150px;
}
.insertBtn{
	margin-top:15px;
	width:200px;
	height:150px;
}
input{
	width:95%;
	height:95%;
}
.writer, .writeDate{
	text-align:center;
}
.update:hover, .delete:hover ,.updateOK:hover{
  cursor: pointer;
  background-color:#CCCCCC;
}
a {
  display: block;
  text-decoration:none;
  color:black;
}
textarea{
	height:97%;
}
.updateOK{
	width:100px;
	text-align:center;
}
</style>
<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">
$.ajax({
  url: 'Json_movie_selcetOne.do',
  data: {
	  mnum:${param.mnum}
  },
  method: 'GET',
  dataType: 'json',
  success: function(vo) {
    console.log('ajax...success:', vo);
    let movieInfo_tag = '';
  	  movieInfo_tag += `
  		<div class="movieInfo__poster"><img src="resources/movie_poster/\${vo.mnum}.jpg"></div>
  		<div class="movieInfo__text">
  			<div class="movieInfo__title">영화 제목 : \${vo.title}</div>
  			<div class="movieInfo__diretor">영화 감독 : \${vo.director}</div>
  			<div class="movieInfo__allactor">출연진 : \${vo.allActor}</div>
  			<div class="movieInfo__genre">장르 : \${vo.genre}</div>
  			<div class="movieInfo__runtime">상영 시간 : \${vo.runtime}분</div>
  			<div class="movieInfo__opendate">개봉일자 : \${vo.opendate}</div>
  			<div class="movieInfo__story_summ">스토리 : \${vo.story_summ}</div>
  		</div>
      `;
    
    $('.movieInfo').html(movieInfo_tag);
  },
  	error: function(xhr, status, error) {
    console.log('xhr.status:', xhr.status);
  },
});

$.ajax({
	  url: 'json_comment_selectAll.do',
	  data: {
		  mnum:${param.mnum}
	  },
	  method: 'GET',
	  dataType: 'json',
	  success: function(arr) {
	    console.log('ajax...success:', arr)
	    let comment_tag = '';
	    for (var i = 0; i < arr.length; i++) {
	    comment_tag += `
	    	<div class="comment__item">
				<div class="comment__item__leftTab leftTab">
					<div class="comment__item__profile profile"><img src="resources/member_profile/\${arr[i].writer}.jpg"
						onerror="this.onerror=null;this.src='resources/member_profile/defaultImg.jpg';"
							width="100px" height="100px"></div>
					<div class="comment__item__writer writer">\${arr[i].writer}</div>
					<div class="comment__item__writeDate writeDate">\${arr[i].wdate}</div>
				</div>
				<div class="comment__item__rightTab rightTab">
					<div class="comment__item__textArea\${arr[i].cnum} textArea">\${arr[i].content}</div>
						<input id="cnum+\${arr[i].cnum}"type="text" vlaue="\${arr[i].cnum}" hidden>
					<div class="comment__item__modifierTab\${arr[i].cnum} modifierTab">
						<div onclick="comment_update(this)" class="comment__item__update+\${arr[i].cnum} update">수정</div>
						<div onclick="comment_delete(this)" class="comment__item__delete+\${arr[i].cnum} delete">삭제</div>
					</div>
				</div>
			</div>`;
	    }
		
	    $('.comment__table').html(comment_tag);
	    let user_id = "${user_id}";

	    $('.comment__table .writer').each(function() {
	      if (user_id === $(this).text()) {
	        $(this).closest('.comment__item').find('.update').show();
	        $(this).closest('.comment__item').find('.delete').show();
	      } else {
	        $(this).closest('.comment__item').find('.update').hide();
	        $(this).closest('.comment__item').find('.delete').hide();
	      }
	    });
	  },
	  error: function(xhr, status, error) {
	    console.log('xhr.status:', xhr.status);
	  },
	});

function comment_delete(elem) {
    let thisClass = elem.className;
    const regex = /\+(\d+)/;
    const cnum = thisClass.match(regex)[1];

    $.ajax({
        url: "comment_deleteOK.do",
        data: { cnum: cnum },
        method: 'GET',
        dataType: 'html',
        success: function(response) {
                location.reload();
        }
    });
}

function comment_update(elem) {
	console.log('comment_update()...');
    let thisClass = elem.className;
    const regex = /(\d+)/; 
    const cnum = thisClass.match(regex)[1];// 여기서 정규식으로 숫자만 추출했어요
    const selector = '.comment__item__textArea' + cnum; // 여기에서 댓글 내용이 들어간 클래스 이름이랑 cnum을 합쳤어요
    const selector2 = '.comment__item__modifierTab' + cnum; // 여기에서 댓글 내용이 들어간 클래스 이름이랑 cnum을 합쳤어요
    let comment_update = `<textarea></textarea>`;
    let modifier_update =
    	`<div onclick="comment_updateOK(this)" class="comment__item__updateOK`
    	+cnum+
    	` updateOK">적용</div>
    `;
    $(selector).html(comment_update);
    $(selector2).html(modifier_update);
}

function comment_updateOK(elem) {
	console.log('comment_updateOK()...');
    let thisClass2 = elem.className;
    const regex = /(\d+)/;
    const updateOK_cnum = thisClass2.match(regex)[1];
    let updateOK_selector = '.comment__item__textArea' + updateOK_cnum;
    let content = $(updateOK_selector).find('textarea').val();

    $.ajax({
        url: "comment_updateOK.do",
        data: { cnum: updateOK_cnum,
        		content:content	
        },
        method: 'GET',
        dataType: 'html',
        success: function(response) {
                location.reload();
        }
    });
}
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="movieInfo block"></div>
	<div class="comment__tab">댓글</div>
	<div class="comment__table block">
	</div>
	<form action="comment_insertOK.do" method="GET">
		<div class="comment__insert block">
			<div class="comment__insert__inputBox inputBox">
				<input name="content" type="text" value="댓글 내용 중 스포일러가 포함된 경우 삭제될 수 있습니다." maxlength="100">
			</div>
			<div class="comment__insertBtn insertBtn">
				<input type="submit" value="등록">
			</div>
			<div class="comment__insert__textBox textBox">
				최대 100글자까지 입력 가능합니다.
				<input type="text" name="writer" value="${user_id}" hidden>
				<input type="text" name="mnum" value="${param.mnum}" hidden>
			</div>
		</div>
	</form>
</body>
</html>