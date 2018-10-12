<%--
  Created by IntelliJ IDEA.
  User: shyou
  Date: 2018/8/30
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="static/jquery-2.0.2.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--搭建显示页面-->
<div class="container" style="border: 1px solid #000;">
    <!-- 员工新增模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input"
                                       placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_add_input"
                                       placeholder="email@ssm.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-3">
                                <select class="form-control" name="dId" id="dept_add_select"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 新增，删除 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-lg" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger btn-lg" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示数据的表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>员工编号</th>
                    <th>员工姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所属部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 分页信息 -->
    <div class="row">
        <!-- 分页文字信息 -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页组件 -->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
</body>
<script type="text/javascript">
    //定义全局总记录数
    var totalRecord;

    //1.页面加载完成以后,直接去加载一个ajax请求,要到分页数据
    $(function () {
        //初始化首页
        to_page(1);
    });

    //跳转到页面
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //解析并显示员工数据
                build_emps_table(result);
                //解析并显示分页信息
                build_page_info(result);
                //解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //构建table之前先清空数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append("<td></td>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");

        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总" + result.extend.pageInfo.pages + "页,总" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, i) {
            var numLi = $("<li></li>").append($("<a></a>").append(i).attr("href", "#"));
            if (result.extend.pageInfo.pageNum == i) {
                numLi.addClass("active");
            } else {
                numLi.removeClass();
            }
            numLi.click(function () {
                to_page(i);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        //$("#page_nav_area")
        navEle.appendTo($("#page_nav_area"));
    }

    //点击新增弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //查出部门信息显示在下拉列表
        $("#dept_add_select").empty();
        //取出dom对象调用reset方法
        $("#empAddModal form")[0].reset();
        getDepts();
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查出部门信息
    function getDepts() {
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //显示部门信息到下拉列表
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").attr("value", this.deptId).append(this.deptName);
                    optionEle.appendTo("#dept_add_select");
                });

            }
        });
    }


    //校验表单数据
    function validate_add_form() {
        //先拿到要校验的表单数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位汉字或6-16位英文数字下划线");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位汉字或6-16位英文数字下划线");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        var email = $("#email_add_input").val();
        var regEmail = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //提出校验方法
    function show_validate_msg(ele, status, msg) {
        //首先清楚校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#empName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    //添加自定义属性判断用户名是否可用
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error","用户名已存在");
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击弹出新增员工
    $("#emp_save_btn").click(function () {
        //先校验要提交的表单数据
        if (!validate_add_form()) {
            return false;
        }
        //先要判断之前的用户名校验是否成功,如果成功了提交可用,否则不可用
        if($(this).attr("ajax-va")=="error"){
            show_validate_msg("#empName_add_input","error","用户名已存在或格式不正确");
            return false;
        }

        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                alert(result.msg);
                //成功后关闭模态框
                $("#empAddModal").modal("hide");
                //发送ajax请求显示最后一页数据,直接传入总记录数确保跳转到最后一页
                to_page(totalRecord);
            }
        });
    });
</script>
</html>
