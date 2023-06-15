<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}

th, td {
	padding: 0px;
}

td {
	width: 100px;
	height: 30px;
	line-height: 30px;
}

td a {
	display: block;
	width: 100%;
	height: 100%;
	color: black;
	text-decoration: none;
}

.row:hover {
	background-color: #D3D3D3;
}
</style>
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<script type="text/javascript">
const movieObject = {};

$(document).ready(function(){
	  console.log('onload....');
	  $.ajax({
	    url: 'Json_movie_selectAll.do',
	    method: 'GET',
	    dataType: 'json',
	    success: function(arr) {
	      console.log('ajax...success:', arr);
	      let poster_msg = '';
	      for (var i = 0; i < arr.length; i++) {
	        movieObject[arr[i].title] = arr[i].mnum;
	        poster_msg += `
	        	<div id="movie--wrap" style="cursor:pointer">
		        	<div id="movie-poster"><img src="resources/movie_poster/\${arr[i].mnum}.jpg"></div>
		            <div id="movie-title">\${arr[i].title}</div>
	          	</div>
	        `;
	      }
	      $('#poster--wrap').html(poster_msg);
	      console.log('movieObject',movieObject);
	      
	      initReservation();
	    },
	    error: function(xhr, status, error) {
	      console.log('xhr.status:', xhr.status);
	    },
	  });
	});

//영화 선택 시 예약하기에 제목 불러가기
$(document).on('click', '#movie--wrap', function() {
	  const movieTitle = $(this).find('#movie-title').text();
	  const movieNum = $(this).find('#movie-poster').find('img').attr('src');
	  const movie_num = movieNum.match(/(\d+)/)[0];
	  
	  $('#title').val(movieTitle);
	  $('#movie_num').val(movie_num);
	});

//selectOne()함수 정의

function initReservation() {
    $(document).ready(function() {
        console.log('selectOne..');
    $.ajax({
      url: 'json_reservation_selectone.do',
      data: {
        user_id: `${user_id}`,
      },
      method: 'GET',
      dataType: 'json',
      success: function(vos) {
        console.log('ajax...success:', vos, typeof vos);
        let msg = '';
        if (vos == null) {
          msg += `
            <tr>
              <td colspan="4">예약 정보가 존재하지 않습니다.</td>
            <tr>
          `;
        } else {
          for (let arr of vos) {
        	let movieTitle = Object.keys(movieObject).find(key => movieObject[key] === arr.movie_num);
        	console.log('movieTitle',movieTitle);
        	console.log('arr.movie_num',typeof(arr.movie_num),arr.movie_num);
            msg += `
              <tr id="tr_\${arr.num}">
                <td>\${arr.num}</td>
                <td class="movie_num\${arr.movie_num}" style="width:200px;">\${movieTitle}</td>
                <td>\${arr.movie_date}</td>
                <td>\${arr.mcount}</td>
                <td style="width:30px"><button onclick="update(\${arr.num})">변경</button></td>
                <td style="width:30px"><button onclick="deleteOK(\${arr.num})">삭제</button></td>
              </tr>
            `;
          }
        }
        $('#my_reservateion').html(msg);;
      },
		error:function(xhr,status,error){
		console.log('xhr.status:', xhr.status);
		}
	});
})
}
	
	function deleteOK(num){
		console.log('deleteOK..',num);
	$.ajax({
		url : "r_deleteOK.do",
		data : {
			num:num
		},
		method:'GET',//default get
		success : function() {//상대가 보내는 답장.
			document.location.href = document.location.href;
			},
		error:function(xhr,status,error){
		console.log('xhr.status:', xhr.status);
			}
	});
}//end deleteOK

function update(num){
	console.log('update..',num);
	const update_id = 'tr_'+num;
	let update_vos;
	let update_msg='';
	$.ajax({
		url : "json_reservation_selectone.do",
		data:{
			user_id:`${user_id}`
		},
		method:'GET',//default get
		dataType:'json', //xml,text도 가능. 미기재시 text
		success : function(vos) {
			console.log('update_vos...',vos)
			for (var i = 0; i < vos.length; i++) {
				if(vos[i]['num']===num){
					update_vos = vos.find(item => item.num === num);
					console.log(update_vos);
					}}

				update_msg +=`<td>\${update_vos.num}</td>
					  <td style="width:200px;"><input type="text" id="update_title" name="update_title"></td>
					  <input type="text" id="update_title" name="update_title">
					  <td><input type="datetime-local" id="update_movie_date" name="update_movie_date"></input></td>
					  <td><input type="text" id="update_mcount" name="update_mcount" value="\${update_vos.mcount}"></td>
					  <td colspan="2"><button onclick="updateOK(\${update_vos.num},$('#update_movie_date').val(),$('#update_mcount').val(),$('#update_title').val())">변경</button></td>`;
					  
				$('#'+update_id).html(update_msg);
				
			
		},
		error:function(xhr,status,error){
		console.log('xhr.status:', xhr.status);
		
		
		}
	})
};//end update

function updateOK(num,movie_date,mcount,update_title){
	let movieNum=movieObject[update_title];
	console.log('movie_num...변환',movie_num)
	$.ajax({
		url : "r_updateOK.do",
		data : {
			num:num,
			movie_date:movie_date,
			mcount:mcount,
			movie_num: movieNum,

		},
		method:'GET',//default get
		success : function() {//상대가 보내는 답장.
			document.location.href = document.location.href;
			},
		error:function(xhr,status,error){
		console.log('xhr.status:', xhr.status);
			}
	});
}
console.log('movie_count...',$('#movie_tb >tbody tr').length);
</script>
<body>
	<h1>영화 예매</h1>
	<jsp:include page="../top_menu.jsp"></jsp:include>
	<div class="poster block">
	<div id="poster--wrap"></div>
	</div>
	<hr>
	<table>
		<thead>
			<tr>
				<th colspan="6">내 예약 목록</th>
			<tr>
				<th>예약번호</th>
				<th>영화이름</th>
				<th>상영날짜</th>
				<th>예약인원</th>
				<th>변경</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody id="my_reservateion">
		</tbody>
	</table>
	<hr>
	<form action="r_insertOK.do" method="post">
	<input type="hidden" id="user_id" name="user_id" value="${user_id}"></input>
		<table>
			<tr>
				<th colspan="3">예약하기</th>
			</tr>
			<tr>
				<th>영화제목</th>
				<th>상영날짜</th>
				<th>예약인원</th>
			</tr>
			<tr>
				<td><input type="text" id="title">
				<input type="hidden" id="movie_num" name="movie_num"></td>
				<td><input type="datetime-local" id="movie_date"
					name="movie_date"></input></td>
				<td><input type="number" id="mcount" name="mcount" value="4"></input></td>
			</tr>
			<tr>
				<td colspan="3"><input type="submit" value="예매하기"></input></td>
			</tr>
		</table>
	</form>
	<hr>
</body>
</html>