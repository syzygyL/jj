---
title: Thymeleaf
tags:
  - note
comments: false
categories:
  - 杂项
  - 模板引擎
date: 2020-04-14 15:39:42
description:
top:
---

## Thymeleaf

Thymeleaf 是一个跟 Velocity、FreeMarker 类似的模板引擎，它可以完全替代 JSP 。

FreeMarker是一个用Java语言编写的模板引擎，它基于模板来生成文本输出。FreeMarker与Web容器无关，即在Web运行时，它并不知道Servlet或HTTP。它不仅可以用作表现层的实现技术，而且还可以用于生成XML，JSP或Java 等，在spring4.0中推荐使用thymeleaf来做前端模版引擎。
2、JSP技术spring boot 官方是不推荐的，原因有三：
2.1. 在tomcat上，jsp不能在嵌套的tomcat容器解析即不能在打包成可执行的jar的情况下解析
2.2. Jetty 嵌套的容器不支持jsp
2.3. Undertow
3、反正就是spring推荐themleaf，就学学themleaf。

### 同类技术对比

#### JSP
优点：
1、功能强大，可以写java代码
2、支持jsp标签（jsp tag）
3、支持表达式语言（el）
4、官方标准，用户群广，丰富的第三方jsp标签库
5、性能良好。jsp编译成class文件执行，有很好的性能表现
缺点：
jsp没有明显缺点，非要挑点骨头那就是，由于可以编写java代码，如使用不当容易破坏mvc结构。

#### Velocity

优点：
1、不能编写java代码，可以实现严格的mvc分离
2、性能良好，据说比jsp性能还要好些
3、使用表达式语言，据说jsp的表达式语言就是学velocity的
缺点：
1、不是官方标准
2、用户群体和第三方标签库没有jsp多。
3、对jsp标签支持不够好
4、已经很久很久没有维护了。

#### Freemarker
优点：
1、不能编写java代码，可以实现严格的mvc分离
2、性能非常不错
3、对jsp标签支持良好
4、内置大量常用功能，使用非常方便
5、宏定义（类似jsp标签）非常方便
6、使用表达式语言
缺点：
1、不是官方标准
2、用户群体和第三方标签库没有jsp多

选择freemarker的原因：
1、性能。velocity应该是最好的，其次是jsp，普通的页面freemarker性能最差（虽然只是几毫秒到十几毫秒的差距）。但是在复杂页面上（包含大量判断、日期金额格式化）的页面上，freemarker的性能比使用tag和el的jsp好。
2、宏定义比jsp tag方便
3、内置大量常用功能。比如html过滤，日期金额格式化等等，使用非常方便
4、支持jsp标签
5、可以实现严格的mvc分离

#### Thymeleaf
Thymeleaf是个XML/XHTML/HTML5模板引擎，可以用于Web与非Web应用。
Thymeleaf的主要目标在于提供一种可被浏览器正确显示的、格式良好的模板创建方式，因此也可以用作静态建模。你可以使用它创建经过验证的XML与HTML模板。相对于编写逻辑或代码，开发者只需将标签属性添加到模板中即可。接下来，这些标签属性就会在DOM（文档对象模型）上执行预先制定好的逻辑。Thymeleaf的可扩展性也非常棒。你可以使用它定义自己的模板属性集合，这样就可以计算自定义表达式并使用自定义逻辑。这意味着Thymeleaf还可以作为模板引擎框架。

Thymeleaf 

优点：静态html嵌入标签属性，浏览器可以直接打开模板文件，便于前后端联调，SprinBoot 官方推荐方案。
缺点：模板必须符合xml规范


