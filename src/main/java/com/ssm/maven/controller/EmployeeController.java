package com.ssm.maven.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.maven.bean.Employee;
import com.ssm.maven.bean.Msg;
import com.ssm.maven.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author shyou
 * @date 2018/8/30 - 13:24
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 检验用户名是否存在
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("empName")String empName){
                    //@requestParam明确的告诉SpringMVC要取出的值
        boolean b = employeeService.checkuser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引入pagehelpr分页插件
        //在查询之前只需要调用pagehelpr
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
        // 封装了详细的信息,包括有我们查询的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }


    // @RequestMapping("/emps")
    public String getEmpS(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入pagehelpr分页插件
        //在查询之前只需要调用pagehelpr
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面
        // 封装了详细的信息,包括有我们查询的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
