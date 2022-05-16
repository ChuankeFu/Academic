---
title: 'R package:blupADC-Feature 6'
author: qsmei
date: '2021-04-19'
slug: relationship_matrix
categories:
  - Relationship matrix
tags: []
subtitle: ''
summary: 'Construct kinship matrix(A,G and H)'
authors: []
lastmod: '2021-04-18T16:36:39+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
math: true
---

{{<toc>}}

## Overview

🙉 In the application of animal and plant breeding, the key step is the construction of kinship matrix.  Package: `blupADC` provides `cal_kinship `function which can construct various type of relationship matrix directly,  including  **additive relationship matrix**(pedigree, genomic and single-step), and **dominance relationship matrix**(pedigree, genomic and single-step), and **the inverse matrix** of these kinship matrix.  

In the construction of single-step relationship matrix, users can select **Metafounder** algorithm or **APY** algorithm. In terms of the construction of dominance relationship matrix, users can select different coding manners for genomic dominance relationship matrix, gene dropping algorithm for pedigree dominance relationship matrix.  In addition, `cal_kinship ` can calculate several types of inbreeding coefficients  (pedigree, genomic, and single-step) .

**Note**: In the construction of genomic and single-step relationship matrix, people need to provide genotype data. These parameters are the same as in `geno_format` function(([see more details](https://qsmei.netlify.app/post/blupadc/)).

## Example

### 😾 Pedigree-based kinship matrix

``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_pedigree=example_ped3,          #provided hapmap data object
                kinship_type=c("P_A"),      #type of  kinship matrix
                inbred_type=c("Pedigree"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

### 🤡 Genomic-based kinship matrix

``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=example_data_hmp,          #provided hapmap data object
                kinship_type=c("G_A","G_D"),      #type of  kinship matrix
                dominance_type=c("genotypic"),    #type of dominance effect
                inbred_type=c("Homozygous"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

###  💨Single-step based kinship matrix
``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=example_data_hmp,          #provided hapmap data object
                input_pedigree=example_ped3,
                kinship_type=c("H_A"),      #type of  kinship matrix
                inbred_type=c("H_diag"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

###  💨Single-step based kinship matrix(via bigmemory method)

``` {.R}
library(blupADC)
phased_kinship_result=cal_kinship(
                input_data_hmp=example_data_hmp,          #provided hapmap data object
                input_pedigree=example_ped3,
                bigmemory_cal=TRUE,
                bigmemory_data_path=getwd(),
                bigmemory_data_name="blupADC",
                kinship_type=c("H_A"),      #type of  kinship matrix
                inbred_type=c("H_diag"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result                
```

## Parameter

### 💪Basic

- **1：kinship_type** 

  Type of kinship matrix, `character` class. User can select multiple types simultaneously, including:

  -   "G_A" : genomic additive kinship matrix
  -   "G_Ainv" :inverse of genomic additive kinship matrix
  -   "G_D" :genomic dominance kinship matrix
  -   "G_Dinv" :inverse of genomic dominance kinship matrix
  -   "P_A" :pedigree additive kinship matrix
  -   "P_Ainv" :inverse of pedigree additive kinship matrix
  -   "P_D" : pedigree dominance kinship matrix
  -   "P_Dinv" :inverse of pedigree dominance kinship matrix
  -   "H_A" :single-step additive kinship matrix
  -   "H_Ainv" :inverse of single-step additive kinship matrix

**Note**: In the construction of pedigree and single-step relationship matrix, user need to provide pedigree data. In the construction of genomic and single-step relationship matrix, user need to provide genotype data.

- **2：dominance_type**

  Type of dominance effect in the construction of dominance relationship matrix , `character` class. 

  -   "genotypic" : coded by  $0-2pq$, $1-2pq$, and $0-2pq$  for $AA$,  $Aa$, and  $aa$, respectively. 
  -   "classical" :     coded by $-2q^2$, $2pq$ , and $-2p^2$ for $AA$,  $Aa$, and  $aa$, respectively. 

> More details about these two types dominance effects could be seen in this reference ：[On the Additive and Dominant Variance and Covariance of Individuals Within the Genomic Selection Scope](https://www.genetics.org/content/195/4/1223.short)

-   **3：inbred_type**

    Type of inbreeding coefficients,  `character` class.

    -   "Homozygous" : proportion of homozygous sites 

    -   "G_Diag" : diagonal of genomic additive relationship matrix minus 1

    -   "H_diag" :diagonal of single-step additive relationship matrix minus 1

    -   "Pedigree" :diagonal of pedigree additive relationship matrix minus 1

-   **4：input_pedigree**

User-provided pedigree data ，`data.frame` or `matrix` class. ([see more details](https://qsmei.netlify.app/post/2021-04-17-r-package-blup-adc-pedigree/pedigree/) about the format of pedigree data) 

-   **5：IND_rename** 

Whether genotype individuals need to be renamed according to the  provided pedigree,  `logical` class. Default is FALSE.

-   **6:bigmemory_cal**

Whether using bigmemory method to calculate. `logical` class. Default is FALSE.

-   **7:bigmemory_data_path**

The file path bigmemory data . `character` class. 

-   **8:bigmemory_data_name**

The file name bigmemory data . `character` class. 

- **9：output_matrix_type**  

  Type of output kinship matrix type,   `character` class. Default is "col_all".

  -    "`col_all`" : n*n format  
  -   "`col_three`" : 3 columns format. The first and the second column are the name of individuals, the third column is the relationship coefficients 。

| 1001 | 1001 | 0.989 |
| ---: | ---- | ----- |
| 1001 | 1002 | 0.421 |
| 1001 | 1003 | 0.567 |

-   **10：output_matrix_path**

File path of output relationship matrix,   `character` class. 

-   **11：output_matrix_name**

File name of output relationship matrix,   `character` class. 

### 🦶Advanced

-   **12：cpu_cores**

Number of cpu in calculating,  `numeric` class. Default is 1.

-   **13：kinship_base** 

Whether take $p=q=0.5$  in the construction of relationship matrix,  `logical` class. Default is FALSE.

-   **14：kinship_trace**

Whether take the trace of kinship matrix to scale relationship matrix,  `logical` class. Default is FALSE.

-   **15：Metafounder_algorithm** 

Whether take the metafounder algorithm to construct single-step relationship matrix,  `logical` class. Default is FALSE.

-   **16：APY_algorithm** 

Whether take the APY algorithm to construct inverse relationship matrix,  `logical` class. Default is FALSE.

-   **17：APY_eigen_threshold** 

Threshold of variation explained by eigenvalues ,  `numeric` class. Default is 0.95.

-   **18：APY_n_core** 

Number of  core animals ,  `numeric` class. Default is NULL.

-   **19：SSBLUP_omega**  

The value of omega in the construction of single-step additive relationship matrix,  `numeric` class. Default is 0.05.

-   **20：gene_dropping** 

Whether take the gene dropping algorithm to construct pedigree dominance relationship matrix,  `logical` class. Default is FALSE.

-   **21：gene_dropping_iteration**  

The number of iteration for gene dropping algorithm ,  `numeric` class. Default is 1000.
