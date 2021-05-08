# Schools
## Analysis of school admission and performance data for Surrey and Hampshire

This repo contains data and analysis relating to primary school admission and performance data in Surrey and Hampshire for academic years beginning September 2016.

## Files and folders in this repo

### data-in
Contains the raw data used for the analysis. Note that due to the current COVID-19 pandemic, the UK Government is not publishing any data relating to school performance for 2020 and it is unlikely to do so for 2021. At the time of writing, this means that the most recent academic year for which performance data is available is 2018-2019.

#### KS2 Performance

* 2016-2017_850_ks2final.csv
* 2016-2017_936_ks2final.csv
* 2017-2018_850_ks2final.csv
* 2017-2018_936_ks2final.csv
* 2018-2019_850_ks2final.csv
* 2018-2019_936_ks2final.csv

The files above contain Key Stage 2 performance data for primary schools in Hampshire (Local Authority no. 850) and Surrey (LA no. 936) for the academic years 2016-2017, 2017-2018 and 2018-2019. In order to generate each file, I navigated to the [school performance data download service][1] and made the following selections:

1. Academic year: either 2016-2017, 2017-2018 or 2018-2019
2. Local authority: either Hampshire (850) or Surrey (936)
3. Data types: Final key stage 4

Further details including an explanation of the terminology used in these data files can be found in the **ref** folder.

#### School Information

* 2021-05-07_850_936_gias.csv

The file above contains additional data relating to primary schools in Hampshire (LA no. 850) and Surrey (LA no. 936). In order to generate this file, I navigated to the [get information about schools service][2] and made the following selections:

1. Find an establishment by local authority: Hampshire and Surrey. Includes open schools only.
2. On the search results page I filtered the results to All-through, Middle Deemed Primary and Primary
3. On the next page I opted to choose a specific set of data and entered the following fields: DistrictAdministrative(name), EstablishmentNumber, EstablishmentName, EstablishmentTypeGroup(name), LA(code), OfstedRating(name), PercentageFSM, PhaseOfEducation(name), ReligiousCharacter(name), URN

### ref
Contains reference materials related to this analysis.

* 2016-2017
* 2017-2018
* 2018-2019

Each of the subfolders above contains additional details about the contents of the raw data csv files in the **data-in** folder. Further information and definitions of commonly used terms in the field of education performance measures can be found on the [GIAS glossary page][3].

### schools.Rproj
The R Project file for this analysis.

## Sources and Credits
* Find and compare schools in England (<https://www.gov.uk/school-performance-tables>)
* Get information about schools (<https://get-information-schools.service.gov.uk/>)

[1]: <https://www.compare-school-performance.service.gov.uk/download-data> "School performance download service"
[2]: <https://get-information-schools.service.gov.uk/> "Get information about schools"
[3]: <https://get-information-schools.service.gov.uk/glossary> "GIAS glossary"