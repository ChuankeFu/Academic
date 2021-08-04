---
title: 'R package:blupADC-简介'
author: qsmei
date: '2021-04-13'
slug: overView
categories:
  - blupADC
tags: []
subtitle: ''
summary: '简介'
authors: []
lastmod: '2021-04-13T22:32:36+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

{{<toc>}}<img src="https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210617165506.png" alt="logo-blupADC"  height="250" align="right" style="zoom:25%;" />

## 简介

`blupADC` 是一个专注于分析动植物育种中的系谱数据、基因型数据及遗传评估的工具。在设计该工具时，我们对数据处理时可能遇到的各种问题均进行了详细的考量(**ps.如果您有好的建议，请积极联系作者!**)。此外，为了提高分析效率， `blupADC` 可支持并行计算(通过`openMP` )，并且`blupADC` 中的核心函数均通过c++(`Rcpp` and `RcppArmadillo `) 进行编写。

`blupADC`提供了许多有用的功能在整个动植物育种的流程中，包括 系谱分析(系谱追溯、重命名及纠错)，基因型数据格式转换(支持**Hapmap, Plink, BLUPF90, Numeric 及VCF** 格式)，基因型数据的质控填充，亲缘关系矩阵的构建(**系谱，基因组及一步法亲缘关系矩阵**)以及遗传评估（仅需几行代码即可通过DMU和BLUPF90完成遗传评估）。

最后，为了方进一步方便用户的使用(尤其是编程基础弱的用户)，我们创建了一个免费的在线网站。绝大部分的`blupADC` 的功能均可通过在网站上实现，用户只需上传、点击及下载即可完成整套的分析流程。但是，网站的一个缺点就是，不能处理大数据，请大家合理选择！

😊 祝好运 ! 

## 开始

### 🙊安装

 安装`blupADC` 之前，用户首先需要安装如下3个包：`Rcpp`, `RcppArmadillo` and `data.table`.

```R
install.packages(c("Rcpp", "RcppArmadillo","data.table"))
```

