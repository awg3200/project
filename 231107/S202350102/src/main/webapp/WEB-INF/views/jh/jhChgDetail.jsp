<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    .list-group-horizontal-sm .list-group-item {
        border: none; /* 테두리 없애기 */
    }
</style>
<title>Insert title here</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	// yr 작성
  // 챌린지 신청 완료 후 body onload 실행
	function chgResultModalClickTest() {
		document.getElementById("chgResultModalClick").click();
	}

  // 챌린지 신청 시 작동
	function cJoin() {
		var sendData = $('#cJoinForm').serialize();	// user_num=?&chg_id=?
		location.href="chgJoinPro?" + sendData;     // YrController에서 작동됨
	}
	
	
/* 	$(document).ready(function() {
		
			$('#description').removeClass('active'); // 기존 활성 탭 비활성화
	        $('#review').addClass('active'); // 새로운 탭 활성화
	        
			$('#descriptionTab').removeClass('show active'); // 기존 활성 탭 비활성화
	        $('#reviewTab').addClass('show active'); // 새로운 탭 활성화
	        
			const offset = $("#reviewTab").offset();
			$('html, body').animate({scrollTop: offset.top}, 0); 
	});
 */

</script> 
</head>
<body onload="chgResultModalClickTest()">  <!-- 챌린지 신청 완료 후 신청완료 modal창 띄우기 -->
    <!-- BREADCRUMB -->
    <nav class="py-5">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Breadcrumb -->
            <ol class="breadcrumb mb-0 fs-xs text-gray-400">
              <li class="breadcrumb-item">
                <a class="text-gray-400" href="index.html">챌린지</a>
              </li>
              <li class="breadcrumb-item">
                <a class="text-gray-400" href="shop.html">${chg.ctn }</a>
              </li>
              <li class="breadcrumb-item active">${chg.title }
                	
              </li>
            </ol>

          </div>
        </div>
      </div>
    </nav>

