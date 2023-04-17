<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<!-- sock.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js" integrity="sha512-ayb5R/nKQ3fgNrQdYynCti/n+GD0ybAhd3ACExcYvOR2J1o3HebiAe/P0oZDx5qwB+xkxuKG6Nc0AFTsPT/JDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- IE 지원용 : babel-standalone bael-polyfill -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js" integrity="sha512-kp7YHLxuJDJcOzStgd6vtpxr4ZU9kjn77e6dBsivSz+pUuAuMlE2UTdKB7jjsWT84qbS8kdCWHPETnP/ctrFsA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.12.1/polyfill.min.js" integrity="sha512-uzOpZ74myvXTYZ+mXUsPhDF+/iL/n32GDxdryI2SJronkEyKC8FBFRLiBQ7l7U/PTYebDbgTtbqTa6/vGtU23A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
    th, td {
        text-align: center;
    }
</style>

<form id="searchStaffFrm" name="searchStaffFrm">
    <table class="table table-bordered">
        <thead>
        <tr>
            <th colspan="6">사원 정보 검색</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="align-middle">이름</td>
            <td>
                <div class="align-self-center">
                    <input id="staffName" class="form-control" type="search" name="staffName" value="" aria-label="Search">
                </div>
            </td>
            <%--			<td class="align-middle">성별</td>--%>
            <%--			<td>--%>
            <%--				<div class="row">--%>
            <%--					<div class="gender-check" style="margin-left: 30px;">--%>
            <%--						<input class="form-check-input" type="checkbox" value="M" id="gender_M" name="gender">--%>
            <%--						<label class="form-check-label" for="flexCheckDefault">--%>
            <%--							남--%>
            <%--						</label>--%>
            <%--					</div>--%>
            <%--					&nbsp;--%>
            <%--					<div class="gender-check">--%>
            <%--						<input class="form-check-input" type="checkbox" value="W" id="gender_F" name="gender">--%>
            <%--						<label class="form-check-label" for="flexCheckChecked">--%>
            <%--							여--%>
            <%--						</label>--%>
            <%--					</div>--%>
            <%--				</div>--%>
            <%--			</td>--%>
            <td class="align-middle">부서</td>
            <td class="align-middle">
                <div class="department-check">
                    <select name="departmentCode" id="departmentCode">
                        <option value=""></option>
                        <option value="1">컨설팅사업부</option>
                        <option value="2">하이테크사업부</option>
                        <option value="3">SI사업부</option>
                        <option value="4">반도체사업부</option>
                        <option value="5">기업부설연구소</option>
                        <option value="6">전략기획팀</option>
                        <option value="7">경영지원팀</option>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <td class="align-middle">학력</td>
            <td>
                <div class="row school-check">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="1" id="flexCheckDefault" name="schoolCode">
                        <label class="form-check-label" for="flexCheckDefault">
                            고졸
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="2" id="flexCheckChecked" name="schoolCode">
                        <label class="form-check-label" for="flexCheckChecked">
                            전문대졸
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="3" id="flexCheckChecked" name="schoolCode">
                        <label class="form-check-label" for="flexCheckChecked">
                            일반대졸
                        </label>
                    </div>
                </div>
            </td>
            <td class="align-middle">기술</td>
            <td colspan="3">
                <div class="row">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="1" name="skillCode" id="skill_1">
                        <label class="form-check-label" for="skill_1">
                            Java
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="2" name="skillCode" id="skill_2">
                        <label class="form-check-label" for="skill_2">
                            JSP
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="3" name="skillCode" id="skill_3">
                        <label class="form-check-label" for="skill_3">
                            ASP
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="4" name="skillCode" id="skill_4">
                        <label class="form-check-label" for="skill_4">
                            PHP
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="5" name="skillCode" id="skill_5">
                        <label class="form-check-label" for="skill_5">
                            Delphi
                        </label>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="align-middle">졸업일</td>
            <td colspan="5 align-middle">
                <select name="startGraduateYear">
                    <option value=""></option>
                    <%for(int i=1981; i<=2000; i++){ %>
                    <option value="<%=i%>"><%=i%></option>
                    <%} %>
                </select>
                년

                <select name="startGraduateMonth">
                    <option value=""></option>
                    <option value="2">02</option>
                    <option value="2">08</option>
                </select>
                월


                ~

                <select name="endGraduateYear">
                    <option value=""></option>
                    <%for(int i=1981; i<=2000; i++){ %>
                    <option value="<%=i%>"><%=i%></option>
                    <%} %>
                </select>
                년

                <select name="endGraduateMonth">
                    <option value=""></option>
                    <option value="2">02</option>
                    <option value="2">08</option>
                </select>
                월

            </td>
        </tr>
        <tr>
            <td class="align-middle">상세검색</td>
            <td colspan="5">
                <div class="row">
                    <div class="align-self-center">
                        <input id="addInfoData" class="form-control" type="search" name="addInfoData" value="" aria-label="Search" style="width:260px;">
                    </div>
                    <div class="row">
                        <div class="gender-check" style="margin-left: 30px;">
                            <input class="form-check-input" type="checkbox" value="or" id="OR" name="add_info_type">
                            <label class="form-check-label" for="OR">
                                OR
                            </label>
                        </div>
                        &nbsp;
                        <div class="gender-check">
                            <input class="form-check-input" type="checkbox" value="and" id="AND" name="add_info_type">
                            <label class="form-check-label" for="AND">
                                AND
                            </label>
                        </div>
                        <div>
                            <input type="submit" class="btn btn-secondary float-right" id="searchDetail" value="검색">
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <br />
    <div class="row">
        <div class="col-sm-6 float-right">
            <input type="submit" class="btn btn-secondary float-right" id="staffSearch" value="검색">
        </div>
        <div class="col-sm-6 float-right">
            <button type="button" class="btn btn-secondary float-right" id="staffInput">등록</button>
            <button type="button" class="btn btn-secondary float-right" style="margin-right:10px;" id="staffReset">초기화</button>
            <button type="button" class="btn btn-secondary float-right" style="margin-right:10px;" id="searchAll">전부검색</button>

            <input type="hidden" name="tagInfo" id="tagInfo" />
            <input type="hidden" name="tagStatus" id="tagStatus" value="ASC"/>
        </div>
    </div>
