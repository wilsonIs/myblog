---
title: 体验优化系列之——转场动画
date: 2020-05-09
comments: true
sidebar: 'auto'
category: experience

categories: 
 - blog
tags:
 - 用户体验
---

转场动画简单的说，是指页面跳转的动画效果，在页面前进或者后退时呈现给用户的过渡动画。
相信大家已经在很多场景中见过了转场动画，比如ppt、抖音视频、手机里的操作交互。
动画的效果有很多种，常见的有弹出、侧滑、渐变，其目的是为了柔和页面的过渡效果，增加切换、加载、等待过场的趣味性。

在业务开发中，我们也可以发现不管是iOS还是安卓，页面的切换都有一个简单的侧滑效果，在操作时会感觉比较舒适。而反观H5的页面切换则比较生硬，和原生的交互体验产生明显的违和、不一致的感觉。

那么，我们能不能给H5页面也添加转场动画，让它和原生交互保持一样的操作效果呢？

答案是肯定的，先上视频为证。

略。

## 实现思路与方案

既然是转场动画，我们是不是只要在页面跳转的时候给页面添加动画就可以了呢？

这样就有几个问题需要我们去思考：

* 一是动画加在哪里，才能做到一处配置，处处可用？

* 二是怎么判断页面是前进还是后退？

* 三是在什么时机去添加动画？

第一个问题比较好解决，因为我们是单页应用，所有的页面都在 `app.vue` 中通过 `router-view`来渲染的视图组件，可以在这里做统一的动画设置。

```vue
// app.vue
<template>
    <transition :name="transitionName">
        <keep-alive>
            <router-view></router-view>
        </keep-alive>
    </transition>
</template>
```

那么怎么去判断页面是前进还是后退呢？这个判断有很多种方案，这里我推荐一种比较简易的方式。
在全局路由守卫中，给路由对象添加时间戳，标志页面的进入时间，通过对比两个页面的时间，来判断前进后退。

```js
router.beforeEach((to, from, next) => {
    if (typeof to.meta._t !== 'undefined') {
        next();
    } else {
        to.meta._t = Date.now();
        next();
    }
});
```

至于添加动画的时机就可以通过监听局部路由的变化来设置动画：

```js
watch: {
    $route(to, from) {
        // 入口页面无需动画
        if (from.path === '/') return;

        if (to.meta._t < from.meta._t) {
            this.transitionName = 'slide-right';
        } else {
            this.transitionName = 'slide-left';
        }
    }
}
```

## 遇到的问题

测试发现按照原先的设置，并不能正常的运作，这是因为动画是加在两个不同的容器上，且在动画生效前，上一个页面可能就已经销毁了。

```vue
<template>
    <div class="app">
        <transition :name="transitionName">
            <keep-alive>
                <router-view v-if="$route.meta.isKeepAlive"></router-view>
            </keep-alive>
        </transition>
        <transition :name="transitionName">
            <router-view v-if="!$route.meta.isKeepAlive"></router-view>
        </transition>
    </div>
</template>
```

上面的方式行不通，那么我们可以改为使用一个 `router-view`，通过 `include` 属性来设置需要 `keepAlive`的页面，是否可以解决呢？

```vue
<template>
    <div class="app">
        <transition :name="transitionName">
            <keep-alive :include="$options.keepAliveRoutes">
                <router-view class="app-router-view"></router-view>
            </keep-alive>
        </transition>
    </div>
</template>
```

上面的 `$options.keepAliveRoutes` 是所有需要缓存的页面，通过下面的方式获取

```js
// main.js
const router = require('../views/router').default;
const routes = router.options.routes;
const keepAliveRoutes = [];
routes.forEach((route) => {
    if (route.meta && route.meta.keepAlive) {
        keepAliveRoutes.push(route.name);
    }
});

new Vue({
    i18n,
    router,
    store,
    ...App,
    keepAliveRoutes
}).$mount('#app');
```

进一步测试发现，`keepAlive` 都失效了，那是因为 `include` 的设置规则在vue官网是这样描述的

> 匹配首先检查组件自身的 name 选项，如果 name 选项不可用，则匹配它的局部注册名称 (父组件 components 选项的键值)。匿名组件不能被匹配。

`include` 匹配的并不是指 `route.name`，而是指组件本身的 `name` 选项，只需要给相应的页面添加上 `name` 选项即可。

## 结语

以上，基本上就完成了H5页面添加转场动画的实现。我们也可以扩展思考下，如果要做类知乎式的上下翻页转场动画是不是也可以实现？侧滑和上下滑动，或者其它多种动画效果如何并存？

这些问题留给大家，本文的分享到此结束，敬请期待下一期 **《体验优化系列之——H5自定义侧滑》**。

## 附录

### 侧滑动画

```css
.slide-right-enter-active,
.slide-right-leave-active,
.slide-left-enter-active,
.slide-left-leave-active {
    will-change: transform;
    transition: all .5s;
    position: absolute;
    width: 100%;
    left: 0;
}

.slide-right-enter {
    transform: translateX(-100%);
}

.slide-right-leave-active {
    transform: translateX(100%);
}

.slide-left-enter {
    transform: translateX(100%);
}

.slide-left-leave-active {
    transform: translateX(-100%);
}
```
