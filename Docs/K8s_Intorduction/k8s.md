---
presentation:
  theme: moon.css
  mouseWheel: true
  width: 1000
  height: 1440
---
<!-- slide -->
# Kubernetes 
## 介绍 与 初体验
<br>

### 讲解人
Windom
<!-- slide -->
- Q: Kubernetes 是什么？
- A: Kubernetes 又名 K8s，是容器编排平台
<br>

- Q: 什么是容器？
- A: 容器是一组与系统其余部分隔离的 1 个或多个进程。  
  - Ref: [什么是 Linux 容器？](https://www.redhat.com/en/topics/containers/whats-a-linux-container)
<br>

- Q: 为何要使用容器？
- A: 做到一次打包，（任何宿主系统）皆可运行
<br>

- Q: dockers 如何工作？
- A: docker → dockerd → containerd → runC → unshare syscall
  - Ref: 
    ![How Docker Works - Intro to Namespaces](How_Docker_Works-Intro_to_Namespaces.png)

<!-- slide -->
- Q: 容器？虚拟化？
- A: 
  ![](Lxc-vm.jpg)
<br>

- 容器操作流程
- docker build; docker push; docker run

<!-- slide -->
### 环境准备

#### Markdown Preview Enhanced 扩展安装

![Markdown Preview Enhanced](/images/Snipaste_2020-02-19_01-03-02.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
##### 五级标题
###### 六级标题
正文
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![标题](/images/Snipaste_2020-02-19_19-57-59.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
#### 无序列表
- 1
- 2
- 3
* 1
* 2
* 3
#### 有序列表
1. 1
2. 2
3. 3
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![列表](/images/Snipaste_2020-02-19_20-04-02.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
> 这里是引用
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![引用](/images/Snipaste_2020-02-19_20-12-16.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
#### 插入链接
[Bing](/images/https://cn.bing.com)
#### 插入图片
![Bing](/images/bing-teal-logo-wordmark1-1920.png)
```
<!-- slide -->
### 基本语

#### Markdown 基本语法

![链接和图片](/images/Snipaste_2020-02-19_20-16-30.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
**这里是粗体**
*这里是斜体*
~~这里是删除线~~
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![强调](/images/Snipaste_2020-02-19_21-14-46.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
#### 表格
| 实验组 | 时间  |   数量 |
| :----- | :---: | -----: |
| M1     |  1h   | 120000 |
| M2     |  2h   | 140000 |
| M3     |  3h   | 160000 |
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![表格](/images/Snipaste_2020-02-19_21-16-49.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![代码块](/images/Snipaste_2020-02-19_21-40-34.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![代码块](/images/Snipaste_2020-02-19_21-41-47.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
#### 下面是分割线
***
#### 下面也是分割线
---
```
<!-- slide -->
### 基本语法

#### Markdown 基本语法

![分割线](/images/Snipaste_2020-02-19_21-43-24.png)
<!-- slide -->
### 基本语法

#### Markdown 基本语法

```Markdown
#### 块内公式

$$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$

#### 行内公式

$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$
```
<!-- slide -->
### 基本语法

#### Markdown 基本语

![公式](./images/Snipaste_2020-02-22_15-39-17.png)
<!-- slide -->
### 基本语法

#### MPE 幻灯片分割

```Markdown
<!-- slide -->
# Hi here
<!-- slide -->
let us go
<!-- slide -->
Thank you!
```
<!-- slide -->
### 基本语法

#### MPE 幻灯片分割

![MPE 幻灯片分割](/images/test1.gif)
<!-- slide -->
### 代码实例

#### 就是本幻灯片
<!-- slide -->
### 结果输出

![结果输出](/images/Snipaste_2020-02-23_19-12-08.png)
<!-- slide -->
# Thank you!