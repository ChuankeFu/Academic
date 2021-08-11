---
title: 'R package:blupADC-功能4'
author: qsmei
date: '2021-04-17'
slug: Pedigree
categories:
  - pedigree
tags: []
subtitle: ''
summary: '系谱数据追溯与重命名'
authors: []
lastmod: '2021-04-16T09:32:43+08:00'
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

🦄大家好,这一节主要给大家讲述的是如何使用`blupADC`中的函数来进行系谱数据处理。`blupADC`提供的`trace_pedigree`函数，可以帮助我们非常方便的对系谱数据进行多种处理:包括系谱重命名、系谱追溯及系谱纠错等。

## 示例

💖同样的，我们还是用一个小例子来简单的看下该函数的用法


```r
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=origin_pedigree,   #provided pedigree data object
                output_pedigree_tree=TRUE  # output pedigree tree
                )                 

```

我们可以通过`str`查看函数的输出结果，如下所示:


```r
str(pedigree_result)
## List of 5
##  $ ped          : chr [1:15945, 1:3] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Offspring" "Sire" "Dam"
##  $ rename_ped   :'data.frame':	15945 obs. of  6 variables:
##   ..$ Offspring   : chr [1:15945] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..$ Generation  : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Offspring_Id: int [1:15945] 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ Sire_Id     : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Dam_Id      : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Order       : int [1:15945] 1 2 3 4 5 6 7 8 9 10 ...
##  $ pedigree_tree: chr [1:15945, 1:15] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:15] "Offspring" "Sire" "Dam" "SireSire" ...
##  $ error_id_set :List of 4
##   ..$ error_duplicated_id: chr [1:24] "DD19119705" "DD20488904" "DD20153801" "DD20376912" ...
##   ..$ error_sex_id: chr "DD13006182"
##   ..$ error_breed_id: NULL
##   ..$ error_birth_date_id: NULL
```

可以很明显的看到,输出结果包括以下几个部分:

-   **ped:** 经过处理后(纠错、追溯等)的原始系谱数据且未进行重命名
-   **rename_ped:** 经过处理(纠错、追溯等)且重命名的系谱数据。第1列为原始系谱ID,第2列为个体在系谱中的代数，第3-5列为重命名后的系谱数据
-   **pedigree_tree**:个体的系谱树矩阵。可以通过设置 pedigree_tree_depth指定系谱树包含的代数，默认不输出系谱树(节省时间)
-   **error_id_set**: 系谱记录错误个体数据集。根据错误的种类可以分为以下4个子集
    -   `error_duplicated_id`:  相同的个体，父母却不相同
    -   `error_sex_id`: 个体同时出现在父亲列和母亲列
    -   `error_breed_id`: 个体和父母的品种不相同(仅针对特殊格式)
    -   `error_birth_date_id`: 个体的出生日期要早于父母的出生日期(需在系谱的第四列提供个体的出生日期)

下面，我们将具体讲解`trace_pedigree`函数中各种参数的含义:

## 参数详解

### 💥基础参数

-   **参数1：input_pedigree**

用户提供的系谱数据，`data.frame`或 `matrix`类型。

💌用户提供系谱数据需为以下几种格式中的一种，包括：

-   3列系谱格式:


|Offspring  |Sire       |Dam        |
|:----------|:----------|:----------|
|DD19575312 |DD18768902 |DD16376015 |
|DD19513112 |DD18768902 |DD17111017 |
|DD20348012 |DD19132207 |DD19234510 |
|DD20361110 |DD19331001 |DD19293112 |
|DD20471212 |DD19331001 |DD19320808 |
|DD20564818 |DD19331001 |DD19311009 |

-   4列系谱格式:


|Offspring  |Sire       |Dam        | Birth_Date|
|:----------|:----------|:----------|----------:|
|DD19575312 |DD18768902 |DD16376015 |   20200101|
|DD19513112 |DD18768902 |DD17111017 |   20200102|
|DD20348012 |DD19132207 |DD19234510 |   20200103|
|DD20361110 |DD19331001 |DD19293112 |   20200104|
|DD20471212 |DD19331001 |DD19320808 |   20200105|
|DD20564818 |DD19331001 |DD19311009 |   20200106|

-   多列系谱格式:


|Offspring  |Sire       |Dam        |SireSire   |DamSire    |SireSireSire |
|:----------|:----------|:----------|:----------|:----------|:------------|
|DD20231905 |DD19581002 |DD18750810 |DD16785512 |DD15507717 |DD14008512   |
|DD20458701 |DD19564302 |DD18925809 |DD15349017 |DD15245411 |DD16771212   |
|DD20324707 |DD19232903 |DD18571012 |DD16794714 |DD16744412 |DD16714516   |
|DD19288609 |DD18713408 |DD18552609 |DD15180015 |DD15479214 |DD15243711   |
|DD16222012 |DD15145005 |DD15378812 |DD14110014 |DD15501518 |DD15206217   |
|DD17684713 |DD16672107 |DD15122311 |DD15505715 |DD15347415 |DD16383111   |

**Note**:需要注意的是，当系谱为多列时，系谱的列名需要标注为特殊形式,e.g. SireSire:父亲的父亲, SirSireSire:父亲的父亲的父亲

系谱数据中缺失值可以设置为: **NA或0**。

同样的，为了便于用户操作，用户还可以直接提供本地系谱数据的路径和名称

-   **参数2：input_pedigree_path**

本地系谱数据的路径,`character`类型。

-   **参数3：input_pedigree_name**

本地系谱数据的名称，`character`类型。

-   **参数4：pedigree_format_conversion**

是否将提供的多列系谱转换到3列，logical类型。如果用户提供的系谱数据包含多列，那么用户必须设置`pedigree_format_conversion=TRUE` 。

-   **参数5：output_pedigree_type**

系谱输出的格式，`character`类型。可选格式包括: BLUPF90, DMU 及 Normal(未重命名)。

-   **参数6：output_pedigree_path**

系谱输出到本地的路径，`character`类型。

-   **参数7：output_pedigree_name**

系谱输出到本地的名称，`character`类型。

### 💨进阶参数

-   **参数8：dup_error_check**

检查相同个体的父母却不相同的错误，`logical`类型，默认为TRUE。

-   **参数9：sex_error_check**

检查个体同时出现在父亲列和母亲列的错误，`logical`类型，默认为TRUE。

-   **参数10：breed_error_check**

检查个体品种与父母品种不同的错误，`logical`类型，默认为FALSE。

-   **参数11：birth_date_error_check**

检查个体出生日期早于父母的错误，`logical`类型，默认为FALSE。

-   **参数12：trace_id**

追溯系谱记录的个体号，`character`类型，默认为`NULL`(追溯系谱中所有的个体)。

-   **参数13：trace_offspring**

是否追溯子代，`logical`类型，默认为FALSE。

-   **参数14：trace_generation**

追溯的代数，`numeric`类型，默认为5。

-   **参数15：trace_birth_date**

追溯出生日期晚于指定日期的个体，`character`类型。

-   **参数16：output_pedigree_tree**

是否输出系谱树，`logical`类型，默认为FALSE。

-   **参数17：pedigree_tree_depth**

系谱树的深度(系谱代数)，`numeric`类型，默认为3。
