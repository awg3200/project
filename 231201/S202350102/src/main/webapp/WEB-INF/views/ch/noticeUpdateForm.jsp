<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ include file="/WEB-INF/views/header4.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/qBoardDetail.css">
<style type="text/css">
  .custom-hr {
    border: 1px solid #000; /* 기본 테두리 스타일 */
    border-width: 0 0 2px 0; /* 아래쪽 테두리만 두껍게 설정 */
  }
  
  #test{  
    min-height: 200px; /* 최소 높이를 200px로 설정 */
    
  }
</style>
<script type="text/javascript">
	function fileUpdate(){
		var fileInput = document.getElementById('fileInput');
		if(fileInput.style.display == "none"){
			fileInput.style.display = "block";			
			$("#imgOroot").hide();
			$("#chgBtn").html("취소");
		} else{
			fileInput.style.display = "none";			
			$("#imgOroot").show();
			$("#chgBtn").html("사진 첨부");
		}
	}
	
	function fileDelete(){
		if($("#Img").css("display") != "none"){
			$("#Img").hide();
			$("#imgOroot").hide();
			$("#delBtn").html("취소");
			$("#delStatus").val(1);
		} else{
			$("#Img").show();
			$("#imgOroot").show();
			$("#delBtn").html("파일 삭제");
			$("#delStatus").val(0);
		}
	}
</script>

</head>
<body>
<section class="section-mt">	
	<div class="container">
		<div class="col-12 text-center">
			<c:if test="${noticeConts.brd_md == 105 }"><h3 class="mb-10">공지사항</h3></c:if>
			<c:if test="${noticeConts.brd_md == 106 }"><h3 class="mb-10">이벤트</h3></c:if>								
		</div>
		<div class="row">
			<div class="col-3">
			
				<nav class="mb-10 mb-md-0">
					<div class="list-group list-group-sm list-group-strong list-group-flush-x">
						<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=105">공지</a>
						<a class="list-group-item list-group-item-action dropend-toggle " href="notice?brd_md=106">이벤트</a>							
					</div>
				</nav>			
				
			</div>
			<div class="col-9">
				<form action="noticeUpdate" method="post" enctype="multipart/form-data">
						<div class="qbd-mainbody" style="height: auto;">
										<span class="title-text text-start">제목:<input type="text" name="title" value="${noticeConts.title }"></span>
										<input type="hidden" value="${noticeConts.brd_num  }" name="brd_num">
										<input type="hidden" value="${noticeConts.user_num  }" name="user_num">
										<input type="hidden" value="${noticeConts.brd_md}" name="brd_md">
							
							<div class="qbd-line-box">
							&nbsp;&nbsp;<span class="qbd-line-box-text">작성자: ${noticeConts.nick }</span>&nbsp;&nbsp;&nbsp;&nbsp;
								<span class="qbd-line-box-text">작성일: <fmt:formatDate value="${noticeConts.reg_date }" pattern="yyyy-MM-dd"/></span>&nbsp;&nbsp;&nbsp;&nbsp;
								
							</div>
								<!-- <div class="qbd-line-li"></div> -->
							<hr class="custom-hr">
							<div class="container">
				    			<div class="row border" style="height: auto;">
									<div id="imgContanier">
										<img alt="UpLoad Image" src="${pageContext.request.contextPath}/upload/${noticeConts.img}" id="Img" style="max-width: 100%"><p>
										
										<c:if test="${not empty noticeConts.img }">
											<input type="hidden" name="img" value="${noticeConts.img}">											
										</c:if>
										<span>
											<textarea rows="20" cols="92" name="conts">${noticeConts.conts }</textarea>
										</span>	
									</div>
									
									<input type="file" name="file1" style="display: none;" id="fileInput">
									<c:if test="${not empty noticeConts.img }"><span id="imgOroot">${pageContext.request.contextPath}/upload/${noticeConts.img}</span></c:if><p>
									<button type="button" onclick="fileUpdate()" id="chgBtn">사진 첨부</button>											
									<c:if test="${not empty noticeConts.img }">
										<button type="button" onclick="fileDelete()" id="delBtn">파일 삭제</button>
										<input type="hidden" name="delStatus" id="delStatus" value="0">				
									</c:if>	
								</div>
							</div>
							<div class="col-12 text-center">
								<input type="submit" value="완료" class="btn-danger btn-xxs">									
								<input type="button" value="목록" onclick="location.href='notice?brd_md=${noticeConts.brd_md}'" class="btn-danger btn-xxs">
							</div>	
							<hr class="custom-hr">				
						</div>
				</form>
			</div>
			
		</div>
	</div>
</section>	
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>