

# Overview ----------------------------------------------------------------
#For my final project I will be using looking at stage of diagnosis of breast cancer among HIV+ and HIV- patients in a cohort from Botswana.  Women enrolled into the study between 2015 & 2019 (currently still enrolling).  Possible confounding variables could be age, SES and marital status.

# Introduction ------------------------------------------------------------
#Cancer is a burden around the globe.   Looking at the epidemiology of cancer worldwide, there are 18 million incident cancer cases per year and 9.6 million deaths annually.  85% of these deaths occur in low to middle income countries.  Africa is disproportionately affected, as is  most sub-Saharan Africa.  
#As motivation for this project, in recognizing the high burden of morbidity and mortality of this disease in Africa, there a paucity of research being done focusing on cancer and deaths from cancer, particularly in Botswana.  Identifying and reporting on characteristics will allow us a better understanding of the landscape of cancer in Botswana and will help aid in the direction of resources and help direct future educational and screening interventions, all with the intent of reducing the morbidity and mortality of this growing epidemic.

#This is a multidisciplinary because it pulls in expertise from chronic diseases, infectious diseases, biostatistics, and and epidemiology.There also needsd to be a clinical understanding of breast cancer (Surbhi Grover).  We will use logsitic regression, chi2 tests and other statistical techniques to look at these factors  We will try to implement machine learning techniques to tease apart risk factors, like a decision tree anylsis (Ryan Urbanowicz) and survival analysis (Tim Rebbeck).  I will also be able to look at some geographic factors that could be risk factors due to being barriers in access to care. (Sherri Zie). 

#Background:
#Botswana is a landlocked country in sub-Saharan Africa.  It is sparsely populated with a population of 2.3 million people and the male/female ratio is approximately 50%.  It is a middle income country with government funded healthcare.  The past few decades have been spent on the HIV epidemic.  There has been great progress battling this infectious disease, and due to this success, the burden of disease is shifting from infectious to chronic diseases, adding to the increasing life span in Botswana.  Currently, the lifespan is 64 years old for males and 68 years for females.  In 2000, approximately 20 years ago, the lifespan was 48 years old.  This makes it an opportune time to focus on cancer, given that the population is living longer and consequently at an increased risk for developing cancer.
#Botswana has government funded healthcare, so healthcare is available and affordable for all citizens.  There is a de-centralized health care system ranging from mobile posts to referral hospitals all around the country.  There are 27 health districts throughout Botswana and each district has access to varying resources.  There are 844 mobile posts throughout the country.  These posts are often staffed with a health education assistant and a lay counselor.  Health posts, of which there are 338, often have a nurse and visits from a midwife and a doctor.   Clinics offer mainly primary health care and outpatient services, treatment of injuries and minor illnesses with serious cases referred to hospitals. Some clinics have access to diagnostic services. Larger clinics and clinics with maternity wards offer most of the primary health care services to the country.  The most equipped facilities in the country are referral hospitals, of which there are 3 in the country.  Referral hospitals are highly advanced facilities prepared to deal with specialized problems, like cancer.   Two of the referral hospitals are located in Gaborone, Botswana and one is in Francistown.  These are the only available facilities in the country where one can receive advanced treatments for cancer.

#Cohort:
#The data from the Botswana Cancer Cohort.  In 2001 a partnership was formed between the University of Pennsylvania, Botswana’s Ministry of Health and the University of Botswana, commonly known as BUP, the Botswana University of Pennsylvania Partnership.  This partnership has worked for 2 decades to combat the HIV/AIDS epidemic and has more recently recognized the need to expand priorities to include chronic diseases.   In 2015, a multidisciplinary clinic formed at Princess Marina Hospital, which is one of the 3 referral hospitals in the country.  This clinic diagnoses individuals with malignancies from all over the country.  It enrolls patients into a prospective cohort study, the Botswana Cancer Cohort.  Patients from both PMH and the second referral hospital in Gaborone, Gaborone Private Hospital (GPH), are enrolled into the BCC.  Patients are diagnosed at this clinic and then referred to the appropriate clinic for treatment and follow up care.  Eligible patients enrolled into the BCC are over the age of 18, have a diagnosis of cancer, and have given informed consent.  All patients are followed up with every three months, and those patients undergoing treatment are followed during every treatment visit until completion.  Information collected in this database includes patient demographics, tumor characteristics, treatment information and follow up.  All of this information is stored in a redcap database.  

