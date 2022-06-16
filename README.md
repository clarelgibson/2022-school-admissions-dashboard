# Schools
## Analysis of school admission and performance data for Surrey and Hampshire

This repo contains data and analysis relating to primary school admission and performance data in Surrey and Hampshire for academic years going as far back as 2014.

## Files and folders in this repo

### [data-in](/data-in)
Contains the raw data used for the analysis. Note that due to the current COVID-19 pandemic, the UK Government is not publishing any data relating to school performance for 2020 and it is unlikely to do so for 2021. At the time of writing, this means that the most recent academic year for which performance data is available is 2018/19.

#### [info](/data-in/info)

* Source: [Get Information About Schools](https://get-information-schools.service.gov.uk/)

The file above contains additional data relating to primary and secondary schools in all local authorities. It excludes nurseries, special schools, children's centers, pupil referral units and post-16 education. In order to generate this file, I  made the following selections:

1. Find an establishment: All establishments. Includes open and closed schools.
2. On the search results page I filtered the Phase of education to All-through, Middle Deemed Primary, Middle Deemed Secondary, Primary and Secondary.
3. On the next page I opted to choose the full set of data, including links.

Once the file was downloaded I performed one additional preparatory step. I ensured that every column had a heading by scrolling to the very right of the table and renaming the blank columns. These are columns containing additional linked establishments so I used a `Links 1`, `Links 2`, `Links 3` etc naming convention.

#### [ks2](/data-in/ks2)

* Source: [School Performance Data Download Service](https://www.compare-school-performance.service.gov.uk/download-data)

Contains Key Stage 2 performance data for primary schools in Hampshire (Local Authority no. 850) and Surrey (LA no. 936) for the academic years 2016/17, 2017/18 and 2018/19. In order to generate each file, I made the following selections:

1. Academic year: either 2016/17, 2017/18 or 2018/19
2. Local authority: either Hampshire (850) or Surrey (936)
3. Data types: Final key stage 4

Further details including an explanation of the terminology used in these data files can be found in the [ref](/ref) folder.

Note that due to COVID-19, the UK Government [cancelled all statutory national curriculum assessments](https://www.gov.uk/government/publications/school-and-college-accountability-approach-2020-to-2022/school-and-college-accountability-2020-to-2021-academic-year) due to be held in summer 2020 and 2021 at both Key Stage 1 and Key Stage 2. Therefore, no data is available for the 2019/20 or 2020/21 academic years. For the 2021/22 academic year, the Government does intend to publish KS2 data. This data should be made available in autumn 2022.

#### [offers-criteria](/data-in/offers-criteria)

* Source: [Surrey County Council](https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years)

Contains the number of Year R places offered by criteria, school and academic year across all primary schools in Waverley Borough (part of the Surrey local authority) for academic years 2018/19 through to 2021/22.

The CSV files in this folder were manually transcribed from the source PDF files and may contain transcription errors.

#### [offers-school](/data-in/offers-school)

* Source: [Surrey County Council](https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years)

This dataset includes the Published Admission Number (PAN) for each school, the number of applications received (of any preference) and the number of places offered both overall and by admission criterion. The dataset also includes the Last Distance Offered metric which details the furthest distance from the school that an applicant lives when the school is oversubscribed. Data is included for academic years 2018/19 through to 2021/22.

The CSV files in this folder were manually transcribed from the source PDF files and may contain transcription errors.

Further details including an explanation of the terminology used in these data files can be found in the [ref](/ref) folder.

#### [offers-la](/data-in/offers-la)

* Source: [Explore Education Statistics Service](   https://explore-education-statistics.service.gov.uk/find-statistics/secondary-and-primary-school-applications-and-offers#dataDownloads-1)

This file contains statistics relating to the number of offers made to applicants for secondary and primary school places for academic years from 2014/15 through to 2021/22, and the proportion which received preferred offers.

Further details including an explanation of the terminology used in these data files can be found in the [ref](/ref) folder.

### [data-out](/data-out)
Contains cleaned data tables for use in the analyses.

### [rda](/rda)
Contains saved rda files.

### [ref](/ref)
Contains reference materials related to this analysis. Each file in this directory contains additional details about the contents of the raw data csv files in the [data-in](/data-in) folder. Further information and definitions of commonly used terms in the field of education performance measures can be found on the [GIAS glossary page](https://get-information-schools.service.gov.uk/glossary).

### [schools-data-prep.R](schools-data-prep.R)
R script to read, clean and prepare data from the [data-in](/data-in) directory for analysis.

## Sources and Credits
* Find and compare schools in England (<https://www.gov.uk/school-performance-tables>)
* Get information about schools (<https://get-information-schools.service.gov.uk/>)
* Explore education statistics (<https://explore-education-statistics.service.gov.uk/>)
* Waverley school admissions (<https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years>)
