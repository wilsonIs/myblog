---
title: vuepress + gh-pages 搭建项目专属文档
date: 2020-04-17
comments: true
sidebar: 'auto'
categories: 
 - blog
tags:
 - 分享
---

本文的目标是学习如何通过 `vuepress` + `gh-pages` 快递搭建项目专属文档。

在开始之前，需要先简单了解下 `gh-pages` 和 `vuepress`。

## gh-pages

gh-pages 也叫 [Github Pages](https://pages.github.com/)，是 github 官方内置的功能，用于为项目搭建专属静态网站。

它提供了以下功能：

* 众多博客模板选择及在线编辑
* 支持 HTML 及 [jekyll](https://github.com/jekyll/jekyll) 模版引擎
* 默认使用 gh-pages 分支构建
* 支持切换使用 master 或 master/docs 分支
* 代码提交即部署

我们可以选择使用 gh-pages 模版来快速搭建页面，更可以将静态页面直接推送到 `gh-pages` 分支，
github 会将该分支下的所有文件当作静态文件部署，这样就可以直接访问我们推送的页面了。

## vuepress

[vuepress](https://vuepress.vuejs.org/zh/) 是一款便捷的vue驱动静态网站生成器，它有以下几个特点：

* markdown即页面
* vue驱动，支持 vue 组件渲染
* 支持多种主题
* 插件即功能
* 丰富且简单的配置
* 扩展性高

## 步骤

基于以上几个特点，用 `gh-pages` 和 `vuepress` 来写文档再合适不过，够简单，够便捷。

下面几个网站都是通过该方式部署的：

* 略

### 选择 gh-pages 部署分支

对于非业务仓库推荐选择 `master/docs` 作为部署目录，而对于业务仓库建议使用 `gh-pages` 分支来部署，方便跟随版本更新文档。

### vuepress 模板

如果你要写博客项目，建议参考 [hl-blog略]()，如果是要写项目文档，我们参考 [略]()来搭建。

#### 添加依赖

```json
{
    "devDependencies": {
        "vuepress": "^1.2.0",
        "@vuepress/plugin-pwa": "^1.2.0",
        "@vuepress/theme-vue": "^1.2.0",
    }
}
```

#### 添加编译脚本

```json
{
    "script": {
        "docs:dev": "vuepress dev docs",
        "docs:build": "vuepress build docs"
    }
}
```

#### vuepress配置

```js
module.exports = {
    // baseurl地址，即访问根路由
    base: '/pages/plugin-h5/repo-name/docs/public/',
    // 打包输出目录
    dest: 'docs/public',
    // 插件
    plugins: [
        // 展示 demo
        'demo-block',
        // 官方pwa插件，发布新版本提示更新
        '@vuepress/pwa',
    ],
    // 主题配置
    themeConfig: {
        // 头部导航栏
        nav: [
            {
                text: '指南',
                link: '/guide/'
            }
        ],
        // 侧边栏
        sidebar: {
            '/guide/': [
                '/guide/install/',
                {
                    title: '业务流程',
                    collapsable: true,
                    children: [
                        '/guide/apply',
                        '/guide/edit'
                    ]
                }
            ]
        }
    }
}

```

### 部署

执行下方脚本，`vuepress` 会将所有的 `md` 编译成静态的 `html` 文件，输出到 `dest` 对应的路径下。继续将构建好的静态文件，推送到远程分支 `gh-pages` ，等待几秒，就可以看到页面已经部署好了🎉🎉🎉

```bash
npm run docs:build
```
