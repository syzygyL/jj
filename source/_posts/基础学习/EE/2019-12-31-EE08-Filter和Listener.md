---
title: EE08-Filter和Listener
tags:
  - note
comments: false
categories:
  - 基础学习
  - EE
date: 2019-12-29 12:00:22
description:
top:
---

## Filter Java 过滤器

### Filter 作用

* 能对客户端的请求进行过滤处理，然后再将请求转发给其他 Web 组件（servlet）

* 对 Web 组件的 ServletRequest 和 ServletResponse 进行检查和修改

* 在 Web 组件调用之前检查 Request ,并修改请求头和请求正文
* 在 Web 组件调用之前检查 Response ,并修改响应头和响应正文

### Filter 配置

```xml
<!-- web.xml 文件配置过滤器 -->
<filter>

        <filter-name>过滤器名称</filter-name>

        <filter-class>过滤器类全名</filter-class>

 </filter>

 <filter-mapping>

        <filter-name>过滤器名称</filter-name>

<!-- 拦截路径 -->

        <url-pattern>过滤器拦截规则</url-pattern>

 </filter-mapping>

```

多个过滤器的执行顺序:

1. 如果采用配置文件方式配置过滤器，那么就按照过滤器的配置先后顺序执行
2. 如果采用注解方式配置过滤器，那么就按照类名的排序执行

## Listener Java 监听器

* ServletContext 对象监听器
* HttpSession 对象监听器
* ServletRequest 对象监听器