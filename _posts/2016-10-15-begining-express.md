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

<section>
	<h2>三、	Express搭建服务器</h2>
	<h3>3.1.	利用express模块搭建一个简易的web服务器</h3>
	<p>
	安装好express模块后，我们就可以着手搭建一个简单的web服务器,用于存储一些web文件，如网页、css、js、图像等。我们在myapp文件夹内新建一个myTcb文件夹，里面放置着项目的网页信息。
	</p>
	<p>
	我们需要做的是，在myapp文件夹中新建一个service.js文件，这个文件的作用是用来实现web服务器的功能。
	service.js的代码如下：<br/>
	<br/>
	var express = require("express");//引入express模块<br/>
	var app = express();//表示创建一个express应用程序<br/>
	app.get("/",function(req,res){//获得用户的请求类型，还有post,delete等<br/>
		res.send("hello app!");//响应信息<br/>
	});
	<br/>
	//注释：这里的“/”是指我们的根目录，意思是指当客户端请求访问根目录时，响应“hello app!”信息，我们可以在网页上看到该信息段。<br/>
	<br/>
	app.get("/app",function(req,res){//获得用户的请求类型<br/>
		res.send("hello world!");//响应信息<br/>
	});<br/><br/>
	<br/>
	//注释：这里的“/app”是指访问根目录下的app目录，响应“hello world!” 
	<br/><br/>
	app.use(express.static('myTcb'))<br/><br/>
	</p>
	<p>
	//注释：启动服务器后，我们就可以在浏览器中输入"http://localhost:3000/index.html"来访问myTcb文件夹下的index.html文件。<br/>
	//注释：我们还可以这样设置一个虚拟路径：<br/>
	//app.use(“/static”,express.static(‘myTcb’),这样我们要访问index.html的路径就是 http://localhost:3000/static/index.html 这里的static并不存在，只是一个虚拟的路径，这样设置可以增加路径的层次关系。<br/>
	//这里的use是一个中间件，也可以理解为一个函数，用于执行一些请求<br/>
	//注释：通过Express内置的express.static可以方便地托管静态文件。<br/>
	//注释：按照我个人的理解就是开放访问该文件夹，并将该文件夹作为了浏览器访问的根目录<br/>
	</p>
	<p>
	// var server = app.listen(3000,function(){<br/>
	// 	//注释：这种方式就可以处理服务启动的一些信息<br/>
	// })<br/><br/>
	<p>
	//app.listen(3000);<br/>
	//监听端口3000的请求<br/><br/>
	
	设置完service.js的信息后，我们还需要将package.json文件中的信息设置一下:
	<code>
		"scripts": {
			"start": "node service.js"
		},
	</code>	
	<br/>
	//这里的信息必须设置，scripts是一个执行脚本，意思是通过start命令来执行service.js文件。
	</p>
	<p>
	以上信息设置完之后，我们就可以愉快的开启我们建立的web服务器了，只需进入myapp文件，在命令行输入：
	
	<code>
		npm start
	</code>
	
	//注释：启动web服务器命令。之后命令行提示 
	<code>
		myapp@0.1.1 start F:\MyWeb\myapp 
		node service.js
	</code>
	//则表示服务器启动成功。服务器启动成功后，可以按下ctrl+c键停止该服务器。<br/><br/>

	下面打开浏览器，输入http://localhost:3000/index.html就可以访问我们的网页啦，同一个局域网下的电脑都能够访问得到。这样我们就成功地设置了一个web服务器，用于模拟访问网页文件等数据。<br/>
	</p>
</section>