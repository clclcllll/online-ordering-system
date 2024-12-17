package com.cugb.javaee.dao;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.utils.DBUtil;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.List;

/**
 * 菜品数据访问对象，处理菜品相关的数据库操作
 */
public class DishDAO {

    private JdbcTemplate jdbcTemplate = DBUtil.getJdbcTemplate();
    private TransactionTemplate transactionTemplate = DBUtil.getTransactionTemplate(); // 获取事务模板

    /**
     * 获取所有菜品列表
     * @return 菜品列表
     */
    public List<DishBean> getAllDishes() {
        String sql = "SELECT * FROM Dish";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(DishBean.class));
    }

    /**
     * 根据菜品ID查询菜品
     * @param dishID 菜品ID
     * @return 菜品对象，如果不存在则返回 null
     */
    public DishBean getDishByID(int dishID) {
        String sql = "SELECT * FROM Dish WHERE DishID = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(DishBean.class), dishID);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 添加新菜品
     * @param dish 菜品对象
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int addDish(DishBean dish) {
        String sql = "INSERT INTO Dish (Name, Price, Description, Stock, Image) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql, dish.getName(), dish.getPrice(), dish.getDescription(),
                dish.getStock(), dish.getImage());
    }

    /**
     * 更新菜品信息
     * @param dish 菜品对象
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int updateDish(DishBean dish) {
        String sql = "UPDATE Dish SET Name = ?, Price = ?, Description = ?, Stock = ?, Image = ? WHERE DishID = ?";
        return jdbcTemplate.update(sql, dish.getName(), dish.getPrice(), dish.getDescription(),
                dish.getStock(), dish.getImage(), dish.getDishID());
    }

    /**
     * 删除菜品（联级删除）
     * @param dishID 菜品ID
     * @return 操作结果，成功返回 1，失败返回 0
     */
    public int deleteDish(final int dishID) {
        return transactionTemplate.execute(new TransactionCallbackWithoutResult() {
            @Override
            protected void doInTransactionWithoutResult(TransactionStatus status) {
                try {
                    // 先删除相关的 OrderItem 记录
                    String deleteOrderItemsSql = "DELETE FROM orderitem WHERE DishID = ?";
                    jdbcTemplate.update(deleteOrderItemsSql, dishID);

                    // 再删除 Dish 记录
                    String deleteDishSql = "DELETE FROM Dish WHERE DishID = ?";
                    int result = jdbcTemplate.update(deleteDishSql, dishID);

                    if (result == 0) {
                        // 如果删除 Dish 失败，回滚事务
                        status.setRollbackOnly();
                    }
                } catch (DataAccessException e) {
                    // 出现异常，回滚事务
                    status.setRollbackOnly();
                    throw e;
                }
            }
        }) == null ? 0 : 1; // 返回 1 表示成功，0 表示失败
    }


    /**
     * 分页获取菜品列表
     * @param pageNum 当前页码，从 1 开始
     * @param pageSize 每页显示的记录数
     * @return 菜品列表
     */
    public List<DishBean> getDishesByPage(int pageNum, int pageSize) {
        String sql = "SELECT * FROM Dish LIMIT ?, ?";
        int offset = (pageNum - 1) * pageSize;
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(DishBean.class), offset, pageSize);
    }

    /**
     * 获取菜品总数
     * @return 菜品总数
     */
    public int getDishCount() {
        String sql = "SELECT COUNT(*) FROM Dish";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /**
     * 根据菜品ID获取菜品库存
     * @param dishID 菜品ID
     * @return 菜品库存
     */
    public int getDishCountByID(int dishID) {
        String sql = "SELECT Stock FROM Dish WHERE DishID = ?";

            return jdbcTemplate.queryForObject(sql, new Object[]{dishID}, Integer.class);
    }

    /**
     * 根据菜名进行模糊搜索，支持分页
     * @param keyword 搜索关键词
     * @param pageNum 当前页码，从 1 开始
     * @param pageSize 每页显示的记录数
     * @return 搜索结果列表
     */
    public List<DishBean> searchDishesByName(String keyword, int pageNum, int pageSize) {
        String sql = "SELECT * FROM Dish WHERE Name LIKE ? LIMIT ? OFFSET ?";
        String searchPattern = "%" + keyword + "%";
        int offset = (pageNum - 1) * pageSize;
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(DishBean.class), searchPattern, pageSize, offset);
    }

    /**
     * 获取搜索结果的总数
     * @param keyword 搜索关键词
     * @return 搜索结果总数
     */
    public int getSearchDishCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM Dish WHERE Name LIKE ?";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.queryForObject(sql, new Object[]{searchPattern}, Integer.class);
    }

}
