<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal.user.user_id" var="principal_user_id" />
<c:set var="app" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script src="//image.hmall.com/p/js/co/jquery-3.4.1.min.js"></script>
<!-- jQuery Plugin -->
<script src="//image.hmall.com/p/js/co/jquery.easing.min.js"></script>
<!-- jQuery UI Effect -->
<script src="//image.hmall.com/p/js/co/jquery-ui.1.12.1.min.js"></script>
<!-- jQuery UI js -->
<link rel="stylesheet" type="text/css"
	href="${app}/resources/css/mypage.css">
<style>
					.mypage-order-wrap .title22 {
					    position: relative;
					    margin: 30px 10px 25px !important;
					}
					
					.inputbox {
							    display: flex;
							    justify-content: center !important;
							    position: relative;
							    height: 46px;
							    padding: 0;
							  }
							  
							.inputbox .btn-find {
							    position: inherit !important;
							    right: 34px !important;

							}
							.inplabel {
									    width: auto !important;
									}
							.filter-box {
								    padding: 14px !important;

								}
								
								.tblwrap {
									    margin-top: 100px !important;
									}
									
									.date {
									    display: inline-flex;
									    align-items: center;
									    color: #333;
    									font-size: 15px;
									}
									
									h5.rentaldate {
									    margin-right: 10px;
									}

										h5.wave {
										    margin: 0px 7px;
										    font-size: 14px;
										}
										.order-list > dl > dt .date span {
										    position: relative;
										    color: #666 !important;
										    font-size: 14px !important;
										    font-weight: 400;
										}
										.btngroup {
										    margin-left: 380px;
										}
										.order-list > dl > dt {
										    position: relative;
										    padding: 18px 20px;
										    background: #f8f8f8;
										}
										.hidden {
										    display: none;
										}
										
										
										.sample0 {
										    background: rgb(240, 246, 234);
										    padding: 10px;
										    font-size: 14px;
										    border: solid 1px transparent;
										    border-radius: 30px;
										    margin-top: 8px;
										    width: fit-content;
										}
</style>
 <script type="text/javascript">
 
 
 const countDownTimer = function (id, date) {
		var _vDate = new Date(date); // ????????????
		var _second = 1000;
		var _minute = _second * 60;
		var _hour = _minute * 60;
		var _day = _hour * 24;
		var timer;

		function showRemaining() {
			var now = new Date(); // ???????????? 
			var distDt = _vDate - now;
			if (distDt < 0) {
				clearInterval(timer);
				document.getElementById(id).textContent = '?????? ????????? ?????? ???????????????!';
				return;
			}

			var days = Math.floor(distDt / _day);
			var hours = Math.floor((distDt % _day) / _hour);
			var minutes = Math.floor((distDt % _hour) / _minute);
			var seconds = Math.floor((distDt % _minute) / _second);
		
		
			document.getElementById(id).textContent = days + '??? ';
			document.getElementById(id).textContent += hours + '?????? ';
			document.getElementById(id).textContent += minutes + '??? ';
			document.getElementById(id).textContent += seconds + '???';
		}
	
		timer = setInterval(showRemaining, 1000);
	}
 
	
 $(document).ready(function(){
	 makeList();
 }); 
 
 
 
 function makeList() {
     var keyword = $("input[name='keyword']").val();
     var no_image_url = "https://image.hmall.com/hmall/pd/no_image_100x100.jpg";

     $.ajax({
         type: "GET"
         , url: "${app}" + "/mypage/rentalList"
         , dataType: 'json'
         , data: {
             keyword: keyword
         }
         , async : false
         , crossDomain: true
         , success: function (data) {
             var rentallist = data[0];
             var list = "";
             

             if (rentallist.length == 0) {
                 list += `<div class="nodata">
	  	 		            <span class=" bgcircle"><i class="icon nodata-type7"></i></span>
	  	 		            <p>????????? ????????? ????????????.</p>
	  	 		           </div>`
             } else {
                 for (var i = 0; i < rentallist.length; i++) {

                     list += `<dl>
	  							<dt>
						<div class="date">
										<h5 class="rentaldate">?????? ?????? : </h5>
											<span>` + Unix_timestamp(Unix_timestampConv(rentallist[i].sdate)) + `</span>
										<h5 class = "wave"> ~</h5>
										<h5 class="rentaldate">?????? ?????? : </h5>
											<span>` + Unix_timestamp(Unix_timestampConv(rentallist[i].edate)) + `</span>`


                     if (rentallist[i].rental_flag == '?????????') {
                         list += `<div class="btngroup">
							  	 		       <button class="btn btn-linelgray small30" type="button"
							  	 		               onClick="window.open('${app}/mypage/rr?rentalorderNo=` + rentallist[i].prd_id + `','????????????','width=588,height=724')"><span>????????????</span>
							  	 		       </button>
							  	  </div>`
                 		}

                 list += `</div>
				  	 		   	</dt>
									<dd class="btn-col2">
									   <a href="${app}/rental/` + rentallist[i].prd_id + `">
				  					   <span class="img"><img src="` + rentallist[i].upload_path + `" alt=" ` + rentallist[i].prd_nm + `" onerror="noImage(this, 'https://image.hmall.com/p/img/co/noimg-thumb.png?RS=300x300&AR=0')"/></span>
									<div class="box">
											<span class="state sky">` + rentallist[i].rental_flag + `<em class="color-999">
											</em>
											</span> 
										<span class="tit">` + rentallist[i].prd_nm + `</span>`
										if (rentallist[i].rental_flag == '?????????') { 
										list += `
										<h2 class = "sample0" id="sample`+ i + `"></h2>
										<div class = "hidden">		             
										`+ countDownTimer('sample'+ i, rentallist[i].edate) + `
								  	 	</div>
										`
										}
										list += `</div>									
									</a>					                     	             
								</dd>				
							</dl>`
             }            
         }
             $(".order-list").html(list);
         }
     });
     $(".state:contains('????????????')").css({color:"#3abbd5"});																													
     $(".state:contains('?????????')").css({color:"#0fc961"});
	 $(".state:contains('????????????')").css({color:"#737373"});
	 $(".state:contains('????????????')").css({color:"#ff5340"});
}

 <!--
