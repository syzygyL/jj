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

## 会话
HTTP协议是无状态(Stateless)的协议。一旦数据交换完毕，客户端与服务器端的连接就会关闭，再次交换数据需要建立新的连接。这就意味着服务器无法从连接上跟踪会话,从而识别用户。要跟踪该会话，必须引入一种机制，而 Cookie 就是这样的一种机制。它可以弥补 HTTP协议无状态的不足。理论上，**一个用户的所有请求操作都应该属于同一个会话**,而另一个用户的所有请求操作则应该属于另一个会话



## Cookie

### Cookie 简介

**什么是 cookie?**

Cookie 是具有名称、单个值和可选属性(如注释、路径和域限定符、有效期和版本号)的不超过 4KB 的小型文本数据,由服务器创建,由浏览器保存,然后再发送回服务器()

**cookie 的作用？**

由于 HTTP 协议本身是无状态（服务器无法判断用户身份）。Cookie 英语直译为小饼干的意思，到了我们 web 项目上实际上是一小段的文本信息（键值对格式）。若客户端向服务器发起请求，如果服务器需要记录该用户状态，就在服务器端（使用 response ）向客户端浏览器添加一个 cookie（这个 cookie 是存放在客户端的）。当客户端再次请求该网站时，会将请求的网址连同这个 cookie 信息一同提交给服务器，因此它可以帮助我们实现记录用户个人信息的功能。

### cookie的基本属性（4个）

|属性项	|属性项介绍|
|-----|-----|
|Name/Value|设置Cookie的名称及相对应的值，对于认证Cookie，Value值包括Web服务器所提供的访问令牌|
|Expires|设置 Cookie 的存活时间（会话性/持久性）|
|Path|定义了 Web 站点上可以访问该 Cookie 的目录|
|Domain|指定了可以访问该 Cookie 的 Web 站点或域| 

### 使用 cookie

```java
...
// 向客户端添加 cookie
// 1.创建一个 Cookie 对象 （k/v 中不能包含 [ ] ( ) = , " / ? @ : ;）
Cookie cookie = new Cookie("key","value"); 
// 2.设置最大生存周期(单位 s)
cookie.setMaxAge(60*60*24); 
// 3.发送 Cookie 到 HTTP 响应头
response.addCookie(cookie);
...
```

```java
// 读取客户端 cookie
cookies = request.getCookies();

```
### 修改/删除 cookie

Cookie 自身并不提供修改、删除操作。如果要修改某个 Cookie，只需要新建一个同名的 Cookie，添加到 response 中覆盖原来的 Cookie 即可。

如果要删除某个 Cookie，只需要新建一个同名的 Cookie，并将 maxAge 设置为0，并添加到 response 中覆盖原来的 Cookie 。注意是 0 而不是负数。负数代表其他的意义。
{% note primary %} 

注意：修改、删除 Cookie 时，新建的 Cookie 除 value、maxAge 之外的所有属性，例如 name、path、domain 等，都要与原 Cookie 完全一样。否则，浏览器将视为两个不同的 Cookie 不予覆盖，导致修改、删除失败。

{% endnote %}

## Session

### Session 简介

**什么是 session?**

session 是服务器端使用的一种记录客户端状态的机制，session 保存在服务器上,使用上比 Cookie 简单一些，相应的也增加了服务器的存储压力。session 会话技术是基于 cookie 的, 默认在一次会话中，也就是说，一次会话中任何资源共用一个 session 对象 。

### Session 的生命周期

**Session在用户第一次访问服务器的时候自动创建**。需要注意只有访问 JSP、Servlet 等程序时才会创建 Session，只访问 HTML、IMAGE 等静态资源并不会创建 Session。如果尚未生成 Session，也可以使用 request.getSession(true) 强制生成 Session 。

Session 生成后，只要用户继续访问，服务器就会更新 Session 的最后访问时间，并维护该 Session 。用户每访问服务器一次，无论是否读写 Session ，服务器都认为该用户的Session “活跃（active）”了一次

由于会有越来越多的用户访问服务器，因此 Session 也会越来越多。为防止内存溢出，服务器会把长时间内没有活跃的 Session 从内存删除。这个时间就是 Session 的超时时间。如果超过了超时时间没访问过服务器，Session 就自动失效了

### 获取 session

使用 request.getSession() 方法，此底层会判断该客户端是否在服务器端已经设置过 session
* 如果不存在，那么就会创建一个新的 session 对象
* 如果该客户端在此服务器上已经存在，则会获得已经存在的该 session 对象返回（其实质就是根据 JSESSIONID 判断客户端是否在服务器上已经存在 session）

### 使用 session 

setAttribute(String name, Object o) // 存储 K/V 数据到 session 域
getAttribute(String name)     // 通过 K 获取到 V 
removeAttribute(String name)  // 移除指定 K
session.invalidate()         // 销毁 session 

### session 活化/钝化

// TODO