package com.ssm.maven.service;

import com.ssm.maven.bean.Department;
import com.ssm.maven.bean.Msg;
import com.ssm.maven.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author shyou
 * @date 2018/9/27 - 16:32
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){

        return departmentMapper.selectByExample(null);
    }
}
