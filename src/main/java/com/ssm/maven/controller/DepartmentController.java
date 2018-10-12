package com.ssm.maven.controller;

import com.ssm.maven.bean.Department;
import com.ssm.maven.bean.Msg;
import com.ssm.maven.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
 *
 * @author shyou
 * @date 2018/9/27 - 16:30
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        //查询所有部门信息
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }

}
