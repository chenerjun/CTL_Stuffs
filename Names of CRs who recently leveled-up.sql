;with 
 L1 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=1 and count(conversation_id) <=9 order by 2 ,1)
,L2 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=10 and count(conversation_id) <=19 order by 2 ,1)
,L3 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=20 and count(conversation_id) <=49 order by 2 ,1)
,L4 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=50 and count(conversation_id) <=99 order by 2,1)
,L5 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=100 and count(conversation_id) <=249 order by 2,1)
,L6 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=250 and count(conversation_id) <=499 order by 2 ,1)
,L7 as (select    user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=500 and count(conversation_id) <=999 order by 2 ,1)
,L8_Plus as (select  user_id,count(conversation_id) as num from [general_sigtables] group by 1  
       having count(conversation_id) >=1000 and count(conversation_id)  order by 2,1)
,L1D AS (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L1) group by user_id)
,L2D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L2) group by user_id)
,L3D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L3) group by user_id)
,L4D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L4) group by user_id)
,L5D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L5) group by user_id)
,L6D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L6) group by user_id)
,L7D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L7) group by user_id)
,L8D as (select Max( startTime) as Date_ , max(conversation_id) as Conversation_ID , user_id from [general_sigtables] 
         where user_id in (select user_id from L8_Plus) group by user_id)
select 'Level_1' as 'Level', u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"] 
  from L1 left join L1D on L1.user_id = L1D.user_id left join user as u on L1.user_id = u.id
union
  SELECT 'Level_2' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"]
  from L2 left join L2D on L2.user_id = L2D.user_id left join user as u on L2.user_id = u.id
union
  select 'Level_3' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"] 
  from L3 left join L3D on L3.user_id = L3D.user_id left join user as u on L3.user_id = u.id
union
  select 'Level_4' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"]
  from L4 left join L4D on L4.user_id = L4D.user_id left join user as u on L4.user_id = u.id
union
  SELECT 'Level_5' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"] 
  from L5 left join L5D on L5.user_id = L5D.user_id left join user as u on L5.user_id = u.id
union
  select 'Level_6' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"]
  from L6 left join L6D on L6.user_id = L6D.user_id left join user as u on L6.user_id = u.id
union
  select 'Level_7' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"]
  from L7 left join L7D on L7.user_id = L7D.user_id left join user as u on L7.user_id = u.id
union
  select 'Level_8_plus' as 'Level' , u.firstName +' '+  u.lastName as name  , u.email, [date_:est:date] as ["Achieve_Level_date(EST)"]
  from L8_Plus left join L8D on L8_Plus.user_id = L8D.user_id left join user as u on L8_Plus.user_id = u.id
order by Level, name, ["Achieve_Level_date(EST)"] 