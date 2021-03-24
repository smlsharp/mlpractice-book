structure IntDict =
struct
  exception Empty
  type 'a dict = (int, 'a) MakeDict.dict
  val {empty, find, enter} = MakeDict.makeDict Int.compare
end

