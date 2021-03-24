fun copyFile inFile outFile =
  let val inFILE = FileIO.fopen (inFile, "r")
      val outFILE = FileIO.fopen (outFile, "w")
      fun loop () =
        let val int = FileIO.fgetc inFILE
        in if int = FileIO.EOF then ()
           else (FileIO.fputc (int, outFILE); loop ())
        end
  in (loop(); FileIO.fclose inFILE; FileIO.fclose outFILE; ())
  end
