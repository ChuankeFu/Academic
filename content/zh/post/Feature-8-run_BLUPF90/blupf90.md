---
title: 'R package:blupADC-功能8'
author: qsmei
date: '2021-04-21'
slug: blupf90
categories:
  - BLUPf90
tags: []
subtitle: ''
summary: '利用BLUPF90进行遗传评估'
authors: []
lastmod: '2021-04-21T15:47:39+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

{{< toc >}} 

## 简述

👻在前面的章节，我们已经讲述了如何在**R**中调用**DMU**软件并完成相应的分析。本章，我们将讲述如何通过`BLUP_ADC`中的`run_BLUPF90`函数，在**R**中调用**BLUPF90**软件并完成数据分析。为了方便用户的使用，我们已经尽可能地将 `run_BLUPF90`函数中的参数 和 `run_DMU`函数中的参数进行了统一。

**👉 Note:  为了方便用户使用， `blupADC` 已经封装了BLUPF90中的几个基本模块(`renumf90`, `remlf90`, `airemlf90`, 和 `blupf90`), 更多的模块可以从BLUPF90官网进行下载([BLUPF90下载网站](http://nce.ads.uga.edu/html/projects/programs/)).** 

**如果您想将BLUPF90用作商业用途，请务必联系 BLUPF90的作者！！！**

接下来，我们还是用几个简单的例子看看该函数的用法:

## 示例

### **单性状模型-系谱**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")   #  示例文件的路径
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # 表型数据的列名(ps.表型文件无列名)
        target_trait_name=list(c("Trait1")),                     #性状名称
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        analysis_model="PBLUP_A",                    #遗传评估模型
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

### **单性状模型-GBLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")   #  示例文件的路径
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # 表型数据的列名(ps.表型文件无列名)
        target_trait_name=list(c("Trait1")),                     #性状名称
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        analysis_model="GBLUP_A",                    #遗传评估模型
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="blupf90_genumeric",       #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

### **单性状模型-Single-step(一步法)**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")   #  示例文件的路径
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # 表型数据的列名(ps.表型文件无列名)
        target_trait_name=list(c("Trait1")),                     #性状名称
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        analysis_model="SSBLUP_A",                   #遗传评估模型
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name=c("pedigree.txt","blupf90_genumeric"),       #亲缘关系文件名
        output_result_path=getwd()                  #结果输出路径
        )  
```

同样的，与DMU使用类似，我们仅需改变 `analysis_model` 及 `relationship_name` 这两个参数即可完成 系谱、GBLUP及SSBLUP的分析(PS: blupf90_genumeric 文件 均可通过 `genotype_data_format_conversion`函数得到 [了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-qc-imputaion/qc_imputation/))。

### **多性状模型-系谱**

上面我们介绍的都是单性状模型(**只包括了一个目标性状**)。与上一节的介绍的`run_DMU`函数类似，如果我们想完成双性状模型的计算，只需要在上面的脚本的基础上稍作修改就能实现目的，具体代码如下：

``` {.R}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")   #  示例文件的路径
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # 表型数据的列名(ps.表型文件无列名)
        target_trait_name=list(c("Trait1"),c("Trait2")),                     #性状名称
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter"),c("Id")),               #随机效应名称
        covariate_effect_name=list(NULL,"Age"),                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        analysis_model="PBLUP_A",                    #遗传评估模型
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        ) 
```



## 参数详解

接下来，我们将对`run_BLUPF90` 中特有的参数进行讲解，剩余的参数大家可移步[DMU软件的交互使用](https://qsmei.netlify.app/zh/post/2021-04-20-r-package-blup-adc-run-dmu/run_dmu/)进行查看，相同参数的用法和含义均是一模一样的。

### 💫特有参数

- **参数1：blupf90_algorithm**

  BLPUF90进行方差组分估计时选用的算法，`character`类型。可选算法包括：

  -   `"AI_REML"`
  -   `"EM_REML"`
  -   `"BLUP"` : 无需估计方差组分，根据提供的先验直接求解混合线性模型方程组。

默认算法为："AI_REML"

-   **参数2：provided_blupf90_prior_file_path**

用户提供的BLUPF90格式的方差组分-PRIOR文件的路径，`character`类型。

**Note**:需要注意的一点是，**BLUPF90**格式的PRIOR文件和**DMU**格式的PRIOR文件是不相同的。关于二者的差异，以后有时间会再出一篇文章进行讲解，这里就不再赘述了。

-   **参数3：provided_blupf90_prior_file_name**

用户提供的BLUPF90格式的方差组分-PRIOR文件的名称，`character`类型。

-   **参数4：provided_blupf90_prior_effect_name**

用户提供的PRIOR文件中，与方差组分对应的各个随机效应名称，`character`类型。

-   **参数5：BLUPf90_software_path**

BLUPF90软件在本地的路径，`character`类型。

