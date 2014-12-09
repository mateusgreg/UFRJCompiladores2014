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
  int temp_bool_9;
  int temp_bool_10;
  int temp_bool_11;
  int temp_bool_12;
  int temp_bool_13;
  int temp_bool_14;
  int temp_bool_15;
  int temp_bool_16;
  int temp_bool_17;
  int temp_bool_18;
  int temp_bool_19;
  int temp_bool_20;
  int temp_bool_21;
  int temp_bool_22;
  int temp_bool_23;
  int temp_bool_24;
  int temp_bool_25;
  int temp_bool_26;
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
  int temp_int_15;
  int temp_int_16;
  int temp_int_17;
  int temp_int_18;
  int temp_int_19;
  int temp_int_20;
  int temp_int_21;
  int temp_int_22;
  int temp_int_23;
  int temp_int_24;
  int temp_int_25;
  int temp_int_26;
  int temp_int_27;
  int temp_int_28;
  int temp_int_29;
  int temp_int_30;
  int temp_int_31;
  int temp_int_32;
  int temp_int_33;
  int temp_int_34;
  int temp_int_35;
  int temp_int_36;
  int temp_int_37;
  int temp_int_38;
  int temp_int_39;
  int temp_int_40;
  int temp_int_41;
  int temp_int_42;
  int temp_int_43;
  int temp_int_44;
  int temp_int_45;
  int temp_int_46;

  int a[12];
  int b[40];
  int c[30];
  int i;
  int j;
  int k;
  int soma;
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
  temp_int_3 = i + j;
  temp_int_4 = i * 4;
  temp_int_5 = temp_int_4 + j;
  a[temp_int_5] = temp_int_3;

  temp_int_2 = j + 1;
  j = temp_int_2;
  goto L_for_cond_1;
  L_for_fim_1:

  temp_int_1 = i + 1;
  i = temp_int_1;
  goto L_for_cond_2;
  L_for_fim_2:

  i = 0;
  L_for_cond_4:
  temp_bool_5 = i < 4;
  temp_bool_8 = !temp_bool_5;
  if( temp_bool_8 ) goto L_for_fim_4;
  j = 0;
  L_for_cond_3:
  temp_bool_6 = j < 10;
  temp_bool_7 = !temp_bool_6;
  if( temp_bool_7 ) goto L_for_fim_3;
  temp_int_9 = i * j;
  temp_int_10 = i * 10;
  temp_int_11 = temp_int_10 + j;
  b[temp_int_11] = temp_int_9;

  temp_int_8 = j + 1;
  j = temp_int_8;
  goto L_for_cond_3;
  L_for_fim_3:

  temp_int_7 = i + 1;
  i = temp_int_7;
  goto L_for_cond_4;
  L_for_fim_4:

  i = 0;
  L_for_cond_7:
  temp_bool_9 = i < 3;
  temp_bool_14 = !temp_bool_9;
  if( temp_bool_14 ) goto L_for_fim_7;
  j = 0;
  L_for_cond_6:
  temp_bool_10 = j < 10;
  temp_bool_13 = !temp_bool_10;
  if( temp_bool_13 ) goto L_for_fim_6;
  soma = 0;

  k = 0;
  L_for_cond_5:
  temp_bool_11 = k < 4;
  temp_bool_12 = !temp_bool_11;
  if( temp_bool_12 ) goto L_for_fim_5;
  temp_int_16 = i * 4;
  temp_int_17 = temp_int_16 + k;

  temp_int_19 = a[temp_int_17];
  temp_int_20 = k * 10;
  temp_int_21 = temp_int_20 + j;

  temp_int_23 = b[temp_int_21];
  temp_int_24 = temp_int_19 * temp_int_23;
  temp_int_25 = soma + temp_int_24;
  soma = temp_int_25;

  temp_int_15 = k + 1;
  k = temp_int_15;
  goto L_for_cond_5;
  L_for_fim_5:

  temp_int_26 = i * 10;
  temp_int_27 = temp_int_26 + j;
  c[temp_int_27] = soma;

  temp_int_14 = j + 1;
  j = temp_int_14;
  goto L_for_cond_6;
  L_for_fim_6:

  temp_int_13 = i + 1;
  i = temp_int_13;
  goto L_for_cond_7;
  L_for_fim_7:

  i = 0;
  L_for_cond_9:
  temp_bool_15 = i < 3;
  temp_bool_18 = !temp_bool_15;
  if( temp_bool_18 ) goto L_for_fim_9;
  j = 0;
  L_for_cond_8:
  temp_bool_16 = j < 4;
  temp_bool_17 = !temp_bool_16;
  if( temp_bool_17 ) goto L_for_fim_8;
  printf( "%s", "a[" );
  printf( "%d", i );
  printf( "%s", "][" );
  printf( "%d", j );
  printf( "%s", "] = " );
  temp_int_31 = i * 4;
  temp_int_32 = temp_int_31 + j;

  temp_int_34 = a[temp_int_32];
  printf( "%d", temp_int_34 );
  printf( "%s", "   " );
  temp_int_30 = j + 1;
  j = temp_int_30;
  goto L_for_cond_8;
  L_for_fim_8:

  printf( "%s", "\n" );
  temp_int_29 = i + 1;
  i = temp_int_29;
  goto L_for_cond_9;
  L_for_fim_9:

  printf( "%s", "\n" );
  i = 0;
  L_for_cond_11:
  temp_bool_19 = i < 4;
  temp_bool_22 = !temp_bool_19;
  if( temp_bool_22 ) goto L_for_fim_11;
  j = 0;
  L_for_cond_10:
  temp_bool_20 = j < 10;
  temp_bool_21 = !temp_bool_20;
  if( temp_bool_21 ) goto L_for_fim_10;
  printf( "%s", "b[" );
  printf( "%d", i );
  printf( "%s", "][" );
  printf( "%d", j );
  printf( "%s", "] = " );
  temp_int_37 = i * 10;
  temp_int_38 = temp_int_37 + j;

  temp_int_40 = b[temp_int_38];
  printf( "%d", temp_int_40 );
  printf( "%s", "   " );
  temp_int_36 = j + 1;
  j = temp_int_36;
  goto L_for_cond_10;
  L_for_fim_10:

  printf( "%s", "\n" );
  temp_int_35 = i + 1;
  i = temp_int_35;
  goto L_for_cond_11;
  L_for_fim_11:

  printf( "%s", "\n" );
  i = 0;
  L_for_cond_13:
  temp_bool_23 = i < 3;
  temp_bool_26 = !temp_bool_23;
  if( temp_bool_26 ) goto L_for_fim_13;
  j = 0;
  L_for_cond_12:
  temp_bool_24 = j < 10;
  temp_bool_25 = !temp_bool_24;
  if( temp_bool_25 ) goto L_for_fim_12;
  printf( "%s", "c[" );
  printf( "%d", i );
  printf( "%s", "][" );
  printf( "%d", j );
  printf( "%s", "] = " );
  temp_int_43 = i * 10;
  temp_int_44 = temp_int_43 + j;

  temp_int_46 = c[temp_int_44];
  printf( "%d", temp_int_46 );
  printf( "%s", "   " );
  temp_int_42 = j + 1;
  j = temp_int_42;
  goto L_for_cond_12;
  L_for_fim_12:

  printf( "%s", "\n" );
  temp_int_41 = i + 1;
  i = temp_int_41;
  goto L_for_cond_13;
  L_for_fim_13:

  printf( "%s", "\n" );

  return 0;
}

