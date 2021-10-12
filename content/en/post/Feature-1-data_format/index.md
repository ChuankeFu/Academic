---
title: 'R package:blupADC-Feature 1'
author: qsmei
date: '2021-04-14'
slug: blupADC
categories: ["Data format"]
tags: []
subtitle: ''
summary: 'Genomic data format conversion'
authors: []
lastmod: '2021-04-14T14:59:41+08:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
output:
  blogdown::html_page:
    toc: true
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(collapse = TRUE)
```

## Overview  

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

According to the result of output, we find that the output contains 5 parts, including:

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

-   **11:input_data_path**

File path of provided genotype data ，`character` class.

-   **12:input_data_name**

File name of provided genotype data ，`character` class.

**Note:**  if input_data_type is Plink or VCF, user don't need to include suffix in the file name of genotype data. 

eg. for Plink type data, files name are test1.map and test1.ped，we should set`input_data_name="test1"`.

-   **13:output_data_name**

File name of output genotype data, `character` class.

- **14:output_data_type**

  File type of output genotype data, `character` class.

  -   Hapmap
  -   Plink
  -   BLUPF90
  -   Numeric
  -   Haplotype
  -   VCF

**Note**: users can  output multiple formats of genotype data simultaneously. e.g.`output_data_type=c("Hapmap","Plink","BLUPF90","Numeric")`, outout 4 types of genotype data simultaneously .

-   **15:return_result**

Whether return result, `logical` class. Default is FALSE.

Additionally,  for convenience, users can  save output genotype data  into local computer .

-   **16:bigmemory_cal**

Whether using bigmemory method to calculate. `logical` class. Default is FALSE.

-   **17:bigmemory_data_path**

The file path bigmemory data . `character` class. 

-   **18:bigmemory_data_name**

The file name bigmemory data . `character` class. 

-   **19:phased_genotype**

Whether genotype data has been phased. `logical` class. Default is FALSE.

-   **20:haplotype_window_nSNP**

According to the number of consecutive SNPs define haplotype block. `numeric` class. Default is NULL.

-   **21:haplotype_window_kb**

According to the physical location define haplotype block. `numeric` class. Default is NULL.

-   **22:haplotype_window_block**

According to user-provided block to define haplotype block . `numeric` class. Default is NULL.

The first column is the position of window start, the second column is the position of window end.

| 1    | 5    |
| ---- | ---- |
| 6    | 10   |
| 11   | 15   |
| 16   | 20   |
| 21   | 25   |
| 26   | 30   |

### 💨Advanced

-   **23:cpu_cores**

Number of cpu in calculating,  `numeric ` class. Default is 1.

-   **24:miss_base**

Missing genotype character,  `character` class. Default is "NN".

-   **25:miss_base_num** 

Missing genotype number after numeric conversion,  `numeric` class. Default is 5.

-   **26:miss_base_num** 

Missing genotype number after numeric conversion,  `numeric` class. Default is 5.