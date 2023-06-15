<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="./css.jsp"></jsp:include>
<ul>
	<li><a href="home.do">홈</a></li>
	<li id="signup"><a href="signup.do">회원가입</a></li>
	<li id="movie"><a href="movie.do">영화</a></li>
	<li id="reservation"><a href="reservation.do">예매</a></li>
	<li id="myPage"><a href="mypage.do">마이페이지</a></li>
	<li id="login"><a href="login.do">로그인</a></li>
	<li id="logout"><a href="logout.do">로그아웃</a></li>
</ul>
<hr>
<script type="text/javascript">
	if ('${user_id}' === '') {
		//비로그인
		$('#login').show();
		$('#signup').show();
		$('#logout').hide();
		$('#myPage').hide();
		$('#reservation').hide();
	} else {
		//로그인
		$('#login').hide();
		$('#signup').hide();
		$('#logout').show();
		$('#myPage').show();
		$('#reservation').show();

	}
</script>
