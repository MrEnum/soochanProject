<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 정보 수정</title>
    <style type="text/css">
        #inputTb {
            width: 100%;
            margin-bottom: 10px;
        }

        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        #deleteBtn, #submitBtn {
            position: relative;
            width: 10%;
        }

        .school {
            font-size: 12px;
        }

        #btnDiv {
            text-align: center;
        }

        th {
            background-color: silver;
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
            setDate();
            <c:forEach items="${staff.skillCode}" var="arr">
            $("input[value=${arr}][name=skill]").attr("checked", true);
            </c:forEach>

            $('input[type="checkbox"][name="school_code"]').click(function () {
                if ($(this).prop('checked')) {
                    $('input[type="checkbox"][name="school_code"]').prop('checked', false);
                    $(this).prop('checked', true);
                }
            });

            $("#submitBtn").click(function () {
                var fmt = RegExp(/^\d{6}[1234]\d{6}$/);
                var graduate_day = ($("#gYear").val() + "-" + $("#gMonth").val() + "-" + "01");
                var staff_name = $("#staffName").val();
                var jumin_no = $("#jumin1").val() + $("#jumin2").val();
                var department_code = $("#department").val();
                var school_code = $("input:checkbox[name=school_code]:checked").val();
                var chkarr = [];
                var staff_no = ${staffNo}
                    $("input:checkbox[name='skill']:checked").each(function () {
                        chkarr.push(this.value);
                    });
                if (staff_name == null || staff_name == "") {
                    alert("이름은 필수사항입니다.");
                    return false;
                }
                if (department_code == "") {
                    alert("부서를 선택해주세요");
                    return false;
                }
                if (school_code == null || school_code == "") {
                    alert("학력을 선택해주세요");
                    return false;
                }
                if (chkarr.length == 0) {
                    alert('기술을 하나이상 선택해주세요');
                    return false;
                }
                if (!fmt.test(jumin_no)) {
                    alert('주민등록번호를 형식에 맞춰 입력해주세요.');
                    return false;
                }
                if ($("#gYear").val() == "" || $("#gMonth").val() == "") {
                    alert("졸업일을 선택해주세요.");
                    return false;
                }
                console.log("staffName" + staff_name);
                console.log("juminNo" + jumin_no);
                console.log("departmentCode" + department_code);
                console.log("schoolCode" + school_code);
                console.log("graduateDay" + graduate_day);

                console.log("staffNo" + staff_no);
                var skillString = chkarr.toString();
                console.log("skillCode" + skillString);

                var staffRequestDto = {
                    staffName: staff_name,
                    juminNo: jumin_no,
                    departmentCode: department_code,
                    schoolCode: school_code,
                    graduateDay: graduate_day,
                    skillCode: skillString,
                    staffNo: staff_no
                };
                console.log(staffRequestDto);
                if (confirm('정말 저장 하시겠습니까?')) {
                    $.ajax({
                        url: 'update',
                        type: 'post',
                        data: staffRequestDto,
                        success: function (msg) {
                            alert("수정되었습니다.");
                            window.close();
                        },
                        error: function () {
                            alert("에러");
                        }
                    });
                }
            });

            $("#deleteBtn").click(function () {
                if (confirm("정말 삭제 하시겠습니까?")) {
                    var staff_no = ${staffNo};
                    console.log("staffNo : " + staff_no);
                    $.ajax({
                        url: '/delete/' + staff_no,
                        type: "DELETE",
                        dataType: "json",
                        success: function (msg) {
                            alert("삭제되었습니다");
                            opener.window.location.reload();
                            close();
                        },
                        error: function () {

                        }
                    });
                }
            });

        });

        function setDate() {
            var dt = new Date();
            var com_year = dt.getFullYear();

            $(".year").append("<option value=''></option>");

            for (var y = (com_year - 30); y <= com_year; y++) {
                $(".year").append("<option value='" + y + "'>" + y + "</option>");
            }

            // ;$(".month").append("<option value=''></option>");
            // for (var i = 1; i <= 12; i++) {
            //     if (i < 10) {
            //         $(".month").append("<option value='" + "0" + i + "'>" + "0" + i + "</option>");
            //     } else {
            //         $(".month").append("<option value='" + i + "'>" + i + "</option>");
            //     }
            // }

            // $(".day").append("<option value=''></option>");
            // for (var i = 1; i <= 31; i++) {
            // 	if (i < 10) {
            // 		$(".day").append("<option value='" + "0" + i + "'>" + "0" + i + "</option>");
            // 	} else {
            // 		$(".day").append("<option value='" + i + "'>" + i + "</option>");
            // 	}
            // }
        }

    </script>
