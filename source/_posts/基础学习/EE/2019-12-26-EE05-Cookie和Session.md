---
title: EE05-Cookie和Session
tags:
  - note
comments: false
categories:
  - 基础学习
  - EE
date: 2019-12-26 18:40:22
description:
top:
---

## Cookie

### 什么是 cookie，cookie的作用

cookie 储存在用户本地终端上的数据（不超过 4KB 的小型文本数据），由于 HTTP 协议本身是无状态（服务器无法判断用户身份）。Cookie 英语直译为小饼干的意思，到了我们 web 项目上实际上是一小段的文本信息（键值对格式）。若客户端向服务器发起请求，如果服务器需要记录该用户状态，就在服务器端（使用 response ）向客户端浏览器添加一个 cookie（这个 cookie 是存放在客户端的）。当客户端再次请求该网站时，会将请求的网址连同这个 cookie 信息一同提交给服务器，因此它可以帮助我们实现记录用户个人信息的功能。

### cookie的基本属性（4个）

|属性项	|属性项介绍|
|-----|-----|
|Name/Value|设置Cookie的名称及相对应的值，对于认证Cookie，Value值包括Web服务器所提供的访问令牌|
|Expires|设置 Cookie 的存活时间（会话性/持久性）|
|Path|定义了 Web 站点上可以访问该 Cookie 的目录|
|Domain|指定了可以访问该 Cookie 的 Web 站点或域| 


## Session

session 会话技术是基于 cookie 的, 默认在一次会话中，也就是说，一次会话中任何资源共用一个 session 对象

### 获取 session

使用 request.getSession() 方法，此底层会判断该客户端是否在服务器端已经设置过 session
* 如果不存在，那么就会创建一个新的 session 对象
* 如果该客户端在此服务器上已经存在，则会获得已经存在的该 session 对象返回（其实质就是根据 JSESSIONID 判断客户端是否在服务器上已经存在 session）

### 使用 session 

setAttribute(String name, Object o) // 存储 K/V 数据到 session 域
getAttribute(String name)     // 通过 K 获取到 V 
removeAttribute(String name)  // 移除指定 K

### session 活化/钝化
