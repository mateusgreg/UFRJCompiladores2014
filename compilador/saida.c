#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;

  int y;
  y = 1;

  printf( "Só que não\n" );

  temp_bool_1 = !y;

  printf( "O valor é %d\n", temp_bool_1 );

  return 0;
}

