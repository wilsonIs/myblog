---
layout: post
title : 深入浅出Express
category: experience
---

<section>
	<h1>Express入门</h1>
	<h2>一、Express简介</h2>
	<p>
		Express是基于Node.js 平台搭建的一种快速、开放、极简的web开发框架。
	它提供了一系列强大的特性，帮助我们创建各种Web和移动设备应用。
	</p>
</section>

<section>
	<h2>二、Express下载安装</h2>
	<h3>2.1.	安装Node.js软件</h3>
	<p>
		Express从安装的角度上来讲，它是属于Node.js的一个模块，所以我们要安装Express
	的前提是先安装好Node.js，Node.js的官方下载地址：https://nodejs.org/en/download/ 。Node.js的安装方法很简单，下载好直接安装即可。然后我们就可以安装Express模块了。
	</p>
</section>

<section>
	<h3>2.2.	安装Express模块</h3>
	<p>
	首先我们在F盘建立一个文件夹MyWeb，通过cmd命令进入MyWeb文件，在MyWeb文件夹下建子文件夹myapp，进入myapp，输入以下命令：<br/>
	<br/>
	npm init<br/> 
	<br/>
	//注释：上面这行命令的作用就是给我们初始化创建一个package.json文件，这个文件在我们输入完以下信息后会自动创建到myapp文件中。Cmd命令行提示输入以下信息：<br/>
	<br/>
	name: //项目名<br/>
	version://当前项目的版本号<br/>
	description://项目描述<br/>
	entry point://main入口，是一个js文件名<br/>
	test command://<br/>
	git repository://github库的地址，没有则不填<br/>
	keywords://可被搜索到的关键词<br/>
	author://作者名<br/>
	license://允许他人访问的许可信息，没有则不填<br/>
	//注释：输入yes之后，则在myapp中可以看到生成了一个package.json文件<br/>
	//package.json是myapp这个项目的配置文件，存储配置信息<br/>
	<br/>
		建立好配置信息之后，我们来安装Express模块。cmd退回到MyWeb文件夹，输入以下命令：<br/>
	<br/>
	npm install express 
	//注释：临时安装Express,不将它添加到依赖列表中，如果需要将express添加到依赖列表中，则输入下面的命令：
	<br/>
	<br/>
	npm install express - -save<br/>
	<br/>
	安装完成后，我们可以在MyWeb文件夹中看到一个node_modules文件夹，里面存放着express模块的安装文件，这样就算是给MyWeb文件引入了express模块。<br/>
	</p>
</section>