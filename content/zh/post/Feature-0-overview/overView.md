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

## 新添加的功能 

### 1.0.3

- 目前能够通过DMU自动分析 母性效应，永久环境效应，随机回归效应 及 社会遗传效应的模型 (2021.8.24)

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
packageurl <- "https://github.com/TXiang-lab/blupADC/raw/master/blupADC_1.0.2_R_x86_64-pc-linux-gnu.tar.gz"
install.packages(packageurl,repos=NULL,method="libcurl")
```

对于中国用户来说，我们推荐使用如下代码进行安装（**安装速度更快**）：

```R
packageurl <- "https://gitee.com/qsmei/blup-adc/attach_files/798138/download/blupADC_1.0.2_R_x86_64-pc-linux-gnu.tar.gz
"
install.packages(packageurl,repos=NULL,method="libcurl")
```

#### 在 Windows 上 安装 blupADC

```R
packageurl <- "https://github.com/TXiang-lab/blupADC/raw/master/blupADC_1.0.2.zip"
install.packages(packageurl,repos=NULL)
```

对于中国用户来说，我们推荐使用如下代码进行安装（**安装速度更快**）：

```R
packageurl <- "https://gitee.com/qsmei/blup-adc/attach_files/798137/download/blupADC_1.0.2.zip"
install.packages(packageurl,repos=NULL)
```

安装成功后，我们输入如下代码即可加载R包:

``` {.r}
library(blupADC)
```

### 🙊功能

-   功能 1. 基因型数据间的格式转换
-   功能 2. 基因型数据的质控与填充
-   功能 3. 品种分析及基因型数据重复性检测
-   功能 4. 系谱追溯、重命名及纠错
-   功能 5. 系谱可视化
-   功能 6. 亲缘关系矩阵的构建(A,G, H)
-   功能 7. 利用DMU软件进行遗传评估
-   功能 8. 利用BLUPF90软件进行遗传评估

## 使用

**为了方便用户使用，所有的文档均支持双语模式(中英文说明书)。**

`blupADC` 内置了几个数据集对象, 包括 `data_hmp` 及`origin_pedigree`.

此外，`blupADC`  提供一些示例文件， 这些文件存储在`~/blupADC/extdata` 路径下。通过输出下面的代码，我们就能得到 这些文件的绝对路径了：

``` {.r}
system.file("extdata", package = "blupADC") # path of provided files
```

#### 功能 1. 基因型数据间的格式转换 ([see more details](https://qsmei.netlify.app/zh/post/blupadc/))

``` R
library(blupADC)
sum_data=genotype_data_format_conversion(
         input_data_hmp=data_hmp,  #provided hapmap data object 
         output_data_type=c("Plink","BLUPF90","Numeric"),# output data format
         return_result = TRUE,      # return result 
         cpu_cores=1                # number of cpu 
                  )
```

#### 功能 2. 基因型数据的质控与填充 ([see more details](https://qsmei.netlify.app/zh/post/feature-2-qc_imputation/qc_imputation/))

``` R
library(blupADC)
genotype_data_QC_Imputation(
            input_data_hmp=data_hmp,    #provided hapmap data object
            data_analysis_method="QC_Imputation",   #analysis method type,QC + imputatoin
            output_data_path="/root/result",        #output data path
            output_data_name="YY_data",             #output data name
            output_data_type="VCF"                #output data format 
            )                       
```

#### 功能 3. 品种分析及基因型数据重复性检测 ([see more details](https://qsmei.netlify.app/zh/post/feature-3-overlap_pca/blupadc/))

``` R
library(blupADC)
check_result=genotype_data_check(
                  input_data_hmp=PCA_data_hmp,   #provided hapmap data object
                  duplication_check=FALSE,       #whether check the duplication of genotype
                  breed_check=TRUE,              # whether check the record of breed
                  breed_record=PCA_Breed,           # provided breed record
                  output_data_path="/root",      #output path
                  return_result=TRUE             #return result 
                  )
```

#### 功能 4. 系谱追溯、重命名及纠错 ([see more details](https://qsmei.netlify.app/zh/post/feature-4-trace_pedigree/pedigree/))

``` R
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=origin_pedigree,   #provided pedigree data object
                trace_generation=3,       # trace generation
                output_pedigree_tree=TRUE  # output pedigree tree
                )  
```

#### 功能 5. 系谱可视化 ([see more details](https://qsmei.netlify.app/zh/post/feature-5-visualize_pedigree/pedigree/))

``` R
library(blupADC)
plot=ggped(
       input_pedigree=plot_pedigree,
       trace_id=c("121"),
       trace_sibs=TRUE   #whether plot the sibs of subset-id  
        ) 
```

#### 功能 6. 亲缘关系矩阵的构建(A,G, H)  ([see more details](https://qsmei.netlify.app/zh/post/feature-6-kinship_matrix/relationship_matrix/))

``` R
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=data_hmp,          #provided hapmap data object
                kinship_type=c("G_A","G_D"),      #type of  kinship matrix
                dominance_type=c("genotypic"),    #type of dominance effect
                inbred_type=c("Homozygous"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

#### 功能 7. 利用DMU软件进行遗传评估 ([see more details](https://qsmei.netlify.app/zh/post/feature-7-run_dmu/run_dmu/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path="/root"                   # output path 
        )
```

#### 功能 8. 利用BLUPF90软件进行遗传评估 ([see more details](https://qsmei.netlify.app/zh/post/feature-8-run_blupf90/blupf90/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path="/root"                   # output path 
        )    
```

