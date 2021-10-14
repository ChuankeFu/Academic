---
title: 'R package:blupADC- 功能1'
author: qsmei
date: '2021-04-14'
slug: blupADC
categories: ["格式转换"]
tags: []
subtitle: ''
summary: '基因型数据格式转换'
authors: []
lastmod: '2021-04-14T14:59:41+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
output:
  blogdown::html_page:
    toc: true
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(collapse = TRUE)
```

## 简介

🙀大家好,通过前一章节的学习，相信大家已经对`blupADC` 有了一个初步的了解了。从本节开始，我们将对`blupADC`中的几个重要的函数一一进行讲解。这一节主要给大家讲述的是如何使用`blupADC`中`geno_format`函数来进行多种基因型格式数据的转换。    

## 示例

#### 格式转换-提供R中的变量名称

```R
library(blupADC)
format_result=geno_format(
         input_data_hmp=example_data_hmp,  #provided hapmap data object 
         output_data_type=c("Plink","BLUPF90","Numeric","VCF"),# output data format
         return_result = TRUE,      # return result 
         cpu_cores=1                # number of cpu 
         )
```

#### 格式转换-提供本地文件的路径和名称

```R
#convert phased VCF data to haplotype format and  haplotype-based numeric format
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of example files 
phased_result=geno_format(
         input_data_path=data_path,      # input data path 
    	 input_data_name="example.vcf",  # input data name,for vcf data 
         input_data_type="VCF",          # input data type
    	 phased_genotype=TRUE,           # whether the vcf data has been phased
         haplotype_window_nSNP=5,        # according to nSNP define block,
    	 output_data_type=c("Haplotype","Numeric"),# output data format
         return_result=TRUE,             #save result as a R environment variable
         cpu_cores=1                     # number of cpu 
                  )
```

#### 格式转换-通过bigmemory方法

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of example files 
phased_result=geno_format(
         input_data_path=data_path,      # input data path 
    	 input_data_name="example.vcf",  # input data name,for vcf data 
         input_data_type="VCF",          # input data type
    	 phased_genotype=TRUE,           # whether the vcf data has been phased
         haplotype_window_nSNP=5,        # according to nSNP define block,
    	 bigmemory_cal=TRUE,             # format conversion via bigmemory object
    	 bigmemory_data_path=getwd(),    # path of bigmemory data 
    	 bigmemory_data_name="test_blupADC", #name of bigmemory data 
         output_data_type=c("Haplotype","Numeric"),# output data format
         return_result=TRUE,             #save result in R environment
         cpu_cores=1                     # number of cpu 
                  )
```

## 输出

输出结果主要分为6个部分(长度为6的列表)，分别为：

-   **hmp** : `Hapmap` 格式的基因型数据

`第1列为SNP，第3列为染色体，第4列为物理位置，第12列开始为基因型数据`

| rs#  | alleles | chrom | pos    | strand | assembly | center | protLSID | assayLSID | panelLSID | QCcode | 3098 | 3498 | 3297 | 2452 |
| ---- | ------- | ----- | ------ | ------ | -------- | ------ | -------- | --------- | --------- | ------ | ---- | ---- | ---- | ---- |
| SNP1 | NA      | 1     | 224488 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | AC   | AC   | CC   |
| SNP2 | NA      | 1     | 293696 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | GG   | TG   | TG   | GG   |
| SNP3 | NA      | 1     | 333333 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | GG   | TT   | TT   | GG   |
| SNP4 | NA      | 1     | 464830 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | CC   | CC   | CC   |
| SNP5 | NA      | 1     | 722623 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | AA   | GG   | GG   | AA   |
| SNP6 | NA      | 1     | 838596 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | TC   | TT   | CC   |

-   **ped**  : `Plink` 格式的基因型数据

`第1列为家系，第2列为个体号，第7列开始为基因型数据。`

