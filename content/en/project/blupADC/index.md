---
date: "2016-04-27T00:00:00Z"
external_link: ""
image:
  caption: Photo by rawpixel on Unsplash
  focal_point: Smart
links:
- icon: github
  icon_pack: fab
  name: Github
  url: https://github.com/TXiang-lab/blupADC
summary: R package for animal and plant breeding, including genotype data analysis, pedigree data analysis, relationship matrix construction and mixed model solving!
tags:
- Deep Learning
title: blupADC
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

`blupADC` is an useful and powerful tool for handling genomic data and pedigree data in animal and plant breeding(**traditional blup and genomic selection**). In the design of this package, most of data analysis problems in breeding have been considered, and the speed of calculation is also the key point. In terms of the speed, the core functions of this package are coded by c++ (`Rcpp` and `RcppArmadillo `) , and it also supports parallel calculation (by applying `openMP` programming) and big data calculation(by importing `bigmemory ` package).

`blupADC` provides many useful functions for the whole steps for animal and plant breeding, including pedigree analysis(**trace pedigree, rename pedigree, and correct pedigree errors**), genotype data format conversion(supports **Hapmap, Plink, Blupf90, Numeric, VCF and Haplotype** format), genotype data quality control and imputation, construction of kinship matrix(**pedigree, genomic and single-step**),and genetic evaluation( by interfacing with two famous breeding softwares, **DMU** and **BLUPF90** in an easy way).

Finally, we kindly provides an easier way of applying `blupADC`, which is a free website([shinyapp](http://47.95.251.15:443/blupADC/)). Several functions are still under development. But the pitfall of this website is that it can't handle big data.
