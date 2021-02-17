---
title: webview局部白屏bug排查及修复
date: 2020-04-27
comments: true
sidebar: 'auto'
category: experience
sticky: 0
tags:
 - Bug
---

## 现象

在财智云0422版本的灰度阶段，发现了一个很诡异的bug，现象是这样的，iOS端从小智进入消费记录，页面的头部、tab栏区域白屏，内容不可见，滚动页面的时候消失空白的区域出现闪烁，一定几率可以看到内容。

为什么在灰度环境突然出现这样一个bug呢？迅速排查分析了下这个bug的特征，发现它有以下几点诡异的地方：

* 一是这个bug在 uat/灰度/产线 环境必现，在测试环境无法重现；
* 二是只在使用 uiwebview 的 ios9-12 系统上出现，在使用 wkwebview 的 ios13 系统无法重现；
* 三是只在即将要发布的 1.1.9的APP上出现，在旧版本的 1.1.8APP上无法重现；

## 排查

基于上面几个现象，初步排查是 1.1.9版本 sdk 改动引起的兼容性问题。所以立马找来负责 sdk 的黄大师协助排查，遗憾的是，黄大师经过一番排查后，也没有找到问题的原因。看来最终还是只能h5自己去做兼容了。

之前消费记录出现过一次局部黑屏的问题，是因为使用了 `transform: translate3d(0,0,0)` 导致的。这次白屏有没有可能也是因为这个呢？

代码全局搜索过后，发现并没有类似的代码。既然如此，只好祭出 google 神器了。

最后找到有人遇到类似的问题，见 [iOS WebView加载网页触摸白屏bug排查及修复](http://www.poorren.com/ios-webview-white-screen-bug-fixes)，问题很可能出现在下面这行样式上面

```css
-webkit-overflow-scrolling: touch;
// 惯性滑动效果
```

搜索消费记录的代码，发现它对 tab 栏设置了 `-webkit-overflow-scrolling`，在 body 上没有设置。

## 修复

根据上文的建议，把该样式写在了 body 上，并移除了在 tab 栏的该样式。

```css
body {
    -webkit-overflow-scrolling: touch;
    -webkit-transform: translate3d(0,0,0);
    // 开启GPU加速，缓存渲染结果
}
```

经测试，it works！

![but-why.jpg]()

## 结束语

虽然上述样式对 uiwebview 有效，但是在 wkwebview 下会出现 tab 栏层级高于骨架屏的情况，导致样式重叠，最后不得不区分 wkwebview 和 uiwebview 做了样式区分。

```css
// wkwebview
body.app-ios.os-13 {
    -webkit-overflow-scrolling: unset;
    -webkit-transform: unset;
}
```

遗憾的是，并没有找到相关的资料可以解释uiwebview渲染的这个bug，最终的原因也不得而知。

## 相关文章

[iOS Safari renders blank page](https://github.com/vuejs/vue/issues/5533)

[记一次vue渲染白屏的hack方法](https://github.com/Pasoul/blog/issues/13)

[iOS WebView加载网页触摸白屏bug排查及修复](http://www.poorren.com/ios-webview-white-screen-bug-fixes)

[运用webkit绘制渲染页面原理解决iscroll4闪动的问题](http://www.iunbug.com/archives/2012/09/19/411.html)

[-webkit-overflow-scrolling:touch属性副作用](https://juejin.im/post/5a275825f265da431280c883)
