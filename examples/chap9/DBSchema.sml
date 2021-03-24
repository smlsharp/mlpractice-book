structure DBSchema =
struct
  type 都道府県一覧ty = {コード:string, 都道府県名:string}
  type 都道府県別人口ty = {コード:string, 人口:real}
  type 都道府県別累積陽性者ty = {都道府県名:string, 累積陽性者:real}
  type データソースty = {都道府県データ:string, 都道府県データ取得日時:string,
                         covid19:string, covid19更新日:string}
  type covidDB = 
  {
   データソース: データソースty list,
   都道府県一覧: 都道府県一覧ty list,
   都道府県別人口: 都道府県別人口ty list,
   都道府県別累積陽性者: 都道府県別累積陽性者ty list
  }
  val covidDBServer = _sqlserver "dbname=covidDB" : covidDB
  fun initDB () =
   let
     val _ = (OS.Process.system "dropdb covidDB";
              OS.Process.system "createdb covidDB")
     val conn =  SQL.connectAndCreate covidDBServer
   in
     SQL.closeConn conn
   end
end
