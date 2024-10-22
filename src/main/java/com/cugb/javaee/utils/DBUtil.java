package com.cugb.javaee.utils;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.jdbc.core.JdbcTemplate;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 数据库工具类，使用 Druid 数据源和 JdbcTemplate
 */
public class DBUtil {
    private static DruidDataSource dataSource;
    private static JdbcTemplate jdbcTemplate;

    static {
        try {
            // 加载数据库配置文件
            Properties properties = new Properties();
            InputStream inputStream = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
            properties.load(inputStream);

            // 创建 Druid 数据源
            dataSource = new DruidDataSource();
            dataSource.setDriverClassName(properties.getProperty("jdbc.driverClassName"));
            dataSource.setUrl(properties.getProperty("jdbc.url"));
            dataSource.setUsername(properties.getProperty("jdbc.username"));
            dataSource.setPassword(properties.getProperty("jdbc.password"));

            // 配置连接池参数（可根据需要调整）
            dataSource.setInitialSize(5);
            dataSource.setMinIdle(5);
            dataSource.setMaxActive(20);

            // 创建 JdbcTemplate 对象
            jdbcTemplate = new JdbcTemplate(dataSource);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取 JdbcTemplate 对象
     * @return JdbcTemplate
     */
    public static JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
}
