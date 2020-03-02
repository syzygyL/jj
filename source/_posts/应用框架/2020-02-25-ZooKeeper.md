---
title: ZooKeeper
tags:
  - note
comments: false
date: 2020-02-25 09:19:51
categories:
description:
top:
---

## ZooKeeper

### 概述

ZooKeeper 是一个分布式的，开放源码的分布式应用程序协调服务，是 Google 的 Chubby 一个开源的实现，是 Hadoop 和 Hbase 的重要组件。它是一个为分布式应用提供一致性服务的软件，提供的功能包括：配置维护、域名服务、分布式同步、组服务等。
ZooKeeper 的目标就是封装好复杂易出错的关键服务，将简单易用的接口和性能高效、功能稳定的系统提供给用户。
ZooKeeper 包含一个简单的原语集，提供 Java 和 C 的接口。
ZooKeeper 代码版本中，提供了分布式独享锁、选举、队列的接口，代码在 `$zookeeper_home\src\recipes`。其中分布锁和队列有 Java 和 C 两个版本，选举只有 Java 版本。

节点数据存储位于`zoo.cfg`的配置`dataDir=../data`路径下，文件都是以二进制存储的。

### 作用

分布式应用程序可以基于 ZooKeeper 实现诸如 **数据发布/订阅、负载均衡、命名服务、分布式协调/通知、集群管理、Master 选举、配置维护，名字服务、分布式同步、分布式锁和分布式队列**等功能。

#### ZooKeeper 文件系统

Zookeeper 提供一个多层级的节点命名空间（节点称为znode）。与文件系统不同的是，这些节点都可以设置关联的数据，而文件系统中只有文件节点可以存放数据而目录节点不行。Zookeeper为了保证高吞吐和低延迟，在内存中维护了这个树状的目录结构，这种特性使得 Zookeeper 不能用于存放大量的数据，每个节点的存放数据上限为**1M**。


#### ZooKeeper 通知机制

#### 主要应用场景

命名服务（注册中心）：维护服务地址列表

数据发布与订阅（配置中心）：抽取公共配置，维护公共配置，一旦修改，应用可监听到并获取最新配置

{%note info%}

**配置中心的关注点** 
* 配置中心的弱依赖
应用应该弱依赖于配置中心，如果配置中心挂掉，不能影响应用的正常运行，所以客户端应该缓存配置数据
* 配置存储应该做好容灾备份
配置中心的数据是不能丢失的，如果丢失了，估计几百个配置项就无法寻回，这种是无法允许的
* 推送时延和推送成功率
如上节使用zookeeper来说，watcher机制并不能保证每一次配置的更改都推送给客户端，这种对于应用也是一件无法允许的事情
* 灰度
 如果使用zookeeper来做配置中心，做灰度是一件很难的事情，不是说不能做，是需要客户端去配合过滤一些不必要的数据，而这种造成了网络的垃圾开销及客户端的复杂度，下文会详细说
* 集中入口及变更审计能力

{%endnote%}

集群管理:
分布式锁管理:
分布式队列管理:
Master 选举: 在分布式环境中，有些业务逻辑只需要集群中的某一台机器进行执行，其他的机器可以共享这个结果，这样可以大大减少重复计算，提高性能，于是就需要进行 Master 选举

*ZooKeeper 负载均衡和 Nginx 负载均衡区别*：zk的负载均衡是可以调控，nginx只是能调权重，其他需要可控的都需要自己写插件；但是nginx的吞吐量比zk大很多，应该说按业务选择用哪种方式。

### 基本概念

#### 文件系统模型

层次模型和key-value 模型是两种主流的数据模型。ZooKeeper 使用文件系统模型主要基于以下两点考虑：

* 文件系统的树形结构便于表达数据之间的层次关系。
* 文件系统的树形结构便于为不同的应用分配独立的命名空间（namespace）。

#### 集群角色

zookeeper 引入了不同以往的 master 和 slave 全新角色

* Leader: 领导者负责进行投票的发起和决议，更新系统状态。
* Follower: 跟随者用于接收客户请求并向客户端返回结果，在选主过程中参与投票
* Observer: 观察者可以接收客户端连接，将写请求转发给 Leader 节点。但 Observer 不参加投票过程，只同步 Leader 的状态。Observer 的目的是为了扩展系统，提高读取速度。

一个 ZooKeeper 集群同一时刻只会有一个 Leader，其他都是 Follower 或 Observer

ZooKeeper 配置很简单，每个节点的配置文件(zoo.cfg)都是一样的，只有 myid 文件不一样。myid 的值必须是 zoo.cfg 中server.{数值} 的{数值}部分。

`zoo.cfg`配置文件示例

```cfg
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial 
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between 
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just 
# example sakes.
dataDir=../data
# the port at which the clients will connect
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the 
# administrator guide before turning on autopurge.
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1
```

ZooKeeper 默认只有 Leader 和 Follower 两种角色，没有 Observer 角色。为了使用 Observer 模式，在任何想变成Observer的节点的配置文件中加入:peerType=observer 并在所有 server 的配置文件中，配置成 observer 模式的 server 的那行配置追加 :observer

#### 节点读写服务分工

1.ZooKeeper 集群的所有机器通过一个 Leader 选举过程来选定一台被称为『Leader』的机器，`Leader`服务器为客户端提供读和写服务。

