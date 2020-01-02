---
title: Hello World
date: '2019/10/01 00:00:00'
tags:
  - tools
  - msic
categories:
  - 杂项
  - 建站
description: "会显示到文章页内的描述" 
top: 20
---

{% cq %}
  此段为引用文本
{% endcq %}

{% note danger %} Content (md partial supported) {% endnote %}
{% note default %} Content (md partial supported) {% endnote %}
{% note primary %} Content (md partial supported) {% endnote %}
{% note success %} Content (md partial supported) {% endnote %}
{% note info %} Content (md partial supported) {% endnote %}

_posts下新建文章：hexo new "文章名"

Welcome to [Hexo](https://hexo.io/)! This is your very first post.Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).

## Quick Start

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
