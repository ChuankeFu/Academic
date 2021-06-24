---
title: 'R package:blupADC-功能6'
author: qsmei
date: '2021-04-20'
slug: run_dmu
categories:
  - DMU
tags: []
subtitle: ''
summary: '与DMU交互进行遗传评估'
authors: []
lastmod: '2021-04-20T18:31:18+08:00'
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

🤠在讲述完各种各样的数据预处理方法后，我们正式进入到育种数据的分析层面。在目前的动植物育种领域，主要的育种软件包括但不限于以下两种：**DMU**和**BLUPf90**。这两款软件均是于上世纪80-90年代开发的，并且一直处于维护中。截至目前，两款软件的引用次数均已接近千次(实际可能更多), 这也足见这两款软件的认可度。

但是，这两款软件均存在一个共同的缺点，就是使用起来较为麻烦(需要提供准备好的参数文件)。笔者当时学习参数文件的配置时，前前后后花费了近一个月的时间，足以见这两款软件的不友好性🥶。

为此，我们在R中编写了相应的函数，使得用户可以轻松的完成两款软件参数文件的配置及对应的数据分析。本章我们主要讲述如何通过`BLUP_ADC`中的`run_DMU`函数，在R中调用**DMU**软件并完成数据分析。在下一章，我们将会讲述如何在R中调用**BLUPf90**软件，并完成数相应的据分析。

**👉 Note:  为了方便用户使用， `blupADC` 已经封装了DMU中的几个基本模块(`dmu1`,`dmuai`, and `dmu5`), 更多的模块可以从DMU官网进行下载([DMU下载网站](https://dmu.ghpc.au.dk/dmu/)).** 

**如果您想将DMU用作商业用途，请务必联系 DMU的作者！！！** 

## 示例

### **单性状模型-系谱**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1"),                           #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="PBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path="/root"                   #结果输出路径
        )
```

### **单性状模型-GBLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1"),                           #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="GBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="G_Ainv_col_three.txt",    #亲缘关系文件名
        output_result_path="/root"                   #结果输出路径
        )
```

### **单性状模型-Single-step(一步法)**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1"),                           #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="SSBLUP_A",                   #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name=c("pedigree.txt","G_A_col_three.txt"),    #亲缘关系文件名
        output_result_path="/root"                   #结果输出路径
        )
```

细心的同学应该能发现，我们仅需改变 `analysis_model` 及 `relationship_name` 这两个参数即可完成 系谱、GBLUP及SSBLUP的分析，极大的简化了我们的分析步骤(PS: G_Ainv_col_three.txt 和 G_A\_col_three.txt 文件 均可通过 `cal_kinship`函数得到，具体可见：XXXX)。

上面我们介绍的都是单性状模型(**只包括了一个目标性状**)，而在实际育种分析中，多性状模型也是非常常见。在上面代码的基础上稍作修改，我们就能够非常方便的完成多性状模型的运算，如下：

### **多性状模型-系谱**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1","Trait2"),                           #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter"),c("Id")),       #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="PBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path="/root"                   #结果输出路径
        )
```

接下来，我们将对`run_DMU`函数中的参数一一进行讲解。

## 参数详解

### 🤡基础参数

-   **参数1：phe_path** 

本地表型数据文件的路径，`character`类型。

-   **参数2：phe_name** 

本地表型数据文件的名称，`character`类型。

-   **参数3：phe_col_names**

表型数据的列名，`character`类型。

-   **参数4：integer_n**

整型变量的数目，`numeric`类型。

-   **参数5：genetic_effect_name**

遗传效应的名称(一般为个体号)，`character`类型。

-   **参数6：target_trait_name** 

目标性状的名称，`character`类型。

通过添加多个性状的名称，我们即可完成多性状模型的分析，e.g. `target_trait_name=c("Trait1","Trait2")` 即可完成 `Trait1` 和 `Trait2`的双性状模型

-   **参数7：fixed_effect_name**

目标性状的固定效应名称，`list`类型。在多性状模型中，`fixed_effect_name`为每个性状的固定效应名称向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

e.g. 第一个性状的固定效应名称为： `c("Sex","Herd_Year_Season")`

第二个性状的固定效应名称为：`c("Sex")`

那么`fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Sex"))`

-   **参数8：random_effect_name**

目标性状的随机效应名称，`list`类型。在多性状模型中，`random_effect_name`为每个性状的随机效应名称向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

e.g. 第一个性状的随机效应名称为： `c("Id","Litter")`

第二个性状的随机效应名称为：`c("Id")`

那么`random_effect_name=list(c("Id","Litter"),c("Id"))`

-   **参数9：covariate_effect_name**

目标性状的协变量效应名称，`list`类型。在多性状模型中，`random_effect_name`为每个性状的协变量效应名称向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

