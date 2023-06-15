<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화</title>
<style>
.poster {
	width: 960px;
	height: 360px;
	margin:50px 0px 0px 50px;
}

#poster--wrap {
	width: 900px;
	hiehgt: 300px;
	margin: 30px 30px 30px 30px;
	display: flex;
	justify-content: space-between;
	flex-wrap: nowrap;
	overflow-x: scroll;
	overflow-y: hidden;
	
}

#movie--wrap {
	width: 200px;
	height: 300px;
	border: 1px solid black;
	box-sizing: border-box;
	margin-right: 30px;
}

#movie-poster {
	width: 200px;
	height: 260px;
	text-align: center;
}

#movie-title {
	width: 200px;
	height: 40px;
	font-size: 14px;
}

img {
	width: 190px;
	height: 250px;
}

.search {
	margin-left: 50px;
	width: 350px;
	height: 40px;
	display: flex;
	justify-content: space-between;
}

.search--box {
	width: 200px;
}

table {
	border-collapse: collapse;
	width: 900px;
	margin: 50px 0px 0px 50px;
	font-size: 16px;
}

table th, table td {
	padding: 12px 15px;
	text-align: center;
}

table th {
	background-color: #f2f2f2;
	font-weight: bold;
}

table td {
	border: 1px solid #ddd;
}

table tr>a {
	display: block;
}

table tr:nth-child(even) {
	background-color: #f2f2f2;
}

table tr:hover {
	background-color: #e2e2e2;
}
</style>
<jsp:include page="../css.jsp"></jsp:include>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">

$(function() {
	  console.log('onload....');
	  $.ajax({
	    url: 'Json_movie_selectAll.do',
	    method: 'GET',
	    dataType: 'json',
	    success: function(arr) {
	      console.log('ajax...success:', arr);
	      let poster_msg = '';
	      let table_msg = '';
	      for (var i = 0; i < arr.length; i++) {
	        poster_msg += `
	        	<div id="movie--wrap"  onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">
		        	<div id="movie-poster"><img src="resources/movie_poster/\${arr[i].mnum}.jpg"></div>
		            <div id="movie-title">\${arr[i].title}</div>
	          	</div>
	        `;
	        table_msg += `
	        	<tr>
		            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].title}</td>
		            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].director}</td>
		            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].mainActor ? arr[i].mainActor : ''}</td>
		            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].runtime}분</td>
		            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].opendate}</td>
	         	</tr>
	        `;
	      }
	      $('#poster--wrap').html(poster_msg);
	      $('#movie--table').html(table_msg);
	    },
	    error: function(xhr, status, error) {
	      console.log('xhr.status:', xhr.status);
	    },
	  });
	});

function m_searchList(searchKey, searchWord) {
	  // let searchKey = document.querySelector('select[name="searchKey"]').value;
	  searchKey = document.querySelector('select[name="searchKey"]').value;
	  searchWord = document.querySelector('input[name="searchWord"]').value;
	  
	  $.ajax({
	    url: "Json_movie_searchList.do",
	    data: {
	      searchKey: searchKey,
	      searchWord: searchWord
	    },
	    method: 'GET', //default get
	    success: function(arr) { //상대가 보내는 답장.	
	    	let table_msg = '';
		      for (var i = 0; i < arr.length; i++) { 
	    	table_msg += `
	        	<tr>
	            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].title}</td>
	            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].director}</td>
	            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].mainActor ? arr[i].mainActor : ''}</td>
	            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].runtime}분</td>
	            <td onclick="location.href='movieInfo.do?mnum=\${arr[i].mnum}'" style="cursor:pointer">\${arr[i].opendate}</td>
         	</tr>
		        `;
		      }
		      $('#movie--table').html(table_msg);
		    },
	    error: function(xhr, status, error) {
	      console.log('xhr.status:', xhr.status);
	    }
	  });
	}
</script>
</head>
<body>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="poster block">
		<div id="poster--wrap"></div>
	</div>
	<div class="search block">
		<select name="searchKey" class="search--select">
			<option value="DIRECTOR">감독</option>
			<option value="TITLE">제목</option>
		</select> <input class="search--box" type="text" name="searchWord"></input>
		<button onclick="m_searchList()">검색</button>
	</div>
	<table>
		<thead>
			<tr>
				<th>영화제목</th>
				<th>영화감독</th>
				<th>주연배우</th>
				<th>상영시간</th>
				<th>개봉일자</th>
			</tr>
		</thead>
		<tbody id="movie--table">
		</tbody>
	</table>
</body>
</html>