function Unix_timestampHi(t){
	    var date = new Date(t*1000);
	    var year = date.getFullYear();
	    var month = " " + (date.getMonth()+1);
	    var day = " " + date.getDate();
	    var hour = "0" + date.getHours();
	    var minute = "0" + date.getMinutes();
	    var second = "0" + date.getSeconds();
	    return month.substr(-2) +"/"+ day.substr(-2) + "/" + year + hour + ":"   ;
	}
 
 -->
 
 

 
 

 	<!-- ????????? ?????? ?????? ?????? --> 
	function Unix_timestamp(t){
	    var date = new Date(t*1000);
	    var year = date.getFullYear();
	    var month = " " + (date.getMonth()+1);
	    var day = " " + date.getDate();
	    var hour = "0" + date.getHours();
	    var minute = "0" + date.getMinutes();
	    var second = "0" + date.getSeconds();
	    return year + "." + month.substr(-2) + "." + day.substr(-2);
	}
	
	function Unix_timestampConv(t)
	{
	    return Math.floor(t/ 1000);
	}
	


 	
	

	

	function search(keyword){		
		$("input[name='keyword']").val(keyword);	
		makeList();
		$("input[name='keyword']").val("");
	}
	
	
	$(function () {
	    $("#txtItemNm").keyup(function (e) {
	    	if (e.keyCode == 13) {   		
	    		var keyword = $("input[name='txtItemNm']").val();
	    		search(keyword);
	    	}
	    })
    })

		
	 

 </script>
</head>
	<form id="formrental" method="get" action="${app}/mypage/rentalList">
		<input type="hidden" name="keyword" value="" />
	</form>
		<h3 class="title22">?????? ??????</h3>

	<!-- ????????? ?????? ?????? start -->	
		<div class="filter-box">
				<input type="hidden" id="searchType" name="searchType" value="2" />
				<input type="hidden" class="from" name="strtDt" id="txtOrdStrtDt"
					maxlength="8" value="" /> <input type="hidden" class="to"
					name="endDt" id="txtOrdEndDt" maxlength="8" value="" />
				<div class="inputbox sm">
					<label class="inplabel icon-find"><input type="text"
						name="txtItemNm" id="txtItemNm" value="" placeholder="????????? ??????"></label>
					<button class="btn btn-find" type="button" id="serach">
						<i class="icon find"></i><span class="hiding">??????</span>
					</button>
					<button class="btn ico-clearabled">
						<i class="icon"></i><span class="hiding">?????????</span>
					</button>
				</div>
		</div>
	
		<div class="order-list">			
		</div>
		
		
		

		<div class="tblwrap">
			<h4 class="ctypo17">???????????? ??????</h4>
			<table>
				<caption>????????? ??????</caption>
				<colgroup>
					<col style="width: 140px">
					<col style="width: 160px">
					<col style="width: auto">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" rowspan="6">?????? ??? ????????????</th>
						<td>????????????</td>
						<td>???????????? ??? ????????? ???????????? ?????? ?????????.</td>
					</tr>
					<tr>
						<td>????????????</td>
						<td>??????/????????? ?????????????????? ??????????????? ????????? ???????????????.</td>
					</tr>
					<tr>
						<td>?????? ?????????</td>
						<td>???????????? ????????? ???????????? ?????? ????????? ???????????? ???????????????.</td>
					</tr>
					<tr>
						<td>?????? ?????????</td>
						<td>???????????? ????????? ???????????? ???????????? ???????????????.</td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td>???????????? ?????? ??????????????? ???????????? ??????????????? ????????? ???????????????. <br>(H.Point???
							???????????? ??????????????? ??????????????? ??? ????????????.)
						</td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td>?????? ?????? ???????????? ??????????????? ???????????????.</td>
					</tr>
					<tr>
						<th scope="row" rowspan="2">??????</th>
						<td>?????????</td>
						<td>????????? ???????????? ?????? ???????????? ???????????????.</td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td>????????? ????????? ???????????????.</td>
					</tr>				
				</tbody>
			</table>
		</div>

		<!-- // 2020-09-03 ????????? ?????? -->
	</div>
</div>
<!-- // .contents -->
</div>
</div>
<!-- //.container -->

</main>
</html>