e.g. 第一个性状的协变量效应名称为： `c("Age")`

第二个性状的协变量效应名称为：`NULL` (**意味着无协变量**)

那么`covariate_effect_name=list(c("Age"),NULL)`

- **参数10：analysis_model**

  遗传评估的分析模型，`character`类型。可选模型包括：

  -   `"PBLUP_A"` : 系谱-加性效应模型
  -   `"GBLUP_A"` :基因组-加性效应模型
  -   `"GBLUP_AD"` :基因组-加性-显性效应模型
  -   `"SSBLUP_A"` :一步法加性效应模型
  -   `"User_define"`: 用户自定义模型

- **参数11：dmu_module**

  DMU分析时使用的模块，`character`类型。可选模块包括：

  -   `"dmuai"`

  -   `"dmu4"`

  -   `"dmu5"`

- **参数12：DMU_software_path**

DMU软件在本地的路径，`character`类型。

-   **参数13：relationship_path**

提供的亲缘关系文件的路径，`character`类型。

-   **参数14：relationship_name**

提供的亲缘关系文件的名称，`character`类型。

针对不同的遗传评估分析模型，我们需要提供不同类型的亲缘关系文件。

针对 "PBLUP_A"模型，我们需要提供系谱文件,e.g. `relationship_name="pedigree.txt"` ；

针对`"GBLUP_A"` 或 `"GBLUP_AD"`模型，我们需要提供3列格式的基因组亲缘关系矩阵的逆矩阵文件, e.g. `relationship_name=c("G_A_inv_matrix.txt","G_D_inv_matrix.txt")`；

针对 `"SSBLUP_A"`模型, 我们需要同时提供系谱文件及3列格式的基因组亲缘关系矩阵的文件, e.g. `relationship_name=c("pedigree.txt","G_A_matrix.txt")` 。

-   **参数15：output_result_path**

DMU运行结果的保存路径，`character`类型。

-   **参数16：output_ebv_path**

输出的育种值、残差及校正表型文件的保存路径，`character`类型。

-   **参数17：output_ebv_name**

输出的育种值、残差及校正表型文件的名称，`character`类型。

### 👺进阶参数

-   **provided_effect_file_path**

性状效应记录文件的路径，`character`类型。为了方便用户输入固定效应、随机效应及协变量效应，用户可以在本地直接提供相应的文件，格式如下所示：

| V1     | V2   | V3   | V4               | V5   | V6   | V7     | V8   | V9   |
| ------ | ---- | ---- | ---------------- | ---- | ---- | ------ | ---- | ---- |
| Trait1 | \*   | Sex  | Herd_Year_Season | \*   | Id   | Litter | \*   | \*   |
| Trait2 | \*   | Sex  | \*               | Id   | \*   | Age    | \*   |      |

每类效应都用\**隔开，每一列的间隔均为制表符间隔。每个性状所在的行均有4个，第1-2个\*之间的效应代表的是固定效应，第2-3个\** *之间的效应代表的是随机效应，第3-4个\** *之间的效应代表的是协变量效应。*

-   **参数19：provided_effect_file_name**

性状效应记录文件的名称，`character`类型。

-   **参数20：provided_DIR_file_path**

用户自己提供的DIR文件的路径，`character`类型。

-   **参数21：provided_DIR_file_name**

用户自己提供的DIR文件的名称，`character`类型。

-   **参数22：included_permanent_effect**

是否进行永久环境效应分析，`logical`类型，默认为FASLE。

-   **参数23：dmu_algorithm_code**

DMU模块内的算法代码，`numeric`类型。

-   **参数24：provided_prior_file_path**

用户提供的方差组分-PRIOR文件的路径，`character`类型。

-   **参数25：provided_prior_file_name**

用户提供的方差组分-PRIOR文件的名称，`character`类型。

-   **参数26：missing_value**

表型数据的缺失值，`numeric`类型，默认为 -9999。

-   **参数27：iteration_criteria**

方差组分迭代收敛的标准，`numeric`类型，默认为 1.0e-7。

-   **参数28：genetic_effect_number**

SOL文件中，遗传效应所代表的数字，`numeric`类型，默认为4。

-   **参数29：residual_cov_trait**

残差协方差约束为0的性状，`list`类型。e.g. 将Trait1和Trait2的残差协方差约束为0，`residual_cov_trait=list(c("Trait1","Trait2"))`

-   **参数30：selected_id**

只输出这部分个体的育种值、残差及校正表型，`character`类型。

-   **参数31：cal_debv**

是否计算DEBV，`logical`类型，默认为FALSE。

-   **参数32：debv_pedigree_path**

计算DEBV时，提供的系谱文件的路径，`character`类型。

-   **参数33：debv_pedigree_name**

计算DEBV时，提供的系谱文件的名称，`character`类型。