**👉 Note:  在 DMU 和 BLUPF90的分析中，我们通常需要提前下载好 DMU 软件 ([DMU下载网站](https://dmu.ghpc.au.dk/dmu/))  和 BLUPF90软件 ([BLUPF90下载网站](http://nce.ads.uga.edu/html/projects/programs/))。为了方便用户使用，我们已经将两款软件中基础模块封装进了 `blupADC`，请大家合理使用。**

**如果您想将DMU和BLUPF90用作商业用途，请务必联系 DMU 和 BLUPF90的作者！！！** 

#### 在 Linux 上 安装 blupADC

```R
packageurl <- "https://github.com/TXiang-lab/blupADC/raw/main/blupADC_1.0.1_linux.tar.gz"
install.packages(packageurl,repos=NULL,method="libcurl")
```

对于中国用户来说，我们推荐使用如下代码进行安装（**安装速度更快**）：

```R
packageurl <- "https://gitee.com/qsmei/blup-adc/attach_files/751023/download/blupADC_1.0.1_linux.tar.gz"
install.packages(packageurl,repos=NULL,method="libcurl")
```

#### 在 Windows 上 安装 blupADC

```R
packageurl <- "https://github.com/TXiang-lab/blupADC/raw/main/blupADC_1.0.1.zip"
install.packages(packageurl,repos=NULL)
```

对于中国用户来说，我们推荐使用如下代码进行安装（**安装速度更快**）：

```R
packageurl <- "https://gitee.com/qsmei/blup-adc/attach_files/751003/download/blupADC_1.0.1.zip"
install.packages(packageurl,repos=NULL)
```

安装成功后，我们输入如下代码即可加载R包:

``` {.r}
library(blupADC)
```

### 🙊功能

-   功能 1. 基因型数据间的格式转换
-   功能 2.基因型数据的重复性检测
-   功能 3. 系谱追溯、重命名及纠错
-   功能 4. 基因型数据的质控与填充
-   功能 5. 亲缘关系矩阵的构建
-   功能 6. DMU软件的交互使用
-   功能 7. BLUPF90软件的交互使用

## 使用

**为了方便用户使用，所有的文档均支持双语模式(中英文说明书)。**

`blupADC` 内置了几个数据集对象, 包括 `data_hmp` 及`origin_pedigree`.

此外，`blupADC`  提供一些示例文件， 这些文件存储在`~/blupADC/extdata` 路径下。通过输出下面的代码，我们就能得到 这些文件的绝对路径了：

``` {.r}
system.file("extdata", package = "blupADC") # path of provided files
```

#### 功能 1. 基因型数据间的格式转换 ([了解更多](https://qsmei.netlify.app/zh/post/blupadc/))

``` R
library(blupADC)
sum_data=genotype_data_format_conversion(
         input_data_hmp=data_hmp,   #提供的hampap格式数据的对象
         output_data_type=c("Plink","BLUPF90","Numeric"),#基因型数据的输出类型
         return_result = TRUE,      #是否在R中返回结果
         cpu_cores=1                #调用的cpu数目
                  )
```

#### 功能 2.基因型数据的重复性检测 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-overlap-genotype/overlap_genotype/))

``` R
library(blupADC)
overlap_result=genotype_data_overlap(
                  input_data_hmp=data_hmp,    #提供的hampap格式数据的对象
                  overlap_threshold=0.95,     #判断重复的阈值
                  return_result=TRUE          #是否在R中返回结果
                  )
```

#### 功能 3. 系谱追溯、重命名及纠错 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-pedigree/pedigree/))

``` R
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=origin_pedigree,    #提供的系谱数据的对象
                trace_generation=3                 # 系谱追溯的代数
                )                 
```

#### 功能 4. 基因型数据的质控与填充 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-qc-imputaion/qc_imputation/))

``` R
library(blupADC)
genotype_data_QC_Imputation(
            input_data_hmp=data_hmp,                #提供的hampap格式数据的对象
            data_analysis_method="QC_Imputation",   #数据分析方法，质控+填充
            output_data_path="/root/result",        #基因型数据的输出路径
            output_data_name="YY_data",             #基因型数据的输出名称
            output_data_type="Plink"                #基因型数据的输出类型
            )                       
```

#### 功能 5. 亲缘关系矩阵的构建 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-17-r-package-blup-adc-calculate-relationship-matrix/relationship_matrix/))

``` R
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=data_hmp,          #提供的hampap格式数据的对象
                kinship_type=c("G_A","G_D"),      #亲缘关系矩阵的类型
                dominance_type=c("genotypic"),    #显性效应的类型
                inbred_type=c("Homozygous"),      #近交系数的类型
                return_result=TRUE)               #在R中返回结果        
```

#### 功能 6. DMU软件的交互使用 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-20-r-package-blup-adc-run-dmu/run_dmu/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  示例文件的路径
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2"), # colnames of phenotype 
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

#### 功能 7. BLUPF90软件的交互使用 ([了解更多](https://qsmei.netlify.app/zh/post/2021-04-20-r-package-blup-adc-run-BLUPF90/BLUPF90/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")   #  示例文件的路径
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2"), # 表型数据的列名(ps.表型文件无列名)
        target_trait_name=c("Trait1"),                           #性状名称
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #固定效应名称
        random_effect_name=list(c("Id","Litter")),               #随机效应名称
        covariate_effect_name=NULL,                              #协变量效应名称
        phe_path=data_path,                          #表型文件路径
        phe_name="phenotype.txt",                    #表型文件名
        analysis_model="PBLUP_A",                    #遗传评估模型
        relationship_path=data_path,                 #亲缘关系文件路径
        relationship_name="pedigree.txt",            #亲缘关系文件名
        output_result_path="/root"                   #结果输出路径
        )   
```
