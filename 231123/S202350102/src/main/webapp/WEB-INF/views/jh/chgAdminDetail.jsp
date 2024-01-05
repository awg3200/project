<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/topBar.jsp" %>
<%@ include file="/WEB-INF/views/header4.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 왜 적용 안됨? */
	th {
	    background-color: #FFB4B4;
	  }
</style>
<script type="text/javascript">
	/* 현재 페이지 클릭시 수정 해야함 */
/* 	function currentPageMove(){
	 	var state_md = ${state_md}
	    var chg_lg = ${chg_lg}
	    var chg_md = ${chg_md}
	    var sortOpt = $('#sortOpt').val()
	    var currentPage = ${page.currentPage}
	    
		location.href = "chgAdminList?state_md="+state_md+"&chg_lg="+chg_lg+"&chg_md="+chg_md+"&sortOpt="+sortOpt+"&currentPage="+currentPage;
			
	} */
	
	function approvReturnFn(pApprovReturn){
		var approvReturn	= pApprovReturn
		var chg_id			= ${chg.chg_id}
		var state_md		= ${chg.state_md}
		var user_num		= ${chg.user_num}
		
		if(approvReturn == 1){
			alert("pApprovReturn 승인 -> " + pApprovReturn);
			
			location.href = "approvReturn?chg_id="+chg_id+"&state_md="+state_md+"&user_num="+user_num+"&approvReturn="+approvReturn;
			
		} else{
			alert("pApprovReturn 반려 -> " + pApprovReturn);
			
			$('#returnModal').modal('show')
		}
	}
	
	
	/* function chk(pApprovReturn){
		var approvReturn	= pApprovReturn
		var return_md		= ${rtnReason.md }
		var chg_id			= ${chg.chg_id}
		var state_md		= ${chg.state_md}
		
		location.href = "approvReturn?chg_id="+chg_id+"&state_md="+state_md+"&return_md="+return_md+"&approvReturn="+approvReturn;
	} */
</script>
</head>
<body>
<!-- MODALS -->
    <!-- Newsletter: Horizontal -->
    <div class="modal fade" id="returnModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
    
          <!-- Close -->
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            <i class="fe fe-x" aria-hidden="true"></i>
          </button>
    
          <!-- Content -->
          <div class="row gx-0">
            <div class="col-12 col-lg-12 d-flex flex-column px-md-8">
    
              <!-- Body -->
              <div class="modal-body my-auto py-10">
    
                <!-- Heading -->
                <h4>챌린지 신청 반려</h4>
    
                <!-- Text -->
                <p class="mb-7 fs-lg">
                  	반려 사유를 선택해 주세요
                </p>
    
                <!-- Form -->
                <form action="/approvReturn" onsubmit="return chk(0)">
                  <div class="row gx-5">
                    <div class="col">
    
                      <!-- Input -->
                      <select class="form-select" id="return_md" name="return_md" required="required">
                      	<c:forEach var="rtnReason" items="${returnReason }" varStatus="status">
                      		<option value="${rtnReason.md }">${rtnReason.ctn }</option>
                      	</c:forEach>
                      </select>
    
                    </div>
                    <div class="col-auto">
    
                      <!-- Button -->
                      <button class="btn btn-sm btn-dark" type="submit" >
                        <i class="fe fe-send"></i>
                      </button>
    
                    </div>
                  </div>
                </form>
    
              </div>
    
            </div>
          </div>
    
        </div>
    
      </div>
    </div>
