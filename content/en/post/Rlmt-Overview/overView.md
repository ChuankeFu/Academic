---
title: 'R package:Rlmt- Overview'
author: qsmei
date: '2022-08-25'
slug: overView
categories:
  - Rlmt
tags: []
subtitle: ''
summary: 'Overview of package:Rlmt '
authors: []
lastmod: '2022-08-25T22:32:36+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---

{{<toc>}}



### Rlmt: R warrper of the Linear Mixed Models Toolbox (LMT)
## Contents

-   [OVERVIEW](#overview)

-   [GETTING STARTED](#getting-started)

-   [USAGE](#usage)

------------------------------------------------------------------------


### OVERVIEW 
​	The **L**inear mixed **M**odels **T**oolbox (**lmt**) is a stand-alone single executable software for for large scale linear mixed model analysis. **lmt** has been used successfully for genetic evaluation data sets with >>200k genotyped animals, >>15m animals, >>500m equations. More details about lmt can be found in website: [lmt website](https://dmu.ghpc.au.dk/lmt/wiki/index.php?title=The_Linear_Mixed_Models_Toolbox)

​	In order to further assistance the use of lmt, i developed an R package: Rlmt for interfacing with lmt. This R package is developed via R6 package which can provides an implementation of encapsulated object-oriented programming for R.  And this makes the grammar of Rlmt looks like easy and elegant (i hope :smile:). 

​	About the usage of lmt in academic and commercial,  user should follow the rules  as mentioned in lmt website. 



## GETTING STARTED

### 🙊Installation

`Rlmt` links to R packages `R6`. This package should be installed before installing `Rlmt`.   `Rlmt` is available by sending a request to the *author* (hzau_qsmei@163.com), 

### 🙊Examples

-   Ex 1. PBLUP
-   Ex 2. SSGBLUP
-   Ex 3. Multiple traits analysis
-   Ex 4. Several special models 
-   Ex 5. Switch to different BLUP analysis
-   Ex 6. Modify jobs

## Usage

`Rlmt` provides several files which are saved in `~/Rlmt/extdata`. We can get the path of these files by typing

``` {.r}
system.file("extdata", package = "Rlmt") # path of provided files
```

#### Ex 1. PBLUP

``` R
library(Rlmt)
# path of example data  
example_path=system.file("extdata", package = "Rlmt") 
#construct lmt_data object
mydata=lmt_data$new(phe_file=paste0(example_path,"/data.csv"),					
                    ped_file=paste0(example_path,"/pedigree_unsorted.csv")) 

#construct  lmt_models object
mymodels=lmt_models$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id)

#construct Rlmt object
mylmt=Rlmt$new(models=mymodels,data=mydata,software_path="....../lmt")

#do analysis
mylmt$do_analysis("....../test_Result") #output path

```

#### Ex 2. SSGBLUP

``` R
library(Rlmt)
# path of example data  
example_path=system.file("extdata", package = "Rlmt") 
#construct lmt_data object
mydata=lmt_data$new(phe_file=paste0(example_path,"/data.csv"),				    
                    ped_file=paste0(example_path,"/pedigree_unsorted.csv"),					
                    geno_file=paste0(example_path,"/genotypes.txt"),					
                    geno_id_file=paste0(example_path,"/genoids.csv"))

#construct  lmt_models object
mymodels=lmt_models$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id)
mymodels$pars$blup_type="SS_GBLUP"
#construct Rlmt object
mylmt=Rlmt$new(models=mymodels,data=mydata,software_path="....../lmt")

#do analysis
mylmt$do_analysis("....../Rlmt/test_Result") #output path                
```

#### Ex 3. Multiple traits analysis

``` R
m2=lmt_formulas$new(fixed=tr2~f11+f12+f13,covariate=~c1c1,random=~id) #creat lmt_formulas object
mylmt$models$add_formulas(m2)
mylmt$do_analysis("....../test_Result") #multple traits analysis

m2=lmt_formulas$new(fixed=tr2~f11+f13,covariate=~c1c1+c1c2+c2c1,random=~id) #modify effect of tr2
mylmt$models$add_formulas(m2)
mylmt$do_analysis("....../Rlmt/test_Result") #output path    
mylmt$models$rm_formulas("tr2") #removes trait: tr2 in analysis
mylmt$do_analysis("....../Rlmt/test_Result") #output path  

```

#### Ex 4.  Several special models 

``` R
# maternal effect
m1=lmt_formulas$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id+dam) 

# permanent effect
m1=lmt_formulas$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id+dam+pe) 

#nested  effect
m1=lmt_formulas$new(fixed=tr1~f11+f12,covariate=~f13(c1c1),random=~id+dam+pe)

#user defined polynomial expression 
m1=lmt_formulas$new(fixed=tr1~f11+f12,covariate=~c1c1,random=~id+dam+pe,,polyno=c1c1~{x^2}+{exp(x)}) 

#3-order Legendre polynomials
m1=lmt_formulas$new(fixed=tr1~f11+f12,covariate=~c1c1,random=~id+dam+pe,,polyno=c1c1~{l1}+{l2}+{l3}) 

#random regression with 3-order Legendre polynomials
m1=lmt_formulas$new(fixed=tr1~f11+f12+f13,random=~c1c1(id)+c1c1(dam)+c1c1(pe),polyno=c1c1~{l1}+{l2}+{l3}) 

 # genetic group as extra random effect
mylmt$models$pars$gg_type="extra"

mylmt$models$add_formulas(m1)

mylmt$models$add_formulas(m1) #update effect
mylmt$do_analysis("....../test_Result") #do analysis
```

#### Ex 5. Switch to different BLUP analysis

``` R
library(Rlmt)
# path of example data  
example_path=system.file("extdata", package = "Rlmt") 
#construct lmt_data object
mydata=lmt_data$new(phe_file=paste0(example_path,"/data.csv"),				    
                    ped_file=paste0(example_path,"/pedigree_unsorted.csv"),					
                    geno_file=paste0(example_path,"/genotypes.txt"),					
                    geno_id_file=paste0(example_path,"/genoids.csv"))

#construct  lmt_models object
mymodels=lmt_models$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id)

mylmt$models$pars$meta_gamma=0.5 #Metafounder

mymodels$pars$blup_type="SS_TBLUP" #SS_TBLUP

mymodels$pars$blup_type="SS_SNPBLUP" #SS_SNPBLUP

mymodels$pars$blup_type="Defined_BLUP"   #Defined_BLUP
mylmt$data$grm$file="test_external.bin"   #Defined_BLUP

#ssGBLUP with two genomic factors
mydata=lmt_data$new(phe_file=paste0(example_path,"/data.csv"),                  
                    ped_file=paste0(example_path,"/pedigree_unsorted.csv"),					
                    geno_file=paste0(example_path,c("/genotypes1.txt","/genotypes2.txt")),			
                    geno_id_file=paste0(example_path,c("/genoids1.txt","/genoids2.txt")))
mymodels=lmt_models$new(fixed=tr1~f11+f12+f13,covariate=~c1c1,random=~id1+id2)                    
     

mylmt$do_analysis("/usr/home/qgg/qumei/Rlmt/test_Result") #do analysis

```

#### Ex  6.  Modify jobs

``` R
#sampler 
m_jobs=lmt_jobs$new(type="sample")
mymodels$pars$jobs=m_jobs
m_jobs$samplers$type=c("singlepass","blocked")
mylmt$do_analysis("....../test_Result") #output path

		
#solver 
m_jobs=mymodels$pars$jobs
m_jobs$type="mcemreml"
m_jobs$conv=-9.21034
m_jobs$rounds=300
mylmt$do_analysis("....../test_Result") #output path

#pevsolve
m_jobs=lmt_jobs$new(type="pevsolve")
mymodels$pars$jobs=m_jobs
mylmt$do_analysis("....../test_Result") #output path
```
