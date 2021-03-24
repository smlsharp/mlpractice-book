structure StringDict =
struct
  exception Empty
  type 'a dict = (string, 'a) MakeDict.dict
  val {empty, find, enter} = MakeDict.makeDict String.compare
end
