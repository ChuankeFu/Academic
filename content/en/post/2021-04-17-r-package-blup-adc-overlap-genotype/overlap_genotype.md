---
title: 'R package:blupADC-Feature 2'
author: qsmei
date: '2021-04-15'
slug: blupADC
categories: ["Detect overlap"]
tags: []
subtitle: ''
summary: 'Detect duplicated genotype data'
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

👦  Duplicated genotype is usually a problem in data analysis. In package:`blupADC`, user can detect the overlap genotype data  by applying `genotype_data_overlap` function.

## Example

``` {.R}
library(blupADC)
overlap_result=genotype_data_overlap(
                  input_data_hmp=data_hmp,   #provided hapmap data object
                  overlap_threshold=0.95,    # threshold of duplicate 
                  return_result=TRUE         #return result 
                  )
```

## Parameter 

Many parameters in  `genotype_data_overlap` are the as `genotype_data_format_conversion` function(see details). 

Thus, we will introduce  specific parameters in  `genotype_data_overlap`  function.

-   **1：selected_snps** 

Number of SNPs in detecting overlap,`numeric` calss. Default is 1000.

-   **2：overlap_threshold**

Threshold of duplicate genotype, `numeric` class. Default is 0.95.

When the proportion of genotype data between two individuals is larger than this threshold, these two individuals will be regarded as the same individual.


