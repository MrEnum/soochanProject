$(document).ready(function() {
	setDateBox();
});

// select box 연도 , 월 표시
function setDateBox() {
	var dt = new Date();
	var year = "";
	var com_year = dt.getFullYear();

	// 발행 뿌려주기
	$("#year1").append("<option value=''>년도</option>");

	// 올해 기준으로 -50년부터 +1년을 보여준다.
	for (var y = (com_year + 1); y >= (com_year - 50); y--) {
		$("#year1").append("<option value='" + y + "'>" + y + "</option>");
	}

	// 월 뿌려주기(1월부터 12월)
	var month;
	$("#month1").append("<option value=''>월</option>");
	for (var i = 1; i <= 12; i++) {
		$("#month1").append("<option value='" + i + "'>" + i + "</option>");
	}

	// 일 뿌려주기(1일부터 31일)
	var day;
	$("#day1").append("<option value=''>일</option>");
	for (var i = 1; i <= 31; i++) {
		$("#day1").append("<option value='" + i + "'>" + i + "</option>");
	}
	setData();
}
function setData() {

	var sjumin = $("#jumin_no").val().trim();
	var sgraduateday = $("#graduate_day").val();
	var sjumin1 = sjumin.substr(0, 6);
	var sjumin2 = sjumin.substr(6);
	var graduatedayarr = sgraduateday.split('-');
	var sdepartment = $("#sdepartment").val();
	var sschool = $("#sschool").val();
	$("#jumin1").val(sjumin1);
	$("#jumin2").val(sjumin2);
	$("#year1").val(graduatedayarr[0]);
	$("#month1").val(graduatedayarr[1]);
	$("#day1").val(graduatedayarr[2].trim());
	$("#department").val(sdepartment).prop("selected", true);
	$('input:radio[name=school_code]:input[value=' + sschool + ']').attr(
			"checked", true);
	// alert(sdepartment);

	// 저장되어 있는 스킬 뿌리기
	$('.myskill').each(function() {

		var myskill = $(this).val()
		// alert(myskill)
		$(".skill_names").eq(myskill - 1).prop("checked", true);
		skill_chk();
	});

	// 저장되어 있는 추가스킬 뿌리기
	$('.myplusskill').each(function() {

		var myp_skill = $(this).val()
		// alert(myp_skill)
		if (myp_skill != 0)
			$(".p_skill_code").eq(myp_skill - 1).prop("checked", true);
		p_skill_chk();
	});

}

// 선택된 스킬 종류 합치기
function skill_chk() {

	var result = Array();

	var cnt = 0;

	var chkbox = $(".skill_names");

	for (i = 0; i < chkbox.length; i++) {

		if (chkbox[i].checked == true) {

			result[cnt] = chkbox[i].value;

			cnt++;
		}
	}
	// alert(result)
	$("#skills").val(result);
	// alert($("#skills").val());
}

// 선택된 추가 스킬 종류 합치기
function p_skill_chk() {

	var result = Array();

	var cnt = 0;

	var chkbox = $(".p_skill_code");

	for (i = 0; i < chkbox.length; i++) {

		if (chkbox[i].checked == true) {

			result[cnt] = chkbox[i].value;

			cnt++;
		}
	}
	// alert(result)
	$("#pskills").val(result);
	// alert($("#pskills").val());
}

// 삭제시 경고 발생
function con() {
	var con_test = confirm("정말 삭제 하시겠습니까?");
	var staff_no = $("#staff_no").val();
	if (con_test == true) {// 예 누르면 삭제 페이지로 이동

		data = {}
		data['staff_no'] = staff_no;

		$.ajax({
			type : "POST",
			url : "./staff_del_ok",
			data : JSON.stringify(data),
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			async : false,
			success : function(res) {
				// alert("통신성공")
				opener.location.reload();
				window.self.close();

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기
				// 통신이
				// 실패할경우
				// error
				// 콜백으로
				// 들어옵니다.
				// alert("통신 실패.")
				setTimeout(function() {
					isAjaxing = false;
				}, 10000);
			}
		});

	} else if (con_test == false) {
	}
}

function check() {
	// 수정 값들의 입력여부 체크하는 스크립트 추가

	var jumin_no1 = $('#jumin1').val();
	var jumin_no2 = $('#jumin2').val();
	var year1 = $('#year1').val();
	var month1 = $('#month1').val();
	var day1 = $('#day1').val();
	var name = $('#staff_name').val();
	var school = $("input[name=school_code]:checked").val();
	var department = $("select[name=department_code]").val();
	var skills = $('#skills').val();
	var pskills = $('#pskills').val();

	console.log($("select[name=department]").val());

	if (jumin_no1.length != 6 || jumin_no2.length != 7 || isNaN(jumin_no1)
			|| isNaN(jumin_no2)) {
		alert("주민번호를 확인해 주세요")
		return false;
	}

	if (name == "" || !isNaN(name)) {
		alert("이름을 확인해 주세요.")
		return false;
	}

	if (school == "") {
		alert("학력을 선택해 주세요.")
		return false;
	}

	if (department == "") {
		alert("부서를 선택해주세요")
		return false;
	}

	if (year1 == "" || month1 == "" || day1 == "") {
		alert("졸업일자가 잘 못되었습니다")
		return false;
	}

	if (skills == "") {
		alert("기술을 하나이상 선택해 주세요")
		return false;
	}

	jumin_no = jumin_no1 + jumin_no2;
	graduate_day = year1 + "-" + month1 + "-" + day1;
	// alert(my.jumin_no.value+" "+my.graduate_day.value+"
	// "+my.department_code.value+" "+my.school_code.value+" "+my.skills.value);

	var data = {};

	data['staff_no'] = $('#staff_no').val();
	data['name'] = name;
	data['department'] = department;
	data['skills'] = skills;
	data['pskills'] = pskills;
	data['school'] = school;
	data['jumin_no'] = jumin_no;
	data['graduate_day'] = graduate_day;
	// data['page']=$("#thispage").val(); //나중에 page따로 빼고 해당 변수 넣기
	console.log(data);

	$.ajax({
		type : "POST",
		url : "./staff_update_json",
		data : JSON.stringify(data),
		dataType : "json",
		contentType : "application/json;charset=UTF-8",
		async : false,
		success : function(res) {
			// alert("통신성공")
			opener.location.reload();
			window.self.close();

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기
			// 통신이
			// 실패할경우
			// error
			// 콜백으로
			// 들어옵니다.
			// alert("통신 실패.")
			setTimeout(function() {
				isAjaxing = false;
			}, 10000);
		}
	});

}