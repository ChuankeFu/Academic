---
title: 'R package:blupADC-Feature 8'
author: qsmei
date: '2021-04-21'
slug: blupf90
categories:
  - BLUPF90
tags: []
subtitle: ''
summary: 'Genetic evaluation with software BLUPF90'
authors: []
lastmod: '2021-04-21T15:47:39+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

{{< toc >}} 

## Oveview

👻In the previous section, we have given detailed description about the interface with **DMU**  by `run_DMU` function.  In this chapter, we will introduce the usage of `run_BLUPF90`  function.   

Note: the usage of  `run_BLUPF90`  and  `run_DMU`  is similar. Thus, we recommend to have a look at the  usage of `run_DMU` function.

👉 **Note:**  **Package `blupADC` has encapsulated  the basic module of BLUPF90 (`renumf90`, `remlf90`, `airemlf90`, and `blupf90`), if you want to use more modules, please download from websit** ([BLUPF90 download website](http://nce.ads.uga.edu/html/projects/programs/)).

 **For commercial use of BLUPF90,  user must contact the author of BLUPF90 !!!** 

## Example

### **Single trait model - Pedigree BLUP**

``` {.r}
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

### **Single trait model - GBLUP**

``` {.r}
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
        analysis_model="GBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="blupf90_genumeric",            #name of relationship file 
        output_result_path="/root"                   # output path  
        )   

```

### **Single trait model - Single-step BLUP** 

``` {.r}
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
        analysis_model="SSBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt","blupf90_genumeric"),            #name of relationship file 
        output_result_path="/root"                  # output path 
        )   
```

Similar to `run_DMU` function, through modifying the two parameters: `analysis_model` and `relationship_name` , we can perform Pedigree-BLUP, GBLUP, and SSBLUP analysis(PS: blupf90_genumeric is generated through `cal_kinship` function，[see more details](https://qsmei.netlify.app/post/2021-04-17-r-package-blup-adc-calculate-relationship-matrix/relationship_matrix/) about `cal_kinship` function). 

### **Multiple traits model - Pedigree BLUP**

The following code is about the usage of multiple traits model through BLUPF90:

``` {.R}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1"),c("Trait2")),                 #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter"),c("Id")),               #random effect name
        covariate_effect_name=list(NULL,"Age"),                          #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt"),            #name of relationship file 
        output_result_path="/root"                   # output path 
        )   
```



## Parameter

Many parameters in  `run_BLUPF90` are the same as in `run_DMU` function([see more details](https://qsmei.netlify.app/post/2021-04-20-r-package-blup-adc-run-dmu/run_dmu/)). 

💫Thus, we will introduce  specific parameters in `run_BLUPF90` function.

- **1：BLUPF90_algorithm**  

  Algorithm of estimating variance components,  `character` class. Default is "EM_REML".

  -   `"AI_REML"`
  -   `"EM_REML"`
  -   `"BLUP"` : no need to estimate variance components,  solve mixed linear model directly. 

-   **2：provided_blupf90_prior_file_path**

File path of user-provided prior file,   `character` class. 

**Note**: The format of BLUPF90 prior file is different to the format of DMU prior file. In the next section, i will give a detailed introduction. 

-   **3：provided_blupf90_prior_file_name**

File name of user-provided prior file,   `character` class.  

-   **4：provided_blupf90_prior_effect_name**

Effect name of user-provided prior file,   `character` class. 

-   **5：BLUPf90_software_path**  

Path of software BLUPF90 , `character` class. 