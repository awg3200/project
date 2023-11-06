<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  /* 테이블을 가운데 정렬하고 화면 너비의 80%를 차지하도록 설정합니다. */
  .centered-table {
    margin: 0 auto;
    width: 80%;
  }
</style>
</head>
<body>
<h3>${reviewContent.title }</h3>
	<table class="centered-table"  border="1">
	    <tr>
	      <td colspan="2">타이틀</td>
	    </tr>
	    <tr>
	      <td colspan="2">날짜</td>
	    </tr>
	    <tr>
	      <td>닉네임</td>
	      <td>댓글 수</td>
	    </tr>
	    <tr>
	      <td colspan="2">글 내용</td>
	    </tr>
	</table>





</body>
</html>