</head>
<body>
<table id="inputTb" align="center">
    <col width="10%">
    <col width="30%">
    <col width="10%">
    <col width="20%">
    <col width="10%">
    <col width="20%">
    <tr>
        <th colspan="6">사원 정보 수정</th>
    </tr>
    <tr>
        <th>이름</th>
        <td><input type="text" style="width:90%;" id="staffName" value="${staff.staffName }"></td>
        <th>주민번호</th>
        <td><input type="text" style="width:35%;" id="jumin1" required="required"
                   value="${fn:substring(staff.juminNo,0,6) }"> - <input type="password" style="width:35%;" id="jumin2"
                                                                         value="${fn:substring(staff.juminNo,6,13) }">
        </td>
        <th>부서</th>
        <td>
            <select style="width:100%;" id="department">
                <option value=""></option>
                <option value="컨설팅사업부" <c:if test="${staff.departmentCode eq '컨설팅사업부' }">selected</c:if>>컨설팅사업부</option>
                <option value="하이테크사업부" <c:if test="${staff.departmentCode eq '하이테크사업부' }">selected</c:if>>하이테크사업부
                </option>
                <option value="SI사업부" <c:if test="${staff.departmentCode eq 'SI사업부'}">selected</c:if>>SI사업부</option>
                <option value="반도체사업부" <c:if test="${staff.departmentCode eq '반도체사업부' }">selected</c:if>>반도체사업부</option>
                <option value="기업부설연구소" <c:if test="${staff.departmentCode eq '기업부설연구소' }">selected</c:if>>기업부설연구소
                </option>
                <option value="전략기획팀" <c:if test="${staff.departmentCode eq '전략기획팀' }">selected</c:if>>전략기획팀</option>
                <option value="경영지원팀" <c:if test="${staff.departmentCode eq '경영지원팀' }">selected</c:if>>경영지원팀</option>
            </select>
        </td>
    </tr>
    <tr>
        <th>학력</th>
        <td>
            <input type="checkbox" name="school_code" value="고졸"
                   <c:if test="${staff.schoolCode eq '고졸' }">checked</c:if>><label class="school">고졸</label>
            <input type="checkbox" name="school_code" value="전문대졸"
                   <c:if test="${staff.schoolCode eq '전문대졸' }">checked</c:if>><label class="school">전문대졸</label>
            <input type="checkbox" name="school_code" value="일반대졸"
                   <c:if test="${staff.schoolCode eq '일반대졸' }">checked</c:if>><label class="school">일반대졸</label>
        </td>
        <th>기술</th>
        <td colspan="3">
            <input type="checkbox" name="skill" value="JAVA"
                   <c:if test="${staff.skillCode eq '31' }">checked</c:if>><label>Java</label>
            <input type="checkbox" name="skill" value="JSP"
                   <c:if test="${staff.skillCode eq '32' }">checked</c:if>><label>JSP</label>
            <input type="checkbox" name="skill" value="ASP"
                   <c:if test="${staff.skillCode eq '33' }">checked</c:if>><label>ASP</label>
            <input type="checkbox" name="skill" value="PHP"
                   <c:if test="${staff.skillCode eq '34' }">checked</c:if>><label>PHP</label>
            <input type="checkbox" name="skill" value="DELPHI"
                   <c:if test="${staff.skillCode eq '35' }">checked</c:if>><label>Delphi</label>
        </td>
    </tr>
    <tr>
        <th>졸업일</th>
        <c:set var="Year"><fmt:formatDate value="${yearMonth}" pattern="yyyy"/></c:set>
        <c:set var="Month"><fmt:formatDate value="${yearMonth}" pattern="MM"/></c:set>
        <%--				<c:set var="Day"><fmt:formatDate value="${staff.graduateDay}" pattern="dd" /></c:set>--%>
        <td colspan="5" id="jol">
            <select style="width:10%;" class="year" id="gYear">
                <option value="${Year }"><c:out value="${Year}"/></option>
            </select>년
            <select style="width:7%;" class="month" id="gMonth">
                <option value="${Month }"></option>
                <option value="02">02</option>
                <option value="08">08</option>
            </select>월
            <%--					<select style="width:7%;" class="day" id="gDay" >--%>
            <%--						<option value="${Day }"><c:out value="${Day}" /></option>--%>
            <%--					</select>일--%>
            <%--				</td>--%>
    </tr>
</table>
<div id="btnDiv">
    <button id="submitBtn">수정</button>
    <button id="deleteBtn">삭제</button>
</div>
</body>
</html>