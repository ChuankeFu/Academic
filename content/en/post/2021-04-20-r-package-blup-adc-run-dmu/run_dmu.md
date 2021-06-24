---
title: 'R package:blupADC-Feature 6'
author: qsmei
date: '2021-04-20'
slug: run_dmu
categories:
  - DMU
tags: []
subtitle: ''
summary: 'Interface with software DMU'
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

## Overview

🤠 In the previous section, we have given detailed description about data preparation.  In the following section, we will introduce genetic evaluation software in animal and plant breeding.  Nowadays, in the filed of animal and plant breeding,  two of the most famous breeding software are **DMU** and **BLUPF90** ( cited over than one thousand).  

Although these two softwares have many advantages, these two softwares have one common pitfall: it is a little difficult to use for freshman(need to prepare parameter file). Thus, in order to overcome this pitfall,  package `blupADC`  provides  `run_DMU` and `run_BLUPF90` for interfacing **DMU** and **BLUPF90** in an easy way.  

In this section, we will give detail descriptions about `run_DMU` function. 

👉 **Note:**  **Package `blupADC` has encapsulated  the basic module of DMU(`dmu1`,`dmuai`, and `dmu5`),more modules could be download from website**([DMU download website](https://dmu.ghpc.au.dk/dmu/)). 

 **For commercial use of DMU,  user must contact the author of DMU !!!** 

## Example

### **Single trait model - Pedigree BLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype
        target_trait_name=c("Trait1"),                           #trait name 
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

### **Single trait model - GBLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1"),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="GBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="G_Ainv_col_three.txt",            #name of relationship file 
        output_result_path="/root"                   # output path 
        )
```

### **Single trait model - Single-step BLUP** 

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2"), # colnames of phenotype 
        target_trait_name=c("Trait1"),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="SSBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt","G_A_col_three.txt"),            #name of relationship file 
        output_result_path="/root"                   # output path 
        )
```

Through modifying the two parameters: `analysis_model` and `relationship_name` , we can perform Pedigree-BLUP, GBLUP, and SSBLUP analysis(PS: we can get G_Ainv_col_three.txt  and G_A\_col_three.txt   through `cal_kinship` function，see more tails(XXXX) about `cal_kinship` function). 

The above example is single-trait model, while in actual breeding, multiple traits model is also common.  Similarity, we only need to modify several parameters to  perform multiple traits model: 

### **Multiple traits model - Pedigree BLUP** 

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=c("Trait1","Trait2"),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter"),c("Id")),               #random effect name
        covariate_effect_name=list(NULL,"Age"),                              #covariate effect name
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

## Parameter

### 🤡Basic

-   **1：phe_path** 

File path of phenotype data ，`character` class。 

-   **2：phe_name** 

File name of phenotype data，`character` class。 

**Note**: User-provided phenotype don't have colnames (the same as the requirement of DMU)

-   **3：phe_col_names**

Column names of  phenotype data，`character` class。 

-   **4：integer_n**

Number of integer variable, `numeric` class。 

-   **5：genetic_effect_name**

Genetic effect name(usually is the id name), `character` class.

-   **6：target_trait_name** 

Target trait name,  `character` class.

For multiple traits model, we should set target_trait_name as character vector, e.g. `target_trait_name=c("Trait1","Trait2")`

-   **7：fixed_effect_name**  

Fixed effects name, `list` class.  

For multiple traits model,  the order of  fixed effects name should corresponding to the target trait name.

eg.  `target_trait_name=c("Trait1","Trait2")` 

`fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season"))`

which means the fixed effects name of trait1 is : `c("Sex","Herd_Year_Season")`,  the fixed effect name of trait2 is : `c("Herd_Year_Season") `  

-   **8：random_effect_name**

Random effects name, `list` class.  

For multiple traits model,  the order of  random effects name should corresponding to the target trait name.

eg.  `target_trait_name=c("Trait1","Trait2")` 

`random_effect_name=list(c("Id","Litter"),c("Id"))`

which means the random effects name of trait1 is : `c("Id","Litter")`,  the random effects name of trait2 is : `c("Id")`

-   **9：covariate_effect_name**

Covariate effects name, `list` class.  

For multiple traits model,  the order of  covariate effects name should corresponding to the target trait name.

eg.  `target_trait_name=c("Trait1","Trait2")` 

`covariate_effect_name=list(NULL,"Age")`

which means the covariate effects name of trait1 is : `NULL` (NULL means no this effect),  the covariate effects name of trait2 is : `Age`

- **10：analysis_model**

  Model of genetic evaluation, `character` class.

  -   `"PBLUP_A"` : Pedigree BLUP- additive model
  -   `"GBLUP_A"` :GBLUP- additive model
  -   `"GBLUP_AD"` :GBLUP- additive and dominance model
  -   `"SSBLUP_A"` :SSBLUP- additive model
  -   `"User_define"`: User define model 

-   **11：dmu_module ** 

    Module of estimating variance components,  `character` class.

    -   `"dmuai"`

    -   `"dmu4"`

    -   `"dmu5"`

-   **12：DMU_software_path**  

Path of DMU software,  `character` class. 

-   **13：relationship_path**  

File path of relationship data,  `character` class.

-   **14：relationship_name**

File name of relationship data,  `character` class.

For difference genetic evaluation model , we should provide different relationship file. 

E.g. for  "PBLUP_A" model, we need to provide pedigree file,  then we should set `relationship_name="pedigree.txt"`   ;

for  "GBLUP_A" model, we need to provide inverse of additive relationship matrix file(3 columns  format),  then we should set `relationship_name="G_Ainv_col_three.txt"`   ;

for  "SSBLUP_A" model, we need to provide pedigree and  additive relationship matrix file(3 columns  format),  then we should set `relationship_name=c("pedigree.txt","G_A_col_three.txt")`   ;

-   **15：output_result_path**  

Path of output DMU result,   `character` class.

-   **16：output_ebv_path**

File path of output EBV,   `character` class. Default is equal to  output_result_path

-   **17：output_ebv_name**  

File name of output EBV,   `character` class. 

### 👺Advanced 

-   **18：provided_effect_file_path** 

File path of trait's  effect data,   `character` class. 

File of trait's effect including fixed effects name, random effects name, and covariate effects name.  Once user provide this file,  user don't need to set  these three parameters: `fixed_effect_name `  `random_effect_name `  `covariate_effect_name `. 

The format of this effect file is as following:

| V1     | V2   | V3   | V4               | V5   | V6   | V7     | V8   | V9   |
| ------ | ---- | ---- | ---------------- | ---- | ---- | ------ | ---- | ---- |
| Trait1 | \*   | Sex  | Herd_Year_Season | \*   | Id   | Litter | \*   | \*   |
| Trait2 | \*   | Sex  | \*               | Id   | \*   | Age    | \*   |      |

The first column is the name of target trait.  Each column stands for one effect name.  In order to recognize three types of effect, we  set  \*   to distinct each type.   

Effects name between the first   \*  and the second  \*  stand for fixed effects name;   

effects name between the second   \*  and the third  \*  stand for random effects name; 

 effects name between the third   \*  and the fourth  \*  stand for covariate effects name.

-   **19：provided_effect_file_name**   

File name of trait's  effect data,   `character` class.   

-   **20：provided_DIR_file_path**  

File path of user-provided DIR data,   `character` class.   

-   **21：provided_DIR_file_name**

File name of user-provided DIR data,   `character` class.   

-   **22：included_permanent_effect**  

If perform permanent-environment analysis,    `logical` class.   Default is FALSE.

-   **23：dmu_algorithm_code**  

Number of dmu-module algorithm,  `numeric` class.

-   **24：provided_prior_file_path**   

File path of user-provided prior file,   `character` class. 

-   **25：provided_prior_file_name**

File name of user-provided prior file,   `character` class. 

-   **26：missing_value**  

Missing value in phenotype file,  `numeric` class. Default is -9999.

-   **27：iteration_criteria** 

Value of iteration convergence,  `numeric` class. Default is 1.0e-7.

-   **28：genetic_effect_number** 

Number of genetic effect in SOL file,  `numeric` class. Default is 4.

-   **29：residual_cov_trait**  

Traits combination of assuming residual-covariance equals to 0. e.g `residual_cov_trait=list(c("Trait1","Trait2"))`

-   **30：selected_id**  

Individuals set of output EBV,  `character` class.   

-   **31：cal_debv**   

If calculate desegregated-EBV(DEBV),   `logical` class.   Default is FALSE.

-   **32：debv_pedigree_path** 

File path of pedigree data for calculating DEBV,   `character` class. 

-   **33：debv_pedigree_name**

File name of pedigree data for calculating DEBV,   `character` class. 
