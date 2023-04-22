<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:requestEncoding value="utf-8"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
      integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 사용자작성 css -->

<!-- sock.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"
        integrity="sha512-ayb5R/nKQ3fgNrQdYynCti/n+GD0ybAhd3ACExcYvOR2J1o3HebiAe/P0oZDx5qwB+xkxuKG6Nc0AFTsPT/JDQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- stomp.js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"
        integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- IE 지원용 : babel-standalone bael-polyfill -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"
        integrity="sha512-kp7YHLxuJDJcOzStgd6vtpxr4ZU9kjn77e6dBsivSz+pUuAuMlE2UTdKB7jjsWT84qbS8kdCWHPETnP/ctrFsA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.12.1/polyfill.min.js"
        integrity="sha512-uzOpZ74myvXTYZ+mXUsPhDF+/iL/n32GDxdryI2SJronkEyKC8FBFRLiBQ7l7U/PTYebDbgTtbqTa6/vGtU23A=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--dataTable--%>
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/>
<%--<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>--%>
<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<style>
    table {
        width: 80%;
        margin-left: auto;
        margin-right: auto;
    }

    td, th {
        text-align: center;
        padding: 2px 10px 2px 10px;
    }

    th {
        background-color: lightgray;
        cursor: pointer;
    }

    table, td, th {

        border-collapse: collapse;
        border: 1px solid black;
    }

    .search_btns {
        display: flex;
        justify-content: space-around;
        width: 100%;
    }

    .search_btn {
        width: 40%;
        text-align: center;
    }

    .other_btns {
        width: 20%;
        text-align: right;
    }

    .graduate_day_box {
        display: flex;
    }

    .date_from_box, .date_to_box {
        width: 49%;
    }

    .date_y {
        width: 20%;
    }

    .date_m, .date_d {
        width: 10%;
    }

    .counts p {
        margin-left: 10%;
        margin-bottom: 0px;
    }

    table.dataTable {
        width: 500px;
    }

    .table-hover {
        margin-right: 100%;
    }

    .col-sm-12 {
        padding-left: 7%;
    }

    .col-sm-5 {
        margin-left: 89px;

    }

    body {
        width: 100%;
    }


    #tbl-board_info {

    }

    #tbl-board_wrapper > div:nth-child(3) {
        margin-left: 40%;
    }

    #tbl-board {
        margin-left: 28%;
        width: 45%;
    }

    #tbl-board_wrapper > div:nth-child(2) {
        width: 100%;
    }

    .form-check-label {
        margin-left: 15px;
        padding-right: 10px;
    }

    #searchStaffFrm > table > tbody > tr:nth-child(3) > td:nth-child(2) {
        padding-right: 13%;
    }

    .newskill {
        border: 1px solid;
        padding: 10px;
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
                    <input id="staffName" class="form-control" type="search" name="staffName" value=""
                           aria-label="Search">
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
                        <option value="컨설팅사업부">컨설팅사업부</option>
                        <option value="하이테크사업부">하이테크사업부</option>
                        <option value="SI사업부">SI사업부</option>
                        <option value="반도체사업부">반도체사업부</option>
                        <option value="기업부설연구소">기업부설연구소</option>
                        <option value="전략기획팀">전략기획팀</option>
                        <option value="경영지원팀">경영지원팀</option>
                    </select>
                </div>
            </td>
        </tr>
        <tr>
            <td class="align-middle">학력</td>
            <td>
                <div class="row school-check">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="고졸" id="flexCheckDefault"
                               name="schoolCode">
                        <label class="form-check-label" for="flexCheckDefault">
                            <div>
                                고졸
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="전문대졸" id="flexCheckChecked"
                               name="schoolCode">
                        <label class="form-check-label" for="flexCheckChecked">
                            <div>
                                전문대졸
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="일반대졸" id="flexCheckChecked"
                               name="schoolCode">
                        <label class="form-check-label" for="flexCheckChecked">
                            <div>
                                일반대졸
                            </div>
                        </label>
                    </div>
                </div>
            </td>
            <td class="align-middle">기술</td>
            <td colspan="3">
                <div class="row">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="JAVA" name="skillCode" id="skill_1">
                        <label class="form-check-label" for="skill_1">
                            <div>
                                Java
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="JSP" name="skillCode" id="skill_2">
                        <label class="form-check-label" for="skill_2">
                            <div>
                                JSP
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="ASP" name="skillCode" id="skill_3">
                        <label class="form-check-label" for="skill_3">
                            <div>
                                ASP
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="PHP" name="skillCode" id="skill_4">
                        <label class="form-check-label" for="skill_4">
                            <div>
                                PHP
                            </div>
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="DELPHI" name="skillCode" id="skill_5">
                        <label class="form-check-label" for="skill_5">
                            <div>
                                Delphi
                            </div>
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
                    <%for (int i = 1981; i <= 2000; i++) { %>
                    <option value="<%=i%>"><%=i%>
                    </option>
                    <%} %>
                </select>
                년

                <select name="startGraduateMonth">
                    <option value=""></option>
                    <option value="02">02</option>
                    <option value="08">08</option>
                </select>
                월


                ~

                <select name="endGraduateYear">
                    <option value=""></option>
                    <%for (int i = 1981; i <= 2000; i++) { %>
                    <option value="<%=i%>"><%=i%>
                    </option>
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

            <%--            <c:forEach items="${staff.newSkillCodes}" var="arr">--%>
            <%--                <span class="newskill" style="margin-left: 7px;" value="${arr}" onclick="deleteDiv(this)">${arr} </span>--%>
            <%--            </c:forEach>--%>
        </tr>
        <tr>
            <td class="align-middle">추가기술</td>
            <td colspan="5">
                <div class="row">
                    <span class="align-self-center">
                        <input id="addInfoData" class="form-control" type="search" name="addInfoData" value=""
                               aria-label="Search" style="width:260px; margin-left: 15px;">
                    </span>
                    <div class="row">
                        <div class="gender-check" style="margin-left: 30px;">
                            <input class="form-check-input" type="radio" value="or" id="OR" name="add_info_type">
                            <label class="form-check-label" for="OR">
                                OR
                            </label>
                        </div>
                        &nbsp;
                        <div class="gender-check">
                            <input class="form-check-input" type="radio" value="and" id="AND" name="add_info_type"
                                   checked>
                            <label class="form-check-label" for="AND">
                                AND
                            </label>
                        </div>


                    </div>
                    <div>
                        <input type="submit" class="btn btn-secondary float-right" id="add-Skill"
                               style="margin-left: 15px;" value="추가">
                        <%--                        onclick="addSkill()"--%>
                    </div>
                    <div class="skill-box" id="skill-box" style="margin-top:5px;">
                        <c:forEach items="${newSkills}" var="arr">
                            <span class="newskill" style="margin-left: 7px;" value="${arr}"
                                  onclick="deleteDiv(this)">${arr} </span>
                        </c:forEach>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <br/>
    <div class="row">
        <div class="col-sm-6 float-right" style="margin-left: 50%;">
            <button type="button" class="btn btn-secondary float-right" id="staffInput" style="margin-right: 10px;"
                    onclick="goRegister()">사원등록
            </button>
            <button type="button" class="btn btn-secondary float-right" style="margin-right:10px;" id="staffReset">초기화
            </button>
            <input type="submit" class="btn btn-secondary float-right" id="staffSearch" style="margin-right:10px;"
                   value="전부검색">
            <input type="submit" class="btn btn-secondary float-right" id="searchDetail" style="margin-right:10px;"
                   value="상세검색"


            <%--			<button type="button" class="btn btn-secondary float-right" style="margin-right:10px;" id="searchAll">전부검색</button>--%>

            <input type="hidden" name="tagInfo" id="tagInfo"/>
            <input type="hidden" name="tagStatus" id="tagStatus" value="ASC"/>
        </div>
    </div>
</form>

<br/>
<br/>
<br/>


<!-- 리스트 시작 -->
<div id="staffContainer">
    <table id="tbl-board" class="table table-hover">
        <thead>
        <tr>
            <th class="col-2" data-tag="staff_no" style="">번호</th>
            <th class="col-2" data-tag="staff_name" style="">이름</th>
            <%--			<th class="col-2">성별</th>--%>
            <th class="col-2">부서</th>
            <th class="col-2">졸업일</th>
            <th class="col-2">수정/삭제</th>
        </tr>
        </thead>
        <!-- 반복접근할 요소 : items="$list} -->
        <!-- 꺼내면 cmmunityEntity니까 communityEntity라는 이름으로 사용 -->
        <tbody id="tbody">


        </tbody>
    </table>
    <!-- 리스트 끝 -->
    <!-- 페이징 시작 -->
    <!-- 페이징 끝 -->
</div>

<script>
    let skillNum = 5;

    function addSkill() {


        let value1 = $('#addInfoData').val().toUpperCase();
        let skillList = ["JAVA", "JSP", "ASP", "PHP", "DELPHI"];
        console.log("value : " + value1);
        var spanValues = document.getElementById("skill-box").getElementsByTagName("span");
        console.log();
        let check = 0;
        // spanValues 변수에 저장된 span 요소의 값을 출력
        for (var i = 0; i < spanValues.length; i++) {
            console.log(i + ': ' + spanValues[i].innerHTML);
            console.log(spanValues[i].innerHTML);
            console.log(value1);
            if (value1 === spanValues[i].innerHTML.trim()) {
                console.log("발동이 안되는거야?");
                check += 1;
            }
        }
        for (var j = 0; j < skillList.length; j++) {
            console.log("스킬리스트 : " + skillList[j]);
            if (value1 === skillList[j] || value1 === "") {
                check += 1;
            }
        }
        if (check == 0) {
            let temphtml = '<span class="newskill" style="margin-left: 7px;" value="' + value1 + '" onclick="deleteDiv(this)" >' + value1 + ' </span>';

            // target-div 요소 내의 모든 span 요소를 선택하여 spanValues 변수에 저장

            $('.skill-box').append(temphtml);
            console.log(check);
        } else {
            alert("이미 포함되어 있거나 비어있습니다.")
        }
    }


    // 수정/삭제 버튼
    function GoUpdate(number) {
        console.log("수정페이지 이동");
        let openWin = window.open("/getupdate?staffNo=" + number, "수정 페이지",
            "width=900, height=900, top=2050, left=2000");

    }

    // 초기화 버튼
    $(document).on("click", "#staffReset", function (e) {
        e.preventDefault();
        console.log("초기화 버튼 작동하나요?");

        $("#searchStaffFrm").each(function (e) {
            this.reset();
        });
    });

    // 검색 버튼
    $("#searchDetail").click(e => {
        console.log("검색 버튼 작동");
        e.preventDefault();
        searchGetPage();
    });

    // 상세검색 버튼
    $("#staffSearch").click(e => {
        console.log("전부검색 버튼 작동");
        e.preventDefault();
        searchAllPage();
    });
    $("#add-Skill").click(e => {
        console.log("스킬추가 작동");
        e.preventDefault();
        addSkill();
    });


    function searchAllPage() {
        $.ajax({
            url: "/searchAll",
            type: 'post',
            dataType: 'text',
            // data: staffRequestDto,
            success: function (jsonString) {
                var jsonArray = JSON.parse(jsonString);
                $('#tbl-board').DataTable().destroy();
                console.log("백에서 가져온 값 : " + jsonString);
                //공식홈페이지에선 데이터가 100,000건 이상이면 서버사이드로 처리하라고 권장하고 있습니다.
                var dataTable = $('#tbl-board').DataTable({
                    "language": {
                        info: '검색건수→ _TOTAL_ 건'
                    },
                    "searching": false,
                    "order": [[0, "desc"]],
                    "pageLength": 4,
                    "lengthChange": false,

                    "ordering": true,
                    "columnDefs": [
                        {"width": "25px", "targets": 0},
                        {"width": "27px", "targets": 1},
                        {"width": "70px", "targets": 2},
                        {"width": "50px", "targets": 3},
                        {"width": "60px", "targets": 4}
                    ],
                    data: jsonArray,
                    columns: [
                        {data: "staffNo"},
                        {data: "staffName"},
                        {data: "departmentCode"},
                        {data: "graduateDay"},
                        {
                            data: "staffNo",
                            render: function (data) {
                                return '<button onclick="GoUpdate(' + data + ')">' + '수정/삭제' + '</button>';
                            }
                        }
                    ]
                });
            },
            error: function () {
                console.log('데이터를 가져오지 못했습니다.');
            }
        });
    }

    function searchGetPage(cPage) {

        const formData = new FormData(document.searchStaffFrm);
        console.log("formData = " + formData);
        const obj = {};
        for (const [k, v] of formData) {
            obj[k] = v;
        }


        // 상세검색
        const $detailSearch = $("[name=detailSearch]").val();
        console.log("detailSearch = " + $detailSearch);


        var orAnd = $('input[name="add_info_type"]:checked').val();

        console.log("orAnd : " + orAnd);


        // 이름
        const $staffName = $("[name=staffName]").val();
        console.log("staffName = " + $staffName);

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


        //새로운 스킬
        const spanValues = document.getElementById("skill-box").getElementsByTagName("span");
        let newSkills = "";
        if (spanValues.length !== 0) {
            newSkills += ",";
            for (let i = 0; i < spanValues.length; i++) {
                newSkills += spanValues[i].innerHTML.trim();
                if (i !== spanValues.length - 1) {
                    newSkills += ", ";
                }
            }
        }

        // 기술
        var skillCodeCnt = $("input[name=skillCode]:checkbox:checked").length;
        console.log("skillCodeCnt = " + skillCodeCnt);
        const $skillCodes = $("[name=skillCode]:checked");
        const skillCodes = $skillCodes
            .toArray() // js array 변환
            .map((skillCode, i) => skillCode.value).toString() + newSkills.replace(/ /g, ""); // skillCode.value만 가진 배열 생성

        // 졸업일 유효성 검사
        var $startGraduateYear = $("select[name=startGraduateYear]").val();
        var $startGraduateMonth = $("select[name=startGraduateMonth]").val();
        var $startGraduateDay = $("select[name=startGraduateDay]").val();
        var $endGraduateYear = $("select[name=endGraduateYear]").val();
        var $endGraduateMonth = $("select[name=endGraduateMonth]").val();
        var $endGraduateDay = $("select[name=endGraduateDay]").val();

        if ($startGraduateYear > $endGraduateYear) {
            alert("졸업일을 정확이 입력해주세요.");
            return false;
        }

        if ($startGraduateMonth != "" && $endGraduateMonth != "") {
            // for문으로 변경해 볼 수 있다.
            if ($startGraduateMonth < 10) {
                $startGraduateMonth = '0' + $startGraduateMonth;
                $startGraduateDay = '01';
            }
            if ($endGraduateMonth < 10) {
                $endGraduateMonth = '0' + $endGraduateMonth;
                $endGraduateDay = '01';
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


        console.log("상세검색작동");
        const staffRequestDto = {
            staffName: $staffName,
            departmentCode: $departmentCode,
            schoolCodes: schoolCodes,
            startGraduateDay: graduateDayFrom,
            endGraduateDay: graduateDayTo,
            skills: skillCodes,
            andOr: orAnd
        }

        $.ajax({
            url: "/search",
            type: 'post',
            dataType: 'text',
            data: staffRequestDto,
            success: function (jsonString) {
                var jsonArray = JSON.parse(jsonString);
                $('#tbl-board').DataTable().destroy();
                console.log("백에서 가져온 값 : " + jsonString);
                //공식홈페이지에선 데이터가 100,000건 이상이면 서버사이드로 처리하라고 권장하고 있습니다.
                var dataTable = $('#tbl-board').DataTable({
                    "language": {
                        info: '검색건수→ _TOTAL_ 건'
                    },
                    "searching": false,
                    "order": [[0, "desc"]],
                    "pageLength": 4,
                    "lengthChange": false,

                    "columnDefs": [
                        {"width": "25px", "targets": 0},
                        {"width": "27px", "targets": 1},
                        {"width": "70px", "targets": 2},
                        {"width": "50px", "targets": 3},
                        {"width": "60px", "targets": 4}
                    ],
                    data: jsonArray,
                    columns: [
                        {data: "staffNo"},
                        {data: "staffName"},
                        {data: "departmentCode"},
                        {data: "graduateDay"},
                        {
                            data: "staffNo",
                            render: function (data) {
                                return '<button onclick="GoUpdate(' + data + ')">' + '수정/삭제' + '</button>';
                            }
                        }
                    ]
                });
            },
            error: function () {
                console.log('데이터를 가져오지 못했습니다.');
            }
        });
    }


    function goRegister() {
        console.log("등록페이지 이동");
        let openWin = window.open("/register", "등록 페이지",
            "width=900, height=900, top=2050, left=2000");

    }

    // newskill을 클릭했을 때 해당 요소를 삭제하는 함수
    function deleteDiv(element) {
        element.parentNode.removeChild(element);
    }

</script>

