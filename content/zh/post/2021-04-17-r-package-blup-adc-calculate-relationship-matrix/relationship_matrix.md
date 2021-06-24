---
title: 'R package:blupADC-功能5'
author: qsmei
date: '2021-04-18'
slug: relationship_matrix
categories:
  - Relationship matrix
tags: []
subtitle: ''
summary: '计算亲缘关系矩阵(A,G and H)'
authors: []
lastmod: '2021-04-18T16:36:39+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
math: true
---

{{<toc>}}



## 简述

🙉在动植物育种中，亲缘关系矩阵的构建是其中的关键步骤。在本章，我们将主要介绍如何利用`blupADC`中的`cal_kinship`函数完成各种亲缘关系矩阵的构建，包括：**加性亲缘关系矩阵**(系谱，基因组，一步法)及**显性亲缘关系矩阵**(系谱，基因组，一步法)等。此外，cal_kinship函数还能方便的计算各种类型的**近交系数**，包括：系谱近交系数，基因组近交系数(Homozygous,Digonal)及一步法近交系数(Digonal)。

## 示例

😾首先，我们还是通过一个小例子来看该函数的用法:

``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=data_hmp,          #provided hapmap data object
                kinship_type=c("G_A","G_D"),      #type of  kinship matrix
                dominance_type=c("genotypic"),    #type of dominance effect
                inbred_type=c("Homozygous"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

在构建基因组亲缘关系矩阵及一步法亲缘关系矩阵的时候，我们必须要事先提供基因型数据，这部分的参数与`genotype_data_format_conversion`函数中的参数用法一致。具体大家可参阅之前的介绍:[基因型数据间的格式转换](https://qsmei.netlify.app/zh/post/blupadc/)。

完成了基因型数据的提供后，我们可以通过以下几个参数来指定构建亲缘关系矩阵类型及近交系数的类型。



## 参数详解

### 💪基础参数

-   **参数1：kinship_type**

    指定构建亲缘关系矩阵的类型，`character`类型。可选关系矩阵类型：

    -   "G_A" :基因组加性亲缘关系矩阵"
    -   "G_Ainv" :基因组加性亲缘关系逆矩阵"
    -   "G_D" :基因组显性亲缘关系矩阵
    -   "G_Dinv" :基因组显性亲缘关系逆矩阵"
    -   "P_A" :系谱加性亲缘关系矩阵
    -   "P_Ainv" :系谱加性亲缘关系逆矩阵
    -   "P_D" :系谱显性亲缘关系矩阵
    -   "P_Dinv" :系谱显性亲缘关系逆矩阵
    -   "H_A" :一步法加性亲缘关系矩阵
    -   "H_Ainv" :一步法加性亲缘关系逆矩阵
    -   "H_D" :一步法显性亲缘关系矩阵
    -   "H_Dinv" :一步法显性亲缘关系逆矩阵

**Note**:如果计算系谱及一步法亲缘关系矩阵，必须要提供系谱数据。关于如何提供系谱数据，我们会在后面进行讲解。

- **参数2：dominance_type**

  指定计算的显性亲缘关系矩阵的类型，`character`类型，可选类型包括:

  -   "genotypic" : 按照($0-2pq$,$1-2pq$,$0-2pq$)方式编码方式构建显性亲缘关系矩阵
  -   "classical" :    按照($-2q^2$,$2pq$,$-2p^2$)方式编码方式构建显性亲缘关系矩阵

> 关于二者的区别，具体可阅读该文献：[On the Additive and Dominant Variance and Covariance of Individuals Within the Genomic Selection Scope](https://www.genetics.org/content/195/4/1223.short)

-   **参数3：inbred_type**

    指定计算的近交系数的类型，`character`类型。可选近交系数类型包括:

    -   "Homozygous" :根据纯合子位点计算

    -   "G_Diag" :G矩阵对角线-1

    -   "H_diag" :H矩阵对角线-1

    -   "Pedigree" :A矩阵对角线-1

-   **参数4：input_pedigree**

用户提供的系谱数据，`data.frame`或 `matrix`类型。具体的系谱数据格式可以参阅之前的介绍：[系谱追溯、重命名及纠错 ](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-pedigree/pedigree/)。

-   **参数5：pedigree_rename**

是否对系谱数据进行重命名,`logical`类型，默认为TRUE(对系谱进行重命名)。

-   **参数6：IND_geno_rename**

是否根据系谱的重命名结果对基因型数据中的个体进行重命名，`logical`类型，默认为FALSE(不进行重命名)。

-   **参数7：rename_to_origin**

将亲缘关系矩阵中重命名的个体号转换回原始的个体号，`logical`类型，默认为FALSE(不进行转换)。

-   **参数8：output_matrix_type**

输出亲缘关系矩阵的格式，`character`类型。可选参数包括：

1.  "col_all" :按照n\*n的格式输出亲缘关系矩阵

2.  "col_three" : 按照3列矩阵的格式输出亲缘关系矩阵，第1列和第2列为个体号，第3列为亲缘系数。DMU和BLUPf90软件均需提供这种格式的亲缘关系矩阵。形如：

    |      |      |       |
    | ---- | ---- | ----- |
    | 1001 | 1001 | 0.989 |
    | 1001 | 1002 | 0.421 |
    | 1001 | 1003 | 0.567 |

默认参数为 "col_three"

-   **参数9：output_matrix_path**

亲缘关系矩阵保存到本地的路径, `character`类型。

-   **参数10：output_matrix_name**

亲缘关系矩阵保存到本地的名称，`character`类型。

### 🦶进阶参数

-   **参数11：cpu_cores**

调用的cpu个数，`numeric`类型，默认为1。

-   **参数12：kinship_base**

是否按照基础群的方式构建基因组亲缘关系矩阵(p=q=0.5)，`logical`类型，默认为FALSE。

-   **参数13：kinship_trace**

是否按照矩阵迹和的方式对基因组亲缘关系矩阵进行标准化，`logical`类型，默认为FALSE。

-   **参数14：kinship_metafounder**

是否按照metafounder的方法计算一步法亲缘关系矩阵，`logical`类型，默认为FALSE。

-   **参数15：SSBLUP_omega**

构建一步法亲缘关系矩阵时G矩阵和A矩阵的比例，`numeric`类型，默认为0.05。

-   **参数16：gene_dropping**

是否使用 gene dropping 的方法构建系谱显性亲缘关系矩阵，`logical`类型，默认为FALSE。

-   **参数17：gene_dropping_iteration**

gene dropping方法的迭代次数，`numeric`类型，默认为1000。

-   **参数18：memory_save**

是否使用省内存的方式进行上述所有的计算，`logical`类型，默认为FALSE。该方法非常节省内存，但是会极大的占据本地存储空间。