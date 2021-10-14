---
title: 'R package:blupADC-功能3'
author: qsmei
date: '2021-04-16'
slug: blupADC
categories: ["Check genotype"]
tags: []
subtitle: ''
summary: 'Breed composition analysis '
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

## Overview 

👦  品种成分分析一直以来都是数据分析中的一个难题。`blupADC` 为用户提供了`geno_check` 函数，使得用户能够方便的解决这个问题。此外，用户还可以用这个函数进行基因型数据的重复性检测。

## 示例

### 品种成分分析

``` {.R}
library(blupADC)
check_result=geno_check(
                  input_data_hmp=example_PCA_data_hmp,   #provided hapmap data object
                  duplication_check=FALSE,       #whether check the duplication of genotype
                  breed_check=TRUE,              # whether check the record of breed
                  breed_record=example_PCA_Breed,        # provided breed record
                  return_result=TRUE             #return result 
                  )
```

### 重复性检测

``` {.R}
library(blupADC)
check_result=geno_check(
                  input_data_hmp=example_data_hmp,   #provided hapmap data object
                  duplication_threshold=0.95, #threshold of duplication
                  duplication_check=TRUE,    #whether check the duplication of genotype
                  breed_check=FALSE,         # whether check the record of breed
                  return_result=TRUE         #return result 
                  )
```

## 输出

输出的结果主要包括以下两个部分，如下：

- **duplicated_genotype**    

| IND1 | IND1 | 1    |
| ---- | ---- | ---- |
| IND2 | IND2 | 1    |
| IND3 | IND3 | 1    |
| IND4 | IND4 | 1    |

第一列和第二列为个体名称，第三列为重复的比例

- **pca_outlier** 

| Id     | Breed | Expeced_Breed |
| ------ | ----- | ------------- |
| IND100 | LL    | YY            |
| IND233 | DD    | YY            |
| IND91  | LL    | YY            |
| IND92  | LL    | YY            |
| IND93  | LL    | YY            |
| IND94  | LL    | YY            |

图A是进行品种分析前的品种记录，图B是进行品种分析后(可以理解为对错误的品种记录数据进行纠正)的品种记录

![PCA_blupADC](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210805034645.png)

## 参数

`geno_check` 函数中的许多参数均与 `geno_format`  函数中一致。故此，接下来我们将主要介绍 `geno_check` 函数中独有的参数[see more details](https://qsmei.netlify.app/post/blupadc/)). 

-   **1：selected_snps** 

进行基因型数据重复性检测时，所选用的SNP数目， `numeric` 类型. 默认 为 1000.

-   **2：overlap_threshold**

判定两个个体为重复的阈值, `numeric` 类型. 默认 为 0.95.

-   **3：duplication_check**

是否进行基因型数据重复性检测, `logical` 类型. 默认为 TRUE.

-   **4：breed_check**

是否进行品种分析, `logical` 类型. 默认为 FALSE.

-   **5：ind_breed**

个体的品种记录数据，`data.frame` 类型.  

`ind_breed`  数据格式如下所示:

| Id   | Breed |
| ---- | ----- |
| IND1 | YY    |
| IND2 | YY    |
| IND3 | YY    |
| IND4 | YY    |
| IND5 | YY    |
| IND6 | YY    |


