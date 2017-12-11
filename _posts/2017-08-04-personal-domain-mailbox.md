---
layout: post
title: 个人域名邮箱
category: experience
---

## What's New
今天有空折腾了自己的个人域名邮箱[me@wilsonisonly.com](me@wilsonisonly.com)，发现其实并不是很麻烦，记录一下步骤以作分享。看起来还是挺有意思的，不过突然还是觉得自己的域名当时取的太长了，用了三个英文，不是很好阅读的感觉=^=，自己本来想注册的域名早就被别人注册走了。下手要趁早。。。

## 实现步骤

### 1、购买域名

首先需要购买一个属于自己的域名，网上一搜有很多网站提供域名购买服务。我的域名是在 [Godaddy](https://www.godaddy.com/) 上面购买的，两年的费用是100元左右，还是很便宜的，Godaddy是国外的域名服务商，区别与国内服务商的地方在于，Godaddy购买的域名不需要备案，省去了一些不必要的麻烦。

### 2、选择企业邮箱-设置域名邮箱

可供选择的有163企业邮箱和qq企业邮箱，设置很方便。以QQ邮箱为例：

登录QQ邮箱->依次点击：顶部设置->体验室->域名邮箱->开始体验->按照如下操作步骤：

![Markdown](http://i2.bvimg.com/1949/02044bf26bcdcec0.png)
![Markdown](http://i2.bvimg.com/603424/44fc20b513d93657.png)
![Markdown](http://i2.bvimg.com/603424/a4d11aebc8ed8192.png)
![Markdown](http://i2.bvimg.com/603424/ecf58785d9bd0998.png)
![Markdown](http://i2.bvimg.com/603424/150d702283ce3b89.png)


### 3、域名解析

Godaddy购买域名的缺点是，国外的dns解析会比较慢，所以我们可以用国内的域名解析来保证域名的访问速度，我用的是 [DNSPOD](https://www.dnspod.cn/)。如果你有设置github博客的话，如下图进行设置，并在gh-pages的根目录下添加CNAME文件，里面的内容时你的域名，之后就可以访问你的博客了。

#### 博客dns设置
![Markdown](http://i2.bvimg.com/603424/1aa1f2a6fa04bc3b.png)

#### 域名邮箱设置

第二步的时候QQ企业邮箱里给了我们两个地方需要设置，一个是CNAME记录，一个是MX记录。设置如下图：

![Markdown](http://i2.bvimg.com/603424/398925370a313b9f.png)


### 4、创建个人域名邮箱

这个时候回到QQ企业邮箱，点击提交验证，验证通过后，就设置好了，页面跳转到下方：
添加自己的个人邮箱，我的设置的个人邮箱是me@wilsonisonly.com

![Markdown](http://i2.bvimg.com/603424/1c91cee41a3bb517.png)

### 5、发送邮件测试

试着给新建的个人域名邮箱发送一封邮件试试？