| 3098 | 3098 | 0    | 0    | 0    | 0    | C    | C    | G    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 3498 | 3498 | 0    | 0    | 0    | 0    | A    | C    | T    | G    |
| 3297 | 3297 | 0    | 0    | 0    | 0    | A    | C    | T    | G    |
| 2452 | 2452 | 0    | 0    | 0    | 0    | C    | C    | G    | G    |
| 4255 | 4255 | 0    | 0    | 0    | 0    | A    | C    | G    | G    |
| 2946 | 2946 | 0    | 0    | 0    | 0    | C    | C    | T    | G    |

-   **map**:  `Plink`格式的基因型数据

`第1列为染色体，第2列为SNP，第3列为遗传距离(cM), 第4列为物理位置。`

| 1    | SNP1 | 0.224488 | 224488 |
| ---- | ---- | -------- | ------ |
| 1    | SNP2 | 0.293696 | 293696 |
| 1    | SNP3 | 0.333333 | 333333 |
| 1    | SNP4 | 0.464830 | 464830 |
| 1    | SNP5 | 0.722623 | 722623 |
| 1    | SNP6 | 0.838596 | 838596 |

-   **blupf90**: `BLUPF90` 格式的基因型数据

`第1列为个体号，第2列为基因型。`

| 3098 | 200000 |
| ---- | ------ |
| 3498 | 112021 |
| 3297 | 112022 |
| 2452 | 200000 |
| 4255 | 102011 |
| 2946 | 212000 |

-   **numeric**: `Numeric` 格式的基因型数据

`行名为个体，列名为SNP，0,1,2表示的是个体在某个SNP位点的基因型数据`

| 2    | 0    | 0    | 0    | 0    | 0    |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1    | 1    | 2    | 0    | 2    | 1    |
| 1    | 1    | 2    | 0    | 2    | 2    |
| 2    | 0    | 0    | 0    | 0    | 0    |
| 1    | 0    | 2    | 0    | 1    | 1    |
| 2    | 1    | 2    | 0    | 0    | 0    |

- **haplotype_hap**: `Haplotype` 格式的基因型数据

  行表示的为SNP,列表式的是个体，每个个体占两列。

  | 0    | 0    | 0    | 1    | 1    | 0    | 0    | 0    |
  | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
  | 0    | 0    | 1    | 0    | 0    | 1    | 0    | 0    |
  | 1    | 1    | 0    | 0    | 0    | 0    | 1    | 1    |
  | 0    | 0    | 1    | 1    | 1    | 1    | 0    | 0    |
  | 0    | 0    | 0    | 1    | 1    | 1    | 0    | 0    |

- **haplotype_sample**: `Haplotype` 格式的基因型数据

  基因型数据的个体名称。

  | 3098 |
  | ---- |
  | 3498 |
  | 3297 |
  | 2452 |
  | 4255 |
  | 2946 |

- **haplotype_map**: `Haplotype` 格式的基因型数据

  | 1    | SNP1 | 224488 | C    | A    |
  | ---- | ---- | ------ | ---- | ---- |
  | 1    | SNP2 | 293696 | G    | T    |
  | 1    | SNP3 | 333333 | T    | G    |
  | 1    | SNP4 | 464830 | A    | G    |
  | 1    | SNP5 | 722623 | C    | T    |
  | 1    | SNP6 | 838596 | C    | A    |

- **vcf**: `VCF` 格式的基因型数据

| ##fileformat=VCFv4.2                 |       |      |      |      |      |        |      |        |      |      |
| ------------------------------------ | ----- | ---- | ---- | ---- | ---- | ------ | ---- | ------ | ---- | ---- |
| ##source="beagle.29May21.d6d.jar"    |       |      |      |      |      |        |      |        |      |      |
| ##INFO<ID=AF,Number=A,Type=Float>    |       |      |      |      |      |        |      |        |      |      |
| ##INFO<ID=IMP,Number=0,Type=Flag">   |       |      |      |      |      |        |      |        |      |      |
| ##FORMAT<ID=GT,Number=1,Type=String> |       |      |      |      |      |        |      |        |      |      |
| #CHROM                               | POS   | ID   | REF  | ALT  | QUAL | FILTER | INFO | FORMAT | 3498 | 3297 |
| 1                                    | 6260  | M2   | T    | A    | .    | PASS   | .    | GT     | 1\|0 | 0\|1 |
| 1                                    | 15289 | M17  | A    | T    | .    | PASS   | .    | GT     | 0\|0 | 0\|0 |

 

