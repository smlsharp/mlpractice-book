structure AnalyzeDB = 
struct
  type dbty =(DBSchema.covidDB, _) SQL.db
  type resultTy = {累積陽性者:real, 
                   都道府県名:string, 
                   人口（万人）:real, 
                   累積陽性者割合（／万人）:real}
  fun fromDB (db : dbty) =
   _sql from #db.都道府県一覧,
             #db.都道府県別人口,
             #db.都道府県別累積陽性者
  fun whereDB (db : dbty) =
    _sql where 
    (#都道府県一覧.都道府県名 = #都道府県別累積陽性者.都道府県名
     and #都道府県一覧.コード = #都道府県別人口.コード)
  fun displayRatio (db : dbty)  =
    _sql select 
        #都道府県別累積陽性者.累積陽性者 as 累積陽性者,
        #都道府県一覧.都道府県名 as 都道府県名,
        #都道府県別人口.人口 / 10000.0 as 人口（万人）,
        (#都道府県別累積陽性者.累積陽性者
            / #都道府県別人口.人口) * 10000.0
         as 累積陽性者割合（／万人）
  val Q = _sql db : dbty => 
          select ...(displayRatio db)
          from ...(fromDB db)
          where ... (whereDB db)
          order by #.累積陽性者割合（／万人） desc
end
