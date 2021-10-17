---
title: 'R package:blupADC-Feature 7'
author: qsmei
date: '2021-04-20'
slug: run_dmu
categories:
  - DMU
tags: []
subtitle: ''
summary: 'Genetic evaluation with software DMU'
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

In this section, we will give detail description about `run_DMU` function. 

👉 **Note:**  **Package `blupADC` has encapsulated  the basic module of DMU(`dmu1`,`dmuai`, and `dmu5`) , more modules could be download from website**([DMU download website](https://dmu.ghpc.au.dk/dmu/)). 

 **For commercial use of DMU,  user must contact the author of DMU !!!** 

## Example

### Single trait  - pedigree BLUP model

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype
        target_trait_name=list(c("Trait1")),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - GBLUP  model

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="GBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="G_Ainv_col_three.txt",            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - single-step BLUP model

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="SSBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt","G_A_col_three.txt"),            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

Through modifying the two parameters: `analysis_model` and `relationship_name` , we can perform Pedigree-BLUP, GBLUP, and SSBLUP analysis (PS: we can get G_Ainv_col_three.txt  and G_A\_col_three.txt   by `cal_kinship` function，[see more details](https://qsmei.netlify.app/post/2021-04-17-r-package-blup-adc-calculate-relationship-matrix/relationship_matrix/)  about `cal_kinship` function). 

The above example is single-trait model, while in actual breeding, multiple traits model is also common.  Similarly, we only need to modify several parameters to  perform multiple traits model: 

### Multiple traits  - pedigree BLUP model

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1"),c("Trait2")),                           #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter"),c("Id")),               #random effect name
        covariate_effect_name=list(NULL,"Age"),                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model(with user-provided prior)

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter",
                         "Trait1","Trait2","Age"),               # colnames of phenotype
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        provided_prior_file_path=data_path,          #path of user-provided prior file
        provided_prior_file_name="PAROUT",           #name of user-provided prior file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with maternal effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Herd","B_month","D_age","Litter","Sex","HY","ID","DAM","L_Dam",
		         "W_birth","W_2mth","W_4mth","G_0_2","G_0_4","G_2_4"), # colnames of phenotype
        target_trait_name=list(c("W_birth")),                           #trait name 
        fixed_effect_name=list(c("B_month","D_age","Litter","Sex","HY")),     #fixed effect name
        random_effect_name=list(c("ID","L_Dam")),    #random effect name
        maternal_effect_name=list(c("DAM")),
        genetic_effect_name="ID",                    #genetic effect name 
        covariate_effect_name=NULL,                  #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="maternal_data",                    #name of phenotype file
        integer_n=9,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="maternal_pedigree",       #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with permanent effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("id","year_grp","breed","time","t_dato",
                        "age","L1","L2","L3","gh"),           # colnames of phenotype
        target_trait_name=list(c("gh")),                      #trait name 
        fixed_effect_name=list(c("year_grp","breed","time")), #fixed effect name
        random_effect_name=list(c("id","t_dato")),            #random effect name
        covariate_effect_name=list(c("age")),                 #covariate effect name	
        genetic_effect_name="id",                    #genetic effect name
        included_permanent_effect=list(c(TRUE)),     #whether include permant effect
        phe_path=data_path,                          #path of phenotype file
        phe_name="rr_data",                          #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with random regression effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("id","year_grp","breed","time","t_dato",
                        "age","L1","L2","L3","gh"),           # colnames of phenotype
        target_trait_name=list(c("gh")),                      #trait name 
        fixed_effect_name=list(c("year_grp","breed","time")), #fixed effect name
        random_effect_name=list(c("id","t_dato")),            #random effect name
        covariate_effect_name=list(c("age")),                 #covariate effect name	
        genetic_effect_name="id",                    #genetic effect name 
        included_permanent_effect=list(c(TRUE)),     #whether include permant effect
        random_regression_effect_name=list(c("L1&id&pe_effect","L2&id&pe_effect")), #random regression effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="rr_data",                          #name of phenotype file
        integer_n=5,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with social genetic effect) 

