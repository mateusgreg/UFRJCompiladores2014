#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mdc(int x, int y);
int mdc(int x, int y){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  int temp_bool_2;
  int temp_int_1;
  int temp_int_2;

  int a;
  int b;
  int c;
  int resp;
  temp_bool_1 = x > y;
  if( temp_bool_1 ) goto L_if_true_1;
  goto L_if_false_1;
  L_if_true_1:
  a = x;

  b = y;

  goto L_if_fim_1;
  L_if_false_1:
  a = y;

  b = x;

  L_if_fim_1:

  temp_int_1 = a % b;
  temp_bool_2 = temp_int_1 == 0;
  if( temp_bool_2 ) goto L_if_true_2;
  goto L_if_false_2;
  L_if_true_2:
  resp = b;

  goto L_if_fim_2;
  L_if_false_2:
  temp_int_2 = a % b;
  c = temp_int_2;

  resp =   mdc(b, c);

  L_if_fim_2:

  return resp;
}

int main(){
  int x_int;
  double x_double;
  float x_float;


  int x;
  int y;
  int resp;
  x = 50;

  y = 15;

  resp =   mdc(x, y);

  printf( "%s", "O MDC entre " );
  printf( "%d", x );
  printf( "%s", " e " );
  printf( "%d", y );
  printf( "%s", " é: " );
  printf( "%d", resp );
  printf( "%s", "\n" );

  return 0;
}

