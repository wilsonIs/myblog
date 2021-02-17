---
layout: post
sidebar: false
category: experience
title: webpack4入坑之旅
date: 2018-09-17
tags:
 - 框架
comments: true
---

## 1、前言

webpack4.x已经出来好久啦，版本也到4.19啦，据说更新了不少新的功能，提升了打包性能，趁最近有空，赶紧升级一波。

## 2、升级前的准备工作

但是大家都知道，升级是有风险的，坑无处不在，怎么合理的避开这些坑呢？

有经验之后，第一件事就是先去查下官方文档的升级指南，然后再去各大论坛搜一下大家的入坑指南。做到有的放矢，大概就能少走一点弯路吧...

[webpack4官方迁移文档](https://webpack.js.org/migrate/4/)

## 3、入坑之旅

### 官方迁移指南
* 需要升级nodejs到v6及以上版本(建议升级到8.12.0LTS版本)
* 如果要使用 webpack cli 命令，则需要单独再安装 webpack-cli
* 更新第三方依赖

	这里会遇到很多错误提示，只要把相关的依赖升级到最新版本就好了。happypack的升级是比较容易忽略的，因为错误提示根本看不出来，看了很多网友分享的升级血泪史才发现的。。。

	```
	npm i webpack file-loader happypack less-loader webpack-dev-server webpack-merge -D
	```


* 构建模式 mode:包括development,production(这个升级方便了许多，官方做了许多默认设置，省去了不少工作)

		module.exports = {
		  // ...
		  mode: 'production',
		}
	
	或者
		
		"scripts": {
			"prd": "webpack --config conf/webpack.prd.config.js --mode=production",
		}

	默认配置（图中红色部分）
	
	![image]({{site.imageurl}}/5f9c4cff93f7878aa8219bd36a86fe45/image.png)

* 支持json直接引入，不再需要json-loader，如果是其它json插件，则需要设置 `type: 'javascript/auto'`
	
		module.exports = {
		  // ...
		  rules: [
		    {
		      test: /config\.json$/,
		      loader: 'special-loader',
		      type: 'javascript/auto',
		      options: {...}
		    }
		  ]
		};

* production 模式默认开启压缩，不再需要设置 uglifyjs-webpack-plugin
		
		optimization: {
		   minimize:true
		}

* 移除module.loaders（webpack3就被废弃了，现在完全移除了，不再支持）
* 公共代码提取
	
	CommonsChunkPlugin 被移除，使用 optimization.splitChunks替代。这里有个大坑，就是下面讲的这个


### mini-css-extract-plugin 替换为 extract-text-webpack-plugin 

由于 extract-text-webpack-plugin 作者表示不再支持webpack4.3.0，未来 extract-text-webpack-plugin 将废弃，作者建议使用 mini-css-extract-plugin 插件.

![image](/pages/plugin-h5/hl-blog/uploads/ee27d6d8beae982c90f3b683a88e29ca/image.png)

**问题1: mini-css-extract-plugin 的使用**

这个需要注意区分开发环境使用vue-style-loader就好

	const MiniCssExtractPlugin = require('mini-css-extract-plugin');
	
	// 开发环境使用vue-style-loader，方便热更新调试开发
	rules:[
		{
			test: /\.css$/,
			use: [process.env.NODE_ENV !== 'production'
            ? 'vue-style-loader'
            : MiniCssExtractPlugin.loader,
          'css-loader']
		}
	]

**问题2: 世纪大blocker:将css提取为一个文件**

现状：webpack4默认会将css也分割成多个块，但是大多数情况下css总文件并不大，我们并不需要将css分的太细，有时候只需要一份bundle.css就够了。配置方法：

	config.optimization.splitChunks.cacheGroups.styles = {
	    name: 'style',
	   	 // 一开始这里忘了匹配vue文件，总是会生成多个文件，需要注意
	    test: /\.(scss|css|less|vue)$/,
	    chunks: 'all',
	    priority: 30,
	    enforce: true
	}

但是设置cacheGroup的同时还会生成style.js文件，这并不是我们需要的，我们期望只生成一份css文件，并且不需要这个多余的js文件，不过无奈。。这个问题依然存在，很多人因为这个问题而放弃了升级webpack4。

我们同样遇到了这个问题，因为旧插件项目引入的资源都是写死的，如果要引入这个style.js文件的话，改动较大,这是个悲伤的故事。。无法做到无感知升级。

看webpack说明预计要到webpack5才会解决这个问题。。。

**升级未完，待续 ========》**

该问题的相关issue见：

[Single-file configuration emits JS assets in its own chunk group](https://github.com/webpack-contrib/mini-css-extract-plugin/issues/85)

![image](/pages/plugin-h5/hl-blog/uploads/6c651f8acee58e72bdc0c5c44ab5f105/image.png)

[[WIP] Support for webpack 4](https://github.com/JeffreyWay/laravel-mix/pull/1495)

![image](/pages/plugin-h5/hl-blog/uploads/94c4216072b825387446115531ab6401/image.png)

## 4. 升级体验

升级后用碧桂园pamo项目打包测试了下打包效果，升级后的js资源包(压缩后)从1.2M降到了300多kb，简直就是amazing了。。。

不过开发环境的编译速度并没有什么明显的变化。

今天进一步优化了plugins-consumRecord消费记录模块，并对打包压缩后的js文件做了对比，记录一下

| webpack3 | webpack4 | moment-->dayjs | external |
| ------ | ------ | ------ | ------ |
| 702kb| 672kb| 489kb | 415kb |

* webpack3 到 webpack4 主要的变化在于 `optimization.splitChunks`的抽离作用，但是由于消费记录模块页面不多，并不明显。

	```
	optimization: {
        noEmitOnErrors: true,
        splitChunks: {
            chunks: 'all',
            minSize: 0,
            maxInitialRequests: Infinity,
            cacheGroups: {
                vendor: {
                    test: /[\\/]node_modules[\\/]/,
                    name(module) {
                        let bundleName = '';
                        let packageName = module.context.match(/[\\/]node_modules[\\/](.*?)([\\/]|$)/)[1];
                        packageName = packageName.replace('@', '');
                        switch (packageName) {
                            case 'yqb-mint-ui':
                            case 'mint-ui':
                                bundleName = 'mintUi';
                                break;
                            default:
                                bundleName = 'vendor';
                                break;
                        }
                        return bundleName;
                    }
                }
            }
        }
	```
* 而moment替换成dayjs的变化是很明显的，直接下降了180kb，压缩后的dayjs只有2kb，非常可观，而dayjs也足够满足业务需求。
	
* external的设置，主要是因为插件项目或者h5项目引入的vue相关资源是从c999文件或者cdn加载，一定程度上减少了打包后的体积。

	```
	externals: {
        zepto: 'Zepto',
        vue: 'Vue',
        vuex: 'Vuex',
        'vue-router': 'VueRouter'
    },
	```
	

---
The End.
		
