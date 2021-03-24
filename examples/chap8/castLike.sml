fun ('a#reify) castLike D (sample : 'a) =
    Dynamic.view (_dynamic D as 'a Dynamic.dyn)
