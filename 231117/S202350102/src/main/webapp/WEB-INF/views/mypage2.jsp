<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="header4.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="./assets/favicon/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./assets/css/libs.bundle.css" />
    <link rel="stylesheet" href="./assets/css/theme.bundle.css" />
    <title>Insert title here</title>
</head>
<body>
<!-- 필수!! -->
 <div class="container">
         <div class="row profile">
            <div class="col-md-3">
                <%@ include file="mypageMenu.jsp" %>
            </div>
             <div class="col-md-9 profile-form">
<!-- 필수!! -->
      <div class="container" style="width : 75%">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h5 class="mb-4">챌린지 목록</h5>
            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#topSellersTab" data-bs-toggle="tab">참여 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">신청한 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">최근 본 챌린지</a>
              <a class="nav-link" href="#topSellersTab" data-bs-toggle="tab">찜한 챌린지</a>
            </div>

            <!-- Content -->
            <div class="tab-content">

              <!-- Pane -->
              <div class="tab-pane fade show active" id="topSellersTab">

                <!-- Slider -->
                <div class="flickity-buttons-lg flickity-buttons-offset px-lg-12" data-flickity='{"prevNextButtons": true}'>

	
                  <!-- Item -->
               <div class="col px-4" style="max-width: 200px;">
                    <div class="card">

                      <!-- Image -->
                      <img class="card-img-top" src="assets/img/products/product-26.jpg" alt="...">

                      <!-- Body -->
                      <div class="card-body py-4 px-0 text-center">

                        <!-- Heading -->
                        <a class="stretched-link text-body" href="shop.html">
                          <h7>챌린지명 <small>(35)</small></h7>
                        </a>

                      </div>

                    </div>
                  </div>

          
                </div>
                    </div>
                  </div>
		</div>

      <div class="container"style="margin-top: 60px;">
        <div class="row">
          <div class="col-12">

            <!-- Heading -->
            <h5 class="mb-4">내가 쓴 글</h5>
            <!-- Nav -->
            <div class="nav justify-content-center mb-10">
              <a class="nav-link active" href="#myCert-list" data-bs-toggle="tab">인증글</a>
              <a class="nav-link" href="#myReview-list" data-bs-toggle="tab">후기글</a>
              <a class="nav-link" href="#myCommu-list" data-bs-toggle="tab">자유글</a>
              <a class="nav-link" href="#myShare-list" data-bs-toggle="tab">쉐어링</a>
            </div>

            <!-- Content -->
               <!-------------------------------- 인증글리스트 --------------------------------------->
        <div class="tab-pane fade show active" id="myCert-list">
			<div id="myCert">
				<div class="container">
					<c:choose>
		            	<c:when test="${not empty myCertiList }">
		            		<c:set var="num" value="${myCertiPage.total - myCertiPage.start+1 }"></c:set> 
			                <table class="boardtable">
			                    <thead>
			                        <tr>
			                            <th scope="col" class="th-num">번호</th>
			                            <th scope="col" class="th-title">제목</th>
			                            <th scope="col" class="th-nick">작성자</th>
			                            <th scope="col" class="th-date">등록일</th>
			                            <th scope="col" class="th-view_cnt">조회수</th>
			                            <th  scope="col" class="th-replyCount">댓글수</th>
			                            <th  scope="col" ></th>
			                            <th></th>
			                        </tr>
			                    </thead>                 
			                    <tbody id="body${Certi_md }">
			                        <c:forEach items="${myCertiList }" var="myCertiList">
			                            <tr id="row${myCertiList.brd_num}">
			                                <td>${num}</td>
			                                <td><a href="detailCommunity?user_num=${myCertiList.user_num}&brd_num=${myCertiList.brd_num}">${myCertiList.title}</a></td>
			                                <td>${myCertiList.nick}</td>
			                                <td><fmt:formatDate value="${myCertiList.reg_date}" pattern="yyyy-MM-dd"/></td>
			                                <td>${myCertiList.view_cnt}</td>
							         		<td>${myCertiList.replyCount}</td>
							         		<td>삭제</td>
							         		<c:set var="num" value="${num-1}"></c:set> 			       
			                            </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			                
							   <div class="page">
							    <c:if test="${myCertiPage.startPage >myCertiPage.pageBlock}">
							        <a href="listCommunity?currentPage=${myCertiPage.startPage-myCertiPage.pageBlock}">[이전]</a>
							    </c:if>
							    <c:forEach var="i" begin="${myCertiPage.startPage}" end="${myCertiPage.endPage}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${Certi_md}, ${i }); return false;" >[${i}]</a>
							    </c:forEach>
							    <c:if test="${myCertiPage.endPage < myCertiPage.totalPage}">
							        <a href="listCommunity?currentPage=${myCertiPage.startPage+myCommuPage.pageBlock}">[다음]</a>
							    </c:if>
							</div>            	
		            	</c:when> 
		            	
		            	<c:otherwise>
		            		<h3>작성한 글이 없습니다.</h3>
		            	</c:otherwise>
		            	
					</c:choose>					
				</div>
			</div>
			<!--------------------------------후기 리스트 --------------------------------------->
			<div class="tab-pane fade" id="myReview-list">
				<div id="myReview">				
					<c:choose>
		            	<c:when test="${not empty myReviewList }">
		            		<c:set var="num" value="${myReviewPage.total - myReviewPage.start+1 }"></c:set> 
			                <table class="boardtable">
			                    <thead>
			                        <tr>
			                            <th scope="col" class="th-num">번호</th>
			                            <th scope="col" class="th-title">제목</th>
			                            <th scope="col" class="th-nick">작성자</th>
			                            <th scope="col" class="th-date">등록일</th>
			                            <th scope="col" class="th-view_cnt">조회수</th>
			                            <th  scope="col" class="th-replyCount">댓글수</th>
			                        </tr>
			                    </thead>                 
			                    <tbody id="body${Review_md}">
			                        <c:forEach items="${myReviewList }" var="myReviewList">
			                            <tr id="row${myReviewList.brd_num }">
			                                <td>${num}</td>
			                                <td><a href="reviewContent?brd_num=${myReviewList.brd_num }&chg_id=${myReviewList.chg_id }">${myReviewList.title}</a></td>
			                                <td>${myReviewList.nick}</td>
			                                <td><fmt:formatDate value="${myReviewList.reg_date}" pattern="yyyy-MM-dd"/></td>
			                                <td>${myReviewList.view_cnt}</td>
							         		<td>${myReviewList.replyCount}</td>
							         		<c:set var="num" value="${num-1}"></c:set> 			       
			                            </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			                
							<div class="page">
							    <c:if test="${myReviewPage.startPage >myReviewPage.pageBlock}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage-myReviewPage.pageBlock}); return false;" >[이전]</a>
							    </c:if>
							    <c:forEach var="i" begin="${myReviewPage.startPage}" end="${myReviewPage.endPage}">					    	
							        <a href="javascript:void(0);" onclick="pageMove(${Review_md}, ${i }); return false;" >[${i}]</a>
							    </c:forEach>
							    <c:if test="${myReviewPage.endPage < myReviewPage.totalPage}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${Review_md},${myReviewPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>
							    </c:if>
							</div>            	
		            	</c:when> 
		            	
		            	<c:otherwise>
		            		<h3>작성한 글이 없습니다.</h3>
		            	</c:otherwise>
		            	
					</c:choose>
					
			</div>
			<!--------------------------------쉐어링 리스트 --------------------------------------->
			<div class="tab-pane fade" id="myShare-list">
				<div id="myShare">
				
					<c:choose>
		            	<c:when test="${not empty myShareList }">
		            		<c:set var="num" value="${mySharePage.total - mySharePage.start+1 }"></c:set> 
			                <table class="boardtable">
			                    <thead>
			                        <tr>
			                            <th scope="col" class="th-num">번호</th>
			                            <th scope="col" class="th-title">제목</th>
			                            <th scope="col" class="th-nick">작성자</th>
			                            <th scope="col" class="th-date">등록일</th>
			                            <th scope="col" class="th-view_cnt">조회수</th>
			                            <th  scope="col" class="th-replyCount">댓글수</th>
			                            <th  scope="col" ></th>
			                        </tr>
			                    </thead>                 
			                    <tbody id="body${Share_md }">
			                        <c:forEach items="${myShareList }" var="myShareList">
			                            <tr id="row${myShareList.brd_num }">
			                                <td>${num}</td>
			                                <td><a href="detailSharing?user_num=${myShareList.user_num}&brd_num=${myShareList.brd_num}">${myShareList.title}</a></td>
			                                <td>${myShareList.nick}</td>
			                                <td><fmt:formatDate value="${myShareList.reg_date}" pattern="yyyy-MM-dd"/></td>
			                                <td>${myShareList.view_cnt}</td>
							         		<td>${myShareList.replyCount}</td>
							         		<td><a href="/deleteCommunity?brd_num=${myShareList.brd_num}">삭제</a></td>
							         		<c:set var="num" value="${num-1}"></c:set> 			       
			                            </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			                
							   <div class="page">
							    <c:if test="${mySharePage.startPage >mySharePage.pageBlock}">
							        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage-mySharePage.pageBlock}); return false;" >[이전]</a>
							    </c:if>
							    <c:forEach var="i" begin="${mySharePage.startPage}" end="${mySharePage.endPage}">
							        <a href="javascript:void(0);" onclick="pageMove(${Share_md}, ${i }); return false;" >[${i}]</a>
							    </c:forEach>
							    <c:if test="${mySharePage.endPage < mySharePage.totalPage}">
							        <a href="javascript:void(0);" onclick="pageMove(${Share_md},${mySharePage.startPage+mySharePage.pageBlock}); return false;" >[다음]</a>
							    </c:if>
							</div>            	
		            	</c:when> 
		            	
		            	<c:otherwise>
		            		<h3>작성한 글이 없습니다.</h3>
		            	</c:otherwise>
		            	
					</c:choose>
					
				</div>
			</div>
			<!--------------------------------자유글 리스트 --------------------------------------->
			<div class="tab-pane fade" id="myCommu-list">
			<div id="myCommu">
				
					<c:choose>
		            	<c:when test="${not empty myCommuList }">
		            		<c:set var="num" value="${myCommuPage.total - myCommuPages.start+1 }"></c:set> 
			                <table class="boardtable">
			                    <thead>
			                        <tr>
			                            <th scope="col" class="th-num">번호</th>
			                            <th scope="col" class="th-title">제목</th>
			                            <th scope="col" class="th-nick">작성자</th>
			                            <th scope="col" class="th-date">등록일</th>
			                            <th scope="col" class="th-view_cnt">조회수</th>
			                            <th  scope="col" class="th-replyCount">댓글수</th>
			                            <th></th>
			                        </tr>
			                    </thead>                 
			                    <tbody>
			                        <c:forEach items="${myCommuList }" var="myCommuList">
			                            <tr>
			                                <td>${num}</td>
			                                <td><a href="detailCommunity?user_num=${myCommuList.user_num}&brd_num=${myCommuList.brd_num}">${myCommuList.title}</a></td>
			                                <td>${myCommuList.nick}</td>
			                                <td><fmt:formatDate value="${myCommuList.reg_date}" pattern="yyyy-MM-dd"/></td>
			                                <td>${myCommuList.view_cnt}</td>
							         		<td>${myCommuList.replyCount}</td>
							         		<td><a href="/deleteCommunity?brd_num=${myCommuList.brd_num}">삭제</a></td>
							         		<c:set var="num" value="${num-1}"></c:set> 			       
			                            </tr>
			                        </c:forEach>
			                    </tbody>
			                </table>
			                
							   <div class="page">
							    <c:if test="${myCommuPage.startPage >myCommuPage.pageBlock}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage-myCommuPage.pageBlock}); return false;" >[이전]</a>
							    </c:if>
							    <c:forEach var="i" begin="${myCommuPage.startPage}" end="${myCommuPage.endPage}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${commu_bd}, ${i }); return false;" >[${i}]</a>
							    </c:forEach>
							    <c:if test="${myCommuPage.endPage < myCommuPage.totalPage}">					        
							        <a href="javascript:void(0);" onclick="pageMove(${commu_bd},${myCommuPage.startPage+myCommuPage.pageBlock}); return false;" >[다음]</a>					        
							    </c:if>
							</div>            	
		            	</c:when> 
		            	
		            	<c:otherwise>
		            		<h3>작성한 글이 없습니다.</h3>
		            	</c:otherwise>
		            	
					</c:choose>
					
			</div>
       
       		<!-- Content -->
			</div>
	
	
	
	       </div>
	            
	            
	
	       </div>
	    </div>
	    
		</div>
        </div>
    
</div>
</div>
</div>

</div>
</div>

    <button type="button" class="btn btn-primary" onclick="location.href='/chgCommManagement'">챌린지 카테고리 관리</button><p>
    <button type="button" class="btn btn-primary" onclick="location.href='/myConts'">내가 쓴 글 </button><p>
</body>
<%@ include file="footer.jsp" %>
</html>