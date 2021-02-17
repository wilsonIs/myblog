---
layout: post
sidebar: false
category: experience
title: eslint引起的疯狂编译问题
date: 2018-12-05
tags:
 - 经验
comments: true
---

之前深圳这边的同学遇到过这样一个奇怪的问题，启动项目后，pack一直在疯狂重新编译，但是实际上又没有任何文件发生变化，今天又有上海的同事遇到了相同的问题，百思不得其解，非常令人头疼。今天定位了最终的问题，记录下来，下次遇到同样的问题能帮助大家迅速解决。

## 问题现象

`pack -n hotel --dev --t plugin`启动后，一直在疯狂重复编译，页面在不停的刷新

## 问题定位

之前有遇到过同样的问题，发现是因为eslint的自动修复对有 右括号前是逗号 这种情况进行修复导致的问题。具体如下：

` const BP = JSON.parse(WEBVIEW.pb_getBusinessParams(WEBVIEW.CONFIG.getName('PLUGIN_ID')) || '{}', );
`

概括下复现场景即为 **右括号前是逗号**：

`const a = window.getSomething(1, );`

## 原因分析

分析原因是因为eslint自动修复的功能导致的，因为自动修复

规则1：`[eslint] A space is required after ','. (comma-spacing)`（逗号后面需要有空格）

规则2：`[eslint] There should be no spaces inside this paren. (space-in-parens)` （方法入参的右括号前不需要空格）

两种规则产生了冲突而导致了无限循环修复问题

## 问题解决

* 方法一：修改上面两个规则中的任意一个规则，如`"space-in-parens": 0`，入参括号允许空格（我们现在用的这种）
* 方法二：不要出现函数入参缺少参数的情况
* 方法三：取消eslint自动修复功能，eslint自动修复包括pack的 `eslint --fix` 和 vscode的 eslint插件都会对上面的这行代码进行自动修复，取消即可。（不推荐，自动修复功能还是挺好用的）而且取消vscode的eslint插件的自动修复配置并不能生效，设置如下
```bash
"eslint.validate": [
        "javascript",
        "javascriptreact",
        {
            "language": "html",
            "autoFix": true
        },
        {
            "language": "vue",
            "autoFix": false
        }
    ]
```
		
