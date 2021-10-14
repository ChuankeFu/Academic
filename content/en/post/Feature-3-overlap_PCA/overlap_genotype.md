---
title: 'R package:blupADC-Feature 3'
author: qsmei
date: '2021-04-16'
slug: blupADC
categories: ["Check genotype"]
tags: []
subtitle: ''
summary: 'Breed composition analysis '
authors: []
lastmod: '2021-04-15T15:11:30+08:00'
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

👦   Breed composition analysis is usually a problem in data analysis. In package:`blupADC`, user can solve this problem by applying `geno_check` function. In addition, user can  detect the duplication of genomic data easily by applying `geno_check` function.

## Example 

### Breed composition analysis 

``` {.R}
library(blupADC)
check_result=geno_check(
                  input_data_hmp=example_PCA_data_hmp,   #provided hapmap data object
                  duplication_check=FALSE,       #whether check the duplication of genotype
                  breed_check=TRUE,              # whether check the record of breed
                  breed_record=example_PCA_Breed,        # provided breed record
                  return_result=TRUE             #return result 
                  )
```

### Check duplication 

``` {.R}
library(blupADC)
check_result=geno_check(
                  input_data_hmp=example_data_hmp,   #provided hapmap data object
                 duplication_threshold=0.95, #threshold of duplication
                  duplication_check=TRUE,    #whether check the duplication of genotype
                  breed_check=FALSE,         # whether check the record of breed
                  return_result=TRUE         #return result 
                  )
```

## Output

The result of output mainly contains two parts, including:

- **duplicated_genotype**    

| IND1 | IND1 | 1    |
| ---- | ---- | ---- |
| IND2 | IND2 | 1    |
| IND3 | IND3 | 1    |
| IND4 | IND4 | 1    |

The first and the second column is the name of individual, the third column is the percentage of overlap.

- **pca_outlier** 

| Id     | Breed | Expeced_Breed |
| ------ | ----- | ------------- |
| IND100 | LL    | YY            |
| IND233 | DD    | YY            |
| IND91  | LL    | YY            |
| IND92  | LL    | YY            |
| IND93  | LL    | YY            |
| IND94  | LL    | YY            |

Figure A is the  PCA result before correcting breed record  , Figure B is the PCA result after correcting breed correcting record

![PCA_blupADC](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210805034645.png)

## Parameter 

Many parameters in  `genotype_data_overlap` are the same as in `genotype_data_format_conversion` function ([see more details](https://qsmei.netlify.app/post/blupadc/)). 

Thus, we will introduce  specific parameters in  `genotype_data_overlap`  function.

-   **1：selected_snps** 

Number of SNPs in detecting overlap, `numeric` class. Default is 1000.

-   **2：overlap_threshold**

Threshold of duplicate genotype, `numeric` class. Default is 0.95.

-   **3：duplication_check**

Whether check duplication of genotype, `logical` class. Default is TRUE.

-   **4：breed_check**

Whether check breed record of genotype, `logical` class. Default is FALSE.

-   **5：ind_breed**

Breed record of individuals, `data.frame` class.  

The format of `ind_breed` is showing as follow:

| Id   | Breed |
| ---- | ----- |
| IND1 | YY    |
| IND2 | YY    |
| IND3 | YY    |
| IND4 | YY    |
| IND5 | YY    |
| IND6 | YY    |

When the proportion of genotype data between two individuals is larger than this threshold, these two individuals will be regarded as the same individual.


