---
title: 'R package:blupADC- Overview'
author: qsmei
date: '2021-04-13'
slug: overView
categories:
  - blupADC
tags: []
subtitle: ''
summary: 'Overview of package:blupADC '
authors: []
lastmod: '2021-04-13T22:32:36+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
---



 

### R package for animal and plant breeding<img src="https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210617165506.png" alt="logo-blupADC"  height="250" align="right" style="zoom:100%;" />

## Contents

-   [OVERVIEW](#overview)

-   [GETTING STARTED](#getting-started)

    -   [Installation](#installation)
    -   [Features](#features)

-   [USAGE](#usage)

------------------------------------------------------------------------
**Documents support two-language([English](https://qsmei.netlify.app/post/feature-0-overview/overview/) and [Chinese](https://qsmei.netlify.app/zh/post/feature-0-overview/overview/)).** 
![overview](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20220516191833.png)

**Documents support two-language([English](https://qsmei.netlify.app/post/feature-0-overview/overview/) and [Chinese](https://qsmei.netlify.app/zh/post/feature-0-overview/overview/)).** 

### OVERVIEW 
`blupADC` is an useful and powerful tool for handling genomic data and pedigree data in animal and plant breeding(**traditional blup and genomic selection**).  In the design of this package, most of data analysis problems in breeding have been considered, and  the speed of calculation is also the key point. In terms of the speed,  the core functions of this package are coded by c++ (`Rcpp` and `RcppArmadillo `) , and it also supports  parallel calculation (by applying `openMP` programming) and big data calculation(by importing `bigmemory ` package). 

`blupADC` provides many useful functions for the whole steps for animal and plant breeding, including pedigree analysis(**trace pedigree, rename pedigree, and correct pedigree errors**), genotype data format conversion(supports **Hapmap, Plink, Blupf90, Numeric,  VCF and Haplotype** format), genotype data quality control and imputation, construction of kinship matrix(**pedigree, genomic  and single-step**),and genetic evaluation( by interfacing with two famous breeding softwares, **DMU** and **BLUPF90**  in an easy way). 

Finally, we kindly provides an easier way of applying `blupADC`, which is a free  website([shinyapp](http://47.95.251.15:443/blupADC/)).  Several functions are still under development.  But the pitfall of this website is that it can't handle big data. 

😊 Good Luck Charlie ! 
If you have suggestion or question, please contact: quanshun1994@gmail.com ! 
### 👨‍💻 Citation 

Quanshun Mei, Chuanke Fu, Jieling Li, Shuhong Zhao, and Tao Xiang. "blupADC: An R package and shiny toolkit for comprehensive genetic data analysis in animal and plant breeding." *bioRxiv* (2021), **doi:** https://doi.org/10.1101/2021.09.09.459557
## New features 

### 1.0.3

- Incorporate  maternal effect, permanent effect, random regression effect, and social genetic  effect models in  the genetic evaluation by DMU (2021.8.24)

### 1.0.4

- Incorporate  haplotype format conversion ,haplotype-based numeric matrix construction and haplotype-based additive relationship matrix construction (2021.10.8)
- Import  bigmemory object in matrix save and calculation  for handling big data(2021.10.8)

### 1.0.5

- Incorporate  format conversion from blupf90 and numeric(0,1,2) format to hapmap format (2021.11.5)
- Support LR method to evaluate prediction accuracy and Hotelling_test to test significance between predictive abilities(by cross-validation method)
- Fix dEBV(2021.12.22)

### 1.0.6

- Support running multiple tasks in DMU and BLUPF90 simultaneously! (2022.05.25)  

### 1.1.0 
- Introduce object-oriented programming in running Genomic Prediction (2023.07.17) ([see more details](https://qsmei.netlify.app/post/r6-genomic-predictionselection/blup/)) 
- Move the example data and software into  another R package, blupSUP, user has to install this package only for once time!
- User can still use the R function in the previous version of blupADC !

## GETTING STARTED

### 🙊Installation

`blupADC` links to R packages `Rcpp`, `RcppArmadillo` , `data.table` and  `bigmemory` .  These dependencies should be installed before installing `blupADC`.  

```R
install.packages(c("Rcpp", "RcppArmadillo","RcppProgress","data.table","bigmemory","R6"))
```
**👉 Note: In the analysis of DMU  and BLUPF90 , we need to download software DMU  ([DMU download website](https://dmu.ghpc.au.dk/dmu/))  and BLUPF90 previously ([BLUPF90 download website](http://nce.ads.uga.edu/html/projects/programs/)). For convenience, we have encapsulated  the basic module of DMU and BLUPF90 in package `blupADC`.**  

 **For commercial use of DMU and BLUPF90,  user must contact the author of DMU and BLUPF90 !!!** 

#### For the latest version of blupADC, user has to install the blupSUP package at first(only for one time), which contains the example data and software(e.g. DMU, BLUPF90, and etc.)!
```R
devtools::install_github("TXiang-lab/blupSUP")
```
#### Install blupADC via devtools
```R
devtools::install_github("TXiang-lab/blupADC")
```

👉 **Note:If the connection with github is not good(such as in China), user can download as below:**  

```R
devtools::install_git("https://gitee.com/qsmei/blupADC")
```

⚠️During installation, if there are some errors like that: ‘trimatl_ind’ was not declared in this scope, ‘class arma::Mat<double>’ has no member named ‘clean’......Please make sure the version of RcppArmadillo over 0.9.870.2.0."

After installed successfully, the `blupADC` package can be loaded by typing

``` {.r}
library(blupADC)
```

**Note**: In terms of the relationship matrix construction, we highly recommend Microsoft R Open(faster than traditional R many times)

### 🙊Features

-   Feature 1. Genomic data format conversion
-   Feature 2. Genomic data quality control and genotype imputation
-   Feature 3. Breed composition analysis and duplication detection of genomic data
-   Feature 4. Pedigree tracing, and analysis
-   Feature 5. Pedigree visualization
-   Feature 6. Relationship matrix construction(A,G, and H) 
-   Feature 7. Genetic evaluation with DMU
-   Feature 8. Genetic  evaluation with BLUPF90

## Usage

`blupADC` provides several datasets objects, including `data_hmp`, `origin_pedigree`.

In addition, `blupSUP` provides several files which are saved in `~/blupSUP/extdata`. We can get the path of these files by typing

``` {.r}
system.file("extdata", package = "blupSUP") # path of provided files
```

#### Feature 1. Genomic data format conversion ([see more details](https://qsmei.netlify.app/post/blupadc/))

``` R
library(blupADC)
format_result=geno_format(
    	input_data_hmp=example_data_hmp,  # provided data variable
        output_data_type=c("Plink","BLUPF90","Numeric"),# output data format
    	output_data_path=getwd(),   #output data path      
    	output_data_name="blupADC", #output data name    
        return_result = TRUE,       #save result in R environment
        cpu_cores=1                 # number of cpu 
                  )

#convert phased VCF data to haplotype format and  haplotype-based numeric format
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of example files 
phased=geno_format(
         input_data_path=data_path,      # input data path 
         input_data_name="example.vcf",  # input data name,for vcf data
         input_data_type="VCF",          # input data type
         phased_genotype=TRUE,           # whether the vcf data has been phased
         haplotype_window_nSNP=5,        # according to nSNP define haplotype-block,
    	 bigmemory_cal=TRUE,             # format conversion via bigmemory object
    	 bigmemory_data_path=getwd(),    # path of bigmemory data 
    	 bigmemory_data_name="test_blupADC", #name of bigmemory data 
         output_data_type=c("Haplotype","Numeric"),# output data format
         return_result=TRUE,             #save result in R environment
         cpu_cores=1                     # number of cpu 
                  )
```

#### Feature 2. Genomic data quality control and genotype imputation ([see more details](https://qsmei.netlify.app/post/feature-2-qc_imputation/qc_imputation/))

``` R
library(blupADC)
geno_qc_impute(
            input_data_hmp=example_data_hmp,        #provided data variable
            data_analysis_method="QC_Imputation",   #analysis method type,QC + imputatoin
            output_data_path=getwd(),               #output data path
            output_data_name="YY_data",             #output data name
            output_data_type="VCF"                  #output data format 
            )                       
```

#### Feature 3. Breed composition analysis and duplication detection of genomic data ([see more details](https://qsmei.netlify.app/post/feature-3-overlap_pca/blupadc/))

``` R
library(blupADC)
check_result=geno_check(
                  input_data_hmp=example_PCA_data_hmp,   #provided hapmap data object
                  duplication_check=FALSE,       #whether check the duplication of genotype
                  breed_check=TRUE,               # whether check the record of breed
                  breed_record=example_PCA_Breed, # provided breed record
                  output_data_path=getwd(),       #output path
                  return_result=TRUE              #save result as a R environment variable
                  )
```

#### Feature 4. Pedigree tracing, analysis ([see more details](https://qsmei.netlify.app/post/feature-4-trace_pedigree/pedigree/))

``` R
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=example_ped1,   #provided pedigree data variable
                trace_generation=3,            # trace generation
                output_pedigree_tree=T         # output pedigree tree
                )  
```

#### Feature 5. Pedigree visualization ([see more details](https://qsmei.netlify.app/post/feature-5-visualize_pedigree/pedigree/))

``` R
library(blupADC)
plot=ggped(
       input_pedigree=example_ped2,
       trace_id=c("121"),
       trace_sibs=TRUE   #whether plot the sibs of subset-id  
        ) 
```

#### Feature 6. Relationship matrix construction(A,G, and H)  ([see more details](https://qsmei.netlify.app/post/feature-6-kinship_matrix/relationship_matrix/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of example files 
kinship_result=cal_kinship(
        		input_data_path=data_path,      # input data path 
        		input_data_name="example.vcf",  # input data name,for vcf data
         		input_data_type="VCF",          # input data type
    			kinship_type=c("G_A","G_D"),      #type of  kinship matrix
    			dominance_type=c("genotypic"),    #type of dominance effect
    			inbred_type=c("Homozygous"),      #type of inbreeding coefficients
    			return_result=TRUE)               #save result as a R environment variable         
```

#### Feature 7. Genetic evaluation with DMU ([see more details](https://qsmei.netlify.app/post/feature-7-run_dmu/run_dmu/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of example files 
  
run_DMU(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
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
        output_result_path=getwd()                   # output path 
        )
```


#### Feature 8. Genetic evaluation with BLUPF90 ([see more details](https://qsmei.netlify.app/post/feature-8-run_blupf90/blupf90/))

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of example files 
  
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
        output_result_path=getwd()                   # output path 
        )   
```

```{r setup, include=FALSE}
knitr::opts_chunk$set(collapse = TRUE)
```

## Feature1

`geno_format` is the basic function of  package:`blupADC`.  By applying `geno_format` , we can convert multiple genotype data formats in an easy way, including Hapmap, Plink, BLUPF90, Numeric, Haplotype and  VCF.   

## Example

#### Format conversion based on provided R variable

```R
library(blupADC)
format_result=geno_format(
         input_data_hmp=example_data_hmp,  #provided hapmap data object 
         output_data_type=c("Plink","BLUPF90","Numeric","VCF"),# output data format
         return_result = TRUE,      # return result 
         cpu_cores=1                # number of cpu 
         )
```

#### Format conversion based on provided data path and data name

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

#### Format conversion via bigmemory method

```R
library(blupADC)
data_path=system.file("extdata", package = "blupADC")  #  path of example files 
phased_result=geno_format(
         input_data_path=data_path,      # input data path 
		 input_data_name="example.vcf",  # input data name,for vcf data
		 input_data_type="VCF",          # input data type
		 phased_genotype=TRUE,           # whether the vcf data has been phased
	     haplotype_window_nSNP=5,        # according to nSNP define haplotype-block,
    	 bigmemory_cal=TRUE,             # format conversion via bigmemory object
    	 bigmemory_data_path=getwd(),    # path of bigmemory data 
    	 bigmemory_data_name="test_blupADC", #name of bigmemory data 
		 output_data_type=c("Haplotype","Numeric"),# output data format
         return_result=TRUE,             #save result in R environment
         cpu_cores=1                     # number of cpu 
                  )
```

## Output

According to the result of output, we find that the output contains 6 parts, including:

-   **hmp ** : `Hapmap` format genotype data

The first column stands for the name of SNP, the thrid column stands for chromosome, the fourth column stands for the physical postion, and the twelth column and the after columns stand for the genotype data

| rs#  | alleles | chrom | pos    | strand | assembly | center | protLSID | assayLSID | panelLSID | QCcode | 3098 | 3498 | 3297 | 2452 |
| ---- | ------- | ----- | ------ | ------ | -------- | ------ | -------- | --------- | --------- | ------ | ---- | ---- | ---- | ---- |
| SNP1 | NA      | 1     | 224488 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | AC   | AC   | CC   |
| SNP2 | NA      | 1     | 293696 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | GG   | TG   | TG   | GG   |
| SNP3 | NA      | 1     | 333333 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | GG   | TT   | TT   | GG   |
| SNP4 | NA      | 1     | 464830 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | CC   | CC   | CC   |
| SNP5 | NA      | 1     | 722623 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | AA   | GG   | GG   | AA   |
| SNP6 | NA      | 1     | 838596 | NA     | NA       | NA     | NA       | NA        | NA        | NA     | CC   | TC   | TT   | CC   |

-   **ped**  : `Plink` format ped data

The first column stands for family name,the second column stands for the individual name,the seventh column and the after columns stand for the genotype data

| 3098 | 3098 | 0    | 0    | 0    | 0    | C    | C    | G    | G    |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 3498 | 3498 | 0    | 0    | 0    | 0    | A    | C    | T    | G    |
| 3297 | 3297 | 0    | 0    | 0    | 0    | A    | C    | T    | G    |
| 2452 | 2452 | 0    | 0    | 0    | 0    | C    | C    | G    | G    |
| 4255 | 4255 | 0    | 0    | 0    | 0    | A    | C    | G    | G    |
| 2946 | 2946 | 0    | 0    | 0    | 0    | C    | C    | T    | G    |

-   **map **:  `Plink`format map data

The first column stands for chromosome, the second column stands for the name of SNP, the thrid column stands for the genetic positon(CM), and the fourth column stands for the physical position

| 1    | SNP1 | 0.224488 | 224488 |
| ---- | ---- | -------- | ------ |
| 1    | SNP2 | 0.293696 | 293696 |
| 1    | SNP3 | 0.333333 | 333333 |
| 1    | SNP4 | 0.464830 | 464830 |
| 1    | SNP5 | 0.722623 | 722623 |
| 1    | SNP6 | 0.838596 | 838596 |

-   **blupf90 **: `BLUPF90` format genotype data

The first column stands for individual name, the second column stands for the genotype data(numeric)

| 3098 | 200000 |
| ---- | ------ |
| 3498 | 112021 |
| 3297 | 112022 |
| 2452 | 200000 |
| 4255 | 102011 |
| 2946 | 212000 |

-   **numeric **: `Numeric` format genotype data

rownames of numeric data stands for the individual name, colnames of numeric data stands for the name of SNP, 0,1,2 stand for the numeric genotype 

| 2    | 0    | 0    | 0    | 0    | 0    |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 1    | 1    | 2    | 0    | 2    | 1    |
| 1    | 1    | 2    | 0    | 2    | 2    |
| 2    | 0    | 0    | 0    | 0    | 0    |
| 1    | 0    | 2    | 0    | 1    | 1    |
| 2    | 1    | 2    | 0    | 0    | 0    |

- **haplotype_hap**: `Haplotype` format genotype data.

  Row stands for marker, column stands for individual, each individual has two columns; 

  | 0    | 0    | 0    | 1    | 1    | 0    | 0    | 0    |
  | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
  | 0    | 0    | 1    | 0    | 0    | 1    | 0    | 0    |
  | 1    | 1    | 0    | 0    | 0    | 0    | 1    | 1    |
  | 0    | 0    | 1    | 1    | 1    | 1    | 0    | 0    |
  | 0    | 0    | 0    | 1    | 1    | 1    | 0    | 0    |

- **haplotype_sample**: `Haplotype` format genotype data

  | 3098 |
  | ---- |
  | 3498 |
  | 3297 |
  | 2452 |
  | 4255 |
  | 2946 |

- **haplotype_map**: `Haplotype` format genotype data

  | 1    | SNP1 | 224488 | C    | A    |
  | ---- | ---- | ------ | ---- | ---- |
  | 1    | SNP2 | 293696 | G    | T    |
  | 1    | SNP3 | 333333 | T    | G    |
  | 1    | SNP4 | 464830 | A    | G    |
  | 1    | SNP5 | 722623 | C    | T    |
  | 1    | SNP6 | 838596 | C    | A    |

- **vcf **: `VCF` format genotype data

| ##fileformat=VCFv4.2                 |       |      |      |      |      |        |      |        |      |      |
| ------------------------------------ | ----- | ---- | ---- | ---- | ---- | ------ | ---- | ------ | ---- | ---- |
| ##source="beagle.29May21.d6d.jar"    |       |      |      |      |      |        |      |        |      |      |
| ##INFO<ID=AF,Number=A,Type=Float>    |       |      |      |      |      |        |      |        |      |      |
| ##INFO<ID=IMP,Number=0,Type=Flag">   |       |      |      |      |      |        |      |        |      |      |
| ##FORMAT<ID=GT,Number=1,Type=String> |       |      |      |      |      |        |      |        |      |      |
| #CHROM                               | POS   | ID   | REF  | ALT  | QUAL | FILTER | INFO | FORMAT | 3498 | 3297 |
| 1                                    | 6260  | M2   | T    | A    | .    | PASS   | .    | GT     | 1\|0 | 0\|1 |
| 1                                    | 15289 | M17  | A    | T    | .    | PASS   | .    | GT     | 0\|0 | 0\|0 |

 

## Parameter 

### 🤡Basic

-   **1: input_data_plink_ped**

User-provided  `Plink`-ped format genotype data ，`data.frame` or `matrix` class. 

-   **2:input_data_plink_map**

User-provided `Plink`-map format genotype data ，`data.frame` or `matrix` class. 

-   **3:input_data_hmp**

User-provided  `Hapmap` format genotype data ，`data.frame` or `matrix` class. 

-   **4:input_data_BLUPF90**

User-provided  `BLUPF90` format genotype data ，`data.frame` or `matrix` class. 

-   **5:input_data_numeric**

User-provided  `Numeric` format genotype data ，`data.frame` or `matrix` class. 

-   **6:input_data_haplotype_hap** 

User-provided  `Haplotype` format genotype data ，`data.frame` or `matrix` class. 

-   **7:input_data_haplotype_sample**

User-provided  `Haplotype` format genotype data ，`data.frame` or `matrix` class. 

-   **8:input_data_haplotype_map**

User-provided  `Haplotype` format genotype data ，`data.frame` or `matrix` class. 

-   **9:input_data_vcf**

User-provided  `VCF` format genotype data ，`data.frame` or `matrix` class.

**Note:**  `input_data_numeric`  should contain both rownames and colnames. 

**In addition, for convenience, users can provide the  file name, file path, and file type of genotype data directly without reading them in R environment.**

- **10:input_data_type**

  File type of provided genotype data ，`character` class.

  -   Hapmap
  -   Plink
  -   BLUPF90
  -   Numeric
  -   Haplotype
  -   VCF

- **11:input_data_path**

File path of provided genotype data ，`character` class.

-   **12:input_data_name**

File name of provided genotype data ，`character` class.

**Note:**  if input_data_type is Plink or Haplotype, user don't need to include suffix in the file name of genotype data. 

eg. for Plink type data, files name are test1.map and test1.ped，we should set`input_data_name="test1"`.

-   **13:output_data_path**

File path of output genotype data, `character` class.

-   **14:output_data_name**

File name of output genotype data, `character` class.

- **15:output_data_type**

  File type of output genotype data, `character` class.

  -   Hapmap
  -   Plink
  -   BLUPF90
  -   Numeric
  -   Haplotype
  -   VCF

**Note**: users can  output multiple formats of genotype data simultaneously. e.g.`output_data_type=c("Hapmap","Plink","BLUPF90","Numeric")`, outout 4 types of genotype data simultaneously .

-   **16:return_result**

Whether return result, `logical` class. Default is FALSE.

Additionally,  for convenience, users can  save output genotype data  into local computer .

-   **17:bigmemory_cal**

Whether using bigmemory method to calculate. `logical` class. Default is FALSE.

-   **18:bigmemory_data_path**

The file path bigmemory data . `character` class. 

-   **19:bigmemory_data_name**

The file name bigmemory data . `character` class. 

-   **20:phased_genotype**

Whether genotype data has been phased. `logical` class. Default is FALSE.

-   **21:haplotype_window_nSNP**

According to the number of consecutive SNPs define haplotype block. `numeric` class. Default is NULL.

-   **22:haplotype_window_kb**

According to the physical location define haplotype block. `numeric` class. Default is NULL.

-   **23:haplotype_window_block**

According to user-provided block to define haplotype block . `data.frame` or `matrix`  class. Default is NULL.

The first column is the position of window start, the second column is the position of window end.

| 1    | 5    |
| ---- | ---- |
| 6    | 10   |
| 11   | 15   |
| 16   | 20   |
| 21   | 25   |
| 26   | 30   |

### 💨Advanced

-   **24:cpu_cores**

Number of cpu in calculating,  `numeric ` class. Default is 1.

-   **25:miss_base**

Missing genotype character,  `character` class. Default is "NN".

-   **26:miss_base_num** 

Missing genotype number after numeric conversion,  `numeric` class. Default is 5.

{{<toc>}}

## Feature2

🤖 Generally, most genotype data need to perform quality control and imputation before applying in animal and plant breeding.  For convenience,  package `blupADC` provides `genotype_data_QC_Imputation` function to perform quality control and imputation by interfacing with  software **Plink** and software **Beagle** in an easy way (we only need to provide the software path and software name).   

**👉 Note:  For convenience,  `blupADC` has encapsulated software Plink(for quality control)  `version-1.9` and software Beagle(for imputation) `version-5.2`. If you want change this version, you should set the related parameters in the part of Advanced parameter.**

## Example

``` {.R}
library(blupADC)
geno_qc_impute(
            input_data_hmp=example_data_hmp,    #provided hapmap data object
            data_analysis_method="QC_Imputation",   #analysis method type,QC + imputatoin
            output_data_path=getwd(),               #output data path
            output_data_name="YY_data",             #output data name
            output_data_type="VCF"                  #output data format 
            )                       
```

In the process of quality control and imputation，we should provide genotype data，these parameters are the as in `geno_format` function([see more details](https://qsmei.netlify.app/post/blupadc/)).

## Parameter

### 💙Basic

- **1：data_analysis_method**

  Method of analyzing data, `character` class.

  -   `"QC"` : only perform quality control
  -   `"Imputation"` : only perform imputation

- `"QC_Imputation"` : first perform quality control, and then  perform imputation


-   **2：qc_snp_rate**

Threshold of SNPs call rate in quality control, `numeric` class. Default is 0.1

-   **3：qc_ind_rate**

Threshold of individuals call rate in quality control, `numeric` class. Default is 0.1

-   **4：qc_maf**  

Threshold of minor allele frequency(MAF)  in quality control, `numeric` class. Default is 0.05

-   **5：qc_hwe**   

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

{{<toc>}} 

## Feature3

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

{{<toc>}} 

## Feature4

🦄 Pedigree is the important information in animal breeding.  By applying `trace_pedigree` function in package: `blupADC`, user can  trace, rename,  correct pedigree errors  in an easy  way. In addition, user can visualize the pedigree structure by  `ggped` function.

### 💖Trace pedigree


```r
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=example_ped1,   #provided pedigree data object
                output_pedigree_tree=TRUE  # output pedigree tree
                )                 

```

## Output

By typing `str(pedigree_result)`, we can get the output result of this function:


```r
str(pedigree_result)
## List of 5
##  $ ped          : chr [1:15945, 1:3] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Offspring" "Sire" "Dam"
##  $ rename_ped   :'data.frame':	15945 obs. of  6 variables:
##   ..$ Offspring   : chr [1:15945] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..$ Generation  : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Offspring_Id: int [1:15945] 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ Sire_Id     : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Dam_Id      : num [1:15945] 0 0 0 0 0 0 0 0 0 0 ...
##   ..$ Order       : int [1:15945] 1 2 3 4 5 6 7 8 9 10 ...
##  $ pedigree_tree: chr [1:15945, 1:15] "DD19348310" "DD19386807" "DD19119705" "DD16007415" ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:15] "Offspring" "Sire" "Dam" "SireSire" ...
##  $ error_id_set :List of 4
##   ..$ error_duplicated_id: chr [1:24] "DD19119705" "DD20488904" "DD20153801" "DD20376912" ...
##   ..$ error_sex_id: chr "DD13006182"
##   ..$ error_breed_id: NULL
##   ..$ error_birth_date_id: NULL
```

Output result includes several parts:

-   **ped:** pedigree without rename
-   **rename_ped:** renamed pedigree. The first column is original id, the second column is generation, columns 3-5 stand for the renamed pedigree. 
-   **pedigree_tree:** pedigree tree. Pedigree tree contains ancestry records information for each individual. For saving time, software doesn't output pedigree tree in default.
-   **error_id_set:** dataset of   pedigree errors .According to the type of pedigree errors, these datasets can be divided four parts:
    -   `error_duplicated_id`:  same individual but has different records of sire and dam
    -   `error_sex_id`:  same individual  appears in the column of sire and dam simultaneously
    -   `error_breed_id`:  breed of parents and offspring is different (only for specify format of original id)
    -   `error_birth_date_id`:  offspring born before its parents (need to provide birth data information in the fourth column of pedigree)

## Parameter

### 💥Basic

-   **1：input_pedigree**

User-provided pedigree data, `data.frame ` or   `matrix` class.

💌The format of provided pedigree data should be one of the following format:

-   3 columns format:


| Offspring  | Sire       | Dam        |
| :--------- | :--------- | :--------- |
| DD19575312 | DD18768902 | DD16376015 |
| DD19513112 | DD18768902 | DD17111017 |
| DD20348012 | DD19132207 | DD19234510 |
| DD20361110 | DD19331001 | DD19293112 |
| DD20471212 | DD19331001 | DD19320808 |
| DD20564818 | DD19331001 | DD19311009 |

-   4 columns format:


| Offspring  | Sire       | Dam        | Birth_Date |
| :--------- | :--------- | :--------- | ---------: |
| DD19575312 | DD18768902 | DD16376015 |   20200101 |
| DD19513112 | DD18768902 | DD17111017 |   20200102 |
| DD20348012 | DD19132207 | DD19234510 |   20200103 |
| DD20361110 | DD19331001 | DD19293112 |   20200104 |
| DD20471212 | DD19331001 | DD19320808 |   20200105 |
| DD20564818 | DD19331001 | DD19311009 |   20200106 |

-   Multiple columns format:


| Offspring  | Sire       | Dam        | SireSire   | DamSire    | SireSireSire |
| :--------- | :--------- | :--------- | :--------- | :--------- | :----------- |
| DD20231905 | DD19581002 | DD18750810 | DD16785512 | DD15507717 | DD14008512   |
| DD20458701 | DD19564302 | DD18925809 | DD15349017 | DD15245411 | DD16771212   |
| DD20324707 | DD19232903 | DD18571012 | DD16794714 | DD16744412 | DD16714516   |
| DD19288609 | DD18713408 | DD18552609 | DD15180015 | DD15479214 | DD15243711   |
| DD16222012 | DD15145005 | DD15378812 | DD14110014 | DD15501518 | DD15206217   |
| DD17684713 | DD16672107 | DD15122311 | DD15505715 | DD15347415 | DD16383111   |

**Note**: When the format of provided pedigree data is multiple columns ，user must set `multi_col=TRUE`, and the colnames of pedigree data should be the specify format , e.g. `SireSire` stands for the father of offspring's father, `SirSireSire` stands for the father of  `SireSire` 

Missing record in pedigree could be set as  **NA** or **0** .

-   **2：input_pedigree_path**

File path of pedigree data, `character` class.

-   **3：input_pedigree_name**

File name of pedigree data, `character` class.

-   **4：multi_col**

Whether convert multiple columns pedigree into standard 3 columns pedigree, `logical` class.  When the format of provided pedigree data is multiple columns, user need to set `multi_col=TRUE` .

-   **5：trace_id**  

Individuals set in tracing pedigree, `character` class. Default is `NULL` , which means tracing all individuals in pedigree.

-   **6：trace_generation**  

The max generation in tracing pedigree, `numeric` class. Default is `NULL` , which means tracing all  generation in pedigree. 

-   **7：trace_birth_date**  

Threshold of  birth date in tracing pedigree, `numeric` class.  Individuals set with birth date earlier than user provided birth date would be excluded in tracing pedigree.  

-   **8：output_pedigree_path**

File path of output pedigree data, `character` class.

-   **9：output_pedigree_name**

File path of output pedigree name, `character` class.

### 💨Advanced

-   **10：dup_error_check**

Whether check the pedigree error of error_duplicated，`logical` class. Default is TRUE.

-   **11：sex_error_check**

Whether check the pedigree error of error_sex，`logical` class. Default is TRUE.

-   **12：birth_date_error_check**  

Whether check the birth date error record，`logical` class. Default is TRUE.

-   **13：output_pedigree_tree**

Whether output the pedigree tree, `logical` class. Default is FALSE. 

-   **14：pedigree_tree_depth** 

Depth of pedigree tree, `numeric` class. Default is 3.



{{<toc>}} 

## Feature5

🦄  An intuitive and clear structure of pedigree could help breeders to make better decision in breeding plan. By  applying  `ggped` function, user can plot the structure of pedigree in an easy way.

## Example

### Plot whole pedigree


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2
                ) 
```

![image-20210708153839657](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708153843.png)

### Plot subset of whole pedigree


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2,
    			trace_id=c("121")             #provided subset-id
                )                   
```

![image-20210708153706707](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708153708.png)

### Plot subset of whole pedigree (with sibs)


```r
library(blupADC)
pedigree_result=ggped(
                input_pedigree=example_ped2,
    			trace_id=c("121"),
    			trace_sibs=TRUE   #whether plot the sibs of subset-id  
                )                   
```

![image-20210708161211022](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210708161212.png)

### Change the style of picture 

User can  change the style of pedigree by modifying the  `shape_type` parameter.   Default `shape_type` is 4.

![shape_type](https://qsmei-markdown.oss-cn-shanghai.aliyuncs.com/markdown-img/20210805002017.png)

## Output

The output of  `ggped`  is the  object of `ggplot`, user can plot the pedigree structure or save it directly. 

## Parameter

### 💥Basic

-   **1：input_pedigree**

User-provided pedigree data, `data.frame ` or   `matrix` class.

💌The format of provided pedigree data should be 3 columns format:


| Offspring  | Sire       | Dam        |
| :--------- | :--------- | :--------- |
| DD19575312 | DD18768902 | DD16376015 |
| DD19513112 | DD18768902 | DD17111017 |
| DD20348012 | DD19132207 | DD19234510 |
| DD20361110 | DD19331001 | DD19293112 |
| DD20471212 | DD19331001 | DD19320808 |
| DD20564818 | DD19331001 | DD19311009 |

-   **2:  trace_id** 

Individuals set in tracing pedigree, `character` class. Default is `NULL` (plot whole individuals in pedigree)

-   **3:  trace_sibs** 

Whether tracing the sibs of  individuals set , `logical` class. Default is `FALSE` .

-   **4:  ind_sex**  

Sex record of individuals , `data.frame` class.   

The format of this data is showing as follow: 	


| Individual | Sex    |
| :--------- | :----- |
| 101        | Male   |
| 102        | Female |
| 103        | Male   |
| 104        | Female |

For individual who doesn't have the record of sex,  the sex of this individual would be set as Male. 

-   **5：plot_family**

Whether showing family structure when plotting the pedigree, `logical` class. Default is `FALSE` .

-   **6：shape_type**

The shape type when plotting pedigree ，`numeric` class. Default is 4.

### 💨Advanced

-   **7:  shape_size**     

The shape size of picture, `numeric` class. Default is `8` .

-   **8：ind_text_size**

The size of individual name, `numeric` class. Default is `4` .

-   **9：ind_text_vjust**

The vjust of individual name, `numeric` class. Default is `3` .

{{<toc>}}

## Feature6

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

- **3：inbred_type**

  Type of inbreeding coefficients,  `character` class.

  -   "Homozygous" : proportion of homozygous sites 

  -   "G_Diag" : diagonal of genomic additive relationship matrix minus 1

  -   "H_diag" :diagonal of single-step additive relationship matrix minus 1

  -   "Pedigree" :diagonal of pedigree additive relationship matrix minus 1

- **4：input_pedigree**

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
  -    "`col_three`" : 3 columns format. The first and the second column are the name of individuals, the third column is the relationship coefficients 。

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

{{< toc >}}

## Feature7

🤠 In the previous section, we have given detailed description about data preparation.  In the following section, we will introduce genetic evaluation software in animal and plant breeding.  Nowadays, in the filed of animal and plant breeding,  two of the most famous breeding software are **DMU** and **BLUPF90** ( cited over than one thousand).  

Although these two softwares have many advantages, these two softwares have one common pitfall: it is a little difficult to use for freshman(need to prepare parameter file). Thus, in order to overcome this pitfall,  package `blupADC`  provides  `run_DMU` and `run_BLUPF90` for interfacing **DMU** and **BLUPF90** in an easy way.  

In this section, we will give detail description about `run_DMU` function. 

👉 **Note:**  **Package `blupADC` has encapsulated  the basic module of DMU(`dmu1`,`dmuai`, and `dmu5`) , more modules could be download from website**([DMU download website](https://dmu.ghpc.au.dk/dmu/)). 

 **For commercial use of DMU,  user must contact the author of DMU !!!** 

👉 **Note:** **Package `blupADC` now supports object-oriented programming in running DMU,  which should be more easier in analysis, see more [details!](https://qsmei.netlify.app/post/r6-genomic-predictionselection/blup/)**

## Example

### Single trait  - pedigree BLUP model

``` R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
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

- **18：dmu_module** 

  Module of estimating variance components,  `character` class.

  -   `"dmuai"`

  -   `"dmu4"`

  -   `"dmu5"`

- **19：DMU_software_path**  

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

{{< toc >}} 

## Feature8

👻In the previous section, we have given detailed description about the interface with **DMU**  by `run_DMU` function.  In this chapter, we will introduce the usage of `run_BLUPF90`  function.   

Note: the usage of  `run_BLUPF90`  and  `run_DMU`  is similar. Thus, we recommend to have a look at the  usage of `run_DMU` function.

👉 **Note:**  **Package `blupADC` has encapsulated  the basic module of BLUPF90 (`renumf90`, `remlf90`, `airemlf90`, and `blupf90`), if you want to use more modules, please download from websit** ([BLUPF90 download website](http://nce.ads.uga.edu/html/projects/programs/)).

 **For commercial use of BLUPF90,  user must contact the author of BLUPF90 !!!** 

👉 **Note:** **Package `blupADC` now supports object-oriented programming in running BLUPF90,  which should be more easier in analysis, see more [details!](https://qsmei.netlify.app/post/r6-genomic-predictionselection/blup/)**

## Example

### **Single trait model - Pedigree BLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files      
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",                    #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                   # output path 
        )   
```

### **Single trait model - GBLUP**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",                    #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="GBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="blupf90_genumeric",            #name of relationship file 
        output_result_path=getwd()                   # output path  
        )   

```

### **Single trait model - Single-step BLUP** 

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
  
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",                    #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="SSBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt","blupf90_genumeric"),            #name of relationship file 
        output_result_path=getwd()                  # output path 
        )   
```

Similar to `run_DMU` function, through modifying the two parameters: `analysis_model` and `relationship_name` , we can perform Pedigree-BLUP, GBLUP, and SSBLUP analysis(PS: blupf90_genumeric is generated through `cal_kinship` function，[see more details](https://qsmei.netlify.app/post/2021-04-17-r-package-blup-adc-calculate-relationship-matrix/relationship_matrix/) about `cal_kinship` function). 

### **Multiple traits model - Pedigree BLUP**

The following code is about the usage of multiple traits model through BLUPF90:

``` {.R}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1"),c("Trait2")),                 #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season"),c("Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter"),c("Id")),               #random effect name
        covariate_effect_name=list(NULL,"Age"),                          #covariate effect name
        genetic_effect_name="Id",                    #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name=c("pedigree.txt"),            #name of relationship file 
        output_result_path=getwd()                   # output path 
        )   
```



### Single trait  - pedigree BLUP model(with user-provided prior)

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
run_BLUPF90(phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter",
                         "Trait1","Trait2","Age"),               # colnames of phenotype
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",	                 #genetic effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        provided_BLUPF90_prior_file_path=data_path,          #path of user-provided prior file
        provided_BLUPF90_prior_file_name="BLUPF90_Prior",    #name of user-provided prior file
        provided_BLUPF90_prior_effect_name=c("Id","Litter","Residual"),
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with maternal effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
run_BLUPF90(
        phe_col_names=c("Herd","B_month","D_age","Litter","Sex","HY","ID","DAM","L_Dam",
		         "W_birth","W_2mth","W_4mth","G_0_2","G_0_4","G_2_4"), # colnames of phenotype
        target_trait_name=list(c("W_birth")),                           #trait name 
        fixed_effect_name=list(c("B_month","D_age","Litter","Sex","HY")),     #fixed effect name
        random_effect_name=list(c("ID","L_Dam")),    #random effect name
        maternal_effect_option=c("mat"),
        genetic_effect_name="ID",                    #genetic effect name 
        covariate_effect_name=NULL,                  #covariate effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="maternal_data",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="maternal_pedigree",       #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with permanent effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files 
run_BLUPF90(
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
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```

### Single trait  - pedigree BLUP model( with random regression effect)

```R
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files  
run_BLUPF90(
        phe_col_names=c("id","year_grp","breed","time","t_dato",
                        "age","L1","L2","L3","gh"),           # colnames of phenotype
        target_trait_name=list(c("gh")),                      #trait name 
        fixed_effect_name=list(c("year_grp","breed","time")), #fixed effect name
        random_effect_name=list(c("id","t_dato")),            #random effect name
        covariate_effect_name=list(c("age")),                 #covariate effect name	
        genetic_effect_name="id",                    #genetic effect name 
        random_regression_effect_name=list(c("L1&id&pe_effect","L2&id&pe_effect")), #random regression effect name
        phe_path=data_path,                          #path of phenotype file
        phe_name="rr_data",                          #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="rr_pedigree",             #name of relationship file 
        output_result_path=getwd()                    # output path 
        )
```



### **Single trait model - BLUP (gibbs sampling)**

``` {.r}
library(blupADC)
data_path=system.file("extdata", package = "blupSUP")  #  path of provided files    
run_BLUPF90(
        phe_col_names=c("Id","Mean","Sex","Herd_Year_Season","Litter","Trait1","Trait2","Age"), # colnames of phenotype 
        target_trait_name=list(c("Trait1")),                     #trait name 
        fixed_effect_name=list(c("Sex","Herd_Year_Season")),     #fixed effect name
        random_effect_name=list(c("Id","Litter")),               #random effect name
        covariate_effect_name=NULL,                              #covariate effect name
        genetic_effect_name="Id",                    #genetic effect name 
        phe_path=data_path,                          #path of phenotype file
        phe_name="phenotype.txt",                    #name of phenotype file
        analysis_model="PBLUP_A",                    #model of genetic evaluation
        relationship_path=data_path,                 #path of relationship file 
        relationship_name="pedigree.txt",            #name of relationship file 
        BLUPF90_algorithm="Gibbs",
        output_result_path=getwd()                   # output path 
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

- **2：provided_blupf90_prior_file_path**

File path of user-provided prior file,   `character` class. 

**Note**: The format of BLUPF90 prior file is different to the format of DMU prior file. In the next section, i will give a detailed introduction. 

-   **3：provided_blupf90_prior_file_name**

File name of user-provided prior file,   `character` class.  

-   **4：provided_blupf90_prior_effect_name**

Effect name of user-provided prior file,   `character` class. 

-   **5：BLUPf90_software_path**  

Path of software BLUPF90 , `character` class. 