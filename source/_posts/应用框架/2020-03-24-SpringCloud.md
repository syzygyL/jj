---
title: SpringCloud
tags:
  - note
comments: false
categories:
  - 应用框架
date: 2020-03-24 13:59:11
description:
top:
---

### 引

在传统的软件架构中，我们通常采用的是单体应用来构建一个系统，一个单体应用糅合了各种业务模块。起初在业务规模不是很大的情况下，对于单体应用的开发维护也相对容易。但随着企业的发展，业务规模与日递增，单体应用变得愈发臃肿。由于单体应用将各种业务模块聚合在一起，并且部署在一个进程内，所以通常我们对其中一个业务模块的修改也必须将整个应用重新打包上线。为了解决单体应用变得庞大脯肿之后产生的难以维护的问题，微服务架构便出现在了大家的视线里

### 什么是Spring Cloud

Spring Cloud是一个基千Spring Boot实现的微服务架构开发工具。它为微服务架构中涉及的配置管理、服务治理、断路器、智能路由、微代理、控制总线、全局锁、决策竞选、分布式会话和集群状态管理等操作提供了一种简单的开发方式。Spring Cloud的诞生并不是为了解决微服务中的某一个问题，而是提供了一套解决微服务架构实施的综合性解决方案。

*版本号的问题*
springcloud项目是由多个独立项目集合而成的，每个项目都是独立的，各自进行自己的迭代和版本发布。所以springcloud不方便使用版本号来管理，而是使用版本名。以避免和子项目版本号的冲突。

我们主要关心的是 Netflix 的子项目

*Spring Cloud*组件

服务发现——Netflix Eureka: Eureka会将服务注册到EurekaService,并且EurakeClient还可以返回过来从EurekaService拉去注册表,从而知道服务在哪里
客服端负载均衡——Netflix Ribbon: 服务间发起请求的时候,基于Ribbon服务做到负载均衡,从一个服务的对台机器中选择一台
熔断器——Netflix Hystrix: 发起的请求是通过Hystrix的线程池来走,不同的服务走不同的线程池,实现了不同的服务调度隔离,避免服务雪崩的问题 
服务网关——Netflix Zuul
分布式配置——Spring Cloud Config

Feign:基于fegin的动态代理机制,根据注解和选择机器,拼接Url地址,发起请求

Zuul:如果前端后端移动端调用后台系统,统一走zull网关进入,有zull网关转发请求给对应的服务

### RestTemplate

### Eureka 服务治理组件

Eureka 是由`Netflix`开发的一款服务治理开源框架，Spring-cloud对其进行了集成。Eureka既包含了服务端也包含了客户端，Eureka服务端是一个**服务注册中心(Eureka Server)**，提供服务的注册和发现，即当前有哪些服务注册进来可供使用；Eureka客户端为**服务提供者(Server Provider)**，它将自己提供的服务注册到Eureka服务端，并周期性地发送心跳来更新它的服务租约，同时也能从服务端查询当前注册的服务信息并把它们缓存到本地并周期性地刷新服务状态。这样**服务消费者(Server Consumer)**便可以从服务注册中心获取服务名称，并消费服务。

{%note info%}

服务端需开启注解：`@EnableEurekaServer`
客户端需开启注解：`@EnableEurekaClient`或`@EnableDiscoveryClient`

{%endnote%}

#### 服务提供者

服务提供者要向`EurekaServer`进行服务注册，并完成服务续约等工作。

* 服务注册
1. 启动类上添加@DiscoveryClient，pom文件中添加eureka-client坐标
2. 配置文件中添加注册中心信息
3. 服务在启动时，检测是否有@DiscoveryClient注解和配置信息
4. 如果有，则会向注册中心发起注册请求，携带服务元数据信息(IP、端口、服务列表)
5. Eureka注册中心会把服务的信息保存在Map中

* 服务续约
服务注册完成以后，服务提供者和注册中心会维持一个 心跳 ，保存服务处于存在状态，这个动作
称之为服务续约(renew)。

```yml
eureka:
  instance:
    #租约到期，服务时效时间，默认值90秒
    lease-expiration-duration-in-seconds: 90
    #租约续约间隔时间，默认30秒
    lease-renewal-interval-in-seconds: 30
```

