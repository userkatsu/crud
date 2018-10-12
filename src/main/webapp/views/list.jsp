<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="../static/jquery-2.0.2.min.js"></script>
    <link href="../static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="../static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--搭建显示页面-->
<div class="container" style="border: 1px solid #000;">
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
                <%--<thead>--%>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>员工编号</th>
                    <th>员工姓名</th>
                    <th>邮箱</th>
                    <th>性别</th>
                    <th>所属部门</th>
                    <th>操作</th>
                </tr>

                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>

                </tr>

                <%--</thead>--%>
                <%--<tbody>

                </tbody>--%>
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
</html>
