---
title: SpringMVC
tags:
  - note
comments: false
categories:
  - 应用框架
date: 2020-02-11 17:43:53
description:
top:
---

## SpringMVC

### MVC

1. MVC全名是Model View Controller 模型视图控制器，每个部分各司其职。
2. Model：数据模型，JavaBean的类，用来进行数据封装。
3. View：指JSP、HTML用来展示数据给用户
4. Controller：用来接收用户的请求，整个流程的控制器。用来进行数据校验等。

{%note success%}
**面向接口编程**

为什么要用Service接口和DAO接口？我们还得回到最基本的面向对象设计原则上去。
面向对象设计原则中有三条与此相关：开闭原则、依赖倒转原则、理氏替换原则。还记得依赖倒转原则吧？高层不依赖于低层，二者都依赖于抽象，也就是面向接口编程。
为什么要用Service接口？是让表示层不依赖于业务层的具体实现。为什么要用DAO接口？是让业务层不依赖于持久层的具体实现。有了这两个接口，Spring IOC容器才能发挥作用。
举个例子，用DAO接口，那么持久层用Hibernate，还是用iBatis，还是 JDBC，随时可以替换，不用修改业务层Service类的代码。
使用接口的意义就在此。 


{%endnote%}

### SpringMVC 是什么?

1. 是一种基于 Java 实现的 MVC 设计模型的请求驱动类型的轻量级WEB框架。
2. `Spring MVC` 属于`SpringFrameWork`的后续产品，已经在`Spring Web Flow`里面。
3. 使用 Spring 可插入的 MVC 架构，从而在使用 Spring 进行 WEB 开发时，可以选择使用 Spring 的 SpringMVC 框架或集成其他 MVC 开发框架，如 Struts1(现在一般不用)，Struts2 等

## 注解

### RequestMapping

作用：建立请求 URL 和处理方法之间的对应关系

**使用位置**

1. 作用在类上：第一级的访问目录
2. 作用在方法上：第二级的访问目录
3. 细节：路径可以不编写 / 表示应用的根目录开始
4. 细节：${ pageContext.request.contextPath }也可以省略不写，但是路径上不能写 /

**属性介绍**

|属性| 描述 |
|---|---|
|path | 指定请求路径的url|
|value| 别名，作用同 path | 
|mthod |指定该方法的请求方式 |
|params | 指定限制请求参数的条件| 
| headers| 发送的请求中必须包含的请求头|

###  RequestParam

作用：把请求中的指定名称的参数传递给控制器中的形参赋值

**使用位置**

作用在方法参数上

**属性介绍**

|属性| 描述 |
|---|---|
|name|请求参数中的名称|
|value| 别名，作用同 name | 
|required | 请求参数中是否必须提供此参数，默认值是true，必须提供|

###  RequestBody

作用：获取请求体的内容（注意：get 方法无效）

**属性介绍**

|属性| 描述 |
|---|---|
|required | 是否必须有请求体，默认值是true|


###  PathVariable

作用：绑定 URL 中的占位符，例如：URL 中有/delete/{id}，{id} 就是占位符

**属性介绍**

|属性| 描述 |
|---|---|
| value | 指定url中的占位符名称 |
| value | 指定url中的占位符名称 |
|required | 是否必须有请求体，默认值是true|

Restful 风格的特征：**请求路径一样，可以根据不同的请求方式去执行后台的不同方法**

Restful 风格的 URL 好处
1. 结构清晰
2. 符合标准
3. 易于理解
4. 扩展方便

{%note info%}

Spring(Spring MVC) 对 RESTful 的支持

- 利用@RequestMapping 指定要处理请求的 URI 模板和 HTTP 请求的动作类型

- 利用@PathVariable 将 URI 请求模板中的变量映射到处理方法参数上

- 利用 Ajax,在客户端发出 PUT、DELETE 动作的请求 

{%endnote%}
 
###  RequestHeader

作用：获取指定请求头的值

###  CookieValue

作用：用于获取指定 Cookie 的名称的值

### ModelAttribute

作用: 出现在方法上：表示当前方法会在控制器方法执行前线执行。 出现在参数上：获取指定的数据给参数赋值。

### SessionAttributes

作用：用于多次执行控制器方法间的参数共享

### 请求参数的绑定

表单提交的数据都是k=v格式的 username=xma&password=1001，SpringMVC 的参数绑定过程是把表单提交的请求参数，作为控制器中方法的参数进行绑定的，要求提交表单的键名和参数的名称是相同的

**支持的数据类型**

基本数据类型和字符串类型
实体类型（JavaBean）
集合数据类型（List、map等）

**类型转换器**

**获取原生servlet API**

