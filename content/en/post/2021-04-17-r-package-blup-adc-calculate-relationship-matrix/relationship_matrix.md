---
title: 'R package:blupADC-Feature 5'
author: qsmei
date: '2021-04-18'
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

🙉 In the application of animal and plant breeding, the key step is the construction of kinship matrix.  Package: `blupADC` provides `cal_kinship `function which can construct various type of kinship matrix directly,  including  **additive kinship matrix**(pedigree, genomic and single-step), and **dominance kinship matrix**(pedigree, genomic and single-step), and **the inverse matrix** of these kinship matrix.  

In the construction of single-step kinship matrix, users can select metafounder algorithm. In terms of the construction of dominance kinship matrix, users can select difference coding manners for genomic dominance kinship matrix, gene dropping algorithm for pedigree dominance kinship matrix.  In addition, `cal_kinship ` can calculate several types of **inbreeding coefficients**(pedigree, genomic, and sigle-step) .

## Example

### 😾 Pedigree kinship matrix

``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_pedigree=origin_pedigree,          #provided hapmap data object
                kinship_type=c("P_A"),      #type of  kinship matrix
                inbred_type=c("Pedigree"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

**Note**: In the construction of pedigree and single-step relationship matrix, people need to provide genotype data. 

### 🤡 Genomic kinship matrix

``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=data_hmp,          #provided hapmap data object
                kinship_type=c("G_A","G_D"),      #type of  kinship matrix
                dominance_type=c("genotypic"),    #type of dominance effect
                inbred_type=c("Homozygous"),      #type of inbreeding coefficients
                return_result=TRUE)               #return result              
```

**Note**: In the construction of genomic and single-step relationship matrix, people need to provide genotype data. These parameters are the same as in `genotype_data_format_conversion` function(([see more details](https://qsmei.netlify.app/post/blupadc/)).

###  💨Single-step kinship matrix



``` {.R}
library(blupADC)
kinship_result=cal_kinship(
                input_data_hmp=data_hmp,          #provided hapmap data object
                input_pedigree=origin_pedigree,
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
  -   "H_D" :single-step dominance kinship matrix
  -   "H_Dinv" :inverse of single-step dominance kinship matrix

**Note**: In the construction of pedigree and single-step kinship matrix, user need to provide pedigree data. In the construction of genomic and single-step kinship matrix, user need to provide genotype data.

- **2：dominance_type**

  Type of dominance effect in the construction of dominance kinship matrix , `character` class. 

  -   "genotypic" : coded by  $0-2pq$,$1-2pq$, and $0-2pq$  for $AA$,  $Aa$, and  $aa$, respectively. 
  -   "classical" :     coded by $-2q^2$, $2pq$ , and $-2p^2$ for $AA$,  $Aa$, and  $aa$, respectively. 

> More details about these two types dominance effects could be seen in this reference ：[On the Additive and Dominant Variance and Covariance of Individuals Within the Genomic Selection Scope](https://www.genetics.org/content/195/4/1223.short)

-   **3：inbred_type**

    Type of inbreeding coefficients,  `character` class.

    -   "Homozygous" : proportion of homozygous sites 

    -   "G_Diag" : diagonal of genomic additive kinship matrix minus 1

    -   "H_diag" :diagonal of single-step additive kinship matrix minus 1

    -   "Pedigree" :diagonal of pedigree additive kinship matrix minus 1

-   **4：input_pedigree**

User-provided pedigree data ，`data.frame` or `matrix` class. ([see more details](https://qsmei.netlify.app/post/2021-04-17-r-package-blup-adc-pedigree/pedigree/) about the format of pedigree data) 

-   **5：pedigree_rename**  

If  pedigree need to be renamed,  `logical` class. Default is TRUE.

-   **6：IND_geno_rename ** 

If genotype individuals need to be renamed according to the  renamed pedigree,  `logical` class. Default is FALSE.

-   **7：rename_to_origin**  

If renamed individuals should keep original name,  `logical` class. Default is FALSE.

- **8：output_matrix_type**  

  Type of output kinship matrix type,   `character` class. Default is "col_three".

  -    "`col_all`" : n*n format  
  -   "`col_three`" : 3 columns format. The first and the second column is the name of individuals, the third column is the value of kinship 。

|      |      |       |
| ---: | ---- | ----- |
| 1001 | 1001 | 0.989 |
| 1001 | 1002 | 0.421 |
| 1001 | 1003 | 0.567 |

-   **9：output_matrix_path**

File path of output kinship matrix,   `character` class. 

-   **10：output_matrix_name**

File name of output kinship matrix,   `character` class. 

### 🦶Advanced

-   **11：cpu_cores**

Number of cpu in calculating,  `numeric`calss. Default is 1.

-   **12：kinship_base** 

If take $p=q=0.5$  in the construction of kinship matrix,  `logical` class. Default is FALSE.

-   **13：kinship_trace**

If take the trace of kinship matrix to scale kinship matrix,  `logical` class. Default is FALSE.

-   **14：kinship_metafounder** 

If take the metafounder algorithm to construct single-step kinship matrix,  `logical` class. Default is FALSE.

-   **15：SSBLUP_omega**  

The value of omega in the construction of single-step additive kinship matrix,  `numeric`calss. Default is 0.05.

-   **16：gene_dropping** 

If take the gene dropping algorithm to construct pedigree dominance kinship matrix,  `logical` class. Default is FALSE.

-   **17：gene_dropping_iteration**  

The number of iteration for gene dropping algorithm ,  `numeric`calss. Default is 1000.

-   **18：memory_save**

If take memory saved way to construct  kinship matrix,  `logical` class. Default is FALSE. (This way need consume more storage space) 