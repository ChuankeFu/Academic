---
title: 'R package:blupADC-功能7'
author: qsmei
date: '2021-04-20'
slug: run_dmu
categories:
  - DMU
tags: []
subtitle: ''
summary: '利用DMU进行遗传评估'
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
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                           #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="PBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

### **单性状模型-GBLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="GBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="G_Ainv_col_three.txt",    #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

### **单性状模型-Single-step(一步法)**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="SSBLUP_A",                   #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name=c("pedigree.txt","G_A_col_three.txt"),    #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

细心的同学应该能发现，我们仅需改变 `analysis_model` 及 `relationship_name` 这两个参数即可完成 系谱、GBLUP及SSBLUP的分析，极大的简化了我们的分析步骤(PS: G_Ainv_col_three.txt 和 G_A\_col_three.txt 文件 均可通过 `cal_kinship`函数得到 [了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-calculate-relationship-matrix/relationship_matrix/))。

上面我们介绍的都是单性状模型(**只包括了一个目标性状**)，而在实际育种分析中，多性状模型也是非常常见。在上面代码的基础上稍作修改，我们就能够非常方便的完成多性状模型的运算，如下：

### **多性状模型-系谱**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1"),c("Trait2")),                               #性状名称 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter"),c("Id")),       #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        integer_n=5,                                 #整型变量数
        analysis_model="PBLUP_A",                    #遗传评估模型
        dmu_module="dmuai",                          #方差组分估计使用的DMU模块
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path=getwd()                   #结果输出路径
        )
```

### 单性状模型-系谱 (用户提供方差组分先验文件)

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
run_DMU(phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter",
                         "Trait1","Trait2","Age"),               # colnames of phenotype
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #遗传效应名称 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        provided_prior_file_path=data_path,          #path of user-provided prior file
        provided_prior_file_name="PAROUT",           #name of user-provided prior file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                   # output path 
        )
```

### 单性状模型-系谱 (包含母性效应)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Herd","B_month","D_age","Litter","Sex","HY","ID","DAM","L_Dam",
		         "W_birth","W_2mth","W_4mth","G_0_2","G_0_4","G_2_4"), # colnames of phenotype
        target_trait_name=list(c("W_birth")),                           #trait name 
        fixed_effect_name=list(c("B_month","D_age","Litter","Sex","HY")),     #fixed effect name
        random_effect_name=list(c("ID","L_Dam")),    #random effect name
        maternal_effect_name=list(c("DAM")),
        genetic_effect_name="ID",                    #遗传效应名称  
        covariate_effect_name=NULL,                  #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="maternal_data",                    #name of phenotype file
        integer_n=9,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="maternal_pedigree",       #name of relationship file 
        output_result_path=getwd()                   # output path 
        )
```

### 单性状模型-系谱 (包含永久环境效应)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("id","year_grp","breed","time","t_dato",
                        "age","L1","L2","L3","gh"),           # colnames of phenotype
        target_trait_name=list(c("gh")),                      #trait name 
        fixed_effect_name=list(c("year_grp","breed","time")), #fixed effect name
        random_effect_name=list(c("id","t_dato")),            #random effect name
        covariate_effect_name=list(c("age")),                 #covariate effect name	
        genetic_effect_name="id",                    #遗传效应名称  
        included_permanent_effect=list(c(TRUE)),     #whether include permant effect
        phe_path=data_path,                          #path of phenotype file
        phe_name="rr_data",                          #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                   # output path 
        )
```

### 单性状模型-系谱 ( 包含随机回归效应)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("id","year_grp","breed","time","t_dato",
                        "age","L1","L2","L3","gh"),           # colnames of phenotype
        target_trait_name=list(c("gh")),                      #trait name 
        fixed_effect_name=list(c("year_grp","breed","time")), #fixed effect name
        random_effect_name=list(c("id","t_dato")),            #random effect name
        covariate_effect_name=list(c("age")),                 #covariate effect name	
        genetic_effect_name="id",                             #遗传效应名称 
        included_permanent_effect=list(c(TRUE)),     #whether include permant effect
        random_regression_effect_name=list(c("L1&id&pe_effect","L2&id&pe_effect")), #random regression effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="rr_data",                          #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                   # output path 
        )
