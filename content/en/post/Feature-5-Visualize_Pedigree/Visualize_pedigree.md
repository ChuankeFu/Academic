---
title: 'R package:blupADC-Feature 5'
author: qsmei
date: '2021-04-18'
slug: Pedigree
categories:
  - Pedigree
tags: []
subtitle: ''
summary: 'Pedigree visualization '
authors: []
lastmod: '2021-04-16T09:32:43+09:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
show_related:
  post: true
---

{{<toc>}} 

## Overview

🦄  An intuitive and clear structure of pedigree could help breeders to make better decision in breeding plan. By  applying  `ggped` function, user can plot the structure of pedigree in an easy way.

## Example

### Plot whole pedigree


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2
                ) 
```

![image-20210708153839657](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708153843.png)

### Plot subset of whole pedigree


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2,
    			trace_id=c("121")             #provided subset-id
                )                   
```

![image-20210708153706707](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708153708.png)

### Plot subset of whole pedigree (with sibs)


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2,
    			trace_id=c("121"),
    			trace_sibs=TRUE   #whether plot the sibs of subset-id  
                )                   
```

![image-20210708161211022](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708161212.png)

### Change the style of picture 

User can  change the style of pedigree by modifying the  `shape_type` parameter.   Default `shape_type` is 4.

![shape_type](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210805002017.png)

## Output

The output of  `ggped`  is the  object of `ggplot`, user can plot the pedigree structure or save it directly. 

## Parameter

### 💥Basic

-   **1：input_pedigree**

User-provided pedigree data, `data.frame ` or   `matrix` class.

💌The format of provided pedigree data should be 3 columns format:


|Offspring  |Sire       |Dam        |
|:----------|:----------|:----------|
|DD19575312 |DD18768902 |DD16376015 |
|DD19513112 |DD18768902 |DD17111017 |
|DD20348012 |DD19132207 |DD19234510 |
|DD20361110 |DD19331001 |DD19293112 |
|DD20471212 |DD19331001 |DD19320808 |
|DD20564818 |DD19331001 |DD19311009 |

-   **2:  trace_id** 

Individuals set in tracing pedigree, `character` class. Default is `NULL` (plot whole individuals in pedigree)

-   **3:  trace_sibs** 

Whether tracing the sibs of  individuals set , `logical` class. Default is `FALSE` .

-   **4:  ind_sex**  

Sex record of individuals , `data.frame` class.   

The format of this data is showing as follow: 	


| Individual | Sex    |
| :--------- | :----- |
| 101        | Male   |
| 102        | Female |
| 103        | Male   |
| 104        | Female |

For individual who doesn't have the record of sex,  the sex of this individual would be set as Male. 

-   **5：plot_family**

Whether showing family structure when plotting the pedigree, `logical` class. Default is `FALSE` .

-   **6：shape_type**

The shape type when plotting pedigree ，`numeric` class. Default is 4.

### 💨Advanced

-   **7:  shape_size**     

The shape size of picture, `numeric` class. Default is `8` .

-   **8：ind_text_size**

The size of individual name, `numeric` class. Default is `4` .

-   **9：ind_text_vjust**

The vjust of individual name, `numeric` class. Default is `3` .

