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

### MVC 设计模型

MVC全名是 Model View Controller 模型视图控制器。
* Model：数据模型，JavaBean的类，用来进行数据封装。
* View：指JSP、HTML用来展示数据给用户
* Controller：用来接收用户的请求，整个流程的控制器。用来进行数据校验等。

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

### 常见组件

用于 HTTP 请求处理程序/控制器的中央调度器: org.springframework.web.servlet.DispatcherServlet

处理器映射器: org.springframework.web.servlet.HandlerMapping

处理器适配器: org.springframework.web.servlet.HandlerAdapter

视图解析器: org.springframework.web.servlet.ViewResolver

---

### 请求参数的绑定

表单提交的数据都是k=v格式的 username=xma&password=1001，SpringMVC 的参数绑定过程是把表单提交的请求参数，作为控制器中方法的参数进行绑定的，要求提交表单的键名和参数的名称是相同的

**支持的数据类型**

基本数据类型和字符串类型
实体类型（JavaBean）
集合数据类型（List、map等）

**类型转换器**

**获取原生servlet API**

---

### 常用注解

#### RequestParam【重点】 

##### 使用说明

+ 作用：

  把请求中指定名称的参数给控制器中的形参赋值。 

+ 属性

  value： 请求参数中的名称。
  required：请求参数中是否必须提供此参数。 默认值： true。表示必须提供，如果不提供将报错。 

  defaultValue:默认值

细节: json 类型数据必须加此注解

##### 使用实例

+ 页面

```html
<a href="user/testRequestParam?name=张三">测试RequestParam </a>
```

+ UserController.java

```java
@Controller
@RequestMapping("/user")
public class UserController {
    @RequestMapping("/testRequestParam")
    public String testRequestParam(@RequestParam(value = "name",required = true,defaultValue = "李四") String username){
        System.out.println("username="+username);
        return "success";
    }
}
```

#### RequestBody/ResponseBody【重点】 

请求体: post方式的请求参数,get方式没有请求体

Get和Post区别

1. get方式 请求参数拼接在请求路径后面, post 方式 请求参数在请求体里面
2. get方式 请求参数浏览器地址栏可见,  post 方式 请求参数浏览器地址栏不可见
3. get方式 请求参数大小有限制的, post 方式请求参数大小没有限制的

##### 使用说明

+ 作用

  1.用于获取请求体内容。 直接使用得到是 key=value&key=value...结构的字符串。

  2.把获得json类型的数据转成pojo对象(后面再讲)

  注意: get 请求方式不适用。 

+ 属性

  required：是否必须有请求体。默认值是:true。当取值为 true 时,get 请求方式会报错。如果取值为 false， get 请求得到是 null。 

##### 使用实例

+ 页面

```html
<form  action="user/testRequestBody " method="post">
    用户名:<input type="text" name="username"/><br/>
    密码:<input type="password" name="password"/><br/>
    <input type="submit" value="测试RequestBody"/>
</form>
```

+ UserController.java

```java
   @RequestMapping("testRequestBody")
    public String testRequestBody(@RequestBody String queryStr){
        System.out.println("queryStr="+queryStr);
        return "success";
    }
```

#### PathVariable【重点】 

##### REST 风格 URL   

​	REST（英文： Representational State Transfer，简称 REST）描述了一个架构样式的网络系统，比如 web 应用程序。它首次出现在 2000 年 Roy Fielding 的博士论文中，他是 HTTP 规范的主要编写者之一。在目前主流的三种 Web 服务交互方案中， REST 相比于 SOAP（Simple Object Access protocol，简单对象访问协议）以及 XML-RPC 更加简单明了，无论是对 URL 的处理还是对 Payload 的编码， REST 都倾向于用更加简单轻量的方法设计和实现。值得注意的是 REST 并没有一个明确的标准，而更像是一种设计的风格。它本身并没有什么实用性，其核心价值在于如何设计出符合 REST 风格的网络接口。

+ restful 的优点

  它结构清晰、符合标准、易于理解、 扩展方便，所以正得到越来越多网站的采用。

+ restful 的特性：

  ​	资源（Resources） ： 网络上的一个实体，或者说是网络上的一个具体信息。它可以是一段文本、一张图片、一首歌曲、一种服务，总之就是一个具体的存在。可以用一个 URI（统一资源定位符）指向它，每种资源对应一个特定的 URI 。要获取这个资源，访问它的 URI 就可以，因此 URI 即为每一个资源的独一无二的识别符。表现层（Representation） ： 把资源具体呈现出来的形式，叫做它的表现层 （Representation）。比如，文本可以用 txt 格式表现，也可以用 HTML 格式、 XML 格式、 JSON 格式表现，甚至可以采用二进制格式。状态转化（State Transfer） ： 每 发出一个请求，就代表了客户端和服务器的一次交互过程。HTTP 协议，是一个无状态协议，即所有的状态都保存在服务器端。因此，如果客户端想要操作服务器，必须通过某种手段， 让服务器端发生“ 状态转化” （State Transfer）。而这种转化是建立在表现层之上的，所以就是 “ 表现层状态转化” 。具体说，就是 HTTP 协议里面，四个表示操作方式的动词： GET 、 POST 、 PUT、DELETE。它们分别对应四种基本操作： GET 用来获取资源， POST 用来新建资源， PUT 用来更新资源， DELETE 用来删除资源 .

