<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header4.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript">
	function ajaxChallengeList(pChg_md){
		$.ajax({
			url: '/recommendCallenge',
			data: {chg_md : pChg_md},
			dataType:'json',
			success:function(RecommendationResult){
				alert("RecommendationResult -> "+RecommendationResult.recomChgListSize);
				 var text = recomList(RecommendationResult);
		            $('#hiddenCard').show();
		            $("#hiddenCard .flickity-page-dots-progress").html(text);
			}
		})
	}
	
	 function recomList(RecommendationResult){
		 var text = "";
	     for(var i = 0; i < RecommendationResult.recomChgListSize; i++ ){
			alert("title -> " + RecommendationResult.recomChgList.title );
	      }
	      return text;
	   }
				
				
				
				
				
			
</script>
<title>당신만의 챌린지를 신청하세요</title>
</head>
<body>
<button onclick="location.href='/modify'"></button>
 <section class="pt-7 pb-12">
      <div class="container">
        <div class="row">
          <div class="col-12 text-center">

            <!-- Heading -->
            <h3 class="mb-10">챌린지 신청</h3>

          </div>
        </div>
        
        <div class="row">
        <!-- 나중에 진짜 사이드바 만들면 추가하기 -->
         <%@ include file="/WEB-INF/views/jh/side.jsp" %>
         
          <div class="col-12 col-md-9 col-lg-8 offset-lg-1">
			<h5>${user.nick }님이 원하시는 챌린지는?</h5>
            <!-- Form -->
            <form>
              <input type="hidden" name="user_num" value="${user.user_num}">
