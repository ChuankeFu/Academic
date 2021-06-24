---
title: 'R package:blupADC-功能4'
author: qsmei
date: '2021-04-17'
slug: qc_imputation
categories:
  - Imputaion
  - QC
tags: []
subtitle: ''
summary: '基因型数据的质控与填充'
authors: []
lastmod: '2021-04-17T21:07:25+08:00'
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

🤖通常来讲，我们公司拿到的原始芯片数据大都是包含缺失值且未经过质控的。而在实际的数据分析中，我们一般都要求数据是经过质控和填充。为此，`blupADC`中提供了`genotype_data_QC_Imputation`函数，可以方便我们在R中调用**Plink**(用于质控)和**Beagle**(用于填充)软件进行基因型数据的质控和填充。

**👉 Note:  为了方便用户使用,  `blupADC` 已经事先封装好了 Plink(用于质控)  `version-1.9` 和  Beagle(用于填充) `version-5.2` 软件，用户无需再重新下载. 如果用户想自行指定软件的版本，可以通过更改相关的参数(在进阶参数部分里).**

老规矩，我们还是用一个小例子来看下函数的用法:

## 示例

``` {.R}
library(blupADC)
genotype_data_QC_Imputation(
            input_data_hmp=data_hmp,    #provided hapmap data object
            data_analysis_method="QC_Imputation",   #analysis method type,QC + imputatoin
            output_data_path="/root/result",        #output data path
            output_data_name="YY_data",             #output data name
            output_data_type="Plink"                #output data format 
            )                       
```

通过上述代码，我们即可对本地的**Hapmap**格式的基因型数据进行质控和填充，并将其以**Plink**格式并保存到本地。

进行质控和填充时，我们必须要事先提供基因型数据，这部分的参数与`genotype_data_format_conversion`函数中的参数用法一致。具体大家可参阅之前的介绍: [基因型数据间的格式转换](https://qsmei.netlify.app/zh/post/blupadc/)。

完成了基因型数据的提供后，我们可以通过以下参数进行质控填充的相关分析。

## 参数详解

### 💙基础参数

- **参数1：data_analysis_method**

  指定基因型数据的处理方法，`character`类型。可选方法包括：

  -   "QC" :进行质控
  -   "Imputation" :进行填充

  -   "QC_Imputation" :先质控，后填充

-   **参数2：qc_snp_rate**

使用Plink进行质控时，SNP call rate 的阈值，`numeric`类型，默认为0.1。

-   **参数3：qc_ind_rate**

使用Plink进行质控时，IND call rate 的阈值，`numeric`类型，默认为0.1。

-   **参数4：qc_maf**

使用Plink进行质控时，MAF 的阈值，`numeric`类型，默认为0.05。

-   **参数5：qc_hwe**

使用Plink进行质控时，哈代温伯格平衡的阈值,`numeric`类型，默认为1e-6。

### 💜进阶参数

- **参数6：plink_software_path**

Plink软件的路径,`character`类型。

-   **参数7：plink_software_name**

Plink软件的名称,`character`类型。

-   **参数8：beagle_software_path**

Beagle软件的路径,`character`类型。

-   **参数9：beagle_software_name**

Beagle软件的名称,`character`类型。

-   **参数10：beagle_ref_data_path**

使用beagle进行填充时，提供的reference data的路径，`character`类型。

-   **参数11：beagle_ref_data_name**

使用beagle进行填充时，提供的reference data的名称，`character`类型。

-   **参数12：beagle_ped_path**

使用beagle进行填充时，提供的系谱数据的路径，`character`类型。

-   **参数13：beagle_ped_name**

使用beagle进行填充时，提供的系谱数据的名称，`character`类型。
