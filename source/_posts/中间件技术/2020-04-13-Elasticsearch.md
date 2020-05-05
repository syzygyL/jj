---
title: Elasticsearch
tags:
  - note
comments: false
categories:
  - 中间件技术
date: 2020-04-13 21:28:58
description:
top:
---

## Elasticsearch

### Ik分词器

ik_max_word和 ik_smart介绍

学习过Solr或Elasticsearch的同学都知道IK分词器，它是一个针对中文的分词器。
IK分词器地址：https://github.com/medcl/elasticsearch-analysis-ik
IK分词器有两种分词模式：ik_max_word和ik_smart模式。

1、ik_max_word

会将文本做最细粒度的拆分，比如会将“中华人民共和国人民大会堂”拆分为“中华人民共和国、中华人民、中华、华人、人民共和国、人民、共和国、大会堂、大会、会堂等词语。

2、ik_smart
会做最粗粒度的拆分，比如会将“中华人民共和国人民大会堂”拆分为中华人民共和国、人民大会堂。

测试两种分词模式的效果：

发送：post localhost:9200/_analyze
测试ik_max_word
{“text”:“中华人民共和国人民大会堂”,“analyzer”:“ik_max_word” }
测试ik_smart
{“text”:“中华人民共和国人民大会堂”,“analyzer”:“ik_smart” }

最佳实践
两种分词器使用的最佳实践是：索引时用ik_max_word，在搜索时用ik_smart。
即：索引时最大化的将文章内容分词，搜索时更精确的搜索到想要的结果。 

### 基本概念

Cluster
 

代表一个集群，集群中有多个节点，其中有一个为主节点，这个主节点是可以通过选举产生的，主从节点是对于集群内部来说的。es的一个概念就是去中心化，字面上理解就是无中心节点，这是对于集群外部来说的，因为从外部来看es集群，在逻辑上是个整体，你与任何一个节点的通信和与整个es集群通信是等价的。

 

Shards
代表索引分片，es可以把一个完整的索引分成多个分片，这样的好处是可以把一个大的索引拆分成多个，分布到不同的节点上。构成分布式搜索。分片的数量只能在索引创建前指定，并且索引创建后不能更改。

 

replicas
代表索引副本，es可以设置多个索引的副本，副本的作用一是提高系统的容错性，当某个节点某个分片损坏或丢失时可以从副本中恢复。二是提高es的查询效率，es会自动对搜索请求进行负载均衡。

 

Recovery
代表数据恢复或叫数据重新分布，es在有节点加入或退出时会根据机器的负载对索引分片进行重新分配，挂掉的节点重新启动时也会进行数据恢复。
