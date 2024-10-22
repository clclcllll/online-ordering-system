package com.cugb.javaee.biz;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.dao.DishDAO;

import java.util.List;

/**
 * 菜品业务逻辑类，处理菜品相关的业务操作
 */
public class DishService {

    private DishDAO dishDAO = new DishDAO();

    /**
     * 获取所有菜品列表
     * @return 菜品列表
     */
    public List<DishBean> getAllDishes() {
        return dishDAO.getAllDishes();
    }

    /**
     * 根据菜品ID获取菜品详情
     * @param dishID 菜品ID
     * @return 菜品对象，未找到返回 null
     */
    public DishBean getDishByID(int dishID) {
        return dishDAO.getDishByID(dishID);
    }

    /**
     * 分页获取菜品列表
     * @param pageNum 当前页码，从 1 开始
     * @param pageSize 每页显示的记录数
     * @return 菜品列表
     */
    public List<DishBean> getDishesByPage(int pageNum, int pageSize) {
        return dishDAO.getDishesByPage(pageNum, pageSize);
    }

    /**
     * 获取菜品总数
     * @return 菜品总数
     */
    public int getDishCount() {
        return dishDAO.getDishCount();
    }

    /**
     * 添加新菜品
     * @param dish 菜品对象
     * @return 添加结果，成功返回 true，失败返回 false
     */
    public boolean addDish(DishBean dish) {
        int result = dishDAO.addDish(dish);
        return result == 1;
    }

    /**
     * 更新菜品信息
     * @param dish 菜品对象
     * @return 更新结果，成功返回 true，失败返回 false
     */
    public boolean updateDish(DishBean dish) {
        int result = dishDAO.updateDish(dish);
        return result == 1;
    }

    /**
     * 删除菜品
     * @param dishID 菜品ID
     * @return 删除结果，成功返回 true，失败返回 false
     */
    public boolean deleteDish(int dishID) {
        int result = dishDAO.deleteDish(dishID);
        return result == 1;
    }
}
