#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int foo(int y, int w, int xpto){
  int x_int;
  double x_double;
  float x_float;

  int temp_int_1;
  int temp_int_2;

  int z;
  w = 10;

  temp_int_1 = y + w;
  temp_int_2 = temp_int_1 + xpto;
  z = temp_int_2;

  return z;
}

int main(){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  int temp_bool_2;
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
  char* temp_charptr_1;
  char* temp_charptr_2;
  char* temp_charptr_3;
  char* temp_charptr_4;
  char* temp_charptr_5;
  char* temp_charptr_6;
  char* temp_charptr_7;
  char* temp_charptr_8;
  char* temp_charptr_9;
  float temp_float_1;
  float temp_float_2;
  float temp_float_3;
  char temp_string_1[256];
  char temp_string_2[256];
  char temp_string_3[256];
  char temp_string_4[256];
  char temp_string_5[256];
  char temp_string_6[256];
  char temp_string_7[256];

  int a;
  int i;
  int j;
  int b[2];
  float f[20];
  float g;
  int z;
  int x;
  char s[256];
  char s1[2560];
  char s2[5376];
  z = 0;

  s[0] = 'M';
  s[1] = 0;

  printf( "%s", s );
  strncpy( s, "\nFrase ", 255 );
  s[255] = 0;


  strncpy( temp_string_1, s, 255 );
  strncat( temp_string_1, "de", 255 );
  temp_string_1[255] = 0;


  strncpy( temp_string_2, temp_string_1, 255 );
  strncat( temp_string_2, " teste!\n", 255 );
  temp_string_2[255] = 0;

  strncpy( s, temp_string_2, 255 );
  s[255] = 0;

  printf( "%s", s );
  temp_int_1 = 3 * 256;
  temp_int_2 = temp_int_1 + 255;
  temp_charptr_1 = s1+temp_int_1;
  strncpy( temp_charptr_1, "Mateus ", 255 );
  s1[temp_int_2] = 0;

  temp_int_3 = 5 * 256;
  temp_int_4 = temp_int_3 + 255;
  temp_charptr_2 = s1+temp_int_3;
  strncpy( temp_charptr_2, "Gregorio ", 255 );
  s1[temp_int_4] = 0;

  temp_int_5 = 3 * 256;

  temp_charptr_3 = s1+temp_int_5;
  strncpy( temp_string_3, temp_charptr_3, 255 );
  temp_string_3[255] = 0;
  printf( "%s", temp_string_3 );
  printf( "%s", "\n" );
  temp_int_6 = 5 * 256;

  temp_charptr_4 = s1+temp_int_6;
  strncpy( temp_string_4, temp_charptr_4, 255 );
  temp_string_4[255] = 0;
  temp_int_7 = 3 * 256;
  temp_int_8 = temp_int_7 + 255;
  temp_charptr_5 = s1+temp_int_7;
  strncpy( temp_charptr_5, temp_string_4, 255 );
  s1[temp_int_8] = 0;

  temp_int_9 = 3 * 256;

  temp_charptr_6 = s1+temp_int_9;
  strncpy( temp_string_5, temp_charptr_6, 255 );
  temp_string_5[255] = 0;
  printf( "%s", temp_string_5 );
  printf( "%s", "\n" );
  temp_int_10 = 2 * 7;
  temp_int_11 = temp_int_10 + 5;
  temp_int_12 = temp_int_11 * 256;
  temp_int_13 = temp_int_12 + 255;
  temp_charptr_7 = s2+temp_int_12;
  strncpy( temp_charptr_7, "de Souza", 255 );
  s2[temp_int_13] = 0;

  temp_int_14 = 2 * 7;
  temp_int_15 = temp_int_14 + 5;
  temp_int_16 = temp_int_15 * 256;

  temp_charptr_8 = s2+temp_int_16;
  strncpy( temp_string_6, temp_charptr_8, 255 );
  temp_string_6[255] = 0;
  printf( "%s", temp_string_6 );
  printf( "%s", "\n" );
  temp_int_17 = 2 * 7;
  temp_int_18 = temp_int_17 + 5;
  temp_int_19 = temp_int_18 * 256;

  temp_charptr_9 = s2+temp_int_19;
  strncpy( temp_string_7, temp_charptr_9, 255 );
  temp_string_7[255] = 0;
  strncpy( s, temp_string_7, 255 );
  s[255] = 0;

  printf( "%s", s );
  a = 10;

  printf( "%s", "\na = " );
  printf( "%d", a );
  temp_int_20 = 1;
  b[temp_int_20] = 50;

  temp_int_21 = 1;

  temp_int_22 = b[temp_int_21];
  a = temp_int_22;

  printf( "%s", "\na = " );
  printf( "%d", a );
  temp_int_23 = a + 1;
  a = temp_int_23;

  printf( "%s", "\nO valor de 'a' é: " );
  printf( "%d", a );
  printf( "%s", "\n" );
  temp_int_24 = 7 * 2;
  temp_int_25 = temp_int_24 + 1;
  f[temp_int_25] = 3.5;

  printf( "%s", "\nf = " );
  temp_int_27 = 7 * 2;
  temp_int_28 = temp_int_27 + 1;

  temp_float_1 = f[temp_int_28];
  printf( "%f", temp_float_1 );
  temp_int_30 = 7 * 2;
  temp_int_31 = temp_int_30 + 1;

  temp_float_2 = f[temp_int_31];
  g = temp_float_2;

  printf( "%s", "\ng = " );
  printf( "%f", g );
  printf( "%s", "\n" );
  printf( "%s", "\n\nEntre com um numero inteiro: " );
  temp_int_33 = 1;
  scanf( "%d", &b[temp_int_33] );
  printf( "%s", "Você digitou: " );
  temp_int_34 = 1;

  temp_int_35 = b[temp_int_34];
  printf( "%d", temp_int_35 );
  printf( "%s", "\n" );
  printf( "%s", "\nEntre com um numero real (float): " );
  temp_int_36 = 7 * 2;
  temp_int_37 = temp_int_36 + 1;
  scanf( "%f", &f[temp_int_37] );
  printf( "%s", "Você digitou: " );
  temp_int_39 = 7 * 2;
  temp_int_40 = temp_int_39 + 1;

  temp_float_3 = f[temp_int_40];
  printf( "%f", temp_float_3 );
  printf( "%s", "\n" );
  printf( "%s", "\nAgora entre com uma palavra: " );
  scanf( "%s", s );
  printf( "%s", "Você digitou: " );
  printf( "%s", s );
  printf( "%s", "\n" );
  printf( "%s", "\n" );
  z=1;
  L_intrv_cond_1:
  temp_bool_1 = z>10;
  if( temp_bool_1 ) goto L_intrv_fim_1;
  printf( "%d", z );
  printf( "%s", "\n" );
  z++;
  goto L_intrv_cond_1;
  L_intrv_fim_1:

  printf( "%s", "\n" );
  x_int = 0;
  x= b[0];
  L_feach_cond_1:
  temp_bool_2 = x_int >1;
  if( temp_bool_2 ) goto L_feach_fim_1;
  printf( "%d", x );
  printf( "%s", "\n" );
  x_int++;
  x= b[x_int];
  goto L_feach_cond_1;
  L_feach_fim_1:

  z = 17;

  printf( "%s", "\n" );
  printf( "%s", "\n" );
  printf( "%s", "foo: " );
  printf( "%d",   foo(1, z, 20) );
  printf( "%s", "\n" );
  printf( "%s", "\n" );
  printf( "%s", "z: " );
  printf( "%d", z );
  printf( "%s", "\n" );

  return 0;
}