## 参数

### 🤡Basic

-   **参数1:input_data_plink_ped**

用户提供的 Plink-ped格式的数据，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数2:input_data_plink_map**

用户提供的 Plink-map格式的数据，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数3:input_data_hmp**

用户提供的 Hapmap格式的数据，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数4:input_data_blupf90**

用户提供的 BLUPF90格式数据，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数5:input_data_numeric**

用户提供的 Numeric格式的数据，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数6:input_data_haplotype_hap** 

用户提供的 `Haplotype`格式的数据 ，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数7:input_data_haplotype_sample**  

用户提供的 `Haplotype`格式的数据 ，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数8:input_data_haplotype_map**

用户提供的 `Haplotype`格式的数据 ，`data.frame ` or `matrix` 类型。具体格式见结果部分

-   **参数9:input_data_vcf**

用户提供的 `VCF`格式的数据 ，`data.frame ` or `matrix` 类型。具体格式见结果部分

**Note:**  `input_data_numeric`  数据应该包含行名和列名。

**此外，为了方便用户使用，用户还可以直接通过提供本地数据的路径、名称与数据类型即可完成数据提供这一步骤,而无需将数据读入到R里面。**

- **参数10:input_data_type**

  用户提供的本地数据的格式，`character `类型。数据格式包括：

  -   Hapmap
  -   Plink
  -   BLUPF90
  -   Numeric
  -   Haplotype
  -   VCF

- **参数11:input_data_path**

用户提供的本地数据的文件路径，`character `类型。

-   **参数12:input_data_name**

用户提供的本地数据的文件名称，`character `类型。

**Note:** 如果提供的数据类型为Plink ,那么本地文件名称不需要带后缀，eg. 本地文件名为test1.map test1.ped，我们提供文件名称为： `input_data_name="test1"`。除了Plink格式的数据外，其他数据格式必须提供完整的名称(带后缀)。

-   **参数13:output_data_path**

输出的基因型数据保存到本地的路径，`character `类型。

-   **参数14:output_data_name**

输出的基因型数据保存到本地的文件名称，`character `类型。

- **参数15:output_data_type**

  用户提供的本地数据的格式，`character `类型。数据格式包括：

  -   Hapmap
  -   Plink
  -   BLUPF90
  -   Numeric
  -   Haplotype
  -   VCF

-   **参数16:return_result**

是否在R中返回输出的结果，`logical`类型。默认为FLASE。

-   **参数17:bigmemory_cal**

是否使用bigmemory方式进行计算. `logical` 类型. 默认为 FALSE.

-   **参数18:bigmemory_data_path**

bigmemory数据保存的路径 . `character` 类型. 

-   **参数19:bigmemory_data_name**

bigmemory数据保存的文件名称 . `character` 类型. 

-   **参数20:phased_genotype**

是否基因型数据已经经过定向. `logical` 类型.默认为 FALSE.

-   **参数21:haplotype_window_nSNP**

根据连续的SNP数目来定义单倍型block. `numeric` 类型. 

-   **参数22:haplotype_window_kb**

根据物理位置信息来定义单倍型block. `numeric` 类型. 

-   **参数23:haplotype_window_block**

根据用户自定义的信息来定义单倍型block. . `data.frame` or `matrix`类型. 

第一列是window起始位置，第二列是window结束位置

| 1    | 5    |
| ---- | ---- |
| 6    | 10   |
| 11   | 15   |
| 16   | 20   |
| 21   | 25   |
| 26   | 30   |

### 💨Advanced

-   **参数24:cpu_cores**

函数调用的cpu个数，`numeric `类型。默认调用1个

-   **参数25:miss_base**

缺失值在原基因型数据中所表示的的字符，`character `类型。默认为"NN"。

-   **参数26:miss_base_num**

数字化格式转换中缺失值转换成的数字，`numeric `类型。默认为 5。