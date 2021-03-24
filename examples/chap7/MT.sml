structure MT =
struct
 val init_genrand64 =  _import "init_genrand64" : word64 -> ()
 val genrand64_int64 = _import "genrand64_int64" : () -> word64
 val genrand64_int63 = _import "genrand64_int63" : () -> int64
 val genrand64_real1 = _import "genrand64_real1" : () -> real
 val genrand64_real2 = _import "genrand64_real2" : () -> real
 val genrand64_real3 = _import "genrand64_real3" : () -> real
end