参数说明：
lease-expiration-duration-in-seconds:
租约到期时效时间，默认90秒；类似于和房东签合同，合同有效期为90天。
lease-renewal-interval-in-seconds:
租约续约间隔时间，默认30秒，类似于每隔30天再次和房东签订一个有效期为90天的合同
服务超过90秒没有发生心跳，EurekaServer会将服务从列表移除[ 前提是EurekaServer关闭了自我保护 ]

#### 服务消费者

* 获取注册中心服务列表(前提：`eureka.client.fetch-registry=true`)

```yml
eureka:
  client:
    service-url:
      # EurekaServer的地址
      defaultZone: http://localhost:7001/eureka
    registry-fetch-interval-seconds: 30
```

参数说明：
服务消费者启动时，会检测是否获取服务注册信息配置
如果是，则会从 EurekaServer服务列表获取只读备份，缓存到本地；每隔30秒，会重新获取并更新数据，每隔30秒的时间可以通过配置 registry-fetch-interval-seconds 修改

#### 服务注册中心

* 失效剔除
服务中心每隔一段时间(默认60秒)将清单中没有续约的服务剔除。
通过eureka.server.eviction-interval-timer-in-ms配置可以对其进行修改，单位是毫秒

```yml
eureka:
  server:
  # 对无效的服务进行剔除，单位是毫秒
    eviction-interval-timer-in-ms: 5000
```

* 自我保护

Eureka Server 在运行期间会去统计心跳失败比例在 15 分钟之内是否低于 85%，如果低于 85%，Eureka Server 会将这些实例保护起来，让这些实例不会过期，但是在保护期内如果服务刚好这个服务提供者非正常下线了，此时服务消费者就会拿到一个无效的服务实例，此时会调用失败，对于这个问题需要服务消费者端要有一些容错机制，如重试，断路器等。(防止网络阻塞的问题)

1.自我保护模式下，不会剔除任何服务实例
2.自我保护模式保证了大多数服务依然可用
3.通过`eureka.server.enable-self-preservation`配置可用关闭触发自我保护，默认值是打开

```yml
eureka:
  server:
    #默认打开 
    enable-self-preservation: false
```

### Ribbon 负载均衡组件

主要提供客户侧的软件负载均衡算法。
遇到的坑: java.net.UnknownHostException，场景：eureka服务治理，ribbon负载均衡时，消费端通过`RestTemplate`调用服务端时出现
解决方法: 在主引导类的`RestTemplate`bean 配置中添加负载均衡注解`@LoadBalanced`

### Hystrix 熔断器组件

为了保证其高可用，单个服务通常会集群部署。由于网络原因或者自身的原因，服务并不能保证100%可用，如果单个服务出现问题，调用这个服务就会出现线程阻塞，此时若有大量的请求涌入，Servlet容器的线程资源会被消耗完毕，导致服务瘫痪。服务与服务之间的依赖性，故障会传播，会对整个微服务系统造成灾难性的严重后果，这就是服务故障的“雪崩”效应（是一种因某个服务提供者的不可用导致服务消费者的不可用,并将不可用逐渐放大的过程）

服务熔断：一般是指软件系统中，由于某些原因使得服务出现了过载现象，为防止造成整个系统故障，从而采用的一种保护措施，所以很多地方把熔断亦称为过载保护。很多时候刚开始可能只是系统出现了局部的、小规模的故障，然而由于种种原因，故障影响的范围越来越大，最终导致了全局性的后果

熔断器的核心：线程隔离和服务降级

* 线程隔离：是指Hystrix在用户请求和服务之间加入了线程池（size:10）。为每个依赖服务调用一个小的线程池，如果线程池用尽，调用立即被拒绝，默认不采用排队。

原理：用户的请求将不再直接访问服务，而是通过线程池中的空闲线程来访问服务，如果线程池已满，则会进行降级处理，用户的请求不会被阻塞，至少可以看到一个执行结果（例如返回友好的提示信息），而不是无休止的等待或者看到系统崩溃。

* 服务降级(兜底方法)：优先保证核心服务，而非核心服务不可用或弱可用（非主要的服务和页面）。触发Hystrix服务降级的情况：线程池已满、请求超时。（client端做） 

熔断器状态介绍:

* **Closed.**：关闭状态，所有请求正常访问，`under threshold`(阈值以下)则关闭。
* **Open**：打开状态，所有请求都会被降级。Hystrix 会对请求情况计数，当一定时间段内失败请求百分比`threshold reached`(达到阈值)则触发熔断，默认失败比例的阈值是50%，熔断触发的最小个数20次/10s
* **Half Open**：半开状态，Open 状态不是永久的，Open状态过一段时间（默认5s）转为此状态来尝试恢复。此状态时：允许有且仅一个请求进入，一旦请求成功就关闭断路器。请求失败就到Open状态（这样再过5秒才能转到半开状态）
流程说明:

