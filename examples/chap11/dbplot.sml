val () =
  OS.Process.exit
    (Main.main (CommandLine.name (),
                CommandLine.arguments ()))
