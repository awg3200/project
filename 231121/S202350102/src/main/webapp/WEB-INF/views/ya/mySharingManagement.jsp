<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header4.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);
    	body{
    	font-family: 'Noto Sans KR', sans-serif;} 
</style>
</head>
<body>
<!-- 필수!! -->
 <div class="container">
         <div class="row profile">
            <div class="col-md-3">
                <%@ include file="../mypageMenu.jsp" %>
            </div>
             <div class="col-md-9 profile-form">
<!-- 필수!! -->

<!--내가 개설한 쉐어링 제목 누르면  brd_num으로 해당하는 상세페이지로 이동시키게 설정하기----------------------------------------------------- -->
    <section class="myUploadSharing">
        <div class="page-title">
            <div class="container">
                <h6>내가 올린 쉐어링 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">
                <table class="table table-sm"  style="font-size: 0.75rem;">
                     <thead class="table-dark">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants">모집인원</th>
                            <th scope="col" class="th-particpants">승인처리한참가인원</th>
                            <th scope="col" class="th-bank_duedate">입금기한</th>
                            <th scope="col" class="th-check">지원자</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board" items="${myUploadSharingList}">
                            <tr>
                                <td>${board.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.applicants}</td>            
                                <td>${board.participants}</td>      
                                <td>${board.bank_duedate}</td>
				         		<td><button type="button" class="btn btn-dark btn-sm openModalButton" data-toggle="modal" data-target="#joinInfoModal" 
				         					data-brd_num="${board.brd_num}"> 조회</button></td>       
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
    </section>
    <!--내가 신청한 쉐어링 joinsharingList ------------------------------------------------------------------------------ -->
	    <section class="myJoinSharing">
        <div class="page-title">
            <div class="container">
                <h6>내가 참가한 쉐어링 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">

                <table class="table table-sm"  style="font-size: 0.75rem;">           
                     <thead class="table-dark">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-applicants">승인상태</th>
                            <th scope="col" class="th-bank_duedate">반려사유</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="sharingList" items="${myJoinSharingList}">
                            <tr>
                                <td>${sharingList.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${sharingList.brd_num}">${sharingList.title}</a></td>
                                 <td>
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 100}">신청완료</c:when>
                                 		<c:when test="${sharingList.state_md == 101}">승인완료</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>                  
                                <td>${sharingList.reject_msg} </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
    </section>
    
 <!--승인완료된 쉐어링 정보 -------------------입금액(총금액/모집인원   ?? ------------------------------------------------------------- -->   
    <section class="myUploadSharing">
        <div class="page-title">
       		 <div class="container">
                <h6>거래할 쉐어링 </h6>
            </div>
        </div>
      <!-- 게시판리스트  -->
        <div id="board-list">
            <div class="container">
            <input type="hidden" value="${board.brd_num }">
                <table class="table table-sm"  style="font-size: 0.75rem;">
                     <thead class="table-dark">
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-bank_info">계좌정보</th>
                            <th scope="col" class="th-price">입금액</th>
                            <th scope="col" class="th-bank_duedate">입금기한</th>
                            <th scope="col" class="th-addr">거래주소</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="board"  items="${myConfirmSharingList}">
                         <input type="hidden" value="${board.applicants}">
                            <tr>
                                <td>${board.brd_num}</td>
                                <td><a href="detailSharing?brd_num=${board.brd_num}">${board.title}</a></td>
                                <td>${board.bank_info}</td>    
                                <td><fmt:formatNumber value="${board.price div board.applicants}" pattern="#,###"/></td>        
                                <td>${board.bank_duedate}</td>
                                <td>${board.addr}</td>                                
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>  
             </div>          
        </div>
    </section>	

<!-----------내가올린 쉐어링모달창 띄우기------------------------------------------------------------------------------------------------------->
<div class="modal  fade" id="joinInfoModal">
    <div class="modal-dialog  modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title">쉐어링 참가자 조회</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <div class="modal-body">
            	<input type="hidden" name="brd_num" value="${board.brd_num}"> 
            	<h6 id="totalParticipants">총 지원자 수 : </h6>
            	 
            	<table class="table table-hover" id="joinInfoForm" >		
                    <thead class="table-light" >
                        <tr>
                            <th scope="col" class="th-user_num">회원번호</th>
                            <th scope="col" class="th-nick">닉네임</th>
                            <th scope="col" class="th-name">이름</th>
                            <th scope="col" class="th-message">메시지</th>
                            <th scope="col" class="th-tel">연락처</th>
                            <th scope="col" class="th-reg_date">신청일자</th>
                            <th scope="col" class="th-check">승인처리</th>
                            <th scope="col" class="th-check">결과</th>
                        </tr>
                    </thead>                 
                    <tbody>
                        <c:forEach var="sharingList" items="${sharingParticipantsInfo}">

                        <input type="hidden" value="${sharingList.brd_num}">
                            <tr>
                            	<td id="user_num">${sharingList.user_num}</td>                     	
                                <td id="nick">${sharingList.nick}</td>
                                <td id="user_name">${sharingList.user_name}</td>
                                <td id="message">${sharingList.message}</td>                  
                                <td id="tel">${sharingList.tel}</td>
                                <td id="reg_date">${sharingList.reg_date}</td>                              
				         		<td><div class="btn-group" role="group" aria-label="Basic example">
				         			<button type="button" class="btn btn-dark btn-sm confirmModalButton" data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"  >승인</button>
        							<button type="button" class="btn btn-dark btn-sm rejectModalButton" data-brd_num="${sharingList.brd_num}" data-user_num="${sharingList.user_num}"
        														data-reject_msg="${sharingList.reject_msg}">반려</button>
				         		</div></td>  
                                 <td>
                                 	<c:choose>
                                 		<c:when test="${sharingList.state_md == 101}">승인</c:when>
                                 		<c:when test="${sharingList.state_md == 104}">반려</c:when>
                                 		<c:otherwise>반려</c:otherwise>
                                 	</c:choose>                               
                                 </td>  
                            </tr>
                        </c:forEach>
                    </tbody>                           
                </table>
            </div>
        </div>	  	 
    </div>
</div>
</div>


<!-- 반려시 모달창 띄우기------------------------------------------------------------------------------------------------------------>
<div class="modal" tabindex="-1" role="dialog" id="rejectReasonModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">반려사유 입력</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="rejectReasonForm">
                    <div class="form-group">
                        <label for="rejectReason">반려 사유:</label>
                        <textarea class="form-control" id="reject_msg" name="reject_msg" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">확인</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</div>


<!-------------------------------- 참가자 조회 모달창 자바스크립트 (중복 승인/반려 막기 해야함 )  applicants(모집인원) <= participants(참가인원) ------------------------------------------------------------------------>
<script type="text/javascript">

//참가자 조회 모달창  열때 
var participantCount = 0;
$(document).on('click', '.openModalButton', function () {
    // 버튼의 데이터 속성에서 게시글 번호 가져오기
    var brd_num = $(this).data('brd_num');
    
    // 모달 내부의 숨겨진 입력란에 값 설정
    $('#joinInfoModal input[name="brd_num"]').val(brd_num);

    // 서버에 데이터를 요청하여 참가자 정보 가져오기
    fetch('/sharingParticipantsInfo?brd_num=' + brd_num)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // 가져온 데이터를 사용하여 모달 내용을 업데이트
            var tbody = $('#joinInfoForm tbody');
            tbody.empty();
            // 참가자 수 초기화
            participantCount = 0;
            
            if (Array.isArray(data) && data.length > 0) {
                data.forEach(sharingList => {
                    // 참가자 정보를 테이블 행으로 추가
                    var regDate = new Date(sharingList.reg_date);
                    var options = { year: '2-digit', month: '2-digit', day: '2-digit' };
                    var formattedRegDate = regDate.toLocaleDateString('en-US', options);
                    
                    // state_md가 101이거나 104이면 버튼을 비활성화
                    var disableButtons = (sharingList.state_md === 101 || sharingList.state_md === 104) ? 'disabled' : '';

                    var row = '<tr>' +
                        '<td>' + sharingList.user_num + '</td>' +
                        '<td>' + sharingList.nick + '</td>' +
                        '<td>' + sharingList.user_name + '</td>' +
                        '<td>' + sharingList.message + '</td>' +
                        '<td>' + sharingList.tel + '</td>' +
                        '<td>' + formattedRegDate + '</td>' +
                        '<td>' + '<div class="btn-group" role="group" aria-label="Basic example">' +
                        '<button type="button" class="btn btn-dark btn-sm confirmModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" ' + disableButtons + '>승인</button>' +
                        '<button type="button" class="btn btn-dark btn-sm rejectModalButton" data-brd_num="' + sharingList.brd_num + '" data-user_num="' + sharingList.user_num + '" '+ disableButtons + '>반려</button>' +
                        '</td>' + '</div>' +
                        '<td>' + (sharingList.state_md == 101 ? '승인' : (sharingList.state_md == 104 ? '반려' : '')) + '</td>' +
                        '</tr>';
                    tbody.append(row);
                    
                    participantCount++;
                });
                //참가자 수 모달에 표시
                updateVisibleParticipants();
               
            } else {
                console.error('Received JSON data is not in the expected format:', data);
            }
         	// 참가자 수 업데이트 함수
            function updateVisibleParticipants() {
                // 참가자 수 업데이트
                $('#totalParticipants').text('총 지원자 수: ' + participantCount);
            }
           
        })

        });
        
