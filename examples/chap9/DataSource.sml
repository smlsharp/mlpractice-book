structure DataSource =
struct
val 都道府県コードUrl = 
  "https://dashboard.e-stat.go.jp/\
  \api/1.0/Json/getRegionInfo\
  \?Lang=JP\
  \&ParentRegionCode=00000"
val 都道府県人口Url =
  "https://dashboard.e-stat.go.jp/\
  \api/1.0/Json/getData\
  \?Lang=JP\
  \&IndicatorCode=0201020000000010000\
  \&RegionalRank=3\
  \&Time=2019CY00"

val 累積陽性者Url = 
  "https://data.corona.go.jp/\
  \converted-json/covid19japan-all.json"
val 都道府県コードSample = 
  {GET_META_REGION_INF =
   {METADATA_INF=
    {CLASS_INF= 
     {CLASS_OBJ= 
      [{"@name"="", 
        CLASS= [{"@regionCode"="", "@name"=""}]}]}}}}
val 都道府県人口Sample = 
  {GET_STATS =
   {RESULT = {status="0", errorMsg="", date=""},
    STATISTICAL_DATA = 
    {RESULT_INF = {TOTAL_NUMBER = "0"},
     DATA_INF =
     {DATA_OBJ = [{VALUE = {"@regionCode"="","$"=""}}]}}}}
val 累積陽性者Sample =
   [{lastUpdate = "", area= [{name_jp= "", npatients= 0}]}]
type 都道府県コードty =
 {GET_META_REGION_INF:
   {METADATA_INF:
      {CLASS_INF:
       {CLASS_OBJ:
        {"@name":string, 
         CLASS:{"@regionCode":string,"@name":string} list} list }}}}
type 都道府県人口ty =
     {GET_STATS:
        {RESULT:{status:string, errorMsg:string, date:string},
         STATISTICAL_DATA: 
           {RESULT_INF:{TOTAL_NUMBER:string},
            DATA_INF:{DATA_OBJ:{VALUE:{"@regionCode":string,"$":string}} list}}}
     }
type 累積陽性者ty = {lastUpdate:string, area:{name_jp:string,npatients:int} list} list
fun import () =
 {
  都道府県コード = 
  JSONImport.import {url = 都道府県コードUrl, sample = 都道府県コードSample},
  都道府県人口 = 
  JSONImport.import {url = 都道府県人口Url,sample = 都道府県人口Sample},
  累積陽性者 = 
  JSONImport.import {url = 累積陽性者Url, sample = 累積陽性者Sample}
 }
end
