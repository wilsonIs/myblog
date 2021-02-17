---
title: 体验优化系列之——H5自定义侧滑
date: 2020-05-14
comments: true
category: experience
sidebar: 'auto'
tags:
 - 用户体验
---

对于混合应用来说，我们希望做到体验、交互一致性，让用户尽可能察觉不到 H5 页面和 native 的差异，以避免对用户造成困扰。

在财智云APP中，有一个比较明显的交互不一致的地方，就是页面的侧滑后退。不管是 iOS 还是 Andriod 手机，都实现了系统侧滑的功能，目的是为了减少手指移动距离，让操作更加的便捷。不过二者的实现方式有所不同，我们可以先简单对比下。

## 系统侧滑

对于 iOS 来说，只能在手机左侧屏幕边缘右滑，来让页面后退，对于左手操作会比较方便。

而 Android 略有不同，在系统导航设置里，你可以选择手势导航，也可以使用屏幕内三键导航。选择手势导航，既可以在屏幕左侧，也可以在右侧边缘滑动，使页面后退，安卓这样的设置对左利手和右利手都很友好。

单从侧滑后退这一功能来讲，iOS 和 Andriod 在实现上是有区别的。iOS 是跟随手势侧滑，在完全关闭之前可以随时取消侧滑。而 Andriod 是通过手势触发页面的后退，页面并不会跟随手势移动，触发后退后也不能中止侧滑动作。这是这两个系统比较显著的区别。

我们通过两者的操作视频可以明显的感受到不同：

> 下面视频展示的分别是是 iOS侧滑、Andriod 侧滑 以及 Andriod 三键导航的返回键返回。

略

## H5自定义侧滑

如果在 H5 页面，我们也做到相同或者相似的后退，那么对用户的体验一定是更好的。

我们来看一下简单的实现方案：

### 安卓返回键

对于安卓的三键导航中，点击返回键返回，我们可以通过监听 SDK 传入的 `backbutton` 事件，来响应用户的返回操作。

```js
// 物理返回键 + native头部返回
document.addEventListener(
    'backbutton',
    () => {
        this.goBack();
    },
    false
);
```

### 侧滑后退

我们需要做到的是监听用户的手势操作，判断右滑动作，来响应页面后退的意图。这里我们需要用到 `vue-directive-touch`，在应用的最外层绑定 `v-touch:right` 指令

```js
// main.js
const touch = require('vue-directive-touch');
Vue.use(touch);
```

```vue
// app.vue
<template>
    <div class="app" v-touch:right="onSwipeRight">
        <transition :name="transitionName">
            <keep-alive :include="$options.keepAliveRoutes">
                <router-view class="app-router-view"></router-view>
            </keep-alive>
        </transition>
    </div>
</template>

<script>
export default {
    methods: {
        onSwipeRight(event, start, end) {
            if ((end.X - start.X) > 100) {
                this.goBack();
            }
        },
    }
}
</script>
```

### 侧滑体验

通过上述方式我们初步实现了侧滑后退的操作。不过虽然如此，要想做到和原生完全一样还有很长的路要走，比如安卓侧滑时，显示在屏幕上的黑色返回图标（系统级别的交互），抑或是 iOS 页面跟随手势的动画（多webview才行）。

## 结束语

大家对体验优化感兴趣的话，推荐可以看一下 **《争论点：用户体验设计师的交互指南》**（微信读书APP有），这也是我最近在读的书，给了我很多的启发。

扩展思考🤔：还有哪些交互体验是 H5 和原生不一致的地方呢？

本文的分享到此结束，敬请期待下一期 **《体验优化系列之——可滑动的模态弹窗》
