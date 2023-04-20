<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 정보 등록</title>
    <style type="text/css">
        #inputTb{
            width: 100%;
            margin-bottom: 10px;
        }
        table,th,td{
            border:1px solid black;
            border-collapse: collapse;
        }
        #cancelBtn{
            position: relative;
            width : 10%;
        }
        #submitBtn{
            position : relative;
            width:10%;
        }
        .school{
            font-size:12px;
        }
        #btnDiv{
            text-align: right;
        }
        th{
            background-color: silver;
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function(){
            setDate();

            $("#cancelBtn").click(function(){
                location.href='register';
            });

            $('input[type="checkbox"][name="gender"]').click(function(){
                if($(this).prop('checked')){
                    $('input[type="checkbox"][name="gender"]').prop('checked',false);
                    $(this).prop('checked',true);
                }
            });

            $('input[type="checkbox"][name="school_code"]').click(function(){
                if($(this).prop('checked')){
                    $('input[type="checkbox"][name="school_code"]').prop('checked',false);
                    $(this).prop('checked',true);
                }
            });

            $("#submitBtn").click(function(){

                var staff_name = $("#staffName").val();
                var jumin_no = parseInt($("#jumin1").val()+$("#jumin2").val());
                var department_code = $("#department").val();
                var school_code = $("input:checkbox[name=school_code]:checked").val();
                var chkarr = [];
                $("input:checkbox[name='skill']:checked").each(function(){
                    chkarr.push(this.value);
                });

                var fmt = RegExp(/^\d{6}[1234]\d{6}$/) ;

                if(staff_name==null || staff_name==""){
                    alert("이름은 필수사항입니다.");
                    return false;
                }

                if(!fmt.test(jumin_no)){
                    alert('주민등록번호를 형식에 맞춰 입력해주세요.');
                    return false;
                }
                if(department_code==""){
                    alert("부서를 선택해주세요");
                    return false;
                }

                if(school_code==null || school_code==""){
                    alert("학력을 선택해주세요");
                    return false;
                }
                if(chkarr.length==0){
                    alert('기술을 하나이상 선택해주세요');
                    return false;
                }
                if($("#sYear").val()=="" || $("#sMonth").val()==""){
                    alert("졸일을 선택해주세요.");
                    return false;
                }
                var strList = chkarr.toString();
                var graduate_day =($("#sYear").val()+"-"+$("#sMonth").val() + "-" + "01");
                console.log(graduate_day);

                var staffRequestDto = {
                    staffName : staff_name,
                    juminNo : jumin_no,
                    departmentCode : department_code,
                    schoolCode : school_code,
                    graduateDay : graduate_day,
                    skillCode : strList
                };
                console.log(JSON.stringify(staffRequestDto));
                if(confirm('정말 저장 하시겠습니까?')){
                    $.ajax({
                        url:'/register/do',
                        type : 'POST',
                        data : staffRequestDto,
                        // contentType : "application/json",
                        // dataType:'json',
                        success : function(msg) {
                            if(msg.check==true) {
                                alert("저장되었습니다.");
                                opener.window.location.reload();
                                close();
                            }
                            else{
                                alert("저장실패");
                            }
                        },
                        error:function(request,status,error){
                            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }

                    });
                }
            });
        });

        function setDate(){
            var dt = new Date();
            var year = "";
            var com_year = dt.getFullYear();

            $(".year").append("<option value=''></option>");

            for(var y=(com_year-30);y<=com_year;y++){
                $(".year").append("<option value='" + y + "'>" + y + "</option>");
            }

            // ;		$(".month").append("<option value=''></option>");
            // for (var i = 1; i <= 12; i++) {
            //     if(i<10){
            //         $(".month").append("<option value='" +"0"+ i + "'>" + "0"+i + "</option>");
            //     }else{
            //         $(".month").append("<option value='" + i + "'>" + i + "</option>");
            //     }
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
        <th colspan="6">사원 정보 등록</th>
    </tr>
    <tr>
        <th>이름</th>
        <td><input type="text" style="width:90%;" id="staffName"></td>
        <th>주민번호</th>
        <td><input type="text" style="width:35%;" id="jumin1" required="required"> - <input type="password" style="width:35%;" id="jumin2"></td>
        <th>부서</th>
        <td>
            <select style="width:100%;" id="department">
                <option value=""></option>
                <option value="컨설팅사업부">컨설팅사업부</option>
                <option value="하이테크사업부">하이테크사업부</option>
                <option value="SI사업부">SI사업부</option>
                <option value="반도체사업부">반도체사업부</option>
                <option value="기업부설연구소">기업부설연구소</option>
                <option value="전략기획팀">전략기획팀</option>
                <option value="경영지원팀">경영지원팀</option>
            </select>
        </td>
    </tr>
    <tr>
        <th>학력</th>
        <td>
            <input type="checkbox" name="school_code" value="고졸"><label class="school">고졸</label>
            <input type="checkbox" name="school_code" value="전문대졸"><label class="school">전문대졸</label>
            <input type="checkbox" name="school_code" value="일반대졸"><label class="school">일반대졸</label>
        </td>
        <th>기술</th>
        <td colspan="3">
            <input type="checkbox" name="skill" value="JAVA"><label>Java</label>
            <input type="checkbox" name="skill" value="JSP"><label>JSP</label>
            <input type="checkbox" name="skill" value="ASP"><label>ASP</label>
            <input type="checkbox" name="skill" value="PHP"><label>PHP</label>
            <input type="checkbox" name="skill" value="DELPHI"><label>Delphi</label>
        </td>
    </tr>
    <tr>
        <th>졸업일</th>
        <td colspan="5" id="jol">
            <select style="width:10%;" class="year" id="sYear">
            </select>년
            <select style="width:7%;" class="month" id="sMonth">
                <option value=""></option>
                <option value="02">02</option>
                <option value="08">08</option>
            </select>월
        </td>
    </tr>
</table>
<div id="btnDiv">
    <button id="submitBtn">등록</button>
    <button id="cancelBtn">초기화</button>
</div>
</body>
</html>