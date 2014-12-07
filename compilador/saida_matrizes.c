#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  int temp_bool_2;
  int temp_bool_3;
  int temp_bool_4;
  int temp_bool_5;
  int temp_bool_6;
  int temp_bool_7;
  int temp_bool_8;
  int temp_int_1;
  int temp_int_2;
  int temp_int_3;
  int temp_int_4;
  int temp_int_5;
  int temp_int_6;
  int temp_int_7;
  int temp_int_8;
  int temp_int_9;
  int temp_int_10;
  int temp_int_11;
  int temp_int_12;
  int temp_int_13;
  int temp_int_14;

  int a[12];
  int b[40];
  int i;
  int j;
  i = 2;

  j = 1;

  temp_int_1 = i * 4;
  temp_int_2 = temp_int_1 + j;
  a[temp_int_2] = 5;

  i = 0;
L_for_cond_2:
  temp_bool_1 = i < 3;
  temp_bool_4 = !temp_bool_1;
  if( temp_bool_4 ) goto L_for_fim_2;
  j = 0;
L_for_cond_1:
  temp_bool_2 = j < 4;
  temp_bool_3 = !temp_bool_2;
  if( temp_bool_3 ) goto L_for_fim_1;
  temp_int_6 = i + j;
  temp_int_7 = i * 4;
  temp_int_8 = temp_int_7 + j;
  a[temp_int_8] = temp_int_6;

  temp_int_5 = j + 1;
  j = temp_int_5;
  goto L_for_cond_1;
L_for_fim_1:

  temp_int_4 = i + 1;
  i = temp_int_4;
  goto L_for_cond_2;
L_for_fim_2:

  i = 0;
L_for_cond_4:
  temp_bool_5 = i < 3;
  temp_bool_8 = !temp_bool_5;
  if( temp_bool_8 ) goto L_for_fim_4;
  j = 0;
L_for_cond_3:
  temp_bool_6 = j < 4;
  temp_bool_7 = !temp_bool_6;
  if( temp_bool_7 ) goto L_for_fim_3;
  printf( "%s", "a[" );
  printf( "%d", i );
  printf( "%s", "][" );
  printf( "%d", j );
  printf( "%s", "] = " );
  temp_int_12 = i * 4;
  temp_int_13 = temp_int_12 + j;
  printf( "%d", a[temp_int_13] );
  printf( "%s", "   " );
  temp_int_11 = j + 1;
  j = temp_int_11;
  goto L_for_cond_3;
L_for_fim_3:

  printf( "%s", "\n" );
  temp_int_10 = i + 1;
  i = temp_int_10;
  goto L_for_cond_4;
L_for_fim_4:


  return 0;
}