2.Follower 和 Observer 都能提供读服务，不能提供写服务。两者唯一的区别在于，Observer机器不参与 Leader 选举过程，也不参与写操作的『过半写成功』策略，因此 Observer 可以在不影响写性能的情况下提升集群的读性能。

#### Session

Session 是指客户端会话，在讲解客户端会话之前，我们先来了解下客户端连接。在 ZooKeeper 中，一个客户端连接是指客户端和 ZooKeeper 服务器之间的TCP长连接。

ZooKeeper 对外的服务端口默认是 2181，客户端启动时，首先会与服务器建立一个 TCP 连接，从第一次连接建立开始，客户端会话的生命周期也开始了，通过这个连接，客户端能够通过心跳检测和服务器保持有效的会话，也能够向 ZooKeeper 服务器发送请求并接受响应，同时还能通过该连接接收来自服务器的 Watch 事件通知。

Session 的 SessionTimeout 值用来设置一个客户端会话的超时时间。当由于服务器压力太大、网络故障或是客户端主动断开连接等各种原因导致客户端连接断开时，只要在 SessionTimeout 规定的时间内能够重新连接上集群中任意一台服务器，那么之前创建的会话仍然有效。

#### 数据节点

ZooKeeper 的结构其实就是一个树形结构，Leader 就相当于其中的根结点，其它节点就相当于 follow 节点，每个节点都保留自己的内容。

有四种类型的 znode：（临时节点可以用来服务发现、服务注册/顺序编号可以用来实现保持时序的分布式锁 命名服务（分布式自增id）分布式队列先进先出 ）

1、PERSISTENT-持久化目录节点：客户端与zookeeper断开连接后，该节点依旧存在

2、PERSISTENT_SEQUENTIAL-持久化顺序编号目录节点：客户端与zookeeper断开连接后，该节点依旧存在，只是Zookeeper给该节点名称进行顺序编号

3、EPHEMERAL-临时目录节点：客户端与zookeeper断开连接后，该节点被删除（node_0000000001）

4、EPHEMERAL_SEQUENTIAL-临时顺序编号目录节点：客户端与zookeeper断开连接后，该节点被删除，只是Zookeeper给该节点名称进行顺序编号

### 高级特性

#### Watcher 机制

首先，ZooKeeper 提供了分布式数据的发布/订阅功能。这就不得不联想到设计模式中的经典「观察者模式」，此模式可以定义对象间的一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。主要解决了**一个对象状态改变给其他对象通知的问题，而且要考虑到易用和低耦合，保证高度的协作**。

ZooKeeper 的 Watcher 机制主要包括客户端线程、客户端 WatchManager 和 ZooKeeper 服务器三部分。 

客户端线程: 分布在各处的 ZooKeeper 的 jar 包程序，被引用在各个独立应用程序中。
WatchManager ：一个接口，用于管理各个监听器，只有一个方法 materialize()，返回一个 Watcher 的 set 
ZooKeeper服务器: 部署在远程主机上的 ZooKeeper 集群，当然，也可能是单机的。

为了更好的实现 Java 操作 ZooKeeper 服务器，后来出现了 Curator 框架，非常的强大，目前已经是 Apache 的顶级项目，里面提供了更多丰富的操作，例如 Session 超时重连、主从选举、分布式计数器、分布式锁等等适用于各种复杂的 Zookeeper 场景的 API 封装

**Curator 引入了 Cache 的概念用来实现对 ZooKeeper 服务器端进行事件监听。Cache 是 Curator 对事件监听的包装，其对事件的监听可以近似看做是一个本地缓存视图和远程 ZooKeeper 视图的对比过程。而且 Curator 会自动的再次监听，我们就不需要自己手动的重复监听了**

```xml
<!--zookeeper的依赖-->
<dependency>
    <groupId>org.apache.zookeeper</groupId>
    <artifactId>zookeeper</artifactId>
    <version>3.4.7</version>
</dependency>
<!--	zookeeper CuratorFramework 是Netflix公司开发一款连接zookeeper服务的框架，通过封装的一套高级API 简化了ZooKeeper的操作，提供了比较全面的功能，除了基础的节点的操作，节点的监听，还有集群的连接以及重试。-->
<dependency>
    <groupId>org.apache.curator</groupId>
    <artifactId>curator-framework</artifactId>
    <version>4.0.1</version>
</dependency>
<dependency>
    <groupId>org.apache.curator</groupId>
    <artifactId>curator-recipes</artifactId>
    <version>4.0.1</version>
</dependency>
```

#### 选举机制

**Leader选举，要求 可用节点数量 > 总节点数量/2 。注意 是 > , 不是 ≥**

假设有三台服务器（a、b、c）用于搭建zookeeper集群，在每台服务器的`$zookeeper/data/`路径下建有 sid 文件，此文件用于保存服务器的编号，分别对应 a-1,b-2,c-3;

1、服务器a 启动，给自己投票，然后发投票信息，由于其它机器还没有启动所以它收不到反馈信息，服务器a 的状态一直属于Looking(选举状态)。
2、服务器b 启动，给自己投票，同时与之前启动的服务器a 比对，首先对比 zxid，谁大谁就是 Leader 如果相同则比较 sid，此时服务器b 的编号大所以服务器b 胜出，此时服务器a 的选票将会改为投给服务器b ，所以服务器b 的选票数大于服务器半数，服务器b 被选为 Leader 
3、服务器c 启动，给自己投票，同时与之前启动的服务器a,b 交换信息，尽管服务器c 的编号大，但之前服务器b 已经胜出，所以服务器c 只能成为 Follower。
