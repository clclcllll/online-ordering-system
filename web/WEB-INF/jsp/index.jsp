<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<style>
    /* 上述优化后的CSS样式 */
    .input-container {
        display: flex;
        margin: 20px auto;
        width: 520px;
        position: relative;
    }

    .label {
        width: 220px;
        margin: auto 20px;
        font-family: '黑体', sans-serif; /* 设置为黑体 */
        font-weight: bold; /* 加粗字体 */
        font-size: 20px; /* 设置字体大小 */
    }
    .iconn {
        position: absolute;
        right: 10px;
        top: calc(50% + 5px);
        transform: translateY(calc(-50% - 5px));
        cursor: pointer;
    }

    .input {
        width: 100%;
        height: 40px;
        padding: 10px;
        transition: .2s linear;
        border: 2.5px solid black;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .input:focus {
        outline: none;
        border: 0.5px solid black;
        box-shadow: -5px -5px 0px black;
    }

    .input-container:hover > .icon {
        animation: anim 1s linear infinite;
    }

    @keyframes anim {
        0%,
        100% {
            transform: translateY(calc(-50% - 5px)) scale(1);
        }

        50% {
            transform: translateY(calc(-50% - 5px)) scale(1.1);
        }
    }

    .focus {
        margin: 30px auto;
        float: left;
        position: relative;
        width: 721px;
        height: 420px;
        background-color: antiquewhite;
        overflow: hidden;
    }

    .focus ul {
        list-style: none;
        padding: 0;
        margin: 0;
        position: absolute;
        width: 3605px;
        /* 721px * 5 */
        transition: left 0.5s;
    }

    .focus ul li {
        float: left;
        width: 721px;
        /* 与 .focus 宽度一致 */
        height: 100%;
    }

    .focus ul li img {
        width: 100%;
        height: 100%;
    }

    .focus .prev,
    .next {
        position: absolute;
        width: 20px;
        height: 30px;
        top: 50%;
        margin-top: -15px;
        background: rgba(0, 0, 0, .5);
        text-align: center;
        cursor: pointer;
    }

    .prev {
        left: 0;
        border-radius: 0 15px 15px 0;
    }

    .prev::after {
        font-family: 'icomoon';
        content: '\e91f';
        font-size: 20px;
        color: white;
    }

    .next {
        right: 0;
        border-radius: 15px 0 0 15px;
    }

    .next::after {
        font-family: 'icomoon';
        content: '\e920';
        font-size: 20px;
        color: white;
    }

    .promo_nav {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 8px;
    }

    .focus ul.promo_nav li {
        width: 8px;
        height: 8px;
        background-color: #fff;
        border-radius: 50%;
        margin: 0 4px;
        cursor: pointer;
        flex-shrink: 0; /* 确保不会被拉伸 */
    }

    .focus ul.promo_nav li.selected {
        background-color: #ff5000;
    }

    @font-face {
        font-family: 'icomoon';
        src: url('/src/main/webapp/fonts/icomoon.eot'); /* 确保路径从项目根目录开始 */
        src: url('/src/main/webapp/fonts/icomoon.eot?#iefix') format('embedded-opentype'),
        url('/src/main/webapp/fonts/icomoon.woff') format('woff'),
        url('/src/main/webapp/fonts/icomoon.ttf') format('truetype'),
        url('/src/main/webapp/fonts/icomoon.svg#icomoon') format('svg');
        font-weight: normal;
        font-style: normal;
    }
    .hot-label {
        position: absolute;
        top: 20px;
        left: 20px;
        background: rgba(255, 0, 0, 0.7); /* 红色半透明背景 */
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        font-weight: bold;
        font-size: 14px;
        font-family: '黑体', sans-serif;
        z-index: 10;
    }

    /* 优化后的用户评价样式 */
    .user-reviews {
        margin: 40px auto;
        max-width: 1200px; /* 增加最大宽度 */
        width: 90%; /* 使用百分比宽度 */
        background-color: #ffffff;
        padding: 30px 40px; /* 增加左右内边距 */
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        font-family: 'Arial', sans-serif; /* 使用更常见的字体提升可读性 */
    }

    /* 标题样式 */
    .user-reviews h2 {
        text-align: center;
        font-size: 32px;
        color: #333333;
        margin-bottom: 30px;
        position: relative;
    }

    .user-reviews h2::after {
        content: '';
        width: 60px;
        height: 3px;
        background-color: #ff5000;
        display: block;
        margin: 10px auto 0;
        border-radius: 2px;
    }

    /* 评论列表 */
    .reviews-list {
        display: flex;
        flex-direction: column;
        gap: 25px;
    }

    /* 单条评论 */
    .review-item {
        display: flex;
        flex-direction: row;
        gap: 15px; /* 从 20px 减小到 15px */
        padding-bottom: 15px;
        border-bottom: 1px solid #e0e0e0;
        align-items: flex-start; /* 垂直对齐 */
    }

    .review-item:last-child {
        border-bottom: none; /* 移除最后一条评论的下边框 */
    }

    /* 评论者头像 */
    .review-avatar {
        flex-shrink: 0;
        width: 50px; /* 从 70px 减小到 50px */
        height: 50px; /* 从 70px 减小到 50px */
        border-radius: 50%;
        background-color: #cccccc; /* 默认头像背景色，可替换为实际图片 */
        background-size: cover;
        background-position: center;
    }

    /* 评论内容 */
    .review-content {
        flex-grow: 1;
    }

    /* 评论内容 */
    .review-text {
        font-size: 16px; /* 从 18px 减小到 16px */
        color: #444444;
        line-height: 1.6;
        display: inline; /* 设置为 inline 以便与引号在同一行 */
        /* 移除 position: relative; 和 padding-left */
        /* padding-left: 20px; */
    }

    /* 添加引号 */
    .review-text::before {
        content: '“';
        font-size: 24px; /* 根据需要调整引号大小 */
        color: #ff5000;
        margin-right: 5px; /* 引号与文本之间的间距 */
    }

    .review-text::after {
        content: '”';
        font-size: 24px; /* 根据需要调整引号大小 */
        color: #ff5000;
        margin-left: 5px; /* 引号与文本之间的间距 */
    }

    .reviewer {
        font-size: 16px; /* 从 16px 减小到 14px */
        color: #888888;
        margin-top: 10px;
        text-align: right;
    }

    /* 响应式设计 */
    @media (max-width: 1200px) {
        .user-reviews {
            max-width: 1000px; /* 适配稍小的屏幕 */
        }
    }

    @media (max-width: 992px) {
        .user-reviews {
            padding: 25px 30px;
        }

        .review-item {
            gap: 15px;
        }

        .review-avatar {
            width: 50px;
            height: 50px;
        }

        .review-text {
            font-size: 16px;
            /* padding-left: 20px; 已移除 */
        }

        .review-text::before,
        .review-text::after {
            font-size: 24px; /* 减小引号尺寸 */
        }

        .reviewer {
            font-size: 14px;
        }
    }

    @media (max-width: 768px) {
        .user-reviews {
            padding: 20px 20px;
        }

        .review-item {
            flex-direction: column;
            align-items: flex-start;
        }

        .review-avatar {
            width: 40px; /* 再次减小尺寸 */
            height: 40px; /* 再次减小尺寸 */
        }

        .review-text {
            padding-left: 0;
        }

        .review-text::before,
        .review-text::after {
            display: none; /* 在小屏幕上隐藏引号 */
        }

        .reviewer {
            text-align: left;
        }
    }
</style>

<!-- 添加搜索表单 -->
<div style="height: 100px">
    <form action="${pageContext.request.contextPath}/dish" method="get">
        <div class="input-container">
            <input type="hidden" name="action" value="search">
            <div class="label">你想吃什么？</div>
            <input type="text" name="keyword" class="input" placeholder="搜索美食" required>
            <button type="submit" class="iconn" style="background: none; border: none; padding: 0;">
                <svg width="19px" height="19px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path opacity="1" d="M14 5H20" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    <path opacity="1" d="M14 8H17" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    <path d="M21 11.5C21 16.75 16.75 21 11.5 21C6.25 21 2 16.75 2 11.5C2 6.25 6.25 2 11.5 2" stroke="#000" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    <path opacity="1" d="M22 22L20 20" stroke="#000" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
            </button>
        </div>
    </form>
</div>

<div class="focus">
    <ul style="left: 0px;">
        <li>
            <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=7">
                <img src="https://img2.baidu.com/it/u=1912640969,552058082&fm=253&fmt=auto&app=138&f=JPEG?w=658&h=451" alt="Slide 1">
                <div class="hot-label">热门商品</div>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=8">
                <img src="https://img2.baidu.com/it/u=481416470,1744258166&fm=253&fmt=auto?w=749&h=500" alt="Slide 2">
                <div class="hot-label">热门商品</div>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=9">
                <img src="https://img2.baidu.com/it/u=4216310193,1531943661&fm=253&fmt=auto&app=138&f=JPEG?w=749&h=500" alt="Slide 3">
                <div class="hot-label">热门商品</div>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=5">
                <img src="https://img0.baidu.com/it/u=1178441119,43429536&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500" alt="Slide 4">
                <div class="hot-label">热门商品</div>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/dish?action=detail&dishID=11">
                <img src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage109.360doc.com%2FDownloadImg%2F2021%2F04%2F2013%2F220446837_9_20210420010925800&refer=http%3A%2F%2Fimage109.360doc.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1737030774&t=a83196a7885dae5890a11747a253e604" alt="Slide 5">
                <div class="hot-label">热门商品</div>
            </a>
        </li>
    </ul>
    <!-- 左右切换按钮 -->
    <a href="#" class="prev"></a>
    <a href="#" class="next"></a>
    <!-- 导航小圆点 -->
    <ul class="promo_nav">
        <li class="selected"></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>

<!-- 用户评价部分 -->
<div class="user-reviews">
    <h3>用户评价</h3>
    <div class="reviews-list">
        <div class="review-item">
            <div class="review-avatar" style="background-image: url('https://api.dicebear.com/9.x/glass/svg?seed=zcl');"></div>
            <div class="review-content">
                <p class="review-text">广东彭于晏觉得不错</p>
                <p class="reviewer">— 章成林</p>
            </div>
        </div>
        <div class="review-item">
            <div class="review-avatar" style="background-image: url('https://api.dicebear.com/9.x/glass/svg?seed=wst');"></div>
            <div class="review-content">
                <p class="review-text">啊!是妈妈的味道!</p>
                <p class="reviewer">— 王书韬</p>
            </div>
        </div>
        <div class="review-item">
            <div class="review-avatar" style="background-image: url('https://api.dicebear.com/9.x/glass/svg?seed=lcy');"></div>
            <div class="review-content">
                <p class="review-text">很多人说我长的像Faker</p>
                <p class="reviewer">— 刘纯源</p>
            </div>
        </div>
        <div class="review-item">
            <div class="review-avatar" style="background-image: url('https://api.dicebear.com/9.x/glass/svg?seed=cyh');"></div>
            <div class="review-content">
                <p class="review-text">你看这个面它又长又宽~~ 就像这个碗它又大又圆~~</p>
                <p class="reviewer">— 谌一航</p>
            </div>
        </div>
    </div>
</div>

<script>
    const focus = document.querySelector('.focus');
    const ul = focus.querySelector('ul');
    const navDots = focus.querySelectorAll('.promo_nav li');
    const prevButton = focus.querySelector('.prev');
    const nextButton = focus.querySelector('.next');
    let currentIndex = 0;
    const totalImages = navDots.length;
    let autoSwitchInterval;

    function updateFocus() {
        ul.style.left = -currentIndex * 721 + 'px';
        navDots.forEach((dot, index) => {
            if (index === currentIndex) {
                dot.classList.add('selected');
            } else {
                dot.classList.remove('selected');
            }
        });
    }

    function startAutoSwitch() {
        clearInterval(autoSwitchInterval);
        autoSwitchInterval = setInterval(() => {
            currentIndex = (currentIndex < totalImages - 1) ? currentIndex + 1 : 0;
            updateFocus();
        }, 5000);
    }

    prevButton.addEventListener('click', (event) => {
        event.preventDefault();
        currentIndex = (currentIndex > 0) ? currentIndex - 1 : totalImages - 1;
        updateFocus();
        startAutoSwitch();
    });

    nextButton.addEventListener('click', (event) => {
        event.preventDefault();
        currentIndex = (currentIndex < totalImages - 1) ? currentIndex + 1 : 0;
        updateFocus();
        startAutoSwitch();
    });

    navDots.forEach((dot, index) => {
        dot.addEventListener('click', (event) => {
            event.preventDefault();
            currentIndex = index;
            updateFocus();
            startAutoSwitch();
        });
    });
    // 启动自动切换图片
    startAutoSwitch();
</script>

<%@ include file="footer.jsp" %>