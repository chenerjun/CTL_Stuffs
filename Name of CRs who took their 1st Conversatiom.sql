select 
 u.firstname+'_'+u.lastname as name
,  u.email
, min([g.startTime:est:date]) as FirstConversation
from [general_sigtables as g]  join user as u on g.user_ID = u. ID
where u.email not like '%@crisistextline.org%'
group by name, u.email
order by name