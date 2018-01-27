---
layout: post
title: 移动端web开发跳坑指南
category: experience
---

> 总结一下移动端开发中遇到的一些坑，以作记录,积累的多了大概便能能助自己跳坑并逃坑。懒癌发作，只记录了个大纲，相信聪明的朋友看到关键词已经明白或者谷歌下也能很快明白是说的啥了。

1. 下拉漏底、滚动的问题

   vux:view-box，overflow
   
   better-scroll：transform


2. 弹窗滚动

    vue:v-transfer-dom
    
    react:ReactDOM.createPortal(child, container)

3. 自动获取焦点
    
    andriod:autofocus

    ios:security-no

4. safari时间格式的兼容
    
    yyyy-mm

5. ios闪屏问题
    
    -webkit-overflow-scrolling:touch

    overflow:auto
    
    动态加载
    
    transition
    
    transform

6. click与touch延迟
    
    fastclick

7. 1px border
    
    背景渐变

    伪类+transform

8. textarea,input在ios中的对齐
    
    placeholder和文字的上下对齐、垂直居中

    3px的差别：padding,margin,text-indent处理


9. textarea自动换行
    
    js处理

10. ios滚动卡卡的

    -webkit-overflow-scrolling:touch
    
11. input 的 compositionstart 和 compositionend
    
    输入完再触发input事件
    
    （输入搜索不再卡卡的）

12. 页面前进后退时组件的销毁、保留
    
    keep-alive,exclude,include,router

......

TBC

......
