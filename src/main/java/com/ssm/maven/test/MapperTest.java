package com.ssm.maven.test;

import com.ssm.maven.bean.Employee;
import com.ssm.maven.dao.DepartmentMapper;
import com.ssm.maven.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author shyou
 * @date 2018/8/23 - 18:51
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD() {
        System.out.println(departmentMapper);

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 10; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "F", uid + "@ssm.com", 1));

        }
        System.out.println("批量插入");
    }
}
