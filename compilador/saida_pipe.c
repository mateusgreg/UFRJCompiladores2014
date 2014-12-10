#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(){
  int x_int;
  int x_int_contador;
  double x_double;
  double x_double_contador;
  float x_float;
  float x_float_contador;

  int temp_bool_1;
  int temp_bool_2;
  int temp_bool_3;
  int temp_bool_4;
  int temp_bool_5;
  int temp_bool_6;
  int temp_bool_7;
  int temp_bool_8;
  int temp_bool_9;
  int temp_int_1;
  int temp_int_2;
  int temp_int_3;
  int temp_int_4;
  int temp_int_5;

  int i;
  int tab[10];
  i = 0;
  L_for_cond_1:
  temp_bool_1 = i <= 9;
  temp_bool_2 = !temp_bool_1;
  if( temp_bool_2 ) goto L_for_fim_1;
  temp_int_2 = i;
  tab[temp_int_2] = i;

  temp_int_1 = i + 1;
  i = temp_int_1;
  goto L_for_cond_1;
  L_for_fim_1:

 x_int_contador = 0;
  x_int = 1;
  L_for_cond_2:
  temp_bool_8 = x_int <= 10;
  temp_bool_9 = !temp_bool_8;
  if( temp_bool_9 ) goto L_for_fim_2;
  temp_int_3 = x_int * x_int;
  temp_int_4 = temp_int_3 % 1;
  temp_bool_3 = temp_int_4 == 0;
  temp_bool_4 = !temp_bool_3;
  if( temp_bool_4 ) goto L_passo_pipe_1;
  temp_int_5 = x_int % 2;
  temp_bool_5 = temp_int_5 == 0;
  temp_bool_6 = !temp_bool_5;
  if( temp_bool_6 ) goto L_passo_pipe_1;
 x_int_contador = x_int_contador + 1;
  temp_bool_7 = x_int_contador>4;
  if( temp_bool_7 ) goto L_passo_pipe_1;
  printf( "%d", x_int );
  printf( "%s", "\n" );
L_passo_pipe_1:
  x_int = x_int + 1;
  goto L_for_cond_2;
  L_for_fim_2:

  return 0;
}

