<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<script>
		function DrDw2(F,b){
    		var aCL=F.split("~");
    		var iC=aCL.length;
    		if(aCL[iC-1]=="")iC--;
    		var i=0;
    		while(i<iC){
    			document.write("<option value=\""+aCL[i]+"\""+(b==aCL[i]?" selected":"")+">"+aCL[i+1]);
        		i=i+2;
    		}
		}
		
		$(()=>{
			$("#useridSignUp").keyup(function(){
				var url = '/idOk';
				var target = $(".checkForm");
				
				$.ajax({
					type:'get',
	 				dataType:'text',
	 				url:url,
	 				data:{'id':$("#useridSignUp").val()},
	 				success:function(result){
	 					//console.log(result);
	 					if(result>=1){
	 						target.css('display','block');
	 						target.html("아이디가 중복되었습니다.");
	 						target.css('color','red');
	 					}else{
	 						target.css('display','none');
	 					}
	 				},error:function(error){
	 					
	 				}
				});
			});
			
			$("#favornation").change(function(){
				//console.log($("#favornation option:selected").val())
				//console.log($("#favornation option:selected").text())
				
				var idx = $("#favornation option").index( $("#favornation option:selected") );
				var state = new Array();
				var target = document.querySelector("#favorstate");
				
				//state[0] = ['테스트1','테스트2','테스트3'];
				state[114] = ['서울', '경기도', '마산'];
				
				target.options.length=1;
				
				for(i in state[idx]){
					var opt = document.createElement("option");
					opt.value = state[idx][i];
					opt.innerHTML = state[idx][i];
					opt.selected;
					target.appendChild(opt);
				}
			});
			
			$("#signUpFrm").submit(function(){
				if($("#useridSignUp").val()==''){
					alert("아이디값을 입력하세요.");
					$("#useridSignUp").focus();
					return false;
				}
				var regular = /^[a-zA-Z0-9]{6,16}$/;
				if(!regular.test($("#useridSignUp").val())){
					alert("아이디 입력 양식이 잘못되었습니다.");
					$("#useridSignUp").focus();
					return false;
				}
				if($("#userpwdSignUp").val()==""){
					alert("비밀번호를 입력하세요.");
					$("#userpwdSignUp").focus();
					return false;
				}
				regular = /^[a-zA-Z0-9!@#$%^&*~?]{8,16}$/;
				if(!regular.test($("#userpwdSignUp").val())){
					alert("비밀번호 양식이 잘못 되었습니다.\n*비밀번호는 8~16자 여야 합니다.\n*사용가능 특수문자 -> !@#$%^&*~?");
					$("#userpwdSignUp").focus();
					return false;
				}
				if($("#userpwdSignUp").val()!=$("#userpwdSignUp2").val()){
					alert("비밀번호가 일치하지 않습니다.");
					$("#userpwdSignUp2").focus();
					return false;
				}
				if($("#usernation").val()==''){
					alert("국적을 선택해 주세요.")
					$("#usernation").focus();
					return false;
				}
				if($("#favornation").val()==''){
					alert("여행 선호 국가를 선택해주세요.")
					$("#favornation").focus();
					return false;
				}
				if($("#favorstate").val()==''){
					alert("여행 선호 국가를 선택해주세요.")
					$("#favorstate").focus();
					return false;
				}
				if($("#username").val()==''){
					alert("이름을 입력해주세요.")
					$("#username").focus();
					return false;
				}
				if($("#tel2").val()==''){
					alert("전화번호를 입력해주세요.");
					$("#tel2").focus();
					return false;
				}
				regular=/^[0-9]{6,16}$/;
				if(!regular.test($("#tel2").val())){
					alert("전화번호 입력 양식이 잘못되었습니다.\n*6~15자리 숫자만 입력가능.");
					$("#tel2").focus();
					return false;
				}
				var data = $("#signUpFrm").serialize();
				console.log(decodeURIComponent(data))
				return true;
			});
		});
	</script>
	<style>
		body{
			background-color:rgb(253,239,239);
		}
		#signUpDiv{
			width:1000px;
			margin:0 auto;
			padding-left:35px;
			background-color:rgb(244,223,208);
			margin-top:100px;
			margin-bottom:100px;
		}
		.inforName{
			display:inline-block;
			width:20%;
			margin-top:30px;
			font-size:1.1em;
		}
		#signUpDiv input,#signUpDiv select{
			background-color:inherit;
			border:none;
			border-bottom:1px solid black;
			box-sizing:border-box;
			height:30px;
		}
		.inputStyle{
			width:75%;			
		}
		.inputStylenation{
			width:36%;
		}
		.inputStyletel1{
			width:15%;
		}
		.inputStyletel2{
			width:58%;
		}
		.gropInforName{
			display:inline-block;
			margin-top:60px;
			font-size:1.5em;
			font-weight:bold;
		}
		.submitBtn{
			width:95%;
			cursor:pointer;
			border:none;
			background-color:blue;
			color:white;
			height:30px;
			margin-top:30px;
			margin-bottom:30px;
		}
		.checkForm{
			margin-top:30px;
			padding-left:20%;
			display:none;
		}
	</style>
	<div id="signUpDiv">
		<form method="post" action="/sighUpOk" id="signUpFrm">
			<span class='gropInforName'>회원가입</span><br/>
			<span class='gropInforName'>로그인 정보</span><br/>
			<span class="inforName">아이디</span>
			<input class="inputStyle" type='text' name='userid' id='useridSignUp' placeholder='아이디는 영문 또는 숫자 6~16자리로 입력해 주세요.'/><br/>
			<div class="checkForm"></div>
			<span class="inforName">비밀번호</span>
			<input class="inputStyle" type='password' name='userpwd' id='userpwdSignUp' placeholder='비밀번호를 입력해 주세요. (8~16자/문자, 숫자, 특수문자 혼용)'/><br/>
			<span class="inforName">비밀번호 확인</span>
			<input class="inputStyle" type='password' id='userpwdSignUp2' placeholder='비밀번호를 확인해 주세요'/><br/>
			<span class='gropInforName'>회원 정보</span><br/>
			<span class="inforName">국적</span> 
			<select class="inputStylenation" id="usernation" name="usernation" >
				<script>
					DrDw2("~국가선택~AF~Afghanistan~AL~Albania~DZ~Algeria~AS~American Samoa~AD~Andorra~AO~Angola~AI~Anguilla~AQ~Antarctica~AG~Antigua and Barbuda~AR~Argentina~AM~Armenia~AW~Aruba~AC~Ascension Island~AU~Australia~AT~Austria~AZ~Azerbaijan~BS~Bahamas~BH~Bahrain~BD~Bangladesh~BB~Barbados~BY~Belarus~BE~Belgium~BZ~Belize~BJ~Benin~BM~Bermuda~BT~Bhutan~BO~Bolivia~BA~Bosnia and Herzegovina~BW~Botswana~BV~Bouvet Island~BR~Brazil~IO~British Indian Ocean Territory~BN~Brunei~BG~Bulgaria~BF~Burkina Faso~BI~Burundi~KH~Cambodia~CM~Cameroon~CA~Canada~CV~Cape Verde~KY~Cayman Islands~CF~Central African Republic~TD~Chad~CL~Chile~CN~China~CX~Christmas Island~CC~Cocos (Keeling) Islands~CO~Colombia~KM~Comoros~CG~Congo~CD~Congo (DRC)~CK~Cook Islands~CR~Costa Rica~HR~Croatia~CU~Cuba~CY~Cyprus~CZ~Czech Republic~DK~Denmark~DJ~Djibouti~DM~Dominica~DO~Dominican Republic~EC~Ecuador~EG~Egypt~SV~El Salvador~GQ~Equatorial Guinea~ER~Eritrea~EE~Estonia~ET~Ethiopia~FK~Falkland Islands (Islas Malvinas)~FO~Faroe Islands~FJ~Fiji Islands~FI~Finland~FR~France~GF~French Guiana~PF~French Polynesia~TF~French Southern and Antarctic Lands~GA~Gabon~GM~Gambia, The~GE~Georgia~DE~Germany~GH~Ghana~GI~Gibraltar~GR~Greece~GL~Greenland~GD~Grenada~GP~Guadeloupe~GU~Guam~GT~Guatemala~GG~Guernsey~GN~Guinea~GW~Guinea-Bissau~GY~Guyana~HT~Haiti~HM~Heard Island and McDonald Islands~HN~Honduras~HK~Hong Kong SAR~HU~Hungary~IS~Iceland~IN~India~ID~Indonesia~IR~Iran~IQ~Iraq~IE~Ireland~IM~Isle of Man~IL~Israel~IT~Italy~JM~Jamaica~JP~Japan~JE~Jersey~JO~Jordan~KZ~Kazakhstan~KE~Kenya~KI~Kiribati~KR~Korea~KW~Kuwait~KG~Kyrgyzstan~LA~Laos~LV~Latvia~LB~Lebanon~LS~Lesotho~LR~Liberia~LY~Libya~LI~Liechtenstein~LT~Lithuania~LU~Luxembourg~MO~Macao SAR~MK~Macedonia, Former Yugoslav Republic of~MG~Madagascar~MW~Malawi~MY~Malaysia~MV~Maldives~ML~Mali~MT~Malta~MH~Marshall Islands~MQ~Martinique~MR~Mauritania~MU~Mauritius~YT~Mayotte~MX~Mexico~FM~Micronesia~MD~Moldova~MC~Monaco~MN~Mongolia~MS~Montserrat~MA~Morocco~MZ~Mozambique~MM~Myanmar~NA~Namibia~NR~Nauru~NP~Nepal~NL~Netherlands~AN~Netherlands Antilles~NC~New Caledonia~NZ~New Zealand~NI~Nicaragua~NE~Niger~NG~Nigeria~NU~Niue~NF~Norfolk Island~KP~North Korea~MP~Northern Mariana Islands~NO~Norway~OM~Oman~PK~Pakistan~PW~Palau~PS~Palestinian Authority~PA~Panama~PG~Papua New Guinea~PY~Paraguay~PE~Peru~PH~Philippines~PN~Pitcairn Islands~PL~Poland~PT~Portugal~PR~Puerto Rico~QA~Qatar~RE~Reunion~RO~Romania~RU~Russia~RW~Rwanda~WS~Samoa~SM~San Marino~ST~S? Tom?and Pr?cipe~SA~Saudi Arabia~SN~Senegal~YU~Serbia and Montenegro~SC~Seychelles~SL~Sierra Leone~SG~Singapore~SK~Slovakia~SI~Slovenia~SB~Solomon Islands~SO~Somalia~ZA~South Africa~GS~South Georgia and the South Sandwich Islands~ES~Spain~LK~Sri Lanka~SH~St. Helena~KN~St. Kitts and Nevis~LC~St. Lucia~PM~St. Pierre and Miquelon~VC~St. Vincent and the Grenadines~SD~Sudan~SR~Suriname~SJ~Svalbard and Jan Mayen~SZ~Swaziland~SE~Sweden~CH~Switzerland~SY~Syria~TW~Taiwan~TJ~Tajikistan~TZ~Tanzania~TH~Thailand~TP~Timor-Leste~TG~Togo~TK~Tokelau~TO~Tonga~TT~Trinidad and Tobago~TA~Tristan da Cunha~TN~Tunisia~TR~Turkey~TM~Turkmenistan~TC~Turks and Caicos Islands~TV~Tuvalu~UG~Uganda~UA~Ukraine~AE~United Arab Emirates~UK~United Kingdom~US~United States~UM~United States Minor Outlying Islands~UY~Uruguay~UZ~Uzbekistan~VU~Vanuatu~VA~Vatican City~VE~Venezuela~VN~Vietnam~VI~Virgin Islands~VG~Virgin Islands, British~WF~Wallis and Futuna~YE~Yemen~ZM~Zambia~ZW~Zimbabwe","");
				</script>
			</select><br/>
			<span class="inforName">여행 선호 국가</span> 
			<select class="inputStylenation" id="favornation" name="favornation">
				<script>
					DrDw2("~국가선택~AF~Afghanistan~AL~Albania~DZ~Algeria~AS~American Samoa~AD~Andorra~AO~Angola~AI~Anguilla~AQ~Antarctica~AG~Antigua and Barbuda~AR~Argentina~AM~Armenia~AW~Aruba~AC~Ascension Island~AU~Australia~AT~Austria~AZ~Azerbaijan~BS~Bahamas~BH~Bahrain~BD~Bangladesh~BB~Barbados~BY~Belarus~BE~Belgium~BZ~Belize~BJ~Benin~BM~Bermuda~BT~Bhutan~BO~Bolivia~BA~Bosnia and Herzegovina~BW~Botswana~BV~Bouvet Island~BR~Brazil~IO~British Indian Ocean Territory~BN~Brunei~BG~Bulgaria~BF~Burkina Faso~BI~Burundi~KH~Cambodia~CM~Cameroon~CA~Canada~CV~Cape Verde~KY~Cayman Islands~CF~Central African Republic~TD~Chad~CL~Chile~CN~China~CX~Christmas Island~CC~Cocos (Keeling) Islands~CO~Colombia~KM~Comoros~CG~Congo~CD~Congo (DRC)~CK~Cook Islands~CR~Costa Rica~HR~Croatia~CU~Cuba~CY~Cyprus~CZ~Czech Republic~DK~Denmark~DJ~Djibouti~DM~Dominica~DO~Dominican Republic~EC~Ecuador~EG~Egypt~SV~El Salvador~GQ~Equatorial Guinea~ER~Eritrea~EE~Estonia~ET~Ethiopia~FK~Falkland Islands (Islas Malvinas)~FO~Faroe Islands~FJ~Fiji Islands~FI~Finland~FR~France~GF~French Guiana~PF~French Polynesia~TF~French Southern and Antarctic Lands~GA~Gabon~GM~Gambia, The~GE~Georgia~DE~Germany~GH~Ghana~GI~Gibraltar~GR~Greece~GL~Greenland~GD~Grenada~GP~Guadeloupe~GU~Guam~GT~Guatemala~GG~Guernsey~GN~Guinea~GW~Guinea-Bissau~GY~Guyana~HT~Haiti~HM~Heard Island and McDonald Islands~HN~Honduras~HK~Hong Kong SAR~HU~Hungary~IS~Iceland~IN~India~ID~Indonesia~IR~Iran~IQ~Iraq~IE~Ireland~IM~Isle of Man~IL~Israel~IT~Italy~JM~Jamaica~JP~Japan~JE~Jersey~JO~Jordan~KZ~Kazakhstan~KE~Kenya~KI~Kiribati~KR~Korea~KW~Kuwait~KG~Kyrgyzstan~LA~Laos~LV~Latvia~LB~Lebanon~LS~Lesotho~LR~Liberia~LY~Libya~LI~Liechtenstein~LT~Lithuania~LU~Luxembourg~MO~Macao SAR~MK~Macedonia, Former Yugoslav Republic of~MG~Madagascar~MW~Malawi~MY~Malaysia~MV~Maldives~ML~Mali~MT~Malta~MH~Marshall Islands~MQ~Martinique~MR~Mauritania~MU~Mauritius~YT~Mayotte~MX~Mexico~FM~Micronesia~MD~Moldova~MC~Monaco~MN~Mongolia~MS~Montserrat~MA~Morocco~MZ~Mozambique~MM~Myanmar~NA~Namibia~NR~Nauru~NP~Nepal~NL~Netherlands~AN~Netherlands Antilles~NC~New Caledonia~NZ~New Zealand~NI~Nicaragua~NE~Niger~NG~Nigeria~NU~Niue~NF~Norfolk Island~KP~North Korea~MP~Northern Mariana Islands~NO~Norway~OM~Oman~PK~Pakistan~PW~Palau~PS~Palestinian Authority~PA~Panama~PG~Papua New Guinea~PY~Paraguay~PE~Peru~PH~Philippines~PN~Pitcairn Islands~PL~Poland~PT~Portugal~PR~Puerto Rico~QA~Qatar~RE~Reunion~RO~Romania~RU~Russia~RW~Rwanda~WS~Samoa~SM~San Marino~ST~S? Tom?and Pr?cipe~SA~Saudi Arabia~SN~Senegal~YU~Serbia and Montenegro~SC~Seychelles~SL~Sierra Leone~SG~Singapore~SK~Slovakia~SI~Slovenia~SB~Solomon Islands~SO~Somalia~ZA~South Africa~GS~South Georgia and the South Sandwich Islands~ES~Spain~LK~Sri Lanka~SH~St. Helena~KN~St. Kitts and Nevis~LC~St. Lucia~PM~St. Pierre and Miquelon~VC~St. Vincent and the Grenadines~SD~Sudan~SR~Suriname~SJ~Svalbard and Jan Mayen~SZ~Swaziland~SE~Sweden~CH~Switzerland~SY~Syria~TW~Taiwan~TJ~Tajikistan~TZ~Tanzania~TH~Thailand~TP~Timor-Leste~TG~Togo~TK~Tokelau~TO~Tonga~TT~Trinidad and Tobago~TA~Tristan da Cunha~TN~Tunisia~TR~Turkey~TM~Turkmenistan~TC~Turks and Caicos Islands~TV~Tuvalu~UG~Uganda~UA~Ukraine~AE~United Arab Emirates~UK~United Kingdom~US~United States~UM~United States Minor Outlying Islands~UY~Uruguay~UZ~Uzbekistan~VU~Vanuatu~VA~Vatican City~VE~Venezuela~VN~Vietnam~VI~Virgin Islands~VG~Virgin Islands, British~WF~Wallis and Futuna~YE~Yemen~ZM~Zambia~ZW~Zimbabwe","");
				</script>
			</select>
			&nbsp;&nbsp;&nbsp;
			<select class="inputStylenation" id="favorstate" name="favorstate">
				<option value='' selected>지역선택</option>
			</select>
			<br/>
			<span class="inforName">이름</span>
			<input class="inputStyle" type="text" name="username" id="username" placeholder='이름을 입력해 주세요.'/><br/>
			<span class="inforName">연락처</span>
			<select class="inputStyletel1" name='telArray' id='tel1'>
				<option value="010" selected>010</option>
				<option value="010">011</option>
				<option value="010">016</option>
				<option value="010">017</option>
				<option value="010">018</option>
				<option value="010">019</option>
			</select>
			 - <input class="inputStyletel2" type="text" name="telArray" id="tel2" placeholder='휴대전화번호를 -없이 입력해 주세요.'/><br/>
			<input type="hidden" name='usertype' value="normal"/>
			<button class='submitBtn'>등록</button>
		</form>
	</div>
</body>
</html>