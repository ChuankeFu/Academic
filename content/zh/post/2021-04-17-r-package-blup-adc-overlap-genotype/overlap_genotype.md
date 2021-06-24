---
title: 'R package:blupADC-功能2'
author: qsmei
date: '2021-04-15'
slug: overlap_genotype
categories:
  - Overlap
tags: []
subtitle: ''
summary: '基因型数据重复性检测'
authors: []
lastmod: '2021-04-15T15:11:30+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

{{<toc>}}

## 简介

👦大家好,这一节给大家带来的是如何使用`blupADC`中的`genotype_data_overlap`函数来对基因型数据进行重复性检测。

与之前类似，我们还是用一个小例子来简单的看下该函数的用法

``` {.R}
library(blupADC)
overlap_result=genotype_data_overlap(
                  input_data_hmp=data_hmp,   #provided hapmap data object
                  overlap_threshold=0.95,    # threshold of duplicate 
                  return_result=TRUE         #return result 
                  )
```

## 参数详解

关于`genotype_data_overlap` 函数中的参数介绍，我们主要介绍以下两个参数：

-   **参数1：selected_snps**

进行重复性检测时随机抽样的SNP的数目，`numeric` 类型，默认为1000。

-   **参数2：overlap_threshold**

判断基因型重复的阈值，`numeric` 类型，默认为0.95。

当个体间的基因型overlap比例超过该阈值时，基因型就会被判定为重复的基因型。

该函数中的其他参数均和`genotype_data_format_conversion`函数中的参数一致(基因型数据的输入与输出)，具体大家可参阅之前的介绍:

具体大家可参阅之前的介绍: [R package:blupADC- 使用说明1](https://qsmei.netlify.app/post/blupadc/)。