<%-- 필요한가
			  <input type="hidden" name="userStatus" value="${userStatus}">
 --%>              
 			  <div class="row">
 			  
 			  
                <div class="col-12">
				
                  <!-- 카테고리 -->
                  <div class="form-group">
                  	<label class="form-label" for="accountFirstName">
                     	카테고리
                    </label>
                    <div class="input-group mb-3  d-flex justify-content-between border-1">
                    	<div class="input-group-text border-0">
							<input class="form-check-input" 
							       type="radio" 
							       name="chg_md" 
							       id="exercise" 
							       value="100"  
							       required="required"
							       onclick="ajaxChallengeList(100)">
                    		<label class="form-check-label" for="exercise">운동</label>
                    	</div>
                    
	                    <div class="input-group-text border-0">
	                    	<input class="form-check-input" 
	                    	type="radio" 
	                    	name="chg_md" 
	                    	id="studying" 
	                    	value="101"
	                    	 onclick="ajaxChallengeList(101)">
	                    	<label class="form-check-label" for="studying">공부</label>
	                    </div>
                    
	                    <div class="input-group-text border-0">
	                    	<input class="form-check-input" 
	                    	type="radio" 
	                    	name="chg_md" 
	                    	id="hobby" 
	                    	value="102"
	                    	 onclick="ajaxChallengeList(102)">
	                    	<label class="form-check-label" for="hobby">취미</label>
	                    </div>
                    
	                    <div class="input-group-text border-0">
	                    	<input class="form-check-input" 
	                    	type="radio" 
	                    	name="chg_md" 
	                    	id="habit" 
	                    	value="103"
	                    	onclick="ajaxChallengeList(103)">
	                    	<label class="form-check-label" for="habit">습관</label>
	                    </div>
					</div>
                  </div>

                </div>
                

				
			    <!-- ARRIVALS -->
			      <div class="container">
			        <div class="row">
			          <div class="col-12">
			
			            <!-- Heading -->
			            <span class="mb-10">이런 챌린지는 어떠세요?</span><p>
							<div class="alert alert-warning">
							카테고리를  선택하시면 기존에 개설된 챌린지 리스트가 나옵니다!
							</div>
			          </div>
			        </div>
			      </div>
			      <div id="hiddenCard" style="display: none;">
				      <div class="flickity-page-dots-progress" data-flickity='{"pageDots": true}'>
				

				       </div>
			       </div>
        
				
                <div class="col-12">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="title">
                      	챌린지명
                    </label>
                    <input class="form-control form-control-sm" id="title" type="text" name="title" required>
                  </div>

                </div>
                
                
                <div class="col-12">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="title">
                      	챌린지 소개
                    </label>
                    <textarea class="form-control form-control-sm" rows="5" id="chg_conts" type="text" name="chg_conts" required placeholder="예) 건강을 위해서 우리 다함께 매일 만보를 걷는 챌린지를 해봐요~"></textarea>
                  </div>

                </div>
                
                

                <div class="col-12">
                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="end_date">
                     	종료 날짜
                    </label>
                    <div class="alert alert-warning">
						관리자가 승인하면 그때부터 챌린지가 시작됩니다!<br>
						승인까지 3~5일이 소요되니 이 점 유의하시고 종료 날짜를 선택해 주시길 바랍니다.
					</div>
                    <input class="form-control form-control-sm" name="end_date" id="end_date" type="date" required>
                  </div>

                </div>
                
                
                
                <div class="col-12 col-md-6">

                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="chg_capacity">
                      	참여 인원
                    </label>
                    <input type="number" class="form-control" name="chg_capacity" id="chg_capacity" max="50" min="1"  required="required">
                  </div>

                </div>
                <div class="col-12">
                  <!--  -->
                  <div class="form-group">
                    <label class="form-label" for="freq">
                     	인증 빈도
                    </label>
					<select class="form-select" id="freq" name="freq" required="required">
				    <option selected value="" selected disabled hidden>일주일에 인증할 횟수를 선택해 주세요</option>
				    <option value="1">1일</option>
				    <option value="2">2일</option>
				    <option value="3">3일</option>
				    <option value="4">4일</option>
				    <option value="5">5일</option>
				    <option value="6">6일</option>
				    <option value="7">매일</option>
				  	</select>
                  </div>

                </div>
                
                
                <div class="col-12 ">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="verificationMethod">
                      	인증 방법
                    </label>
					<input type="text" class="form-control" placeholder="예)하루 만보 걷기 챌린지 : 매일 만보를 걷고 만보가 적힌 만보기 사진을 올려주세요 " id="verificationMethod" name="upload"  required="required">
                  </div>

                </div>
                
                <div class="col-12">

                  <!-- 인증예시 사진 -->
                  <div class="form-group">
                    <label class="form-label" for="accountEmail">
                      	인증 예시
                    </label>
					<input type="file" class="form-control" id="inputGroupFile01" name="sample_img">
                  </div>

                </div>
                
                 <div class="col-12 col-lg-6">

                  <!-- Gender -->
                  <div class="form-group mb-3">

                    <!-- Label -->
                    <label class="form-label">공개 여부</label>
                    <!-- Inputs -->
                    <c:choose>
                    	<c:when test="{user.status_md = 101}">
	                    	<div>
		                      <!-- Male -->
		                      <input class="btn-check" type="radio" name="chg_public" id="public" checked>
		                      <label class="btn btn-sm btn-outline-border" for="public">공개</label>
		
		                      <!-- Female -->
		                      <input class="btn-check" type="radio" name="chg_public" id="private">
		                      <label class="btn btn-sm btn-outline-border" for="private">비공개</label>
		
		                    </div>
                    	</c:when>
                    	<c:otherwise>
                    		<p>멤버십 가입자만 공개/비공개 설정을 할 수 있습니다~!
	                    	<div>
		                      <!-- Male -->
		                      <input class="btn-check" type="radio" name="chg_public" id="public" disabled>
		                      <label class="btn btn-sm btn-outline-border" for="public">공개</label>
		
		                      <!-- Female -->
		                      <input class="btn-check" type="radio" name="chg_public" id="private" disabled>
		                      <label class="btn btn-sm btn-outline-border" for="private">비공개</label>
		                    </div>
                    	</c:otherwise>
                    </c:choose>
                    

                  </div>

                </div>
                
                
                <div class="col-12 col-md-6">

                  <!-- Password -->
                  <div class="form-group mb-3">
                    <label class="form-label" for="priv_pswd">
                      	비밀번호
                    </label>
                     <c:choose>
                    	<c:when test="{user.status_md = 101}">
							<input type="password" class="form-control" id="priv_pswd" name="priv_pswd"  required="required">
					 	</c:when>
					
                     	<c:otherwise>
							<input type="password" class="form-control" id="priv_pswd" name="priv_pswd"  disabled required="required">
					 	</c:otherwise>
                    </c:choose>
                  </div>

                </div>
                
                <div class="col-12">

                  <!-- 챌린지명 -->
                  <div class="form-group">
                    <label class="form-label" for="title">
                      	썸네일
                    </label>
					<input type="file" class="form-control" id="inputGroupFile01" name="thumb">
                  </div>

                </div>
         
               
                <div class="col-12">

                  <!-- Button -->
                  <button class="btn btn-dark" type="submit">Save Changes</button>

                </div>
              </div>
            </form>

          </div>
        </div>
      </div>
    </section>


</body>
</html>