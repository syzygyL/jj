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

### Elasticsearch之Ik分词器

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