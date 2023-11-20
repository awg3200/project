<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>챌린지 관리자 페이지</title>
<script type="text/javascript">
	function categoryFilterFn(){
		var category = $('#categoryFilter').val();
		
		
	}

</script>

</head>
<body>
<section class="py-11">
 <div class="container">
        <div class="row">
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="pt-10 pb-5">
            	<h3 class="mb-10">신청 챌린지 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
    		<%@ include file="adminSidebar.jsp" %>
    		<div class="col-12 col-md-auto">
				
				<!-- 필터 만들기 전체 조회일 때 어떻게 할지 생각하기  -->
                <!-- 필터 조회 -->
                <select class="form-select form-select-xs" id="categoryFilter" onchange="categoryFilterFn()"> 
                  <option value=""<c:if test="">	selected="selected"</c:if>>{ctg.ctn}</option>
                <c:forEach var="ctg" items="${category }" varStatus="status">
                  <option value="${ctg.md }"	<c:if test="">	selected="selected"</c:if>>{ctg.ctn}</option>
                
                </c:forEach>
                  
                </select>

              </div>
		<div class="col-10">
		<c:set var="num" value=""></c:set>
		
			<table class="table table-bordered table-sm mb-0">
			  <thead>
				<tr class="p-2 text-center">
					<th>번호</th>
					<th>카테고리명</th>
					<th>챌린지명</th>
					<th>신청자</th>
					<th>신청일</th>
					<th class="text-center"> 승인 </th>
					<th class="text-center"> 반려 </th>
				</tr>
			  </thead>
			  <tbody>
				<c:forEach var="chgApcList" items="" varStatus="status">
					<tr class="text-center" id="user">
						<input type="hidden" id="user_num" value="">
						<input type="hidden" id="delete_yn" value="">
						<td></td>
						<td></td>
						<td></td>
						<td>}</td>
						<c:choose>
							<c:when test=""><td>일반</td></c:when>
							<c:when test=""><td>멤버쉽</td></c:when>
							<c:when test=""><td>관리자</td></c:when>
							<c:when test=""><td></td></c:when>
						</c:choose>						
						<td></td>
						<td class="justify-content-center">
							<button type="button" class="btn btn-secondary btn-xs" onclick="location.href='/detailUserByAdmin?user_num=&pageNum='">상세보기</button>
						</td>
					</tr>
					<c:set var="num" value=""></c:set>
				</c:forEach>
			 </tbody>
			</table>
			
				<!-- 페이지네이션  -->
					 <nav class="d-flex justify-content-center justify-content-md-center mt-3">
	      	   		 <ul class="pagination pagination-lg text-gray-400">
					  	<c:if test="">
					  		<li class="page-item">
								<a class="page-link page-link-arrow" href="listUserAdmin?currentPage=">
								<i class="fa fa-caret-left">이전</i></a>
							</li>
						</c:if>
						
					    <c:forEach var="i" begin="" end="">
							<li class="page-item">
								<c:if test="">
									<a class="page-link px-2" href="listUserAdmin?currentPage="><b class="text-primary"></b></a>
								</c:if>
								<c:if test="">
									<a class="page-link px-2" href="listUserAdmin?currentPage="></a>
								</c:if>
							</li>
						</c:forEach>
					    <c:if test="">
					    	<li class="page-item">
								<a class="page-link page-link-arrow" href="listUserAdmin?currentPage=">
								<i class="fa fa-caret-right">다음</i></a>
							</li>
						</c:if>
					 </ul>
			  		</nav>
			  </div>
		  	</div>
		  	<div class="py-10"></div>	
		  </div>
		  
		 </section>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>