</form>

<br />
<br />
<br />

<div class="float-right" id="totalCountContainer">
    <p>검색건수 → ${totalContent}건</p>
</div>

<!-- 리스트 시작 -->
<div id="staffContainer">
    <table id="tbl-board" class="table table-hover">
        <thead>
        <tr>
            <th class="col-2" data-tag="staff_no" style="cursor:pointer;">번호</th>
            <th class="col-2" data-tag="staff_name" style="cursor:pointer;">이름</th>
            <%--			<th class="col-2">성별</th>--%>
            <th class="col-2">부서</th>
            <th class="col-2">졸업일</th>
            <th class="col-2"></th>
        </tr>
        </thead>
        <!-- 반복접근할 요소 : items="${list} -->
        <!-- 꺼내면 cmmunityEntity니까 communityEntity라는 이름으로 사용 -->
        <tbody id = "tbody">


        </tbody>
    </table>
    <!-- 리스트 끝 -->
    <!-- 페이징 시작 -->
    <!-- 페이징 끝 -->
</div>

<script>
    $(document).ready(function() {
        $(".dropdown-toggle").dropdown();
    });

    // 상세검색 토글
    $('input[type="checkbox"][name="orAnd"]').click(function(){
        // 만약에 체크박스가 클릭되어있으면,
        if($(this).prop('checked')){
            // 체크박스 전체를 checked 해제 후,
            $('input[type="checkbox"][name="orAnd"]').prop('checked', false);
            // click한 요소만 true로 지정
            $(this).prop('checked', true);
        }
    });

    // // 성별 토글
    // $('input[type="checkbox"][name="gender"]').click(function(){
    // 	// 만약에 체크박스가 클릭되어있으면,
    // 	if($(this).prop('checked')){
    // 		// 체크박스 전체를 checked 해제 후,
    // 		$('input[type="checkbox"][name="gender"]').prop('checked', false);
    // 		// click한 요소만 true로 지정
    // 		$(this).prop('checked', true);
    // 	}
    // });

    // 전부검색
    $(document).on('click', '#searchAll', function(e){
        e.preventDefault();
        location.href = `${pageContent.request.contextPath}/erp/staff/selectAllStaff.do`
    });

    // 등록 버튼
    $("#staffInput").on("click", function(e){
        e.preventDefault();
        console.log("등록버튼 작동하나요?");

        let popUrl = "${pageContext.request.contextPath}/staff/staff_input_form.do";
        let popOption = "width = 1500px, height=500px, top=100px, left=200px, scrollbars=yes";

        window.open(popUrl, "등록", popOption);
    });

    // 수정/삭제 버튼
    $(document).on("click", "#modifyDelete", function(e){
        e.preventDefault();
        console.log("수정/삭제 버튼 작동하나요?");
        var $staffNo = $("#modifyDelete").val();
        console.log("삭제할 staffNo = " + $staffNo);

        let popUrl = `${pageContext.request.contextPath}/staff/staff_updel_form.do?staffNo=\${\$staffNo}`;
        let popOption = "width = 1500px, height=500px, top=100px, left=200px, scrollbars=yes";

        window.open(popUrl, "수정/삭제", popOption);
    });

    // 초기화 버튼
    $(document).on("click", "#staffReset", function(e){
        e.preventDefault();
        console.log("초기화 버튼 작동하나요?");

        $("#searchStaffFrm").each(function(e){
            this.reset();
        });
    });

    // 검색 버튼
    $("#staffSearch").click(e => {
        console.log("검색 버튼 작동");
        e.preventDefault();
        searchGetPage();
    });

    // 상세검색 버튼
    $("#searchDetail").click(e => {
        console.log("상세검색 버튼 작동");
        e.preventDefault();
        searchGetPage();
    });

    // 정렬
    $("th").click((e) => {
        var tagInfo = $(e.target).data('tag');
        $("#tagInfo").val(tagInfo);
        console.log("tagInfo = " + tagInfo);

        if($("#tagStatus").val() == 'ASC'){
            var tagStatus = $("#tagStatus").val('DESC');
        }else{
            var tagStatus = $("#tagStatus").val('ASC');
        }

        const formData = new FormData(document.searchStaffFrm);
        console.log("formData = " + formData);
        const obj = {};
        for(const [k, v] of formData){
            obj[k] = v;
        };

        // 상세검색
        const $detailSearch = $("[name=detailSearch]").val();
        console.log("detailSearch = " + $detailSearch);

        // OR AND
        const orAnd = $("input[name='orAnd']:checked").val();
        //console.log("orAnd = " + orAnd);

        // paging
        var cPage;
        obj.cPage = cPage;
        // 이름
        const $staffName = $("[name=staffName]").val();
        console.log("staffName = " + $staffName);

        // 성별
        //const $gender = $("input[name='gender']:checked").val();
        //console.log("gender = " + $gender);

        // 부서
        const $departmentCode = $("select[name=departmentCode]").val();
        console.log("departmentCode = " + $departmentCode);

        // 학력
        var schoolCodeCnt = $("input[name=schoolCode]:checkbox:checked").length;
        console.log("schoolCodeCnt = " + schoolCodeCnt);
        const $schoolCodes = $("[name=schoolCode]:checked");
        const schoolCodes = $schoolCodes
            .toArray() // js array 변환
            .map((schoolCode, i) => schoolCode.value); // schoolCode.value만 가진 배열 생성
        obj.schoolCode = schoolCodes;

        // 기술
        var skillCodeCnt = $("input[name=skillCode]:checkbox:checked").length;
        console.log("skillCodeCnt = " + skillCodeCnt);
        const $skillCodes = $("[name=skillCode]:checked");
        const skillCodes = $skillCodes
            .toArray() // js array 변환
            .map((skillCode, i) => skillCode.value); // skillCode.value만 가진 배열 생성
        obj.skillCode = skillCodes;

        // 졸업일 유효성 검사
        var $startGraduateYear = $("select[name=startGraduateYear]").val();
        var $startGraduateMonth = $("select[name=startGraduateMonth]").val();
        var $startGraduateDay = $("select[name=startGraduateDay]").val();
        var $endGraduateYear = $("select[name=endGraduateYear]").val();
        var $endGraduateMonth = $("select[name=endGraduateMonth]").val();
        var $endGraduateDay = $("select[name=endGraduateDay]").val();

        if($startGraduateYear > $endGraduateYear){
            alert("졸업일을 정확이 입력해주세요.");
            return false;
        }

        if($startGraduateMonth != "" && $endGraduateMonth != ""){
            // for문으로 변경해 볼 수 있다.
            if($startGraduateMonth < 10){
                $startGraduateMonth = '0' + $startGraduateMonth;
                $startGraduateDay = '00';
            }
            if($endGraduateMonth < 10){
                $endGraduateMonth = '0' + $endGraduateMonth;
                $endGraduateDay = '00';
            }
        } else {
            $startGraduateYear = "";
            $endGraduateYear = "";
            $startGraduateMonth = "";
            $endGraduateMonth = "";
            $startGraduateDay = "";
            $endGraduateDay = "";
        }

        obj.graduateDayFrom = $startGraduateYear + $startGraduateMonth + $startGraduateDay;
        obj.graduateDayTo = $endGraduateYear + $endGraduateMonth + $endGraduateDay;


        const searchStr = JSON.stringify(obj);
        console.log("searchStr = " + searchStr);


        $.ajax({
            url: "/search",
            method: "POST",
            data: searchStr,
            // contentType: "application/json; charset=utf-8",
            success(res){
                console.log("res = " + res);

                $("#tbody").html('');

                $.each(res.selectStaffInfoByTypeList, (k, v) => {
                    const graduateDay = v.graduateDay.substr(0, 4) + "-" + v.graduateDay.substr(4, 2) + "-" + v.graduateDay.substr(6, 2);
                    $("#tbody").append(`
							<tr>
								<td>\${v.staffNo}</td>
								<td>\${v.staffName}</td>
<!--								<td>\${v.gender}</td>-->
								<td>\${v.departmentName}</td>
								<td>\${graduateDay}</td>
								<td><button value="\${v.staffNo}"  id=modifyDelete type="button" class="btn btn-secondary float-right">수정/삭제</button></td>
							</tr>


							`);
                });
                $(".pagebar").html('').html(res["pagebar"]);
                $("#totalCountContainer").html(`검색건수 → \${res.totalContent}건`);
            },
            error: console.log
        });
    });


    function searchGetPage(cPage) {

        const formData = new FormData(document.searchStaffFrm);
        console.log("formData = " + formData);
        const obj = {};
        for(const [k, v] of formData){
            obj[k] = v;
        };

        // 상세검색
        const $detailSearch = $("[name=detailSearch]").val();
        console.log("detailSearch = " + $detailSearch);

        // OR AND
        const $orAnd = $("input[name='orAnd']:checked").val();
        console.log("orAnd = " + $orAnd);

        // paging
        // var cPage;
        // obj.cPage = cPage;

        // 이름
        const $staffName = $("[name=staffName]").val();
        console.log("staffName = " + $staffName);

        // 성별
        //const $gender = $("input[name='gender']:checked").val();
        //console.log("gender = " + $gender);

        // 부서
        const $departmentCode = $("select[name=departmentCode]").val();
        console.log("departmentCode = " + $departmentCode);

        // 학력
        var schoolCodeCnt = $("input[name=schoolCode]:checkbox:checked").length;
        console.log("schoolCodeCnt = " + schoolCodeCnt);
        const $schoolCodes = $("[name=schoolCode]:checked");
        const schoolCodes = $schoolCodes
            .toArray() // js array 변환
            .map((schoolCode, i) => schoolCode.value).toString(); // schoolCode.value만 가진 배열 생성
        // obj.schoolCode = schoolCodes;

        // 기술
        var skillCodeCnt = $("input[name=skillCode]:checkbox:checked").length;
        console.log("skillCodeCnt = " + skillCodeCnt);
        const $skillCodes = $("[name=skillCode]:checked");
        const skillCodes = $skillCodes
            .toArray() // js array 변환
            .map((skillCode, i) => skillCode.value).toString(); // skillCode.value만 가진 배열 생성
        // obj.skillCode = skillCodes;

        // 졸업일 유효성 검사
        var $startGraduateYear = $("select[name=startGraduateYear]").val();
        var $startGraduateMonth = $("select[name=startGraduateMonth]").val();
        var $startGraduateDay = $("select[name=startGraduateDay]").val();
        var $endGraduateYear = $("select[name=endGraduateYear]").val();
        var $endGraduateMonth = $("select[name=endGraduateMonth]").val();
        var $endGraduateDay = $("select[name=endGraduateDay]").val();

        if($startGraduateYear > $endGraduateYear){
            alert("졸업일을 정확이 입력해주세요.");
            return false;
        }

        if($startGraduateMonth != "" && $endGraduateMonth != ""){
            // for문으로 변경해 볼 수 있다.
            if($startGraduateMonth < 10){
                $startGraduateMonth = '0' + $startGraduateMonth;
                $startGraduateDay = '00';
            }
            if($endGraduateMonth < 10){
                $endGraduateMonth = '0' + $endGraduateMonth;
                $endGraduateDay = '00';
            }
        } else {
            $startGraduateYear = "";
            $endGraduateYear = "";
            $startGraduateMonth = "";
            $endGraduateMonth = "";
            $startGraduateDay = "";
            $endGraduateDay = "";
        }

        var graduateDayFrom = $startGraduateYear + $startGraduateMonth + $startGraduateDay;
        var graduateDayTo = $endGraduateYear + $endGraduateMonth + $endGraduateDay;

        // const searchStr = JSON.stringify(obj);
        // console.log("searchStr = " + searchStr);
        console.log($staffName);
        console.log($departmentCode);
        console.log(schoolCodes);
        console.log(graduateDayFrom);
        console.log($graduateDayTo);
        console.log(skillCodes);
        staffRequestDto ={
            staffName : $staffName,
            departmentCode : $departmentCode,
            schoolCode : schoolCodes,
            startGraduateDay : graduateDayFrom,
            endGraduateDay : graduateDayTo,
            skills : skillCodes
        }

        $.ajax({
            url: "/search",
            method: "POST",
            data: staffRequestDto,
            // contentType: "application/json; charset=utf-8",
            success(res){
                console.log("res = " + res);

                $("#tbody").html('');

                $.each(res.selectStaffInfoByTypeList, (k, v) => {
                    const graduateDay = v.graduateDay.substr(0, 4) + "-" + v.graduateDay.substr(4, 2) + "-" + v.graduateDay.substr(6, 2);
                    $("#tbody").append(`
							<tr>
								<td>\${v.staffNo}</td>
								<td>\${v.staffName}</td>
								<td>\${v.gender}</td>
								<td>\${v.departmentName}</td>
								<td>\${graduateDay}</td>
								<td><button value="\${v.staffNo}"  id=modifyDelete type="button" class="btn btn-secondary float-right">수정/삭제</button></td>
							</tr>


							`);
                });
                $(".pagebar").html('').html(res["pagebar"]);
                $("#totalCountContainer").html(`검색건수 → \${res.totalContent}건`);
            },
            error: console.log
        });

    }


</script>

