<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 챌린지 후기 관리</title>
</head>
<body>
<section class="pt-7 pb-12">
 <div class="container">
        <div class="row">
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="col-12 text-center">
            
            	<h3 class="mb-10">
            	</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
		<%@ include file="adminSidebar.jsp" %>	
		
		<div class="col-md-10 ">
		<div class="col-12">
		<c:set var="num" value="${reviewPage.total-reviewPage.start+1 }"></c:set>
		
			<table class="table table-bordered table-sm mb-0   table-hover">
                    <thead class="table-dark">
				<tr class="p-2 text-center">
					<th>번호</th>
					<th>글 제목</th>
					<th>작성일자</th>
					<th>조회 수</th>
					<th>댓글 수</th>
					<th>댓글 관리</th>
					<th>상세보기</th>
				</tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="review" items="${chgReviewList }" varStatus="status">
				  	<tr class="text-center" id="review${status.index }">
				  		<td>${num }</td>
				  		<td><a href="/reviewContent?chg_id=${review.chg_id }&brd_num=${review.brd_num}">${review.title }</a></td>
						<td><fmt:formatDate value="${review.reg_date }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
						<td>${review.view_cnt }</td>
						<td>${review.replyCount }</td>
						<td class="justify-content-center">
								<button type="button" class="btn btn-secondary btn-xxs" onclick="">댓글 관리</button>
						</td> 
						<td class="justify-content-center">
								<button type="button" class="btn btn-secondary btn-xxs" onclick="">상세보기</button>
						</td> 
				  	</tr>
					<c:set var="num" value="${num -1 }"></c:set>
				</c:forEach>
			  </tbody>
			  </table>
			 </div>
			  
			  
			 
       		<!-- Pagination -->
			<nav class="d-flex justify-content-center mt-9">
			  <ul class="pagination pagination-sm text-gray-400">
			  <c:if test="${reviewPage.startPage > reviewPage.pageBlock}">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="chgReviewAdmin?currentPage=${reviewPage.startPage-reviewPage.pageBlock }&chg_id=${chg.chg_id}">
			        <i class="fa fa-caret-left"></i>
			      </a>
			    </li>
              </c:if>
	          <c:forEach var="i" begin="${reviewPage.startPage }" end="${reviewPage.endPage }">
			    <li class="page-item">
			    	<c:if test="${i == reviewPage.currentPage}">
			      		<a class="page-link" href="chgReviewAdmin?currentPage=${i}&chg_id=${chg.chg_id}"><b class="text-primary">${i}</b></a>
			    	</c:if>
			    	<c:if test="${i != reviewPage.currentPage}"> 
			     		<a class="page-link" href="chgReviewAdmin?currentPage=${i}&chg_id=${chg.chg_id}">${i}</a>
			    	</c:if>
			    </li>
	          </c:forEach>
	          <c:if test="${reviewPage.endPage < reviewPage.totalPage }">
			    <li class="page-item">
			      <a class="page-link page-link-arrow" href="chgReviewAdmin?currentPage=${reviewPage.startPage+reviewPage.pageBlock }&chg_id=${chg.chg_id}">
			        <i class="fa fa-caret-right"></i>
			      </a>
			    </li>
	          </c:if>
			  </ul>
			</nav>
</body>
</html>