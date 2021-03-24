long long int S(long long int n) {
   long long int a = 0;
   long long int i = n;
   while (i > 0) {
     a = a + i;
     i = i - 1;
   }
   return a;
 }
