<%@page import="java.util.List"%>
<%@page import="com.ktx.ddep.dao.MarketTimesDAO"%>
<%@page import="com.ktx.ddep.vo.MarketTime"%>
<%@page import="com.ktx.ddep.dao.AddressDAO"%>
<%@page import="com.ktx.ddep.vo.Address"%>
<%@page import="com.ktx.ddep.vo.Point"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ktx.ddep.vo.Market"%>
<%@page import="com.ktx.ddep.dao.MarketsDAO"%>
<%@page import="com.ktx.ddep.dao.MembersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
	<c:import url="/WEB-INF/view/template/link.jsp"/>
    <link rel="stylesheet" href="/css/mypage.css">
    <link rel="stylesheet" href="/css/mypageReview.css">
    <style type="text/css">
    #tmp{
    	height: 500px;
    }
    
    </style>
</head>

<body>
	<c:import url="/WEB-INF/view/template/header.jsp"/>
<div class="mypage_wrap">
    <div id="mypage">
        <div class="profile_wrap" >
            <label for="profileImg">
            <!--로그인시 내 마이페이지일시에만 input 작동  -->
            <c:choose>
            <c:when test="${loginMember!=null&&member.no==loginMember.no}">
                <input type="file" accept="image/*" id="profileImg" class="filter_radio" />
                <div class="profile_img before">
            </c:when>
            <c:otherwise>
                <div class="profile_img">
            </c:otherwise>
            </c:choose>
                    <img id="profileImage" class="profile_img_big" src="/img/profileImg/${member.profileImg}"/>
                </div>
            </label>
            <div class="close_btn hidden"><i class="fas fa-times"></i></div>

          	<c:if test="${loginMember!=null&&member.no==loginMember.no}">
            <div class="info_management">
                	<a href="/info"><h3>정보관리</h3></a>
            </div>
           	</c:if>
        </div><!--profile_wrap end-->


        <div class="user_info_wrap">

                <div class="user_info">
                    <h4 class="space
                    	<%-- 210107 양 장터지기 단계가 m 이거나 y 이면 장터지기 표시,
                    	아니면 그냥 여백의 미--%>
                    	<c:choose>
                    	<c:when test="${member.marketkeeperStep=='m'||member.marketkeeperStep=='y'}">
                    	marketkeeper">장터지기
                    	</c:when>
                    	<c:otherwise>"></c:otherwise>
                    	</c:choose>
                    </h4>
                    
                    <em class="user_nickname 
                    <!--로그인 시 내 마이페이지 일 경우에만 hover시 테두리 생성 되는 클래스 추가  -->
                    <c:if test="${loginMember!=null&&loginMember.no==member.no}">
                    	hover
                    </c:if>">${member.nickname}</em>
                    <div class="grade_img"></div>
                    <!--로그인시 내 마이페이지일 경우에만 input 작동  -->
                    <c:if test="${loginMember!=null&&loginMember.no==member.no}">
                    	<div class="nickname_box hidden">
	                        <input type="text" id="nickname"  maxlength="7">
	                        <div class="nickname_regex"></div>
	                    </div><!--nickname_box-->
                    </c:if>
                </div><!--nickname end-->
        </div><!--userinfo_wrap end-->


        <div class="user_point_wrap">
            <div class="user_point">
                <div class="cumulative_point">
                    <span>${member.accuPoints}p</span>
                </div>
                <%-- 로그인 memberNo와 마이페이지 memberNo가 같다면 보여줌--%>
                <c:if test="${loginMember!=null&&loginMember.no==member.no}">
                	<div class="point">
                    <span>${member.currPoints}p</span>
                </div>
                </c:if>
            </div>
        </div> <!--user_point_wrap end-->

		
        <div class="service_idx_wrap marketkeeper" >
       	<c:if test="${member.marketkeeperStep=='m'||member.marketkeeperStep=='y'}">
            <div class="service_idx">            
	        <c:choose>
		        <c:when test="${market!=null&&market.serviceIdx!=null}">
                	<span>${market.serviceIdx}
		       	</c:when>
		       	<c:otherwise>
            		<span class="font_small">대기중
		       	</c:otherwise>
	       	</c:choose>
            </span>
            </div>
       	</c:if>
        </div><!--service_idx_wrap end  -->
		
        <div class="user_ranking_wrap">
            <div class="user_ranking">
                <a class="ranking_weekly" href="/rank/week" title="주간랭킹으로">
                <c:choose>
				<c:when test="${weeklyRank==-1}">
                	<span class="font_small">순위밖
				</c:when>
				<c:otherwise>
            		<span>${weeklyRank}
				</c:otherwise>                
                </c:choose>
                	</span>
                </a>
                <a class="ranking_total" href="/rank/total/page/1" title="전체랭킹으로">                
            		<span>${totalRank}</span>
                </a>
            </div><!--user_ranking end  -->
        </div><!--user_ranking_wrap end  -->
        
    </div><!--mypage end-->
    
    <div id="userAddress">
        <h3 id="roadAddress"        
        //로그인시 내 마이페이지면 주소 변경창 작동 및 hover시 테두리
        <c:if test="${loginMember!=null&&loginMember.no==member.no}">
        	onclick="sample4_execDaumPostcode()" class="hover"
        </c:if>
        > 주소로딩중...</h3>
    </div><!--userAddress end-->

	<ul id="mypageTab">
	    <li class="mypage_tab receipt_tab">
	        <i class="fas fa-receipt"></i><em class="tab_click">레시피</em><h4></h4>
	    </li>
	    <li class="mypage_tab market_tab">
	        <i class="fas fa-store"></i><em>장터</em><h4></h4>
	    </li>
	    <li class="mypage_tab review_tab">
	        <i class="fas fa-comment-alt"></i><em>요리후기</em><h4></h4>
	    </li>
	    <li class="mypage_tab question_tab">
	        <i class="fas fa-headset"></i><em>1:1 문의</em><h4></h4>
	    </li>
	    <li class="tab_under_bar"></li>
	</ul><!--mypageTab-->
