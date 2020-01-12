---
title: Web08-Filter和Listener
tags:
  - note
comments: false
categories:
  - 基础学习
  - Web
date: 2019-12-29 12:00:22
description:
top:
---

## Filter
```xml

web.xml 文件配置过滤器

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

## Listener 