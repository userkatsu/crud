package com.ssm.maven.test;

import com.github.pagehelper.PageInfo;
import com.ssm.maven.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.awt.event.ItemListener;
import java.util.List;

/**
 * @author shyou
 * @date 2018/8/30 - 13:59
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {

    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求看到处理结果
    MockMvc mockMvc;

    @Before
    public void InitMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception{

        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
        //请求成功以后请求域中会有PageInfo,我们取出pageInfo验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页码:"+pi.getPageNum());
        System.out.println("总页码:"+pi.getPages());
        System.out.println("总记录:"+pi.getTotal());
        System.out.print("在页面连续显示的页码:");
        int[] nums=pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" "+i);
        }
        
        //获取员工书序
        List<Employee> list = pi.getList();
        for (Employee employee : list) {
            System.out.println("ID:"+employee.getEmpId());
            System.out.println("NAME:"+employee.getEmpName());
            
        }
    }
}
