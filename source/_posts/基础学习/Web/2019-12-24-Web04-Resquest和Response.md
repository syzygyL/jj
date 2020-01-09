---
title: Web04-Resquest和Response
tags:
  - note
comments: false
categories:
  - 基础学习
  - Web
date: 2019-12-24 11:22:02
description:
top:
---

# Request


# Response


前端发送请求到服务端的中文乱码问题:

对于get请求:参数追加到地址栏,会使用 utf-8 编码,服务器(tomcat7)接受到请求之后,使用 iso-8859-1 解码,所以会出现乱码
对于post请求,参数是放在请求体中,服务器获取请求体的时候使用 iso-8859-1 解码,也会出现乱码
        
通用的方法: new String(获取到的字符串参数.getBytes("iso-8859-1"),"utf-8");

针对于post请求来说:只需要将请求流的编码设置成 utf-8 即可 ==> request.setCharacterEncoding("utf-8"); 