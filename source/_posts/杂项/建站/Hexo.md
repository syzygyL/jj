---
title: Hexo
tags:
  - Hexo
comments: false
categories:
  - 杂项
  - 建站
date: 2019-11-11 08:00:29
description:
top:
---

注：安装环境为 win10 x64、git、node ( 默认 git 已提前装好，主站配置文件不能错)

## 1.下载安装node
* 浏览器输入`nodejs.cn`，跳转官网选择对应win10安装包，64位

* 双击打开安装，可修改安装路径，安装完成后命令行输入检查

> node -v    #查看node版本

> npm -v     #查看包管理器版本

## 2.安装镜像源

> npm install -g cnpm --registry=https://registry.npm.taobao.org

> cnpm #查看已是否全局配置

## 3.下载hexo

> cnpm install -g hexo-cli

> hexo -v #查看hexo信息

到了这步环境就已经搭好了~，输入 exit 退出命令行

## 4.创建本地博客

* 新建文件夹，此文件夹就是你的 blog 保存路径，进入文件夹，地址栏输入 cmd --> 回车

* 执行下面的语句，初始化blog，执行 git 的 clone 操作，前提是需要将 git 配置到环境变量

> hexo init

建议连上vpn克隆，或者修改 hosts，初始化失败的话输入 npm install

* 预览博客：浏览器地址栏输入 `localhost:4000` 

> hexo s

* 新建博客：将在`\source\_posts`下创建一篇新的blog(随便写点)

> hexo n "blogName"

* 清除缓存并生成静态文件：重新生成blog，刷新一下 `localhost:4000` 就可以看到啦

> hexo clean 

> hexo g

## 托管至Github

- 新建一个代码仓库，强制要求名字格式为
    `你的登录名.github.io`
- 安装git部署插件，blog存放路径下打开命令行输入
    `cnpm install -save hexo-deployer-git`

- 修改blog存放路径下的 `_config.yml文件`，双击打开，到最底部删除最后一个引号，配置以下三个属性，保存即可
    注意：属性的冒号后面要接空格
> type: git
> repo: 此处将新建的代码仓库中的 https 链接复制过来
> branch: master

- 系统级别签名
git config --global user.name "你的目标用户名"
git config --global user.email "你的目标邮箱名"

- 命令行输入`hexo d` 开始推送静态文件，若出现 *ERROR 报错： Deployer not found: git* ，代表第二步安装部署插件安装失败，再次输入`cnpm install --save hexo-deployer-git`即可（出现的 *WARN* 忽略），此步可能需要登录 GitHub ，按提示输入即可

## 6.克隆主题
> git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia

* 修改blog存放路径下的 `_config.yml 文件`，找到`theme`属性将值改为 yilia 即可

## 7.更新blog推送步骤
将blog放置于 `source\_posts`目录下，依次输入
> hexo clean  
> hexo g -d

学习hexo更多命令：https://hexo.io/zh-cn/docs/commands

## 主题配置相关插件
### 安装渲染器
> cnpm install hexo-renderer-pug hexo-renderer-stylus --save
### PWA 
> cnpm install hexo-offline --save
### 字數統計
> npm install hexo-wordcount --save 若安装失败 hexo g 时则会报错
!()[]
解决：`cnpm i --save hexo-wordcount`
### 文章置顶
依次输入
> cnpm install hexo-generator-index-pin-top --save
cnpm uninstall hexo-generator-index --save

### 新建文章
_posts 下打开 Git bash ：hexo new "文章名"

### 插件修复
检查hexo相关插件：cnpm ls --depth 0
安装缺失的插件：cnpm install hexo-generator-archive --save
修复：cnpm audit fixc