structure DBSetup =
struct
 fun setupDB () =
   let
     val conn = SQL.connect DBSchema.covidDBServer
     val {都道府県コード, 都道府県人口, 累積陽性者} = DataSource.import()
     val データソース =
         [{都道府県データ = DataSource.都道府県人口Url,
           都道府県データ取得日時 = 
           #date (#RESULT  (#GET_STATS 都道府県人口)),
           covid19 = DataSource.累積陽性者Url,
           covid19更新日 = #lastUpdate (hd 累積陽性者)
         }]
(*
     val 都道府県一覧: DBSchema.都道府県一覧ty list = 
         map (fn {"@name" =n, "@regionCode" = c} =>
                 {都道府県名 = n, コード =c}) 
             (#CLASS (hd ((#CLASS_OBJ o #CLASS_INF o #METADATA_INF o #GET_META_REGION_INF) 
                            都道府県コード)))
*)
     val 都道府県一覧: DBSchema.都道府県一覧ty list = 
         map (fn {"@name" =n, "@regionCode" = c} =>
                 {都道府県名 = n, コード =c}) 
         (#CLASS 
          (hd 
           (#CLASS_OBJ  
              (#CLASS_INF  
                 (#METADATA_INF 
                    (#GET_META_REGION_INF 都道府県コード)
         )))))
         
     val 都道府県別人口: DBSchema.都道府県別人口ty list =
         map (fn {VALUE={"$"=p, "@regionCode" = r}} => 
                 {人口 = valOf (Real.fromString (p ^ ".0")), コード = r})
             ((#DATA_OBJ o #DATA_INF o #STATISTICAL_DATA o #GET_STATS) 
                都道府県人口)
     val 都道府県別累積陽性者: DBSchema.都道府県別累積陽性者ty list =
         map (fn {name_jp=n, npatients=p} => 
                 {都道府県名=n, 累積陽性者 = Real.fromInt p})
             (#area (hd 累積陽性者))
     val _ = (_sql db => insert into #db.データソース
                        (都道府県データ, 都道府県データ取得日時, covid19, covid19更新日)
                        values データソース)
             conn
     val _ = (_sql db => insert into #db.都道府県一覧
                        (コード, 都道府県名)
                        values 都道府県一覧)
             conn
     val _ = (_sql db => insert into #db.都道府県別人口
                        (コード, 人口)
                        values 都道府県別人口)
             conn
     val _ = (_sql db => insert into #db.都道府県別累積陽性者
                        (都道府県名, 累積陽性者)
                        values 都道府県別累積陽性者)
             conn

   in
     SQL.closeConn conn
   end
end
