structure Main =
struct
  val _ = DBSchema.initDB()
  val _ = DBSetup.setupDB()
  val conn = SQL.connect DBSchema.covidDBServer
  val r = SQL.fetchAll (AnalyzeDB.Q conn)
  val _ = Dynamic.pp r
  val _ = SQL.closeConn conn
end
