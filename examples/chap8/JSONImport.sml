structure JSONImport =
struct
  fun downloadJson url =
    let
      val tmpFile = OS.FileSys.tmpName ()
      val cmd =
          "wget -o wget.log -O " ^ tmpFile ^ " " 
          ^ "\"" ^ url ^ "\""
      val _ = OS.Process.system cmd
    in
      Dynamic.fromJsonFile tmpFile 
      before OS.FileSys.remove tmpFile
    end
  fun 'a#reify castLike D (sample : 'a) =
    Dynamic.view (_dynamic D as 'a Dynamic.dyn)
  fun 'a#reify import {url, sample : 'a, ...} =
    castLike (downloadJson url) sample
  val jpNpatients =
      {url = "https://data.corona.go.jp/converted-json/\
             \covid19japan-npatients.json",
       contents = "累積陽性者数",
       sample = [{date = "", npatients = 0, adpatients = 0}]
      };
end
