# Schools
## Analysis of school admission and performance data for Surrey and Hampshire

This repo contains data and analysis relating to primary school admission and performance data in Surrey and Hampshire for academic years going as far back as 2014.

## Files and folders in this repo

### [data-in](/data-in)
Contains the raw data used for the analysis. Note that due to the current COVID-19 pandemic, the UK Government is not publishing any data relating to school performance for 2020 and it is unlikely to do so for 2021. At the time of writing, this means that the most recent academic year for which performance data is available is 2018/19.

#### [ks2](/data-in/ks2)

* Source: [School Performance Data Download Service](https://www.compare-school-performance.service.gov.uk/download-data)

Contains Key Stage 2 performance data for primary schools in Hampshire (Local Authority no. 850) and Surrey (LA no. 936) for the academic years 2016/17, 2017/18 and 2018/19. In order to generate each file, I made the following selections:

1. Academic year: either 2016/17, 2017/18 or 2018/19
2. Local authority: either Hampshire (850) or Surrey (936)
3. Data types: Final key stage 4

Further details including an explanation of the terminology used in these data files can be found in the [ref](/ref) folder.

#### [offers-criteria](/data-in/offers-criteria)

* Source: [Surrey County Council](https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years)

Contains the number of Year R places offered by criteria, school and academic year across all primary schools in Waverley Borough (part of the Surrey local authority) for academic years 2018/19 through to 2021/22.

The CSV files in this folder were manually transcribed from the source PDF files and may contain transcription errors.

#### [offers-school](/data-in/offers-school)

* Source: [Surrey County Council](https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years)

Contains the total number of Year R places offered and the last distance offered metric by school and academic year for all primary schools in Waverley for academic years 2018/19 through to 2021/22.

The CSV files in this folder were manually transcribed from the source PDF files and may contain transcription errors.

#### [offers-la](/data-in/offers-la)

* AppsandOffers_2021.csv

This file contains statistics relating to the number of offers made to applicants for secondary and primary school places for academic years from 2014-2015 through to 2021-2022, and the proportion which received preferred offers. I downloaded this file from the [UK Government Explore Education Statistics service][4].

#### Waverley Offers

* 2018_936_waverley_offers_crit.csv
* 2018_936_waverley_offers_school.csv
* 2019_936_waverley_offers_crit.csv
* 2019_936_waverley_offers_school.csv
* 2020_936_waverley_offers_crit.csv
* 2020_936_waverley_offers_school.csv
* 2021_936_waverley_offers_crit.csv
* 2021_936_waverley_offers_school.csv

The files above contain school-level admissions data for Waverley Borough in Surrey. The data is restricted to primary school admissions for Year R intake only. The dataset includes the Published Admission Number (PAN) for each school, the number of applications received (of any preference) and the number of places offered both overall and by admission criterion. The dataset also includes the Last Distance Offered metric which details the furthest distance from the school that an applicant lives when the school is oversubscribed.

#### School Information

* 2021-05-07_850_936_gias.csv

The file above contains additional data relating to primary schools in Hampshire (LA no. 850) and Surrey (LA no. 936). In order to generate this file, I navigated to the [get information about schools service][2] and made the following selections:

1. Find an establishment by local authority: Hampshire and Surrey. Includes open schools only.
2. On the search results page I filtered the results to All-through, Middle Deemed Primary and Primary
3. On the next page I opted to choose a specific set of data and entered the following fields: DistrictAdministrative(name), EstablishmentNumber, EstablishmentName, EstablishmentTypeGroup(name), LA(code), OfstedRating(name), PercentageFSM, PhaseOfEducation(name), ReligiousCharacter(name), URN

### ref
Contains reference materials related to this analysis. Each file in this directory contains additional details about the contents of the raw data csv files in the **data-in** folder. Further information and definitions of commonly used terms in the field of education performance measures can be found on the [GIAS glossary page][3].

### schools.Rproj
The R Project file for this analysis.

### schools-data-prep.R
R script to read, clean and prepare data from the [data-in](/data-in) directory for analysis.

### read.R
R script file to read in the raw data (from the data-in directory).

### clean.R
R script file to clean the raw data. Selects required columns and renames columns for brevity, removes unwanted rows.

### eda.R
R script file for exploratory data analysis. Used to get to know the contents of the raw data better whilst cleaning it.

### offers_la.R
R script file to prepare and export the data for analysis of school offers by local authority.

### performance.R
R script file to prepare the data for analysis of primary school KS2 performance. Summarises ks2 performance data to report a single average score for the 3 years of data collected.

### rda
Contains saved rda files.

## Sources and Credits
* Find and compare schools in England (<https://www.gov.uk/school-performance-tables>)
* Get information about schools (<https://get-information-schools.service.gov.uk/>)
* Explore education statistics (<https://explore-education-statistics.service.gov.uk/>)
* Waverley school admissions (<https://www.surreycc.gov.uk/schools-and-learning/schools/admissions/arrangements-and-outcomes/previous-years>)

[1]: <https://www.compare-school-performance.service.gov.uk/download-data> "School performance download service"
[2]: <https://get-information-schools.service.gov.uk/> "Get information about schools"
[3]: <https://get-information-schools.service.gov.uk/glossary> "GIAS glossary"
[4]: <https://explore-education-statistics.service.gov.uk/find-statistics/secondary-and-primary-school-applications-and-offers#dataDownloads-1> "Applications and Offers"
