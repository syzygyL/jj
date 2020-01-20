---
title: SE05-Lambda和Stream
tags:
  - note
comments: false
categories:
  - 基础学习
  - SE
date: 2019-12-02 19:34:32
description:
top:
---

## Lambda

**函数式编程**：函数式编程是种编程方式，它将电脑运算视为函数的计算。函数编程语言最重要的基础是λ演算（lambda calculus），而且λ演算的函数可以接受函数当作输入（参数）和输出（返回值），其主要思想是把运算过程写成嵌套函数调用，Java 中体现为 Lambda 表达式的使用

**函数式接口**：当接口中有且只有一个抽象方法时，此接口就是函数式接口（可以有其他方法比如：默认方法，静态方法...），可以使用 `@FunctionalInterface` 注解来标识
 
### Lambda 使用条件

1. 必须是函数式接口
2. 可以语句上下文推断

### Lambda 格式要求：

标准格式：()->{}

省略格式（3种情况可省）：
* 小括号中的形式参数类型可以不写
* 当且仅当接口的参数只有一个时，小括号可以省略不写
* 当花括号中语句只有一条语句时，花括号、return、分号可以省略(同时省略)

### 函数式编程优点

* 代码简洁，开发迅速
* 不改变输入参数，方便代码管理
* 易于“并发编程”

## Stream

java.util.Stream 表示能应用在一组元素上执行操的作序列，一般应用于 java.util.Collection 的子类
Stream 特点：不改变源操作数的状态，最后必须有终结方法，否则延迟方法不会执行，流不能重复使用。

怎么获取流?
* 获取集合的流： Collection.stream()  Collection 集合调用方法 stream 获取一个流
* 获取 Map 的流：先通过 keySet 、values 、entrySet 方法获取到集合对象，再获取流
* 获取数组的流： Stream.of(数组名)  

延迟方法：方法特征--->方法返回值为 Stream<T> 类型
* filter 过滤：方法参数 interface Predicate<? super T> p -- 过滤条件的接口，需实现抽象方法 test() 
    接口常用默认方法
    - negate()：对过滤条件取反集
    - and(条件n)：通过 filter(A.and(B)) 实现 A && B
    - or(条件n)：通过 filter(A.or(B)) 实现 A || B


* Sorted 排序：方法参数 interface Comparator<? super T> c -- 排序规则的接口，需实现抽象方法 compare()
* limit 取用前几个
* skip 跳过前几个
* map 类型转换：方法参数 interface Function<T， R> 对象映射的接口，需实现抽象方法 apply() ，将 T 类型转换为 R 类型
    接口常用默认方法
* concat 合并两个 Stream 流

终结方法：方法特征--->方法返回值不为 Stream<T> 类型
* count 统计个数
* forEach 逐一消费元素

元素收集
* 收集到 List： collect(Collectors.toList())
* 收集到 Set： collect(Collectors.toSet())
* 收集到 数组：toArray() ，由于泛型被编译擦除，返回数组类型为 Object
