<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>맛있게! 즐겁게! 건강한 습관 커뮤니티 + Life is the best game.</title>
<%@ include file="/WEB-INF/views/header4.jsp" %>
	<script type="text/javascript">
		// 팔로우 하기 버튼
		function following(p_index) {
			$.ajax({
				url : "/followingPro",
				type : "POST",
				data : {user_num : p_index},
				dataType : 'json',
				success : function(followResult) {
	
					if(followResult.following > 0) {
						$(".follow" + p_index).removeClass("btn-danger");
						$(".follow" + p_index).addClass("btn-light");
						$(".follow" + p_index).text("팔로잉");
					} else if(followResult.following == 0) {
						$(".follow" + p_index).removeClass("btn-light");
						$(".follow" + p_index).addClass("btn-danger");
						$(".follow" + p_index).text("팔로우");
					} else {
						alert("자신의 계정은 팔로우 할 수 없습니다");
					}
				},
				error : function() {
					alert("팔로우 오류");
				}
	
			});
			
		}

		// 좋아요 버튼
		function likePro(p_index) {
			var brd_num = $('#brd_num' + p_index).val();
			var like_cnt = $('#like_cnt' + p_index).val();
			var inputLikeCnt = parseInt(like_cnt) + 1;
			alert("inputLikeCnt -> " + inputLikeCnt);

			$.ajax({
	            url: "/likePro",
	            type: "POST",
	            data: { brd_num: brd_num },
	            dataType: 'json',
	            success: function (likeResult) {
	            	if(likeResult.likeProResult > 0) {
	            		// 좋아요 insert
	            		$('#likeBtn' + p_index).attr('src', './images/yr/heart-fill.png');
	            		$('#inputLikeCnt')
	            	} else {
	            		// 좋아요 delete
	            		$('#likeBtn' + p_index).attr('src', './images/yr/heart.png');
	            	}
	            },
	            error: function () {
	                alert("좋아요 에러");
	            }
	        });
		}
	
		// 댓글 버튼
		function comment(p_index) {
			
		}

	</script>
