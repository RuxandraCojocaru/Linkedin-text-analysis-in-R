# Text-analysis-in-R

#GOAL OF PROJECT: #
The main goal has been to investigate the transition from education to employment in Romania, analyzing the romanian work field dedicated to graduates of higher education institutions and highlighting the main aspects of interest using content analysis in R. 

#DATA SOURCE:#
The data used by the textual-analysis methods applied in this scope was collected from the Linkedin platform and consists of 842 job descriptions, which represent raw unstructured data. The data was collected in accordance to the existing  job offers for youth available throughout the month of October 2022. Structured data was also collected in association with each job description, such as the company’s name, city or the type of job (on-site/remote).

#ANALYSIS OF STRUCTERED DATA (data.xlsx):# 
From the structured data it was shown that the romanian market for youth is mainly concentrated geographically in its capital city, Bucharest, along with other regions such as Cluj, Brașov and Timiș. Half of the jobs offered are on-site jobs, followed by remote and hybrid. No matter on what type of position the graduate is intending to apply (intern, junior or associate), the majority of jobs available are full-time. Most work offers are made in the IT Services and IT Consulting sector, Software Development, Motor Vehicle Manufacturing, Financial Services and Appliances Electronical and Electronics Manufacturing, in the detriment of jobs on the humanities spectrum.

#ANALYSIS OF UNSTRUCTERED DATA (files):#
The word-cloud analysis points to the words ‘experience’, ‘team’ , ‘work’, ‘skills’, ‘development’, ‘knowledge’, ‘support’, ‘data’, ‘business’, ’software’, ‘management’, ‘services’, ‘environment’ and ‘customer’ as being the most present words in the job descriptions analyzed.
![image](https://user-images.githubusercontent.com/101098099/220897929-16390091-82aa-4d30-bcc4-8fa05cf85f4b.png)

#FREQUENT PAIRS OF WORDS:# 
Markup : -The most used pairs of words, called bi-grams, are ‘communication skills’ with 283 appearances, ‘sexual orientation’ with 152, ‘equal opportunity’ and ‘national origin’ with 144, ‘job description’ with 134 and ‘gender identity’ with 130 incidences. 
Markup : -The word ‘skill’ has been found to be preponderantly linked to the following words: ‘communication’, ‘analytical’, ‘interpersonal’, ‘language’, ‘solving’, ‘soft’, ‘management’, ‘presentation’ and ‘english’. 
Markup : -In terms of foreign languages, the most proeminent in the texts are english, german, french, italian and spanish, with english being by far the most searched for language. 
Markup : -Moreover,the word ‘receive’ pinpoints to what students/graduates are said to obtain from their employers: ‘consideration’, ‘feedback’, ‘mentorship’. In turn, employees have to deliver things that are associated with words like  ‘unique’, ‘results’, ‘centralized’, ‘client’, ‘exceptional’, ‘excellent’. 
Markup : -Finally, the word ‘bonus’ is used to describe what kind of rewards employees might obtain should they perform well: the most correlated word is ‘access’, meaning that employees get to benefit of access to new facilities or platforms, while other associations to bonuses are ‘transport’, ‘medical’, ‘private’, ‘psychological’ and ‘communication’.

#WORD AND CORRELATION NETS: 
The correlation net portrayed the central nodes to be ‘experience’, ‘team’ and ‘skills’ and the pairs being formed are: experience-team-skills-knowledge-development-english-environment-support-communication-business-management. The combinations of words most encountered are gender-age-color-marital-physical-mental-inclusion.
![image](https://user-images.githubusercontent.com/101098099/220899264-f0372525-1407-46de-91b8-9c65c00e0862.png)
![image](https://user-images.githubusercontent.com/101098099/220899522-07f3bc63-037f-4e00-aa6e-117a9d1178e8.png)

#TOPIC MODELLING: 
Using topic modelling more clusterizations have been tried in order to identify the best way of grouping words.Topic modelling findings recommended the presence of four main clusters of topics covered in job descriptions.

![image](https://user-images.githubusercontent.com/101098099/220899618-6b6909d4-3c34-48e4-b09d-20ed827b907f.png)
The first cluster is linked with words that indicate the business sector as its main topic. The second cluster puts emphasis on soft skills, whereas the third one concentrates around the software industry and the fourth one seems to refer to hardware.
