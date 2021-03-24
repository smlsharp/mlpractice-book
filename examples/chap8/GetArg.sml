structure GetArg =
struct
exception Format
  fun getArg sample =
    let
      val args = String.concatWith " " (CommandLine.arguments ())
      val errMes = "使用方法：" ^ (CommandLine.name ())
                   ^ " '" ^ Dynamic.valueToJson sample ^ "'\n"
    in
      castLike (Dynamic.fromJson args) sample
      handle x => (print errMes; raise Format)
    end
end
