select
  (
    select
      "Yesterday"
  )
  as Window
  , conversations
  , texters
  , dacs
  , WaitTime
  , quality
from
  [kpis_all]
where
  date_ = [now():est:date] - interval '1 day'
union all
select
  (
    select
      "Prev 28 Days"
  )
  as Window
  , sum(conversations) as conversations
  , (
    select
      count(distinct actor_id) as texters
    from
      [general_sigtables as b]
    where
      [startTime:est] between [now():est:date] - interval '29 day'
      and [now():est:date] - interval '1 day'
  )
  as texters
  , (
    select
      macs
    from
      [kpis_all]
    where
      date_ = [now():est:date] - interval '1 day'
  )
  as macs
  , (
    select
      1.0 * sum(
        case
          when extract('EPOCH' from b.takenFromQueue - b.addedToQueue) < 300
            then 1
          when extract('EPOCH' from b.takenFromQueue - b.addedToQueue) >= 300
            then 0
          else null
        end
      )
      / count(b.conversation_id) as waittime
    from
      [general_sigtables as b]
    where
      b.takenFromQueue is not null
      and b.addedToQueue is not null
      and [startTime:est] between [now():est:date] - interval '29 day'
      and [now():est:date] - interval '1 day'
  )
  waittime
  , (
    select
      [sn_metric_quality(Quality_val)] as quality
    from
      [general_sigtables as b]
    where
      [startTime:est] between [now():est:date] - interval '29 day'
      and [now():est:date] - interval '1 day'
  )
  as quality
from
  [kpis_all]
where
  date_ between [now():est:date] - interval '29 day'
  and [now():est:date] - interval '1 day'
union all
select
  (
    select
      "All Time"
  )
  as Window
  , sum(conversations) as conversations
  , (
    select
      count(distinct actor_id) as texters
    from
      [general_sigtables as b]
  )
  as texters
  , (
    select
      macs
    from
      [kpis_all]
    where
      date_ = [now():est:date] - interval '1 day'
  )
  as macs
  , (
    select
      1.0 * sum(
        case
          when extract('EPOCH' from b.takenFromQueue - b.addedToQueue) < 300
            then 1
          when extract('EPOCH' from b.takenFromQueue - b.addedToQueue) >= 300
            then 0
          else null
        end
      )
      / count(b.conversation_id) as waittime
    from
      [general_sigtables as b]
    where
      b.takenFromQueue is not null
      and b.addedToQueue is not null
  )
  waittime
  , (
    select
      [sn_metric_quality(Quality_val)] as quality
    from
      [general_sigtables as b]
  )
  as quality
from
  [kpis_all]
order by
  1 desc