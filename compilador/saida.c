#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int james(int x){
  printf( "%s", "James\n" );
  return 1;
}

int main(){
  int x_int;
  double x_double;
  float x_float;


  int a;
  a = 0;

  printf( "%d",   james(a) );

  return 0;
}

