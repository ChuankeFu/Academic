---
title: 'R package:blupADC-Feature 4'
author: qsmei
date: '2021-04-17'
slug: Pedigree
categories:
  - Pedigree
tags: []
subtitle: ''
summary: 'Pedigree analysis'
authors: []
lastmod: '2021-04-16T08:32:43+06:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: []
toc: true
show_related:
  post: true
---

{{<toc>}} 

## Overview

🦄 Pedigree is the important information in animal breeding.  By applying `trace_pedigree` function in package: `blupADC`, user can  trace, rename,  correct pedigree errors  in an easy  way. In addition, user can visualize the pedigree structure by  `ggped` function.

## Example

### 💖Trace pedigree


```r
library(blupADC)
pedigree_result=trace_pedigree(
                input_pedigree=origin_pedigree,   #provided pedigree data object
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


|Offspring  |Sire       |Dam        |
|:----------|:----------|:----------|
|DD19575312 |DD18768902 |DD16376015 |
|DD19513112 |DD18768902 |DD17111017 |
|DD20348012 |DD19132207 |DD19234510 |
|DD20361110 |DD19331001 |DD19293112 |
|DD20471212 |DD19331001 |DD19320808 |
|DD20564818 |DD19331001 |DD19311009 |

-   4 columns format:


|Offspring  |Sire       |Dam        | Birth_Date|
|:----------|:----------|:----------|----------:|
|DD19575312 |DD18768902 |DD16376015 |   20200101|
|DD19513112 |DD18768902 |DD17111017 |   20200102|
|DD20348012 |DD19132207 |DD19234510 |   20200103|
|DD20361110 |DD19331001 |DD19293112 |   20200104|
|DD20471212 |DD19331001 |DD19320808 |   20200105|
|DD20564818 |DD19331001 |DD19311009 |   20200106|

-   Multiple columns format:


|Offspring  |Sire       |Dam        |SireSire   |DamSire    |SireSireSire |
|:----------|:----------|:----------|:----------|:----------|:------------|
|DD20231905 |DD19581002 |DD18750810 |DD16785512 |DD15507717 |DD14008512   |
|DD20458701 |DD19564302 |DD18925809 |DD15349017 |DD15245411 |DD16771212   |
|DD20324707 |DD19232903 |DD18571012 |DD16794714 |DD16744412 |DD16714516   |
|DD19288609 |DD18713408 |DD18552609 |DD15180015 |DD15479214 |DD15243711   |
|DD16222012 |DD15145005 |DD15378812 |DD14110014 |DD15501518 |DD15206217   |
|DD17684713 |DD16672107 |DD15122311 |DD15505715 |DD15347415 |DD16383111   |

**Note**: When the format of provided pedigree data is multiple columns ，the colnames of pedigree data should be the specify format , e.g. `SireSire` stands for the father of offspring's father, `SirSireSire` stands for the father of  `SireSire`

Missing record in pedigree could be set as  **NA** or **0** .

-   **2：input_pedigree_path**

File path of pedigree data, `character` class.

-   **3：input_pedigree_name**

File name of pedigree data, `character` class.

-   **4：pedigree_format_conversion**

Whether convert multiple columns pedigree into standard 3 columns pedigree, `logical` class.  Whether the format of provided pedigree data is multiple columns, user need to set `pedigree_format_conversion=TRUE` .

-   **5：output_pedigree_path**

File path of output pedigree data, `character` class.

-   **6：output_pedigree_name**

File path of output pedigree name, `character` class.

### 💨Advanced

-   **7：dup_error_check**

Whether check the pedigree error of error_duplicated，`logical` class. Default is TRUE.

-   **8：sex_error_check**

Whether check the pedigree error of error_sex，`logical` class. Default is TRUE.

-   **9：breed_error_check**
