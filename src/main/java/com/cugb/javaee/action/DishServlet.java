package com.cugb.javaee.action;

import com.cugb.javaee.bean.DishBean;
import com.cugb.javaee.biz.DishService;
import com.cugb.javaee.utils.Constants;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

import java.util.logging.Logger;

/**
 * 菜品展示和详情的 Servlet
 */
@WebServlet("/dish")
public class DishServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DishServlet.class.getName());

    private DishService dishService = new DishService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取请求参数
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                // 展示菜品列表
                listDishes(request, response);
                break;
            case "detail":
                // 展示菜品详情
                showDishDetail(request, response);
                break;
            case "search":
                // 处理搜索请求
                searchDishes(request, response);
                break;
            case "index":
                // 展示首页
                request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * 处理搜索请求，支持模糊搜索和分页
     */
    private void searchDishes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取搜索关键词
        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            // 如果关键词为空，重定向到菜品列表
            response.sendRedirect(request.getContextPath() + "/dish?action=list");
            return;
        }
        keyword = keyword.trim();

        // 获取分页参数
        String pageNumStr = request.getParameter("pageNum");
        int pageNum = pageNumStr != null ? Integer.parseInt(pageNumStr) : 1;
        int pageSize = Constants.PAGE_SIZE;

        // 获取搜索结果和总数
        List<DishBean> dishes = dishService.searchDishesByName(keyword, pageNum, pageSize);
        int totalCount = dishService.getSearchDishCount(keyword);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // 打印调试信息
        logger.info("搜索关键词: " + keyword);
        logger.info("当前页码: " + pageNum);
        logger.info("总记录数: " + totalCount);
        logger.info("总页数: " + totalPage);
        logger.info("找到菜品数量: " + (dishes != null ? dishes.size() : 0));



        // 设置请求属性
        request.setAttribute("dishes", dishes);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("searchKeyword", keyword);

        // 转发到搜索结果页面
        request.getRequestDispatcher("/WEB-INF/jsp/searchList.jsp").forward(request, response);
    }

    /**
     * 展示菜品列表，支持分页
     */
    private void listDishes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取分页参数
        String pageNumStr = request.getParameter("pageNum");
        int pageNum = pageNumStr != null ? Integer.parseInt(pageNumStr) : 1;
        int pageSize = Constants.PAGE_SIZE;

        // 获取菜品列表和总数
        List<DishBean> dishes = dishService.getDishesByPage(pageNum, pageSize);
        int totalCount = dishService.getDishCount();
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        // 设置请求属性
        request.setAttribute("dishes", dishes);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPage", totalPage);

        // 转发到菜品列表页面
        request.getRequestDispatcher("/WEB-INF/jsp/dishList.jsp").forward(request, response);
    }

    /**
     * 展示菜品详情
     */
    private void showDishDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取菜品ID
        String dishIDStr = request.getParameter("dishID");
        if (dishIDStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int dishID = Integer.parseInt(dishIDStr);

        // 获取菜品详情
        DishBean dish = dishService.getDishByID(dishID);
        if (dish == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置请求属性
        request.setAttribute("dish", dish);

        // 转发到菜品详情页面
        request.getRequestDispatcher("/WEB-INF/jsp/dishDetail.jsp").forward(request, response);
    }
}