# Methods -----------------------------------------------------------------
#Database:
#Seventeen different types of cancers are represented in this cohort.  Given this is an ongoing, prospective cohort, as of the end of October 2019, a total of 2119 individuals with a cancer diagnosis were enrolled.  Cervical cancer is the most common cancer diagnosed in this cohort with over 900 cancers diagnosed to date.  This is followed by breast cancer, the second most frequent cancer to be diagnosed, with over 400 cancers in the database, and head and neck cancer is the third most commonly diagnosed cancer in this cohort.  Other top malignancies being captured include vulvar, kaposi’s sarcoma, endometrial, lymphoma and esophageal.

#Pulling in my data: Botswana Cancer Cohort
library(readxl)
final_project_BCC <- read_excel("final_project.BCC.xls")
View(final_project_BCC)
str(final_project_BCC)
head(final_project_BCC)
library(tidyverse)

#select variables from dataset
final_project<-final_project_BCC %>%
  select(record_id, enrollment_site, gender, smoker, seeing_natural_healer, height_cm, weight_kg, age, yearofvisit, yearofdeath, stage_high, stage_new, hiv, dead, assume_dead, marital_status)
str(final_project)
table<- final_project %>%
  select(age, gender, assume_dead, smoker, stage_high, yearofvisit, yearofdeath)
library(knitr)
library(kableExtra)
options(knitr.kable.NA='')

#data summary
kable(summary(table))
library(ggplot2)
#Risk factors: 

#One of the most important risk factors for death from cancer is stage at diagnosis.  Cancer diagnosed at an advanced stage, stages III & IV, have an increase in morbidity and mortality, while cancers diagnosed at an earlier stage, stages I & II, have a better chance at curative treatment.  In the United States for example, with treatment, 80-90% of women with stage I cervical cancer, and 60-75% of those with stage II cervical cancer are alive 5 years after diagnosis. Survival rates decrease to 30-40% for women with stage III cancer and 15% or fewer of those with stage IV cervical cancer are alive five years after diagnosis.  Therefore, it is important to characterize the stages that cancers are being diagnosed in this cohort.  The majority of cancer in this population, 56%, are presenting at an advanced stage.  
#do a graph os stage
#In looking at stages of diagnosis in the United States vs. the BCC, many cancers in the United States are diagnosed at an earlier stage.  For example, for cervical cancer, 85% of cervical cancers in the United States are diagnosed at an early stage.  In the past 40 years in the US, the death rate from cervical cancer has decreased 50%, most likely due to screening and the subsequent early diagnosis of cervical cancer. A few other examples, 68% of breast cancers are diagnosed at an early stage in the US vs. 21% of breast cancers presenting in this cohort, 75% of colon cancers vs. <20% in here, over 90% of prostate cancers are diagnosed at an early stage vs. only 15% of prostate cancers in the BCC, and for lung cancer, 30% are stage 1 or II at diagnosis, yet there were no early stage lung cancers diagnosed in this cohort. These represent just some of the differences seen between high income countries and low income countries.   

