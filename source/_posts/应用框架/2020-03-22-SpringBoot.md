---
title: SpringBoot
tags:
  - note
comments: false
categories:
  - 应用框架
date: 2020-03-22 09:31:28
description:
top:
---

## SpringBoot

### 简介

用来简化spring应用的初始搭建以及开发过程 使用特定的方式来进行配置（properties或yml文件），创建独立的spring引导程序，启动main方法运行一个springboot项目，拥有嵌入的 Tomcat 无需部署war文件，简化maven配置（依赖传递性），添加对应功能的starter自动化配置需要的参数。

总结：spring boot来简化spring应用开发，约定大于配置，去繁从简，just run就能创建一个独立的，产品级别的应用

#### 项目运行命令: nohup和&的区别

& ： 指在后台运行

nohup（no hang up） ： 不挂断的运行，注意并没有后台运行的功能，，就是指，用nohup运行命令可以使命令永久的执行下去，和用户终端没有关系，例如我们断开SSH连接都不会影响他的运行，注意了nohup没有后台运行的意思；&才是后台运行

&是指在后台运行，但当用户推出(挂起)的时候，命令自动也跟着退出

那么，我们可以巧妙的吧他们结合起来用就是
nohup COMMAND &
这样就能使命令永久的在后台执行

#### bootstrap 配置文件

在 Spring Boot 中有两种上下文【配置文件】，一种是 bootstrap, 另外一种是 application；
bootstrap 是应用程序的父上下文，也就是说 bootstrap 加载优先于 applicaton。bootstrap 主要用于
从额外的资源来加载配置信息【git服务器等】，还可以在本地外部配置文件中解密属性。这两个上下文
共用一个环境，它是任何Spring应用程序的外部属性的来源。bootstrap 里面的属性会优先加载，它们
默认也不能被本地相同配置覆盖。
因此，对比 application 配置文件，bootstrap 配置文件具有以下几个特性。
boostrap 由父 ApplicationContext 加载，比 applicaton 优先加载
boostrap 里面的属性不能被覆盖

**bootstrap使用场景**

使用 Spring Cloud Config 配置中心时，这时需要在 bootstrap 配置文件中添加连接到配置中心的
配置属性来加载外部配置中心的配置信息；
一些固定的不能被覆盖的属性
一些加密/解密的场景；

#### 多配置文件

mvn 打包(注意: 要在`poxm.xml`同级目录下)

```
mvn clean package -Dmaven.test.skip=true -P prod
```

#### 扩展

* 自动配置(AutoConfiguration)原理-condition接口
* 自动配置(AutoConfiguration)原理-@Enable*类型注解
