---
title: 我为什么要对base2动手
date: 2020-11-25
comments: true
sidebar: 'false'
category: experience
tags:
 - 优化
---

## 前言

说起base2大家一定都不会陌生，所有插件开发都必须引用base2的代码，使用起来也很简单，只需要两行代码，轻松使用。

```js
import initFramework from '@base2/framework';
initFramework();
```

`唉，这个使用挺简单的嘛，涛哥，你为啥要对base2动手呀？`

在回答这个问题之前，我们先来看几个我经常会被问到的问题？

## 问题

问题一：涛哥，插件项目里面这几个依赖为什么是这样引入的，为什么不直接`script src`？

```js
<script>
    window.vueURIobj = {
        vue: 'https://caikucloud.yqb.com/pamo/lib/2.5.16/vue.min.js',
        vueRouter: 'https://caikucloud.yqb.com/pamo/lib/2.5.16/vue-router.min.js',
        vuex: 'https://caikucloud.yqb.com/pamo/lib/2.5.16/vuex.min.js'
    }
</script>
```

问题二：

```js
Q: 我在 `main.js` 中直接 `import hlUi from '@yqb/hl-ui'` 怎么报错了？
A: 改成 `const hlUi = require('@yqb/hl-ui')`
Q: 真的可以，why(黑人脸)???
```

问题三：定义了 `FRAMEWORKREADY`函数，为什么没看到调用？

```js
window.FRAMEWORKREADY = FRAMEWORKREADY;
```

问题四：

```js
Q: 拉起我的插件为什么一直在loading?
A: 是不是忘了写tryPageLoadFinish？
Q: 这个是干啥的，怎么没有看到哪里使用？

Q: 我的项目有骨架屏，我想在vue初始化之前就关掉 loading 要怎么办？
A: ...
```

问题五：sdk新加了个API，怎么加到 c999 中去？

问题六：我想用react来写插件，要怎么弄呢？

问题 so many...

## 剖析 base2

上面所有的答案其实都指向 base2，base2做了很多很多不为大家所知的事情，初衷是为了让开发不感知底层逻辑，轻松上阵。但是随着时间的推移，base2承担了越来越多的功能，慢慢的变成了一个黑洞一样的存在。开发不知道里面做了什么，也不敢去动，导致难以维护，失去了base2原有的意义。

下面是我列出来的base2的主要功能，不管是什么，只要是公用的就可以往里放，俨然一个全家桶。
如果你说：

```js
Q: 我的项目很简单，有些功能不需要，或者是想换一换？
A: 对不起，爱我就要爱我的全部
```

![plugins-base2.png]()

## 动刀子

::: tip
说出来你可能不信，是代码先动手的
:::

我们的目的很简单，就是要把base2 `大卸八块，想吃哪块吃哪块`，稍微梳理下，去其糟粕取其精华，base2最后剩下这么几块：

![base2+.png]()

原先base2的功能被拆分成一个个的 npm 包，方便开发自由组合，不再受到框架、基础的限制，和普通的H5应用开发没有太大的区别了：

* vuejs 直接 script src 引入
* 不再需要等待 `frameworkReady`之后才能 require vue 相关依赖
* dist 中不再存放一堆 C999 的本地代码
* 自己控制 `window.FRAMEWORKREADY` 的调用时机
* `tryPageLoadFinish` 没有了，直接`WEBVIEW.pb_pageLoadFinish()`，想什么时候关loading都可以
* 新增API更方便
* 可以使用自己的 api.config 配置
* 不用 vue 框架写代码也是可以的
* 替换到看云埋点很容易
* ...

总而言之，base2不再是不可知的黑洞，而是一个个小巧的工具，是一个 base+ 生态的原型