<!-- PRODUCT -->
    <section>
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="row">
              <div class="col-12 col-md-6">

                <!-- Card -->
                <div class="card">

                  <!-- Badge -->
                  <div class="badge bg-primary card-badge text-uppercase">
                                    인기
                                    <!-- 찜수  -->
                  </div>

                  <!-- Slider -->
                  <div class="mb-4" data-flickity='{"draggable": false, "fade": true}' id="productSlider">


                    <!-- Item -->
                      <img src="assets/img/chgDfaultImg.png" alt="${chg.title }" class="card-img-top" onerror="assets/img/chgDfaultImg.png">
             <!--썸네일 처리 해야 함 파일 위치랑 null일 때 뜨게 할 것  -->
                  </div>
                </div>


              </div>
              <div class="col-12 col-md-6 ps-lg-10">

                <!-- Heading -->
                <h3 class="mb-2">${chg.title }</h3>
                
                
                <div class="col-12 col-md-6">


                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">개설자</li>
                    <li class="list-group-item">${chg.nick }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                      <li class="list-group-item">참여 인원</li>
                    <li class="list-group-item">${chgrParti } / ${chg.chg_capacity }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">진행 기간</li>
                    <li class="list-group-item"><fmt:formatDate value="${chg.start_date }" pattern="yyyy-MM-dd"/> ~ <fmt:formatDate value="${chg.end_date }" pattern="yyyy-MM-dd"/> </li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">진행 상태</li>
                    <li class="list-group-item">${chg.stateCtn }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">인증 빈도</li>
                    <li class="list-group-item">${chg.freq }</li>
                  </ul>
                  <ul class="list-group list-group-horizontal-sm">
                    <li class="list-group-item">챌린지 찜</li>
                    <li class="list-group-item">${chg.pick_cnt }</li>
                  </ul> 
               
               
                  <div class="form-group">
                    <div class="row gx-5 mb-7">
                      <!-- 참여하기 -->
                      <!-- YR 작업 중 -->
                      <div class="col-12 col-lg">
                        <c:choose>
                        
                          <c:when test="${sessionScope.user_num != null}">
                            <!-- 로그인 한 상태 -->
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
                              참여하기
                            </button>
                        
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                              <div class="modal-dialog">
                        
                                <c:choose>
                        
                                  <c:when test="${chg.chg_capacity == chgrParti }">
                                    <!-- 참여 정원 = 참가 인원 -->
                                    <div class="modal-content">
                                      <div class="modal-body">
                                        <p>참여인원이 마감되었습니다</p>
                                      </div>
                                      <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">취소하기</button>
                                      </div>
                                    </div>
                        
                                  </c:when>
                        
                                  
                                  <c:otherwise>

                                    <c:choose>

                                      <c:when test="${chgrYN == 1 }">
                                        <!-- 이미 챌린지 참여함 -->
                                        <div class="modal-content">
                                          <div class="modal-body">
                                            <p>이미 참여한 챌린지입니다</p>
                                          </div>
                                          <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">취소하기</button>
                                          </div>
                                        </div>
                                      </c:when>
                                      
                                      
                                      <c:otherwise>
                                        <!-- 챌린지 참가 -->
                                        <div class="modal-content">
                                          <div class="modal-body">
                                            <p>현재 참여 인원 : ${chgrParti } / 참여 정원 : ${chg.chg_capacity}</p>
                                            <p>${user.nick }님 챌린지에 참여하시겠습니까?</p>
                                          </div>
                                          <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">취소하기</button>
                                            <button type="button" class="btn btn-danger" onclick="cJoin()">참여하기</button>
                                            <form id="cJoinForm">
                                              <input type="hidden" name="user_num" value="${user.user_num}">
                                              <input type="hidden" name="chg_id" value="${chg.chg_id}">
                                            </form> 
                                          </div>
                                        </div>
                                      
                                      </c:otherwise>
                                      
                                    </c:choose>
                                    
                                  </c:otherwise>
                        
                                </c:choose>
                                
                              </div>
                            </div>
                        
                          </c:when>
                        
                          <c:when test="${sessionScope.user_num == null}">
                            <!-- 로그인 안 한 상태 -->
                            <button type="button" class="btn btn-danger" onclick="location.href='/loginForm'">
                              참여하기
                            </button>
                          </c:when>
                        
                        </c:choose>

                      </div>
                      
                      <!-- 참여완료 YN -->
                      <button type="button" class="btn btn-danger" id="chgResultModalClick" data-bs-toggle="modal" data-bs-target="#chgResultModal" hidden>
                       	참여완료
                      </button>
                      
                      <!-- 챌린지 참여 성공 -->
                      <c:if test="${insertResult > 0}">
                        <div class="modal fade" tabindex="-1" id="chgResultModal" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-body">
                                <p>챌린지 참여가 완료되었습니다</p>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">닫기</button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </c:if>
                        

                      <!-- 찜하기 -->
                      <div class="col-12 col-lg-auto">

                        <!-- Wishlist -->
                        <button class="btn btn-outline-dark w-100 mb-2" data-toggle="button">
                          	챌린지 찜 <i class="fe fe-heart ms-2"></i>
                        </button>

                      </div>
                    </div>


                    <!-- Share -->
                    <p class="mb-0">
                      <span class="me-4">Share:</span>
                      <a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
                        <i class="fab fa-twitter"></i>
                      </a>
                      <a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
                        <i class="fab fa-facebook-f"></i>
                      </a>
                      <a class="btn btn-xxs btn-circle btn-light fs-xxxs text-gray-350" href="#!">
                        <i class="fab fa-pinterest-p"></i>
                      </a>
                    </p>

                  </div>
                </form>

              </div>
            </div>
          </div>
        </div>
      </div>
    </section>



 <!-- DESCRIPTION -->
    <section class="pt-11">
      <div class="container">
        <div class="row">
          <div class="col-12">

            <!-- Nav -->
            <div class="nav nav-tabs nav-overflow justify-content-start justify-content-md-center border-bottom">
              <a class="nav-link active" data-bs-toggle="tab" href="#descriptionTab">
               	 챌린지 소개
              </a>
              <a class="nav-link" data-bs-toggle="tab" href="/certBoard?chg_id="+"${chg.chg_id }">
                             인증 게시판
              </a>
              <a class="nav-link" data-bs-toggle="tab" href="/ssjFriends?chg_id="+"${chg.chg_id }">
                             소세지들
              </a>
              
              <!-- 일단 기본 활성화 상태로 두었다가 시간 남으면 챌린지 종료되면 활성화 되게 하기  -->
              <a class="nav-link" data-bs-toggle="tab" href="#reviewTab">
                             후기 게시판
              </a>
            </div>
			
            <!-- Content -->
            <div class="tab-content">
              <div class="tab-pane fade show active" id="descriptionTab">
                <div class="row justify-content-center py-9">
                  <div class="col-12 col-lg-10 col-xl-8">
                    <div class="row">
                      <div class="col-12">

                        <!-- Text -->
                        <p class="text-gray-500">
                        <!-- 유저닉은 로그인 유지 되는지 확인하기 위한 것 나중에 삭제 예정 -->
                        	${user.nick} <p>
							${chg.chg_conts }<p>
							인증방법 : ${chg.upload }<p>
							<img alt="인증예시" src="${sample_img }">
                        </p>

                      </div>
                      
                    </div>
                  </div>
                </div>
              </div>
              
              
            <c:choose>
            	<c:when test="${chg.stateCtn == '종료'}">
   	              <div class="tab-pane fade" id="reviewTab">
	                <div class="row justify-content-center py-9">
	                  <div class="col-12 col-lg-10 col-xl-8">
	                  	 <!-- Heading -->
				            <h4 class="mb-10 text-center">후기 게시판</h4>
				
				            <!-- Header -->
				            <div class="row align-items-center">
				              <div class="col-12 col-md-auto">
				
				                <strong class="fs-sm ms-2">유저 아이디</strong>
				               		
				              </div>
				              <div class="col-12 col-md text-md-center">
				
				              
				
				                <!-- Count -->
				                <strong class="fs-sm ms-2">총 리뷰수 : ${reviewTotal }</strong>
				
				              </div>
				              <div class="col-12 col-md-auto">
				
				                <!-- Button -->
				                <a class="btn btn-sm btn-dark" data-bs-toggle="collapse" href="#reviewForm">
				                  Write Review
				                </a>
				
				              </div>
				            </div>
				
				            <!-- New Review -->
				            <div class="collapse" id="reviewForm">
				
				              <!-- Divider -->
				              <hr class="my-8">
				
				              <!-- Form -->
				              <form>
				                <div class="row">
				                  <div class="col-12 mb-6 text-center">
				
				                    <!-- Text -->
				                    <p class="mb-1 fs-xs">
				                      Score:
				                    </p>
				
				                    <!-- Rating form -->
				                    <div class="rating-form">
				
				                      <!-- Input -->
				                      <input class="rating-input" type="range" min="1" max="5" value="5">
				
				                      <!-- Rating -->
				                      <div class="rating h5 text-dark" data-value="5">
				                        <div class="rating-item">
				                          <i class="fas fa-star"></i>
				                        </div>
				                        <div class="rating-item">
				                          <i class="fas fa-star"></i>
				                        </div>
				                        <div class="rating-item">
				                          <i class="fas fa-star"></i>
				                        </div>
				                        <div class="rating-item">
				                          <i class="fas fa-star"></i>
				                        </div>
				                        <div class="rating-item">
				                          <i class="fas fa-star"></i>
				                        </div>
				                      </div>
				
				                    </div>
				
				                  </div>
				                  <div class="col-12 col-md-6">
				
				                    <!-- Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewName">Your Name:</label>
				                      <input class="form-control form-control-sm" id="reviewName" type="text" placeholder="Your Name *" required>
				                    </div>
				
				                  </div>
				                  <div class="col-12 col-md-6">
				
				                    <!-- Email -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewEmail">Your Email:</label>
				                      <input class="form-control form-control-sm" id="reviewEmail" type="email" placeholder="Your Email *" required>
				                    </div>
				
				                  </div>
				                  <div class="col-12">
				
				                    <!-- Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewTitle">Review Title:</label>
				                      <input class="form-control form-control-sm" id="reviewTitle" type="text" placeholder="Review Title *" required>
				                    </div>
				
				                  </div>
				                  <div class="col-12">
				
				                    <!-- Name -->
				                    <div class="form-group">
				                      <label class="visually-hidden" for="reviewText">Review:</label>
				                      <textarea class="form-control form-control-sm" id="reviewText" rows="5" placeholder="Review *" required></textarea>
				                    </div>
				
				                  </div>
				                  <div class="col-12 text-center">
				
				                    <!-- Button -->
				                    <button class="btn btn-outline-dark" type="submit">
				                      Post Review
				                    </button>
				
				                  </div>
				                </div>
				              </form>
				
				            </div>
	                  	
		                    <!-- Table -->
		                    <div class="table-responsive">     
                    			<c:set var="num" value="${reviewPage.total-reviewPage.start+1 }"></c:set>
								<table class="table table-bordered table-sm table-hover" border="1">
								       <thead>
								         <tr>
								           <th>글번호</th>
								           <th>제목</th>
								           <th>작성자</th>
								           <th>조회수</th>
								           <th>작성일</th>
								         </tr>
								       </thead>
								       <tbody>
								         <c:forEach var="review" items="${chgReviewList}">
								          <tr>
								            <td>${num }</td>
								            <td><a href="/reviewContent?brd_num=${review.brd_num}&chg_id=${chg.chg_id}">${review.title }</a></td>
								            <td>${review.nick }</td>
								            <td>${review.view_cnt }</td>
								            <td><fmt:formatDate value="${review.reg_date }" pattern="yyyy-MM-dd"/></td>
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
								      <a class="page-link page-link-arrow" href="chgDetail?currentPage=${reviewPage.startPage-reviewPage.pageBlock }">
								        <i class="fa fa-caret-left"></i>
								      </a>
					              </c:if>
								    </li>
						          <c:forEach var="i" begin="${reviewPage.startPage }" end="${reviewPage.endPage }">
								    <li class="page-item active">
								      <a class="page-link" href="chgDetail?currentPage=${i}">${i}</a>
								    </li>
						          </c:forEach>
						          <c:if test="${reviewPage.endPage < reviewPage.totalPage }">
								    <li class="page-item">
								      <a class="page-link page-link-arrow" href="chgDetail?currentPage=${reviewPage.startPage+reviewPage.pageBlock }">
								        <i class="fa fa-caret-right"></i>
								      </a>
								    </li>
						          </c:if>
								  </ul>
								</nav>

                  			</div>
               			</div>
              		</div>
           		</c:when>
            
            	<c:otherwise>
            	<div class="tab-pane fade" id="reviewTab">
	                <div class="row justify-content-center py-9" >
	                  <div class="col-12 col-lg-10 col-xl-8">
            			<h5>챌린지가 종료된 후 후기를 써주세요</h5>
            		  </div>
            		</div>
            	</div>
            	</c:otherwise>
            </c:choose>
            
					
            </div>

          </div>
        </div>
      </div>
    </section>








</body>
</html>