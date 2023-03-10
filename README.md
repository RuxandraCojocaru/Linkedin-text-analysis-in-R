# Text-analysis-in-R

### GOAL OF PROJECT: 
The main goal has been to investigate the transition from education to employment in Romania, analyzing the romanian work field dedicated to graduates of higher education institutions and highlighting the main aspects of interest using content analysis in R. 

### DATA SOURCE:
The data used by the textual-analysis methods applied in this scope was collected from the Linkedin platform and consists of 842 job descriptions, which represent raw unstructured data. The data was collected in accordance to the existing  job offers for youth available throughout the month of October 2022. Structured data was also collected in association with each job description, such as the company’s name, city or the type of job (on-site/remote).

### ANALYSIS OF STRUCTERED DATA (data.xlsx):
From the structured data it was shown that the romanian market for youth is mainly concentrated geographically in its capital city, Bucharest, along with other regions such as Cluj, Brașov and Timiș. Half of the jobs offered are on-site jobs, followed by remote and hybrid. No matter on what type of position the graduate is intending to apply (intern, junior or associate), the majority of jobs available are full-time. Most work offers are made in the IT Services and IT Consulting sector, Software Development, Motor Vehicle Manufacturing, Financial Services and Appliances Electronical and Electronics Manufacturing, in the detriment of jobs on the humanities spectrum.

### ANALYSIS OF UNSTRUCTERED DATA (files):
The word-cloud analysis points to the words ‘experience’, ‘team’ , ‘work’, ‘skills’, ‘development’, ‘knowledge’, ‘support’, ‘data’, ‘business’, ’software’, ‘management’, ‘services’, ‘environment’ and ‘customer’ as being the most present words in the job descriptions analyzed.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/220906499-4f5ec5e8-4d49-4404-bb81-b6dd542ea9e6.png">
</div>


### FREQUENT PAIRS OF WORDS: 
- The most used pairs of words, called bi-grams, are ‘communication skills’ with 283 appearances, ‘sexual orientation’ with 152, ‘equal opportunity’ and ‘national origin’ with 144, ‘job description’ with 134 and ‘gender identity’ with 130 incidences. 
- The word ‘skill’ has been found to be preponderantly linked to the following words: ‘communication’, ‘analytical’, ‘interpersonal’, ‘language’, ‘solving’, ‘soft’, ‘management’, ‘presentation’ and ‘english’. 
- In terms of foreign languages, the most proeminent in the texts are english, german, french, italian and spanish, with english being by far the most searched for language. 
- Moreover,the word ‘receive’ pinpoints to what students/graduates are said to obtain from their employers: ‘consideration’, ‘feedback’, ‘mentorship’. In turn, employees have to deliver things that are associated with words like  ‘unique’, ‘results’, ‘centralized’, ‘client’, ‘exceptional’, ‘excellent’. 
- Finally, the word ‘bonus’ is used to describe what kind of rewards employees might obtain should they perform well: the most correlated word is ‘access’, meaning that employees get to benefit of access to new facilities or platforms, while other associations to bonuses are ‘transport’, ‘medical’, ‘private’, ‘psychological’ and ‘communication’.

### WORD AND CORRELATION NETS: 
The correlation net portrayed the central nodes to be ‘experience’, ‘team’ and ‘skills’ and the pairs being formed are: experience-team-skills-knowledge-development-english-environment-support-communication-business-management. The combinations of words most encountered are gender-age-color-marital-physical-mental-inclusion.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/220905558-c7490607-41db-4574-8252-a51b30587d8e.png">
</div>

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/220905343-8de9b31a-5a95-4f90-856d-08e4a4757a03.png">
</div>

### TOPIC MODELLING: 
Using topic modelling more clusterizations have been tried in order to identify the best way of grouping words.Topic modelling findings recommended the presence of four main clusters of topics covered in job descriptions.

<div align="center">
    <img src="https://user-images.githubusercontent.com/101098099/220906199-2da6cfb5-6930-408c-81ff-a3890a67cba3.png">
</div>

The first cluster is linked with words that indicate the business sector as its main topic. The second cluster puts emphasis on soft skills, whereas the third one concentrates around the software industry and the fourth one seems to refer to hardware.