</div><!-- mypage_wrap end-->
<div id="tmp"></div>

<!--■■■■■■■■■■■■■■■■■■■■■■■■■등급박스■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->

<div class="grade_info_box box hidden">
    <div class="close_btn"><i class="fas fa-times"></i></div>
    <h2>등급이란?</h2>
    <h3>누적 포인트에 따라 등급이 결정됩니다.</h3>
    <h3>등급을 높히고 추가 적립 혜택을 누리세요!</h3>

    <div id="grade_info_wrap">

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconRoyal.png" alt="royal">
            </div><!--grade_icon end-->

            <div class="grade_detail two_line">
                <p>400,001p~</p>
                <p>추가 적립 10%</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconHeritage.png" alt="heritage">
            </div><!--grade_icon end-->

            <div class="grade_detail two_line">
                <p>150,001p~400,000p</p>
                <p>추가 적립 7%</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconDiamond.png" alt="diamond">
            </div><!--grade_icon end-->

            <div class="grade_detail two_line">
                <p>70,001p ~150,000p</p>
                <p>추가 적립 5%</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconPlatinum.png" alt="platinum">
            </div><!--grade_icon end-->

            <div class="grade_detail two_line">
                <p>30,001p ~70,000p</p>
                <p>추가 적립 3%</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconGold.png" alt="gold">
            </div><!--grade_icon end-->

            <div class="grade_detail one_line">
                <p>10,001p ~30,000p</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconSilver.png" alt="silver">
            </div><!--grade_icon end-->

            <div class="grade_detail one_line">
                <p>5,001p ~10,000p</p>
            </div><!-- grade_detatil end-->
        </div><!-- grade_info end-->

        <div class="grade_info">
            <div class="grade_icon">
                <img src="/img/iconFamily.png" alt="family">
            </div><!--grade_icon end-->

            <div class="grade_detail one_line">
                <p>회원가입시 ~ 5,000p</p>
            </div><!-- point_detatil end-->
        </div><!-- point_use end-->
    </div><!--grade_info_wrap end-->

</div><!-- grade_info_box end -->

<!--■■■■■■■■■■■■■■■■■■■■■■■■■등급박스 end■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->





<!--■■■■■■■■■■■■■■■■■■■■■■■■■서비스 지수 박스■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->

<!-- 마켓 정보가 있고 장터가 존재하는 marketkepperStep이 y인 경우 -->
 <c:if test="${member.marketkeeperStep=='y'||member.marketkeeperStep=='m'}">
<div class="service_idx_box box hidden">
    <div class="close_btn"><i class="fas fa-times"></i></div>
    <div class="profile_wrap">
        <div class="profile_img">
            <img class="profile_img_big" src="/img/profileImg/${member.profileImg}"/>
        </div>
        <div class="user_info_wrap">
            <div class="user_info">
                <h4 class="space marketkeeper">장터지기</h4>
                <em class="user_nickname">${member.nickname}</em>
            </div><!--nickname end-->
             <c:choose>
		        <c:when test="${market!=null&&market.serviceIdx!=null}">
                	<span>${market.serviceIdx}
		       	</c:when>
		       	<c:otherwise>
            		<span class="font_small">대기중
		       	</c:otherwise>
	       	</c:choose>
	       	</span>
        </div><!--userinfo_wrap end-->
    </div><!--profile_wrap-->
    <div class="market_card">
        <a href="" class="market_card_a">
            <img class="market_card_img" src="/img/marketImg/${market.img}" />
            <div class="market_info">
                <div class="market_card_name">${market.name}</div>
                <div class="market_card_market_time">${timeStr}</div>
            </div><!-- market_info end -->
        </a><!--.market_card_a end-->
    </div><!-- .market_card end-->
