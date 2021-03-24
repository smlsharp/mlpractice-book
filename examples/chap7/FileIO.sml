structure FileIO =
struct
  type FILE = unit ptr
  val EOF = ~1
  val fopen = _import "fopen" : (string, string) -> FILE
  val fclose = _import "fclose" : FILE -> int
  val fgetc = _import "fgetc" : FILE -> int
  val fputc = _import "fputc" : (int, FILE) -> int
end
