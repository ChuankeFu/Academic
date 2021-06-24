---
title: 'R package:blupADC-Feature 4'
author: qsmei
date: '2021-04-17'
slug: qc_imputation
categories:
  - Imputaion
  - QC
tags: []
subtitle: ''
summary: 'data qc and imputation'
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

## Overview

🤖 Generally, most genotype data need to perform quality control and imputation.  For convenience,  package `blupADC` provides `genotype_data_QC_Imputation` function to perform quality control and imputation by interfacing with  software **Plink** and software **Beagle** in an easy way (we only need to provide the software path and software name).   

**👉 Note:  For convenience,  `blupADC` has encapsulated software Plink(for quality control)  `version-1.9` and software Beagle(for imputation) `version-5.2`. If you want change this version, you could set the related parameters in the part of Advanced parameter.**

## Example

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

In the process of quality control and imputation，we should provide genotype data，these parameters are the as in`genotype_data_format_conversion`function(see more details).

## Parameter

### 💙Basic

- **1：data_analysis_method**

  Method of analyzing data, `character` class.

  -   `"QC"` : only perform quality control
  -   `"Imputation"` : only perform imputation
-   `"QC_Imputation"` : first perform quality control, and then  perform imputation


-   **2：qc_snp_rate**

Threshold of SNPs call rate in quality control, `numeric` class. Default is 0.1

使用Plink进行质控时，SNP call rate 的阈值，`numeric`类型，默认为0.1。

-   **3：qc_ind_rate**

Threshold of individuals call rate in quality control, `numeric` class. Default is 0.1

-   **4：qc_maf **  

Threshold of minor allele frequency(MAF)  in quality control, `numeric` class. Default is 0.05

-   **5：qc_hwe **   

Threshold of hardy weinberg equilibrium(HWE)  in quality control, `numeric` class. Default is 1e-7

### 💜Advanced

-   **6：plink_software_path**

Path of software **Plink**  , `character` class.

-   **7：plink_software_name**

Name of  software  **Plink** , `character` class.

-   **8：beagle_software_path**

Path of software **Beagle** , `character` class.

-   **9：beagle_software_name**

Name of software **Beagle** , `character` class.

-   **10：beagle_ref_data_path**  

File path of reference data in imputation, `character` class.

-   **11：beagle_ref_data_name**

File name of reference data in imputation, `character` class.

-   **12：beagle_ped_path**

File path of pedigree data in imputation, `character` class.

-   **13：beagle_ped_name**

File name of pedigree data in imputation, `character` class.