</head>
<body>


	<!-- yr 작성 -->
	<!-- 최신 인증글 -->
	<section class="py-12">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-md-10 col-lg-8 col-xl-6 text-center">
					<!-- Heading -->
					<h2 class="mb-10">소세지들 인증타임</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
		
					<!-- 인증글 시작 -->
					<c:forEach var="certList" items="${chgCertList }" varStatus="status">
						<input type="hidden" id="brd_num${status.index}" value="${certList.brd_num}">
						<input type="hidden" id="like_cnt${status.index }" value="${certList.like_cnt }">
					
						<c:if test="${certList.brd_step == 0 }">

							<div class="mt-3 d-flex justify-content-center">

								<!-- Card -->
								<div class="card-lg card border col-10">
									<div class="card-body">
					
										<!-- Header -->
										<div class="row align-items-center mb-6">

											<!-- 인증 사진 -->
											<div class="col-4">
					
												<a href="/chgDetail?chg_id=${certList.chg_id }">
													<img src="${pageContext.request.contextPath}/upload/${certList.img}" alt="certImg" class="img-fluid">
												</a>
					
											</div>

											<div class="col-8 ms-n2">
					
												<!-- 유저 프로필 사진 -->
						                    	<div class="avatar avatar-lg">
													<img src="${pageContext.request.contextPath}/upload/${certList.user_img}" alt="profile" class="avatar-img rounded-circle">
												</div>
												
												<!-- Nick & Date & follow -->
												<div class="row mb-6">
													<div class="col-12">
														<span class="fs-xs text-muted d-flex justify-content-between">
															
															<span>
																<!-- Nick -->
																<span style="color: black;">${certList.nick}</span>
																<br>
																<!-- Date -->
																<!-- 오늘 날짜 -->
																<jsp:useBean id="javaDate" class="java.util.Date" />
																<fmt:formatDate var="nowDateFd" value="${javaDate }" pattern="yyyy-MM-dd" />
																<fmt:parseDate var="nowDatePd" value="${nowDateFd }" pattern="yyyy-MM-dd" />
																<fmt:parseNumber var="nowDatePn" value="${nowDatePd.time/(1000*60*60*24) }" integerOnly="true" />
																
																<!-- 마지막 작성일자 -->
																<fmt:formatDate var="lastRegDateFd" value="${certList.reg_date }" pattern="yyyy-MM-dd" />
																<fmt:parseDate var="lastRegDatePd" value="${lastRegDateFd }" pattern="yyyy-MM-dd" />
																<fmt:parseNumber var="lastRegDatePn" value="${lastRegDatePd.time/(1000*60*60*24) }" integerOnly="true" />
			
																<c:set var="dDay" value="${nowDatePn - lastRegDatePn}" />
			
																<span>
																	${dDay }일 전
																</span>
															</span>
															
															<!-- follow -->
															<span>
																<c:choose>
																	<c:when test="${certList.followyn == 1}">
																	<!-- 팔로잉 -->
																		<button type="button" class="btn btn-light btn-xxs follow${certList.user_num}" onclick="following(${certList.user_num})">
                                        									팔로잉
                                        								</button>
																	</c:when>
																	
																	<c:otherwise>
																	<!-- 팔로우 -->
																		<button type="button" class="btn btn-danger btn-xxs follow${certList.user_num}" onclick="following(${certList.user_num})">
																			팔로우
																		</button>
																	</c:otherwise>
																</c:choose>
															</span>
														</span>
													</div>
												</div>
												
												<!-- Title & conts -->
												<a href="/chgDetail?chg_id=${certList.chg_id }">
													<!-- Title -->
													<p class="mb-2 fs-lg fw-bold" style="color: black;">
														${certList.title}
													</p>
												
													<!-- conts -->
													<p class="text-gray-500">
														${certList.conts }
													</p>
												</a>
	
												<!-- 좋아요 & 댓글 -->
												<footer class="fs-xs text-muted">
													
													<c:choose>
														<c:when test="${sessionScope.user_num != null }">
															<!-- 로그인 한 상태 -->
															
															<a class="rate-item" data-toggle="vote" href="#" role="button" onclick="likePro(${status.index})">
																좋아요 
																<c:choose>
																	<c:when test="${certList.likeyn > 0}">
																	<!-- 좋아요 눌렀을 때 -->
																		<img alt="heart-fill" src="./images/yr/heart-fill.png" id="likeBtn${status.index }">
																	</c:when>
														
																	<c:otherwise>
																	<!-- 좋아요 안 눌렀을 때 -->
																		<img alt="heart" src="./images/yr/heart.png" id="likeBtn${status.index }">
																	</c:otherwise>
														
																</c:choose>
																<span id="inputLikeCnt">${certList.like_cnt}</span>
															</a>
														</c:when>
													
														<c:otherwise>
															<!-- 로그인 안 한 상태 -->
															<a class="rate-item" data-toggle="vote" data-count="${certList.like_cnt}" href="/loginForm" role="button">
																좋아요 
																<img alt="heart" src="./images/yr/heart.png">
															</a>															
														</c:otherwise>
													
													</c:choose>

													<!-- 댓글 -->
													<a class="rate-item" data-count="${certList.replyCount}" href="#" role="button" onclick="comment(${certList.brd_num})"
													data-bs-toggle="modal" data-bs-target="#showModal">
														댓글
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
															<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
															<path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2"/>
														</svg>
													</a>

												</footer>

												
											</div>
										</div>
									</div>
								</div>
					
							</div>
						</c:if>

						<!-- 댓글 클릭 시 modal -->
						<div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
							  <div class="modal-content">
						  
								<!-- Close -->
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
								  <i class="fe fe-x" aria-hidden="true"></i>
								</button>
						  
								<!-- Header-->
								<div class="modal-header lh-fixed fs-lg">
								  <strong class="mx-auto">비밀번호 찾기</strong>
								</div>
						  
								<!-- Body -->
								<div class="modal-body text-center">
						  
								  <!-- Text -->
								  <p class="mb-7 fs-sm text-gray-500">
										아이디와 이메일을 입력해주세요 <br>
										해당 이메일로 새로운 비밀번호를 발급 받으실 수 있습니다
								  </p>
						  
								  <!-- Form -->
								  <form action="/sendMailForResetPswd">
									  
									<!-- 아이디 -->
									<div class="form-group">
									  <label class="visually-hidden" for="modalPasswordResetEmail">
											아이디 *
									  </label>
									  <input class="form-control form-control-sm" id="modalPasswordResetEmail" name="user_id" type="text"  placeholder="아이디 " required>
									</div>
											
									<!-- Email -->
									<div class="form-group">
									  <label class="visually-hidden" for="modalPasswordResetEmail">
											이메일 *
									  </label>
									  <input class="form-control form-control-sm" id="modalPasswordResetEmail" name="email" type="email" placeholder="이메일 you@xxx.xxx" required>
									</div>
									
								 
						  
									<!-- Button type ="submit을" 안걸어도 알아서 연동됨 ;; 왜지?-->
									<button class="btn btn-sm btn-dark">
										  비밀번호 리셋
									</button>
						  
								  </form>
						  
								</div>
						  
							  </div>
						  
							</div>
						</div>


					</c:forEach>
				</div>
			</div>
		</div>
	</section>	
	
	
	
	
	
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>