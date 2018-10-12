package com.ssm.maven.service;

import com.ssm.maven.bean.Employee;
import com.ssm.maven.bean.EmployeeExample;
import com.ssm.maven.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shyou
 * @date 2018/8/30 - 13:44
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     *
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存方法
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否可用
     * return true 代表没有改记录,false 代表存在该条记录
     */
    public boolean checkuser(String empName) {
        //创建一个Example对象
        EmployeeExample example = new EmployeeExample();
        //创建查询条件
        EmployeeExample.Criteria criteria = example.createCriteria();
        //拼装我们要的条件
        //员工的名字必须是传进来的值
        criteria.andEmpNameEqualTo(empName);
        //查询数据库中所存在的该条记录数有则>0
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

}
