<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<style>
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
        <li><a href="#"><img src="https://img2.baidu.com/it/u=1912640969,552058082&fm=253&fmt=auto&app=138&f=JPEG?w=658&h=451" alt="Slide 1"></a></li>
        <li><a href="#"><img src="https://img2.baidu.com/it/u=481416470,1744258166&fm=253&fmt=auto?w=749&h=500" alt="Slide 2"></a></li>
        <li><a href="#"><img src="https://img2.baidu.com/it/u=4216310193,1531943661&fm=253&fmt=auto&app=138&f=JPEG?w=749&h=500" alt="Slide 3"></a></li>
        <li><a href="#"><img src="https://img0.baidu.com/it/u=1178441119,43429536&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500" alt="Slide 4"></a></li>
        <li><a href="#"><img src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimage109.360doc.com%2FDownloadImg%2F2021%2F04%2F2013%2F220446837_9_20210420010925800&refer=http%3A%2F%2Fimage109.360doc.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1737030774&t=a83196a7885dae5890a11747a253e604" alt="Slide 5"></a></li>
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