<section class="py-11">
 <div class="container">
        <div class="row">
          <div class="col-12 text-center">
			
            <!-- Heading -->
            <div class="pt-10 pb-5">
            
            	<h3 class="mb-10">
            	<c:choose>
            		<c:when test="${state_md ==102 }">
		            	진행중 
            		</c:when>
            		<c:when test="${state_md ==103 }">
            			종료
            		</c:when>
            		<c:when test="${state_md ==104 }">
            			반려
            		</c:when>
            		<c:otherwise>
            			신청
            		</c:otherwise>
            	</c:choose>
            	챌린지 관리</h3>
            </div>

          </div>
        </div>
        
        <div class="row">
        <!--사이드바   -->
        <%@ include file="adminSidebar.jsp" %>
        
        <div class="col-10">
		<table class="table table-bordered table-sm mb-0">
			    <tr>
			      <th scope="row">챌린지명</th>
			      <td>${chg.title }</td>
			      <th rowspan="3">썸네일</th>
				  <td rowspan="3">
				  <c:choose>
				  	<c:when test="${chg.thumb !=null }">
	                  	<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.thumb }" alt="이미지를 불러오는 데 실패했습니다." style="width: 100%; height: 150px; border-radius: 10px;" >
				  	</c:when>
				  	<c:otherwise>
	                  	<img class="card-img-top" src="assets/img/chgDfaultImg.png" alt="userDfault" style="width: 100%; height: 150px; border-radius: 10px;">
				  	</c:otherwise>
				  </c:choose>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 닉네임</th>
			      <td>${chg.nick }</td>
			    </tr>
			    <tr>
			      <th scope="row">개설자 이름</th>
			      <td>${chg.userName }</td>
			    </tr>
			    <tr>
			      <th scope="row">카테고리</th>
			      <td>${chg.ctn }</td>
			      <th>진행상태</th>
			      <td>${chg.stateCtn }</td>
			    </tr>
			    <tr>
			    	<c:if test='${chg.state_md == 104 }'>
				      <th scope="row">반려사유</th>
				      <td colspan="3">${chg.returnReason }</td>
			    	</c:if>
			    </tr>
			    <tr>
			      <th scope="row">참가자수    /  참여정원</th>
			      <td> ${chgrParti }  / ${chg.chg_capacity }</td>
			      <th>찜수</th>
				  <td>${chg.pick_cnt }</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 소개</th>
			      <td colspan="3">${chg.chg_conts }</td>
			    </tr>
			    <tr>
			      <th scope="row">인증방법</th>
			      <td colspan="3">${chg.upload }</td>
			    </tr>
			    
			    <tr>
				    <th scope="row">인증빈도</th>
				      <td>${chg.freq }</td>
				      <th rowspan="3">인증 예시</th>
					  <td rowspan="3">
		                  	<img class="card-img-top" src="${pageContext.request.contextPath}/upload/${chg.sample_img }" alt="userImg" style="width: 100%; height: 150px; border-radius: 10px;" >
					  </td>
				</tr>
			    <tr>
			      <th scope="row">공개여부</th>
			      <td>
					<c:choose>
						<c:when test="${chg.chg_public == 1 }">비공개</c:when>
						<c:otherwise>공개</c:otherwise>
					</c:choose>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">비밀번호</th>
			      <td>${chg.priv_pswd}</td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 신청일</th>
			      <td colspan="3"><fmt:formatDate value="${chg.reg_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 개설일</th>
			      <td colspan="3"><fmt:formatDate value="${chg.create_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    </tr>
			    <tr>
			      <th scope="row">챌린지 종료일</th>
			      <td colspan="3"><fmt:formatDate value="${chg.end_date }" pattern="yyyy년 MM월 dd일"></fmt:formatDate></td>
			    </tr>
		</table>
		<div class="d-flex justify-content-start mt-5">
			<button class="btn btn-sm btn-dark mx-1" onclick="currentPageMove()">목록</button>
			
			<c:choose>
				<c:when test="${chg.state_md == 100 }">
					<button class="btn btn-sm btn-dark mx-1" onclick="approvReturnFn(1)" id="approval"  >승인</button>
					<button class="btn btn-sm btn-dark mx-1" onclick="approvReturnFn(0)" id="return" >반려</button>
				</c:when>
			</c:choose>
			<!-- 탈퇴여부에따라 보이는 버튼이 탈퇴 / 활성화로 바뀜  -->
			<c:if test="${chg.state_md == 102 }">			      
				<button class="btn btn-sm btn-dark mx-1" id="updateBtn" onclick="updateFn()">수정</button>
			</c:if>
			<c:if test="${chg.state_md == 102 || chg.state_md == 103}">
				<button class="btn btn-sm btn-info mx-1" id="deleteBtn" onclick="deleteFn()">삭제</button>
			</c:if>
		</div>	
		</div>
		<div class="py-10"></div>	
	</div>	<!-- adminMenu.jsp 에서 <div class="row"> 닫기 용   -->
	</div>  <!-- adminMenu.jsp 에서 <div class="container"> 닫기용 -->
      </div>
      </div>
      </section>    
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %> <!-- 이렇게해야 푸터가 꽉차게 들어감 -->
</html>