{%note info%}

Spring(Spring MVC) 对 RESTful 的支持

- 利用@RequestMapping 指定要处理请求的 URI 模板和 HTTP 请求的动作类型

- 利用@PathVariable 将 URI 请求模板中的变量映射到处理方法参数上

- 利用 Ajax,在客户端发出 PUT、DELETE 动作的请求 

{%endnote%}

+ 实例      

```text
保存
	传统：http://localhost:8080/user/save
	REST：http://localhost:8080/user						    POST方式	执行保存

更新
	传统：http://localhost:8080/user/update?id=1
	REST：http://localhost:8080/user/1					    PUT方式	执行更新   1代表id

删除	
	传统：http://localhost:8080/user/delete?id=1
	REST：http://localhost:8080/user/1				       DELETE方式	执行删除 1代表id  

查询
	传统：http://localhost:8080/user/findAll
	REST：http://localhost:8080/user						  GET方式	查所有

	传统：http://localhost:8080/user/findById?id=1
	REST：http://localhost:8080/user/1 					  GET方式	根据id查1个
```

##### 使用说明

+ 作用：

  用于绑定 url 中的占位符。 例如：请求 url 中 /delete/{id}， 这个{id}就是 url 占位符。
  url 支持占位符是 spring3.0 之后加入的。是 springmvc 支持 rest 风格 URL 的一个重要标志。

+ 属性：

  value： 用于指定 url 中占位符名称。
  required：是否必须提供占位符。 

##### 使用实例

+ 页面

```
<a href="user/testPathVaribale/1">测试PathVaribale</a><br/>
```

+ UserController.java

```java
 @RequestMapping("testPathVaribale/{id}")
 public String testPathVaribale(@PathVariable(value = "id") Integer id){
     System.out.println("id="+id);
       return "success";
}
```

#### RequestHeader【了解】 

##### 使用说明

+ 作用：
  用于获取请求消息头。
+ 属性：
  value：提供消息头名称
  required：是否必须有此消息头 

##### 使用实例

+ 页面

```
<a href="user/testRequestHeader">测试RequestHeader</a><br/>
```

+ UserController.java

```java
    @RequestMapping("testRequestHeader")
    public String testRequestHeader(@RequestHeader(value = "User-Agent") String requestHeader){
        System.out.println("requestHeader="+requestHeader);
        return "success";
    }
```

#### CookieValue【了解】 

##### 使用说明

+ 作用：

  用于把指定 cookie 名称的值传入控制器方法参数。

+ 属性：

  value：指定 cookie 的名称。
  required：是否必须有此 cookie。 

##### 使用实例

+ 页面

```
<a href="user/testCookieValue">测试CookieValue</a><br/>
```

+ UserController.java

```java
    @RequestMapping("testCookieValue")
    public String testCookieValue(@CookieValue(value="JSESSIONID") String sessionId){
        System.out.println("sessionId="+sessionId);
        return "success";
    }
```

#### ModelAttribute 【课后自学】

##### 使用说明

+ 作用：

  ​	该注解是 SpringMVC4.3 版本以后新加入的。它可以用于修饰方法和参数。

  ​	出现在方法上，表示当前方法会在控制器的方法执行之前，先执行。它可以修饰没有返回值的方法，也可以修饰有具体返回值的方法。

  ​	出现在参数上，获取指定的数据给参数赋值。

+ 属性：
  value：用于获取数据的 key。 key 可以是 POJO 的属性名称，也可以是 map 结构的 key。

+ 应用场景：
  当表单提交数据不是完整的实体类数据时，保证没有提交数据的字段使用数据库对象原来的数据。
  例如：
  ​        我们在编辑一个用户时，用户有一个创建信息字段，该字段的值是不允许被修改的。在提交表单数
  ​         据是肯定没有此字段的内容，一旦更新会把该字段内容置为 null，此时就可以使用此注解解决问题。 

##### 使用实例

+ 页面

```html
<form action="user/testModelAttribute" method="post">
    用户名:<input type="text" name="username"/><br/>
    密码:<input type="text" name="password"/><br/>
    <input type="submit" value="testModelAttribute"/>
</form>
```

+ UserController.java(用在方法上面)

```java
    @RequestMapping("/testModelAttribute")
    public String  testModelAttribute(User user){
        System.out.println("testModelAttribute ...收到了请求..."+user);
        return  "success";
    }

    @ModelAttribute
    public User  getModel(String username,String password){
        System.out.println("getModel ...收到了请求...");
        //模拟查询数据库, 把性别也查询出来
        User user = new User();
        user.setUsername(username);
        user.setUsername(password);
        user.setSex("男");
        return  user;
    }
```