```

### 单性状模型-系谱( 包含 社会遗传效应) 

用户提供的表型文件不需要包含 最大群体大小相关的列

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Group","Sex","Phe"), # colnames of phenotype
        target_trait_name=list(c("Phe")),          #trait name 
        fixed_effect_name=list(c("Sex")),          #fixed effect name
        random_effect_name=list(c("Id","Group")),  #random effect name
        covariate_effect_name=NULL,                #covariate effect name		
        genetic_effect_name="Id",                  #遗传效应名称   
        include_social_effect=list(c(TRUE)),   
        group_effect_name="Group",
        phe_path=data_path,                          #path of phenotype file
        phe_name="raw_social_data",                  #name of phenotype file
        integer_n=3,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="socail_pedigree",         #name of relationship file 
        output_result_path=getwd()  # output path 
        )
```

### 单性状模型-系谱( 包含 社会遗传效应) 

用户提供的表型文件需要包含 最大群体大小相关的列

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  示例文件的路径
  
run_DMU(phe_col_names=c("Id","Group","Sex","Gr_id1","Gr_id2","Gr_id3","Gr_id4","Gr_id5",                         
                        "Phe","Status_Gr_id1","Status_Gr_id2","Status_Gr_id3","Status_Gr_id4","Status_Gr_id5"),# colnames of phenotype
	target_trait_name=list(c("Phe")),           #trait name 
	fixed_effect_name=list(c("Sex")),           #fixed effect name
	random_effect_name=list(c("Id","Group")),   #random effect name
	covariate_effect_name=NULL,
	genetic_effect_name="Id",		           #遗传效应名称 
	include_social_effect=list(c(TRUE)),       #whether include social genetic effect 
	integer_group_names=c("Gr_id1","Gr_id2","Gr_id3","Gr_id4","Gr_id5"),  #integer variable name of max group size    
        real_group_names= c("Status_Gr_id1","Status_Gr_id2","Status_Gr_id3","Status_Gr_id4","Status_Gr_id5"), #real variable name of max group size
        phe_path=data_path,                          #path of phenotype file
        phe_name="social_data",                      #name of phenotype file
        integer_n=8,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="socail_pedigree",         #name of relationship file 
        output_result_path=getwd()  # output path 
		)