//참가자 조회 모달의 닫기 버튼 클릭 이벤트 핸들러
$('#closeModalButton').on('click', function () {
    $('#joinInfoModal').modal('hide');
});

<!--참가 승인 완료 (update staet_md 101 & board.participants +1) 모달창 띄우기---------------------------------------------------------->
document.getElementById('joinInfoForm').addEventListener('click', function (event) {
    // 클릭된 요소가 버튼인지 확인
    if (event.target.tagName === 'BUTTON') {
        // 버튼의 속성 출력
        console.log('Button attributes:', event.target.attributes);

        // 버튼의 데이터 속성에서 필요한 정보를 가져옵니다.
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;
       /*  var brd_num = event.target.data('data-brd_num');
        var user_num = event.target.data('data-user_num'); */

        console.log('brd_num:', brd_num);
        console.log('user_num:', user_num);
    }
    // 승인 버튼이 클릭된 경우
    if (event.target.classList.contains('confirmModalButton')) {
        var formData = new FormData();
    	formData.append('brd_num', parseInt(brd_num, 10));
    	formData.append('user_num', parseInt(user_num, 10));
    
    	// 서버로 데이터를 전송하는 fetch API 사용
        fetch('/sharingConfirm', {
            method: 'POST',
             headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body:  'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num),  
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 성공적으로 처리된 경우
                alert(data.message); // "승인이 완료되었습니다" 메시지를 띄웁니다.
                // 모달을 닫습니다.
                $('#joinInfoModal').modal('hide');
                // 버튼 비활성화
                disableButtons(brd_num, user_num); 
            } else {
                // 처리에 실패한 경우
                alert(data.message); // "승인 실패되었습니다" 메시지를 띄웁니다.
            }
        })
        .catch(error => {
            // 서버 요청 중 에러가 발생한 경우
            alert("서버 오류가 발생했습니다.");
        });
    }

 // 반려 버튼이 클릭된 경우
    else if (event.target.classList.contains('rejectModalButton')) {
        var brd_num = event.target.dataset.brd_num;
        var user_num = event.target.dataset.user_num;

        // 반려 이유 모달을 표시합니다.
        $('#rejectReasonModal').modal('show');

        // 반려 이유 폼 제출을 처리합니다.
        $('#rejectReasonForm').on('submit', function (e) {
            e.preventDefault();
            var reject_msg = $('#reject_msg').val();

            // 서버에 반려 이유를 전송합니다.
            fetch('/sharingReject', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'brd_num=' + encodeURIComponent(brd_num) + '&user_num=' + encodeURIComponent(user_num) + '&reject_msg=' + encodeURIComponent(reject_msg),
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message); // 성공 메시지를 표시합니다.
                    $('#rejectReasonModal').modal('hide'); // 반려 이유 모달을 닫습니다.
                    // 버튼 비활성화
                    disableButtons(brd_num, user_num);
                } else {
                    alert(data.message); // 실패 메시지를 표시합니다.
                }
            })
            .catch(error => {
                alert("서버 오류가 발생했습니다.");
            });
        });
        // 반려 이유 모달 닫기 버튼 클릭 이벤트 핸들러
        document.getElementById('closeRejectReasonModalButton').addEventListener('click', function () {
            $('#rejectReasonModal').modal('hide');
        });
    }

    // 모달을 닫기 위한 버튼 클릭 이벤트 핸들러
    document.getElementById('closeModalButton').addEventListener('click', function () {
        $('#joinInfoModal').modal('hide');
    }); 
}); 

// 성공적으로 승인 반려버튼 비활성화 함수
function disableButtons(brd_num, user_num) {
    var confirmButton = document.querySelector(`.confirmModalButton[data-brd_num="${brd_num}"][data-user_num="${user_num}"]`);
    var rejectButton = document.querySelector(`.rejectModalButton[data-brd_num="${brd_num}"][data-user_num="${user_num}"]`);

    if (confirmButton) {
        confirmButton.classList.remove('confirmModalButton');
        confirmButton.classList.add('btn-secondary', 'disabled');
        rejectButton.classList.remove('rejectModalButton');
        rejectButton.classList.add('btn-secondary', 'disabled');
        confirmButton.disabled = true;
    }

    if (rejectButton) {
        confirmButton.classList.remove('confirmModalButton');
        confirmButton.classList.add('btn-secondary', 'disabled');
        rejectButton.classList.remove('rejectModalButton');
        rejectButton.classList.add('btn-secondary', 'disabled');
        rejectButton.disabled = true;
    }
}
</script>

<%@ include file="../footer.jsp" %>
</body>
</html>