+ UserController.java(用在参数上面)

```java
    @RequestMapping("/testModelAttribute")
    public String  testModelAttribute(@ModelAttribute("u") User user){
        System.out.println("testModelAttribute ...收到了请求..."+user);
        return  "success";
    }

    @ModelAttribute
	//没有返回值
    public void  getModel(String username, String password, Map<String,User> map){
        System.out.println("getModel ...收到了请求...");
        //模拟查询数据库, 把性别也查询出来
        User user = new User();
        user.setUsername(username);
        user.setUsername(password);
        user.setSex("男");
        map.put("u",user);
    }
```

#### SessionAttributes 【课后自学】

##### 使用说明

+ 作用：

  用于多次执行(多次请求)控制器方法间的参数共享。(该注解定义在类上)，底层会存入到 request 域中

+ 属性：
  value：用于指定存入的属性名称
  type：用于指定存入的数据类型。 

##### 使用实例

+ 页面

```java
<a href="sessionController/setAttribute?name=张三&age=18">测试SessionAttributes(存)</a><br/>
<a href="sessionController/getAttribute">测试SessionAttribute(取)</a><br/>
<a href="sessionController/removeAttribute">测试SessionAttribute(清空)</a><br/>
```

+ SessionController.java

```java
@Controller
@RequestMapping("/sessionController")
@SessionAttributes(value = {"name","age"})
public class SessionController {

    @RequestMapping("/setAttribute")
    public String setAttribute(String name, int age, Model model){
        model.addAttribute("name",name);
        model.addAttribute("age",age);
        return  "success";
    }

    @RequestMapping("/getAttribute")
    public String getAttribute(ModelMap modelMap){
        System.out.println("name="+modelMap.get("name"));
        System.out.println("age="+modelMap.get("age"));
        return  "success";
    }

    @RequestMapping("/removeAttribute")
    public String removeAttribute(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return  "success";
    }

}
```

---

### 响应和结果视图

响应 String
响应 void
响应 ModelAndView
响应关键字：forword/redirect

### 文件上传


当我们使用 jersy 把图片从客服端上传到引用服务器之后，在上传指图片服务器时，我们可能会遇见以下三个错误：

{%note danger%}
returned a response status of 400 OR 403 OR 409
{%endnote%}

* 400 解决方法

首先排除 url 和参数错误，这里只说在你确认代码无误的情况下报错的情况：**不管上传的是什么类型的文件，文件名改成英文名**

* 403 解决方法

**Tomcat 默认为情况下，是不允许向服务器执行写操作的**，所以我们需要到文件服务器的`\conf\web.xml`文件中追加如下参数

```xml
  <servlet>
      <servlet-name>default</servlet-name>
      <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
      <init-param>
          <param-name>debug</param-name>
          <param-value>0</param-value>
      </init-param>

<!--追加参数 begin--> 
  <init-param>
    <param-name>readonly</param-name>
    <param-value>false</param-value>
  </init-param>
<!--追加参数 end--> 

      <init-param>
          <param-name>listings</param-name>
          <param-value>false</param-value>
      </init-param>
      <load-on-startup>1</load-on-startup>
  </servlet>
```


* 409 解决方法

由于和被请求的资源的当前状态之间存在冲突，请求无法完成。即当前访问的路径下没有相关文件或文件夹，所以我们在`target/项目名`的路径下，**新建一个上传服务器路径一致的文件夹**

### MVC 异常处理机制

### MVC 拦截机制

Spring MVC 的拦截器类似于 Servlet 开发中的过滤器 Filter，用于对处理器(自己编写的 Controller)进行预处理和后处理。他们之间的区别如下 

| 类别   | 使用范围      | 拦截范围                            |
| ------ | ------------- | ----------------------------------- |
| 拦截器 | SpringMVC项目 | 只会拦截访问的控制器方法的请求      |
| 过滤器 | 任何web项目   | 任何资源(servlet,控制器,jsp,html等) |

​	我们要想自定义拦截器， 要求必须实现： HandlerInterceptor 接口。 

```java

public class SysInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("拦截!!!!!!");
        //如果返回false则被拦截，true则放行
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        System.out.println("postHandle执行...");
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion执行...");
    }
}

```

注册到 SpringMVC 的配置文件

```xml
<mvc:interceptors>
    <!-- 
        "/*"和"/**"的区别:
          "/*"表示拦截一级目录
          "/**"表示拦截多级目录 
    -->
    <mvc:interceptor>
        <mvc:mapping path="/"/>
        <bean id="sysInterceptor" class="com.juejun.Interceptor.SysInterceptor"/>
    </mvc:interceptor>
</mvc:interceptors>

```

---
