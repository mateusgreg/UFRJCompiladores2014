int main() {
  
  int i, tab[10];
  
  for (i=0; i <= 9; i++)
    tab[i] = i;
  
  INTERVAL[ 1 .. 10 ]
    => firstN[ 5 ]
    => fIlTEr[ (x*x) % 1 == 0 ]
    => fiLTEr[ x % 2 == 0 ]
    => firsTn[ 3 ]
    => forEach[ printf( x + "\n" ); ];
}
