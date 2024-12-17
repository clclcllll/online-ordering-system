package com.cugb.javaee.utils;

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * 数据库工具类，使用 Druid 数据源和 JdbcTemplate
 */
public class DBUtil {
    private static DruidDataSource dataSource;
    private static JdbcTemplate jdbcTemplate;
    private static PlatformTransactionManager transactionManager;
    private static TransactionTemplate transactionTemplate;

    static {
        try {
            // 初始化 Druid 数据源
            dataSource = new DruidDataSource();
            dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
            dataSource.setUrl("jdbc:mysql://rm-cn-t8j3yxq06000eilo.rwlb.rds.aliyuncs.com/ordering_system");
            dataSource.setUsername("txyyt01");
            dataSource.setPassword("Qazwsx123098");

            // 配置连接池参数（可根据需要调整）
            dataSource.setInitialSize(5);
            dataSource.setMinIdle(5);
            dataSource.setMaxActive(20);

            // 创建 JdbcTemplate 对象
            jdbcTemplate = new JdbcTemplate(dataSource);

            // 初始化事务管理器
            transactionManager = new DataSourceTransactionManager(dataSource);

            // 创建 TransactionTemplate 对象
            transactionTemplate = new TransactionTemplate(transactionManager);


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * 获取 TransactionTemplate 对象
     * @return TransactionTemplate
     */
    public static TransactionTemplate getTransactionTemplate() {
        return transactionTemplate;
    }


    /**
     * 获取 JdbcTemplate 对象
     * @return JdbcTemplate
     */
    public static JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    /**
     * 获取数据库连接
     * @return Connection
     * @throws SQLException 如果获取连接失败
     */
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    /**
     * 关闭数据库连接
     * @param conn 数据库连接对象
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


}