#### User-provided phenotype doesn't need to have max group size columns 

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(
        phe_col_names=c("Id","Group","Sex","Phe"), # colnames of phenotype
        target_trait_name=list(c("Phe")),          #trait name 
        fixed_effect_name=list(c("Sex")),          #fixed effect name
        random_effect_name=list(c("Id","Group")),  #random effect name
        covariate_effect_name=NULL,                #covariate effect name		
        genetic_effect_name="Id",                  #genetic effect name
        include_social_effect=list(c(TRUE)),   
        group_effect_name="Group",
        phe_path=data_path,                          #path of phenotype file
        phe_name="raw_social_data",                  #name of phenotype file
        integer_n=3,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="socail_pedigree",         #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with social genetic effect) 

#### User-provided phenotype need to have  max group size columns

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of provided files 
  
run_DMU(phe_col_names=c("Id","Group","Sex","Gr_id1","Gr_id2","Gr_id3","Gr_id4","Gr_id5",                         
                        "Phe","Status_Gr_id1","Status_Gr_id2","Status_Gr_id3","Status_Gr_id4","Status_Gr_id5"),# colnames of phenotype
	target_trait_name=list(c("Phe")),           #trait name 
	fixed_effect_name=list(c("Sex")),           #fixed effect name
	random_effect_name=list(c("Id","Group")),   #random effect name
	covariate_effect_name=NULL,
	genetic_effect_name="Id",		           #genetic effect name
	include_social_effect=list(c(TRUE)),       #whether include social genetic effect 
	integer_group_names=c("Gr_id1","Gr_id2","Gr_id3","Gr_id4","Gr_id5"),  #integer variable name of max group size    
        real_group_names= c("Status_Gr_id1","Status_Gr_id2","Status_Gr_id3","Status_Gr_id4","Status_Gr_id5"), #real variable name of max group size
        phe_path=data_path,                          #path of phenotype file
        phe_name="social_data",                      #name of phenotype file
        integer_n=8,                                 #number of integer variable 
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        dmu_module="dmuai",                          #modeule of estimating variance components 
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="socail_pedigree",         #name of relationship file 
        output_result_path=getwd()                    # output path 
		)
```

### 🤡Basic

-   **1：phe_path** 

File path of phenotype data ，`character` class。 

-   **2：phe_name** 

File name of phenotype data，`character` class。 

**Note**: User-provided phenotype doesn't have colnames (the same as the requirement of DMU)

-   **3：phe_col_names**

Colnames of  phenotype data，`character` class。 

-   **4：integer_n**

Number of integer variable, `numeric` class。 

-   **5：genetic_effect_name**

Genetic effect name (usually is the individual name), `character` class.

-   **6：target_trait_name** 

Target trait name,  `list` class. One list for each trait. 

For multiple traits model, we should set target_trait_name as character vector, e.g. `target_trait_name=list(c("Trait1"),c("Trait2"))`

-   **7：fixed_effect_name**  

Fixed effects name, `list` class.  

For multiple traits model,  the order of  fixed effects name should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))`

`fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season"))`

which means the fixed effects name of trait1 is : `c("Sex","Herd_Year_Season")`,  the fixed effect name of trait2 is : `c("Herd_Year_Season") `  

-   **8：random_effect_name**

Random effects name, `list` class.  

For multiple traits model,  the order of  random effects name should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))`

`random_effect_name=list(c("Id","Litter"),c("Id"))`

which means the random effects name of trait1 is : `c("Id","Litter")`,  the random effects name of trait2 is : `c("Id")`

-   **9：covariate_effect_name**

Covariate effects name, `list` class.  

For multiple traits model,  the order of  covariate effects name should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`covariate_effect_name=list(c(NULL),c("Age"))`

which means the covariate effects name of trait1 is : `NULL` (NULL means no this effect),  the covariate effects name of trait2 is : `Age`

-   **10：maternal_effect_name**

Maternal effects name(usually is the Dam), `list` class.  

For multiple traits model,  the order of  maternal effects name should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`maternal_effect_name=list(c(NULL),c("Dam"))`

-   **11：random_regression_effect_name**

Random regression effects name, `list` class.  

For multiple traits model,  the order of  random regression effects name should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`random_regression_effect_name=list(c("L1&id&pe_effect","L2&id&pe_effect"),c("L1&id&pe_effect","L2&id&pe_effect"))`    

Within each list,  the left side of  `&`  stands for  polynomial coefficient name,  the right side of  `&`  stands for  random effect name or fixed  effect name. If user want to include permanent effect in random regression model,  the random effect name in the right side of `&`   should be "pe_effect", and user must set  included_permanent_effect as TRUE

-   **12：included_permanent_effect**  

Whether perform permanent-environment analysis,    `list` class.   

For multiple traits model,  the order of  permanent effect should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`included_permanent_effect=list(c(TRUE),c(TRUE))` 

-   **13：include_social_effect**  

Whether perform social genetic effect analysis,    `list` class.    

For multiple traits model,  the order of  permanent effect should correspond to the target trait name.

eg.  `target_trait_name=list(c("Trait1"),c("Trait2"))` 

`include_social_effect=list(c(TRUE),c(TRUE))` 

-   **14：group_effect_name**  

The group effect name in the social genetic analysis,   `character` class.    

When user-provided phenotype doesn't have max group size columns, user need to specify the group_effect_name parameter. When user provides group_effect_name, software will generate a new phenotype with max group size columns  automatically.  And then, software will perform the social genetic analysis without additional parameter. 

-   **15：integer_group_names**    

Integer variable name of max group size columns, `character` class.     

When user-provided phenotype has max group size columns, user need to specify the integer variable name of max group size columns.

-   **16：real_group_names**    

Real variable name of max group size columns, `character` class.     

When user-provided phenotype has max group size columns, user need to specify the real variable name of max group size columns.

- **17：analysis_model**

  Model of genetic evaluation, `character` class.

  -   `"PBLUP_A"` : Pedigree BLUP- additive model
  -   `"GBLUP_A"` :GBLUP- additive model
  -   `"GBLUP_AD"` :GBLUP- additive and dominance model
  -   `"SSBLUP_A"` :SSBLUP- additive model
  -   `"User_define"`: User define model 

-   **18：dmu_module** 

    Module of estimating variance components,  `character` class.

    -   `"dmuai"`

    -   `"dmu4"`

    -   `"dmu5"`

-   **19：DMU_software_path**  

Path of DMU software,  `character` class. 

-   **20：relationship_path**  

File path of relationship data,  `character` class.

-   **21：relationship_name**

File name of relationship data,  `character` class.

For different genetic evaluation model , we should provide different relationship file. 

E.g. for  "PBLUP_A" model, we need to provide pedigree file,  then we should set `relationship_name="pedigree.txt"`   ;

for  "GBLUP_A" model, we need to provide inverse of additive relationship matrix file(3 columns  format),  then we should set `relationship_name="G_Ainv_col_three.txt"`   ;

for  "SSBLUP_A" model, we need to provide pedigree and  additive relationship matrix file(3 columns  format),  then we should set `relationship_name=c("pedigree.txt","G_A_col_three.txt")`   ;

-   **22：output_result_path**  

Path of output DMU result,   `character` class.

-   **23：output_ebv_path**

File path of output EBV,   `character` class. Default is equal to  output_result_path

-   **24：output_ebv_name**  

File name of output EBV,   `character` class. 

### 👺Advanced 

-   **25：provided_effect_file_path**  

File path of trait's  model effect data,   `character` class. 

File of trait's model effect include fixed effects name, random effects name, and covariate effects name.  Once user provides this file,  user don't need to set  these three parameters: `fixed_effect_name `  `random_effect_name `  `covariate_effect_name `. 

The format of this effect file is as following:

| V1     | V2   | V3   | V4               | V5   | V6   | V7     | V8   | V9   |
| ------ | ---- | ---- | ---------------- | ---- | ---- | ------ | ---- | ---- |
| Trait1 | \*   | Sex  | Herd_Year_Season | \*   | Id   | Litter | \*   | \*   |
| Trait2 | \*   | Sex  | \*               | Id   | \*   | Age    | \*   |      |

The first column is the name of target trait.  Each column stands for one effect name.  In order to recognize three types of effect, we  set  \*   to distinguish each type.   

Effects name between the first   \*  and the second  \*  stand for fixed effects name;   

effects name between the second   \*  and the third  \*  stand for random effects name; 

 effects name between the third   \*  and the fourth  \*  stand for covariate effects name.

-   **26：provided_effect_file_name**   

File name of trait's  model effect data,   `character` class.   

-   **27：provided_DIR_file_path**  

File path of user-provided DIR data,   `character` class.   

-   **28：provided_DIR_file_name**

File name of user-provided DIR data,   `character` class.   

-   **29：included_permanent_effect**  

Whether perform permanent-environment analysis,    `logical` class.   Default is FALSE.

-   **30：dmu_algorithm_code**  

Number of dmu-module algorithm,  `numeric` class.

-   **31：provided_prior_file_path**   

File path of user-provided prior file,   `character` class. 

-   **32：provided_prior_file_name**

File name of user-provided prior file,   `character` class. 

-   **33：missing_value**  

Missing value in phenotype file,  `numeric` class. Default is -9999.

-   **34：iteration_criteria** 

Value of iteration convergence,  `numeric` class. Default is 1.0e-7.

-   **35：genetic_effect_number** 

Number of genetic effect in SOL file,  `numeric` class. Default is 4.

-   **36：residual_cov_trait**  

Traits combination of assuming residual-covariance equals to 0. e.g `residual_cov_trait=list(c("Trait1","Trait2"))`

-   **37：selected_id**  

Individuals set of output EBV,  `character` class.   

-   **38：cal_debv**   

Whether calculate de-regressed EBV(DEBV),   `logical` class.   Default is FALSE.

-   **39：debv_pedigree_path** 

File path of pedigree data for calculating DEBV,   `character` class. 

-   **40：debv_pedigree_name**

File name of pedigree data for calculating DEBV,   `character` class. 