1:每次调用创建一个新的HystrixCommand，把依赖调用封装在run()方法中。
2:执行execute()/queue做同步或异步调用。
3:判断熔断器(circuit-breaker)是否打开，如果打开跳到步骤8，进行降级策略，如果关闭进入步骤。
4:判断线程池/队列/信号量是否跑满，如果跑满进入降级步骤8，否则继续后续步骤。
5:调用HystrixCommand的run方法。运行依赖逻辑
5a:依赖逻辑调用超时，进入步骤8。
6:判断逻辑是否调用成功
6a:返回成功调用结果
6b:调用出错，进入步骤8。
7:计算熔断器状态，所有的运行状态(成功, 失败, 拒绝,超时)上报给熔断器，用于统计从而判断熔断器状态。
8:getFallback()降级逻辑。
    以下四种情况将触发getFallback调用：
    (1)：run()方法抛出非HystrixBadRequestException异常
    (2)：run()方法调用超时
    (3)：熔断器开启拦截调用
    (4)：线程池/队列/信号量是否跑满
8a:没有实现getFallback的Command将直接抛出异常
8b:fallback降级逻辑调用成功直接返回
8c:降级逻辑调用失败抛出异常
9:返回执行成功结果

#### 服务降级

熔断策略配置(部分)：

0. 熔断器状态(false:关闭): circuitBreaker.forceClosed
1. 熔断后休眠时间(5000毫秒)：circuitBreaker.sleepWindowInMilliseconds
2. 熔断触发最小请求次数(20次/10s)：circuitBreaker.requestVolumeThreshold
3. 熔断触发错误比例阈值(50%)：circuitBreaker.errorThresholdPercentage
4. 熔断超时时间(1000毫秒)：execution.isolation.thread.timeoutInMilliseconds
默认值：1000
在`THREAD`模式下，达到超时时间，可以中断
在`SEMAPHORE`模式下，会等待执行完成后，再去判断是否超时
5. 隔离策略(THREAD)：execution.isolation.strategy
默认使用THREAD模式，以下几种情况可以使用SEMAPHORE模式：
* 只想控制并发度
* 外部的方法已经做了线程隔离
* 调用的是本地方法或者可靠度非常高、耗时特别小的方法（如medis）

**局部熔断**

1.导入 hystrix 依赖坐标
2.开启熔断:引导类加`@EnableCircuitBreaker`或者`@SpringCloudApplication`(此注解相当于：`@SpringBootApplication`+ `@EnableDiscoveryClient`+`@EnableCircuitBreaker`)
3.熔断后的降级处理方法 fallBack()
4.在需要熔断降级处理的方法上加`@HystrixCommand(fallbackMethod = "fallBack")`

**全局熔断**

针对某个类进行全局熔断。

1.导入 hystrix 依赖坐标
2.开启熔断:引导类加`@EnableCircuitBreaker`或者`@SpringCloudApplication`(此注解相当于：`@SpringBootApplication`+ `@EnableDiscoveryClient`+`@EnableCircuitBreaker`)
3.熔断后的降级处理方法 defaultFallBack()
4.在需要熔断降级处理的方法上加`@HystrixCommand`，在类上加`@DefaultProperties(defaultFallback = "defaultFallBack")`

### Feign 声明式服务调用组件

前面我们分别通过Spring Cloud Ribbon和Spring Cloud Hystrix实现了客户端负载均衡和服务容错，而Spring Cloud Feign不但整合了这两种功能，而且还提供了一种比Ribbon更简单的服务调用方式-在Spring Cloud Feign中编写服务调用代码非常简单，几乎可以直接将服务提供者的代码复制过来，去掉方法体转换为接口即可。

### Gateway 服务网关

网关：为微服务提供统一的路由管理，可以在路由管理基础上进行一系列的过滤，可以做一系列的监控操作，限流。

Spring Cloud Gateway 是 Spring Cloud 的一个全新项目，该项目是基于 Spring 5.0，Spring Boot2.0 和 Project Reactor 等技术开发的网关，它旨在为微服务架构提供一种简单有效的统一的 API 路由管
理方式。

路由和转发：过滤器断言