```

我们将对`run_DMU`函数中的参数一一进行讲解。

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

目标性状的名称，`list`类型。 每个列表均代表一个性状。

通过添加多个性状的名称，我们即可完成多性状模型的分析，e.g. `target_trait_name=list(c("Trait1"),c("Trait2"))` 即可完成 `Trait1` 和 `Trait2`的双性状模型

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

那么`covariate_effect_name=list(c("Age"),NULL) `

-   **参数10：maternal_effect_name**

母性效应名称(一般为母亲名称), `list` 类型.  

在多性状模型中，`maternal_effect_name`为每个性状的母性效应名称向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`maternal_effect_name=list(c(NULL),c("Dam"))`

-   **参数11：random_regression_effect_name**

随机回归效应名称, `list` 类型.  

在多性状模型中，`random_regression_effect_name`为每个性状的随机回归效应名称向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`random_regression_effect_name=list(c("L1&id&pe_effect","L2&id&pe_effect"),c("L1&id&pe_effect","L2&id&pe_effect"))`    

在每个列表中,    `&`  左边 代表的是多项式系数名称,   `&`  右边 代表的是嵌套在多项式里的相应的随机效应名称或固定效应名称。 如果用户想将 永久环境效应也嵌套在多项式里，`&`  右边 代表的随机效应名称应设置为 "pe_effect"，并且需要设置  included_permanent_effect 参数为 TRUE。

-   **参数12: included_permanent_effect**

是否包括永久环境效应在分析中,`list` 类型.  

在多性状模型中，`included_permanent_effect`为每个逻辑向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`included_permanent_effect=list(c(TRUE),c(TRUE))` 

-   **参数13：include_social_effect**   

是否包括社会遗传效应在分析中,`list` 类型.  

在多性状模型中，`include_social_effect`为每个逻辑向量组成的列表结构，性状的顺序需与`target_trait_name`一一对应。

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`include_social_effect=list(c(TRUE),c(TRUE))` 

-   **参数14：group_effect_name**   

Group效应的名称在社会遗传效应分析中， `character` 类型。

当用户提供的表型数据中不包含最大群体大小相关的列时，用户需要提供 group_effect_name 参数。 当用户提供了 Group效应的名称后， 软件将会自动生成包含 最大群体大小相关的列的表型并进行后续的社会遗传分析。

-   **参数15：integer_group_names**     

最大群体大小相关的整型列的变量名称,  `character` 类型。 

当用户提供的表型数据中包含最大群体大小相关的列时, 用户需要指定 最大群体大小相关的整型列的变量名称。

-   **参数16：real_group_names**    

最大群体大小相关的实型列的变量名称,  `character` 类型。 

当用户提供的表型数据中包含最大群体大小相关的列时, 用户需要指定 最大群体大小相关的实型列的变量名称。

- **参数17：analysis_model**

  遗传评估的分析模型，`character`类型。可选模型包括：

  -   `"PBLUP_A"` : 系谱-加性效应模型
  -   `"GBLUP_A"` :基因组-加性效应模型
  -   `"GBLUP_AD"` :基因组-加性-显性效应模型
  -   `"SSBLUP_A"` :一步法加性效应模型
  -   `"User_define"`: 用户自定义模型

- **参数18：dmu_module**

  DMU分析时使用的模块，`character`类型。可选模块包括：

  -   `"dmuai"`

  -   `"dmu4"`

  -   `"dmu5"`

- **参数19：DMU_software_path**

DMU软件在本地的路径，`character`类型。

-   **参数20：relationship_path**

提供的亲缘关系文件的路径，`character`类型。

-   **参数21：relationship_name**

提供的亲缘关系文件的名称，`character`类型。

针对不同的遗传评估分析模型，我们需要提供不同类型的亲缘关系文件。

针对 "PBLUP_A"模型，我们需要提供系谱文件,e.g. `relationship_name="pedigree.txt"` ；

针对`"GBLUP_A"` 或 `"GBLUP_AD"`模型，我们需要提供3列格式的基因组亲缘关系矩阵的逆矩阵文件, e.g. `relationship_name=c("G_A_inv_matrix.txt","G_D_inv_matrix.txt")`；

针对 `"SSBLUP_A"`模型, 我们需要同时提供系谱文件及3列格式的基因组亲缘关系矩阵的文件, e.g. `relationship_name=c("pedigree.txt","G_A_matrix.txt")` 。

-   **参数22：output_result_path**

DMU运行结果的保存路径，`character`类型。

-   **参数23：output_ebv_path**

输出的育种值、残差及校正表型文件的保存路径，`character`类型。

-   **参数24：output_ebv_name**

输出的育种值、残差及校正表型文件的名称，`character`类型。

### 👺进阶参数

-   **参数25: provided_effect_file_path**

性状效应记录文件的路径，`character`类型。为了方便用户输入固定效应、随机效应及协变量效应，用户可以在本地直接提供相应的文件，格式如下所示：

| V1     | V2   | V3   | V4               | V5   | V6   | V7     | V8   | V9   |
| ------ | ---- | ---- | ---------------- | ---- | ---- | ------ | ---- | ---- |
| Trait1 | \*   | Sex  | Herd_Year_Season | \*   | Id   | Litter | \*   | \*   |
| Trait2 | \*   | Sex  | \*               | Id   | \*   | Age    | \*   |      |

每类效应都用\**隔开，每一列的间隔均为制表符间隔。每个性状所在的行均有4个，第1-2个\*之间的效应代表的是固定效应，第2-3个\** *之间的效应代表的是随机效应，第3-4个\** *之间的效应代表的是协变量效应。*

-   **参数26：provided_effect_file_name**

性状效应记录文件的名称，`character`类型。

-   **参数27：provided_DIR_file_path**

用户自己提供的DIR文件的路径，`character`类型。

-   **参数28：provided_DIR_file_name**

用户自己提供的DIR文件的名称，`character`类型。

-   **参数29：included_permanent_effect**

是否进行永久环境效应分析，`logical`类型，默认为FASLE。

-   **参数30：dmu_algorithm_code**

DMU模块内的算法代码，`numeric`类型。

-   **参数31：provided_prior_file_path**

用户提供的方差组分-PRIOR文件的路径，`character`类型。

-   **参数32：provided_prior_file_name**

用户提供的方差组分-PRIOR文件的名称，`character`类型。

-   **参数33：missing_value**

表型数据的缺失值，`numeric`类型，默认为 -9999。

-   **参数34：iteration_criteria**

方差组分迭代收敛的标准，`numeric`类型，默认为 1.0e-7。

-   **参数35：genetic_effect_number**

SOL文件中，遗传效应所代表的数字，`numeric`类型，默认为4。

-   **参数36：residual_cov_trait**

残差协方差约束为0的性状，`list`类型。e.g. 将Trait1和Trait2的残差协方差约束为0，`residual_cov_trait=list(c("Trait1","Trait2"))`

-   **参数37：selected_id**

只输出这部分个体的育种值、残差及校正表型，`character`类型。

-   **参数38：cal_debv**

是否计算DEBV，`logical`类型，默认为FALSE。

-   **参数39：debv_pedigree_path**

计算DEBV时，提供的系谱文件的路径，`character`类型。

-   **参数40：debv_pedigree_name**

计算DEBV时，提供的系谱文件的名称，`character`类型。