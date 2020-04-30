---
title: Hello World
date: '2019/10/01 00:00:00'
tags:
categories:
  - 杂项
  - 建站
description: "此描述将会显示到文章页内" 
top: 1
---

{% cq %}
  此段为引用文本
{% endcq %}

MarkDown 语法兼容大部分 HTML 

<center> 居中文字 </center>

{% note danger %} 警告 (红色) {% endnote %}
{% note default %} 默认 (灰色) {% endnote %}
{% note primary %} 主要 (紫色) {% endnote %}
{% note success %} 成功 (绿色) {% endnote %}
{% note info %} 生成 (蓝色)) {% endnote %}

## [快速入门](#QuickStart)

Welcome to [Hexo](https://hexo.io/)! This is your very first post.Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).


## QuickStart

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/one-command-deployment.html)

## next6/7之后，配置`_config.yml`的摘要/预览失效问题

解决方法：使用`<!-- more -->`标签包裹你不需要在首页展示的内容

```text

这里放摘要

<!-- more -->
...
这里放正文
...
<!-- more -->

```

还可以这样
```text

这里放摘要
<!-- more -->
<!-- more -->
...
这里放正文
...

```



配置后，敲个本地调试命令`hexo s`，浏览器输入`http://localhost:4000/`即可看到此时首页只显示摘要，而不显示后面的内容了。