</div><!--service_idx_box end-->
</c:if>



<!--mypage content 영억 start-->


<div id="mypageContent">
    <div id="mypageReceipt" class="hidden"></div>
    <div id="mypageMarket" class="hidden"></div>
    <div id="mypageReview" class="hidden"> </div>
    <div id="mypageQuestion" class="hidden"> </div>

</div><!--mypageContent end-->


<div id=layerWrap class=hidden></div>




<!--■■■■■■■■■■■■■■■■■■■■■내가 쓴 요리 후기 템플릿 end■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->

<c:import url="/WEB-INF/view/template/footer.jsp"/>



<!--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
<!--■■■■■■■■■■■■■■■■■■■■■■■■■■자바스크립트 영역 시작■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
<!--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->


<!-- 우편번호 불러오기 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=890ebc38603ef0cdf515d3fe4f928964&libraries=services"></script>

<script>
    //선언
    const $receipt_tab=$(".receipt_tab");
    const $market_tab=$(".market_tab");
    const $review_tab=$(".review_tab");
    const $question_tab=$(".question_tab");
    const $tab_under_bar=$(".tab_under_bar")
    const $mypageReceipt=$("#mypageReceipt");
    const $mypageReview=$("#mypageReview");
    const $mypageMarket=$("#mypageMarket");
    const $mypageQuestion=$("#mypageQuestion");
    const $mypageContent=$("#mypageContent");


    //마이페이지 탭 선택시 아래 막대 이동 함수
    function underbar(x){
        $tab_under_bar.css("left",x+"px");
    }

    //레시피 선택 시
    $receipt_tab.on("click",function (){
        $mypageContent.children().addClass("hidden");
        $mypageMarket.removeClass("hidden");
        underbar(72);
    })

    //장터 선택시
    $market_tab.on("click",function (){
        $mypageContent.children().addClass("hidden");
        $mypageReceipt.removeClass("hidden");
        underbar(322);
    })

    //요리 후기 선택시
    $review_tab.on("click",function (){
        $mypageContent.children().addClass("hidden");
        $mypageReview.removeClass("hidden");
        underbar(572);
    })

    //문의하기 선택 시
    $question_tab.on("click",function (){
        $mypageContent.children().addClass("hidden");
        $mypageQuestion.removeClass("hidden");
        underbar(822);
    })



    /*--■■■■■■■■■■■■■■■■■■■■■■■■■■■■---각종 안내---■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--*/

    //선언
    const $user_info_grade_img=$(" .user_info .grade_img");
    const $grade_info_box=$(".grade_info_box");
    const $layerWrap=$("#layerWrap");
    const $cumulative_point=$(".cumulative_point");
    const $point=$(".point");
    const $point_history_box=$(".point_history_box");
    const $service_idx_box=$(".service_idx_box");
    const $point_accumulation_tab= $(".point_accumulation_tab");
    const $service_idx=$(".service_idx");
    
    //창 닫기를 위한 선언
    const $close_btn=$(".close_btn");
    const $box=$(".box");   

    //창 열기 함수 선언
    function openBox(click_name, box_name){
        click_name.on("click",function(){
            box_name.removeClass("hidden");
            $layerWrap.removeClass("hidden");
        })
    }

    //창 닫기 함수 선언
    function closeBox(){
        $box.addClass("hidden");
        $layerWrap.addClass("hidden");
    }
    
    //닉네임 뒤 등급 이미지 클릭시 등급 설명 보여주기
    openBox($user_info_grade_img,$grade_info_box);

    //누적 포인트 클릭시 등급 설명 보여주기
    openBox($cumulative_point,$grade_info_box);

    //주변 검은 부분 눌렀을 시 창 닫기
    $layerWrap.on("click",function (){
        closeBox();
    })

    //닫기 버튼 눌렀을 시 창 닫기
    $close_btn.on("click",function (){
        closeBox();
    })
   
    //서비스 지수 클릭시 서비스 지수 창 보여주기
    $service_idx.on("click",function(){
        $(".service_idx_box").removeClass("hidden");
        $layerWrap.removeClass("hidden");
    })
    
    //새주소 변환 관련 선언
	$roadAddress = $("#roadAddress");
	
	let sido="";
	let gugun="";
	let dong="";
	let lat="";
	let lng="";
	
	//주소-좌표 변환 객체를 생성
	var geocoder = new kakao.maps.services.Geocoder();
	
	//좌표를 통해 새주소로 변경 함수
	function callAdress(newLat,newLng){
		var coord = new kakao.maps.LatLng(newLat, newLng);
		var callback = function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		    	if(result[0].road_address!==null){
		    		$roadAddress.text(result[0].road_address.address_name);
		    	}else{
		    		$roadAddress.text(result[0].address.address_name);
		    	}//if ~ else end
		    }
		        //console.log('그런 너를 마주칠까 ' + result[0].road_address.address_name  + '을 못가');		   
		}
		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    }
    
	//새주소로 변경 실행
    callAdress(${address.lat}, ${address.lng});
   
    <c:if test="${loginMember!=null&&member.no==loginMember.no}">    
    /* □■□■□■□■ 로그인 멤버==마이페이지 일시 작동 ■□■□■□■□ */
    
    /*--■■■■■■■■■■■■■■■■■■■■■■■■■■■닉네임 변경■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--*/

    //선언
    const $nickname=$("#nickname");
    const $nickname_regex=$(".nickname_regex");
    const $nickname_box=$(".nickname_box");
    const $user_nickname=$(".user_nickname");
    const $mypage_user_nickname=$("#mypage .user_nickname");

    //유효성 판별을 위한 변수 선언
    let nicknameBoolean = false;

    //유효성 에러시 메세지 출력 함수
    function wrong(){
        $nickname_regex.html("한글,영어,숫자 7글자까지 가능합니다.")
        $nickname_regex.css("color","red");
    }

    //닉네임 클릭시 input창 보여주기
    $mypage_user_nickname.on("click",function(){

        $nickname_box.removeClass("hidden");

        //input에 포커스를 맞추고 값을 현재 유저이름으로 변경
        $nickname.val($mypage_user_nickname.text());
        $nickname.focus();
    })

    //input focus 벗어날 시 현재 값을 지우고 숨기기
    $nickname.blur(function (){
        $(this).val('');
        $nickname_box.addClass("hidden");
    });

    //21-02-02 19:19 양 닉네임 변경
    $nickname.on("keyup",function(e){

        //새로운 닉네임 입력 시 한글,숫자,영어만 입력 가능
        const regex = /^[가-힣|\w]*$/
        const result = regex.exec($(this).val());

        //닉네임 유효성 검사
        if(result!= null){
            $nickname_regex.html("멋진 닉네임이네요.");
            $nickname_regex.css("color","#1c00db");

            nicknameBoolean=true;

            //글자수 7글자 초과시 메세지 출력
            if(($(this).val().length)>7||($(this).val().length===0)){
                wrong();
                nicknameBoolean=false;
            }//if end

        //한글,숫자,영어가 아니면 메세지 출력
        }else{
            wrong();
            nicknameBoolean=false;
        } //if-else end
        
        
        if(nicknameBoolean){
        //닉네임 중복검사
	        $.ajax({
	    		url:"/ajax/nickname",
	    		type:"get",
	    		data:{"nickname":$(this).val()},
	    		dataType:"json",
	    		error:function(xhr, error) {
	    			alert("서버 점검 중입니다.")        			
	    		}, //error end
	    		success:function(json) {
	    			if(json===true){
	    				 $nickname_regex.html("이미 사용중인 닉네임입니다.").css("color","red");
            			 nicknameBoolean=false;
	    			} else {
	    				 $nickname_regex.html("멋진 닉네임이네요.").css("color","#1c00db");
	    				 //엔터치면 업데이트 진행
	    				 if (e.keyCode === 13&&nicknameBoolean){
	    			            $.ajax({
	    			    			url : "/ajax/nickname",
	    			    			type : "PUT",	    			    			
	    			    			data : {"nickname" : $nickname.val(), "no" : ${loginMember.no}},	    			    			
	    			    			error : function() {
	    			    				alert("닉네임 쪽 서버 점검중!")
	    			    			},
	    			    			success : function() {
	    			    				$user_nickname.text($nickname.val());
	    			    	            $nickname_box.addClass("hidden"); 
	    			    			}//success end
	    			            })//ajax end	    			            
	    				 }
	    			}//if~else end
	    		}//success end    		
	    	}); //ajax() end        
        }//if end
    }) //$nickName keyup() end

    /*--■■■■■■■■■■■■■■■■■■■■■■■■---닉네임 변경 end---■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--*/
    
    /*--■■■■■■■■■■■■■■■■■■■■■■■■---프로필 이미지 변경 start---■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--*/

    const $mypage_profile_wrap=$("#mypage .profile_wrap");
    const $profile_wrap_close_btn=$(".profile_wrap .close_btn");
    const $profileImage=$("#profileImage");
    const $profile=$("#profileImg");

    //마우스를 프로필 이미지에 hover시 x버튼 보여주기
    $mypage_profile_wrap.hover(
        function () {
            if ($profileImage.attr("src")!== "/img/profileImg/profile.jpg") {
            $profile_wrap_close_btn.removeClass("hidden")
            }
        }, function () {
            $profile_wrap_close_btn.addClass("hidden")
        }
    )
	
    //x버튼 누르면 기본 이미지로 변경하기
    $profile_wrap_close_btn.on("click",function (){
    	console.log('${loginMember.no}');
        //서버에 기본 이미지로 변경
           $.ajax({
    			url : "/ajax/profile",
    			type : "PUT",
    			data : {"memberNo" : ${loginMember.no}},
    			dataType : "text",
    			error : function() {
    				alert("서버 점검중!")
    			},
    			success : function(text) {
    				//이미지 경로 변경
    		        $profileImage.attr("src","/img/profileImg/"+text); 
    				//헤더 이미지도 변경
    		        $(".circle_user_img").attr("src", "/img/profileImg/"+text);
    		        //x버튼 숨기기
    		        $profile_wrap_close_btn.addClass("hidden");
    			}
            })
    });
    
    
    //■■■21-02-02 양 10:09 ajax를 활용한 프로필 업로드■■■//
    
    //프로필 변경시
    $profile.on("change",function(){
		const file = this.files[0];
		if (file.size===0) {
			alert("제대로 된 파일을 선택하시오. -_-;");
			return;
		}//if end		
		//2) 파일의 종류가 image
		if (!file.type.includes("image/")) {
			//파일이 image가 아닐때
			alert("이미지를 선택해주시오. -_-;");
			return;
		}//if end
		//3) FormData객체 생성
		const formData = new FormData();
		//4) formdata에 파라미터를 추가
		//?type=P 파라미터
		formData.append("type", "P");
		//파일을 append
		formData.append("profile", file, file.name);
		$.ajax({
			url : "/ajax/profile",
			type : "POST",
			processData : false,
			contentType : false,
			data : formData,
			dataType : "json",
			error : function() {alert("서버 점검중!")},
			success : function(json) {
				//img요소의 src속성을 넘어온 이미지로 변경 
				$profileImage.attr("src", "/img/profileImg/" + json.profileImg);
				//header의 이미지도 변경
				$(".circle_user_img").attr("src", "/img/profileImg/" + json.profileImg);

			}
		});//ajax() end
	})//profile change() end
	
	//■■■210202 양 10:09 ajax를 활용한 프로필 업로드 끝■■■//
	
	//--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■지도■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■--//
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.

	function sample4_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let roadAddr = data.roadAddress; // 도로명 주소 변수
				let extraRoadAddr = ''; // 참고 항목 변수
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}//if end
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}//if end
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}// if end
				
                //Address table 에 넣기 위한 값(sido, sigungu, dong)
                sido =data.sido;
                gugun=data.sigungu;

                if(data.bname1!=null) {
                    dong=data.bname1+data.bname2;
                } else {
                    dong=data.bname2;
                }//if else end
                			
			    // 주소로 좌표를 검색
			    geocoder.addressSearch(roadAddr, function(result, status) {
			        // 정상적으로 검색이 완료시
			        if (status === kakao.maps.services.Status.OK) {
			            //좌표값 얻기
			        	var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			            //좌표값 저장하기
			            lat = result[0].y;
                        lng = result[0].x;
                        //ajax로 데이터 전송
                        $.ajax({
							url:"/ajax/address",//주소
							type:"PUT",//방식
							data:{"sido": sido, "gugun":gugun, "dong":dong,
								"lat":lat, "lng":lng,"no":${loginMember.no} },//넘길 파라미터 이름
							dataType:"text",//응답의 자료형
							error:function(xhr,error){ //받아오기 실패시
								alert("서버 점검중!");
								console.log(error);
							},
							success:function(json){ //받아오기 성공시
								//바뀐 주소를 새주소로 변경하기 
								callAdress(lat, lng);
							}
                        })//ajax end
			        }//if end
			    });//addressSearch() end
			}
		}).open();
	}//sample4_execDaumPostcode() end
	</c:if>

</script>
</body>
</html>