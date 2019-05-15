( ) Prefer not to answer
( ) 13 or younger
( ) 14
( ) 15
( ) 16
( ) 17
( ) 18-20
( ) 21-24
( ) 25-29
( ) 30-39
( ) 40-49
( ) 50-59
( ) 60-69
( ) 70+
14

( ) Je préfère ne pas répondre
( ) 13 ans ou moins
( ) 14
( ) 15
( ) 16
( ) 17
( ) Entre 18 et 20 ans
( ) Entre 21 et 24 ans
( ) Entre 25 et 29 ans
( ) Entre 30 et 39 ans
( ) Entre 40 et 49 ans
( ) Entre 50 et 59 ans
( ) Entre 60 et 69 ans
( ) 70 ans ou plus



;with CTE as
(
select  g.province,
case value
when "Je préfère ne pas répondre" then "Prefer not to answer" 
when  "13 ans ou moins" then "13 or younger"
when "Entre 18 et 20 ans" then "18-20"
when "EEntre 21 et 24 ans" then "21-24"
when "Entre 25 et 29 ans" then "25-29"
when "Entre 30 et 39 ans" then "30-39"
when "EEntre 40 et 49 ans" then "40-49"
when "Entre 50 et 59 ans" then "50-59"
when "EEntre 60 et 69 ans" then "60-69"
when "70 ans ou plus" then "70+"
 else value
end as [value]
from texter_survey_response_value as v 
        left join texter_survey_response as r on r.id=v.response_id
        left join [general_sigtables as g] on r.conversation_id = g.conversation_id
where v.question_id = 69 and [g.startTime:est:date] >= '2018-01-01' and [g.startTime:est:date] <'2019-01-01'
order by g.startTime )
select province,
 count(case  when value = "Prefer not to answer" then value end) as  ["Prefer not to answer"]
,count(case  when value = "13 or younger" then value end) as  ["13-"]
,count(case  when value = "14" then value end) as  ["14"]
,count(case  when value = "15" then value end) as  ["15"]
,count(case  when value = "16" then value end) as  ["16"]
,count(case  when value = "17" then value end) as  ["17"]
,count(case  when value = "18-20" then value end) as  ["18-20"]
,count(case  when value = "21-24" then value end) as  ["21-24"]
,count(case  when value = "25-29" then value end) as  ["25-29"]
,count(case  when value = "30-39" then value end) as  ["30-39"]
,count(case  when value = "40-49" then value end) as  ["40-49"]
,count(case  when value = "50-59" then value end) as  ["50-59"]
,count(case  when value = "60-69" then value end) as  ["60-69"]
,count(case  when value = "70+" then value end) as  ["70+"]
from CTE
where province is not null
group by province 
order by province 
