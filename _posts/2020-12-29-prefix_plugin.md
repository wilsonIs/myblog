---
title: 通用接口前置请求方案
date: 2020-12-29
comments: true
category: experience
tags:
 - 经验
---

## 前言

在超杰跟我提出接口前置技改的时候，我是举双手赞成的，因为优点是可以预想得到的。

根据之前的埋点统计数据分析，**从用户点击插件到h5发起请求的这一段过渡时间**，大约在**200～600ms**左右，而接口前置技改将这段时间充分利用起来了。也就是说，插件首屏拿到数据的时间预计可以减少200～600ms，这对首屏时间、用户可交互时间都有较大的改进。

我们可以假设几个数据：

* 拉起插件时间：500ms;
* 接口请求时间：800ms;

如下图所示，技改前，从点击插件到可交互的时间大致为：

```js
拉起插件时间 + 接口请求时间 = 13000ms
```

技改后的时间为：

```js
拉起插件时间 + (接口请求时间 - 拉起插件时间) = 800ms
```

![与native通信图]()

## 思考🤔

优点很明显，这个技改必须支持，但是缺点呢？分析下来有以下几点：

* 新增API，需要考虑兼容问题；
* 前置的接口有多个，有些业务是并行的，而有些是串行的；
* 对业务有较大的侵入性，需要修改之前的业务逻辑，有一定的风险；
* 如果需要新增、修改前置接口不仅要改cms配置，还要发版本改业务；

综上考虑，是有一定的接入成本的，如果有一套简单易用无侵入的通用方案，就可以将成功经验快速移植到其它业务，岂不美哉？😄

## 设计

通用方案有以下几个目标：

* 做好兼容处理；
* 接入过程不关心、不侵入业务；
* 有埋点，可统计；
* 任意新增、修改前置接口，只需要修改cms配置，不需要修改代码；

接下来我们简单设计一下实现方案：

![prefetch层]()

## 实现细节一览

接口前置目前在newfas试点，由于newfas使用的是commonCaiku的axios封装，所以在这里统一接入

```js
// axios.js
import prefetchInstance from './prefetch';

const axiosHandle = (...) => {
    // prefetch初始化
    if (!prefetchInstance.initialized) {
        prefetchInstance.init();
    }

    // 获取对应url数据
    const prefetchedUrlData = await prefetchInstance.getUrlData(originReqUrl);
    
    // 获取到数据则直接返回
    if (prefetchedUrlData) {
        // 取完数据后清空
        prefetchInstance.clearUrlData(originReqUrl);
        // 关键埋点，前置接口真实使用时间
        prefetchInstance.log('api-prefetch-spending-time-per-url',{...}）;
        
        return resHandle(...);
    } else {
        // 原axios逻辑
        return instance({...}).then((res) => resHandle(...))
    }
}


// pretch.js
class Prefetch {
    constructor() {
        // cms配置的预请求接口
        this.supportUrls = null;
        // native预请求的数据
        this.prefetchData = null;
        // 是否已从native获得数据
        this.fetched = false;
        // 当前app是否支持预请求
        this.isPrefetchSupport = false;
        // 预请求等待队列
        this.waitingQuene = [];
        // native预请求花费时间
        this.fetchSpendingTime = 0;
        // native通信超时设置
        this.maxTimeOut = 5000;
        // 通信计时器
        this.timer = null;
        // 初始化状态
        this.initialized = false;
    }

    init() {
        this.initialized = true;
        this.isPrefetchSupport = this.ifPrefetchSupport();

        if (this.isPrefetchSupport) {
            this.getSupportUrls();
            this.getPluginPrefixAPIData();
        }
        // ...
    }

    // 判断当前app是否支持预请求
    ifPrefetchSupport() {}

    // 同步接口从native获取cms配置预请求接口
    getSupportUrls() {}

    // 判断当前url是否在cms配置
    ifUrlSupport() {}

    // 从native获取预请求数据
    getPluginPrefixAPIData() {}

    // 业务请求队列
    resolveWaitingQuene() {}

    // 获取对应url的预请求数据
    getUrlData(url) {}

    // 预请求数据只使用一次后即清空
    clearUrlData(url) {}

    // 对关键节点进行埋点
    log() {}
}
```