#Another known risk factor for cancer is age.  The median age is 48.9 years old (range: XX-XX), which is younger than the median age of 66 in the United States (ref).  In addition, the life expectancy in Botswana in 2000 was 48 (ref), but now it is in the upper 60s, so individuals are now living well past this median age of diagnosis, putting this aging population at an increased risk for developing cancer.  
#When studying health in Botswana, it is important to recognize the high prevalence of HIV in this population.  In addition, there are known HIV associated cancers.  In this cohort, 58% of the population is HIV positive.  HIV associated cancers, Cervical, vulvar, oral cavity, Hodgkin Lymphoma, pharynx, Kaposi Sarcoma, all show a large proportion of cancer patients also co-infected with HIV.   There are 9 cancer types that have over 50% of patients that are HIV +.  There are a few cancers not known to be associated with HIV, like Breast, prostate, colon, ovarian, and we can see that for these cancers there are proportionately less patients with HIV.  However, it remains important to account for this co-morbidity in patients as it may affect their diagnosis, treatment and survival from cancer.  
#It is not surprising that the age of cancer diagnosis is significantly different between HIV+ and HIV- patients.  This box plot shows that the median age of cancer diagnosis in the HIV- population is 58 years old, while the median age in the HIV + population is 14 years younger, or 44 years old.  The factors associated with this difference have yet to be elucidated, yet it is important to consider this difference in any analysis when looking at malignancies in Botswana.  

#graphs of variables to be used in the analysis
#histogram of age
ggplot(data=final_project, aes(x=age)) +
  geom_histogram(binwidth=3) +
  ggtitle(paste("Patinets age distribution")) + 
  theme (
    text=element_text(family="Palatino"),
    plot.title=element_text(hjust=0, face="bold", size=20))

#bar graph of marital status
ggplot(data=final_project, aes(x=marital_status)) +
  geom_bar() +
  ggtitle(paste("Patient's marital status")) + 
  theme (
    text=element_text(family="Palatino"),
    plot.title=element_text(hjust=0, face="bold", size=20))

#bar graph of year of visit
#total<-na.exclude(final_project)
ggplot(data=final_project, aes(x=yearofvisit)) +
  geom_bar() +
  ggtitle(paste("Year of Visit")) + 
  theme (
    text=element_text(family="Palatino"),
    plot.title=element_text(hjust=0, face="bold", size=20))
#need fill to be a characrter not a number

#histogram of HIV
ggplot(data=final_project, aes(x=age, fill=hiv)) +
  geom_histogram(binwidth=3) +
  scale_fill_manual(values=c("gray40", "gray90")) +
  theme_bw() +
  ggtitle(paste("Survival Status of all Patients Across Ages")) + 
  theme (
    text=element_text(family="Palatino"),
    plot.title=element_text(hjust=0, face="bold", size=20))

#try for a choropleth of the contry
#Cancers being presented in this cohort are geographically representative of the country’s population.  Every district has contributed some cases to this cohort, demostrating that districts from all over the country will come to the referral hospitals for treatment.  There are more cancers from the districts closer to Gaborone and much fewer cancers coming from districts further away.  

#graph/plot mortality
#In regards to mortality among the cohort, of the 167 malignancies diagnosed in 2015, 71 or 43% have died.  Overall in the cohort, 20% or 421 of the over 2000 cancers captured in this cohort have died.   

#Conclusions: 
#In conclusion, there are a large number of cancers in Botswana presenting at referral hospitals.  In the cohort, 56% are presenting at an advanced stage, the median age at diagnosis is relatively young and the majority of patients are HIV +.  In addition, cancer are being diagnosed from districts all around the country.  

#There are limitations to this study.  A main limitation is the generalizability.  This cohort is only capturing those cancers presenting at the clinic at PMH and does not represent the entire population.  There could also be selection bias in cohort as well as loss to follow up and missing data.  Inconsistency with subdistricts (different classifications from different sources)

#This is a necessary first step in gathering and reporting on malignancies in this cohort & this country.  Tailored interventions and treatments need to be developed for this unique population to diagnose cancers at an earlier stage and be aware of co-morbidities during treatment.  In addition, we aim to identify points of intervention for this cohort, interventions like education, screening, access to care and vaccines to name a few, to increase awareness about cancer.  All of this effort is done with the ultimate goal of reducing the increasing burden if morbidity and mortality due to cancer in Botswana.  
