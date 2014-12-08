#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int james(int& x){
  printf( "%s", "James\n" );
  return x;
}

int main(){
  int x_int;
  double x_double;
  float x_float;

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
  char temp_string_1[256];
  char temp_string_2[256];

  int a;
  int i;
  int j;
  int b[2];
  float f[20];
  float g;
  int z;
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
  strncpy( &s1[temp_int_1], "Mateus ", 255 );
  s1[temp_int_2] = 0;

  temp_int_3 = 5 * 256;
  temp_int_4 = temp_int_3 + 255;
  strncpy( &s1[temp_int_3], "Gregorio ", 255 );
  s1[temp_int_4] = 0;

  temp_int_5 = 3 * 256;
  printf( "%s", &s1[temp_int_5] );
  printf( "%s", "\n" );
  temp_int_6 = 5 * 256;
  temp_int_7 = 3 * 256;
  temp_int_8 = temp_int_7 + 255;
  strncpy( &s1[temp_int_7], &s1[temp_int_6], 255 );
  s1[temp_int_8] = 0;

  temp_int_9 = 3 * 256;
  printf( "%s", &s1[temp_int_9] );
  printf( "%s", "\n" );
  temp_int_10 = 2 * 7;
  temp_int_11 = temp_int_10 + 5;
  temp_int_12 = temp_int_11 * 256;
  temp_int_13 = temp_int_12 + 255;
  strncpy( &s2[temp_int_12], "de Souza", 255 );
  s2[temp_int_13] = 0;

  temp_int_14 = 2 * 7;
  temp_int_15 = temp_int_14 + 5;
  temp_int_16 = temp_int_15 * 256;
  printf( "%s", &s2[temp_int_16] );
  printf( "%s", "\n" );
  temp_int_17 = 2 * 7;
  temp_int_18 = temp_int_17 + 5;
  temp_int_19 = temp_int_18 * 256;
  strncpy( s, &s2[temp_int_19], 255 );
  s[255] = 0;

  printf( "%s", s );
  a = 10;

  printf( "%s", "\na = " );
  printf( "%d", a );
  temp_int_20 = 1;
  b[temp_int_20] = 50;

  temp_int_21 = 1;
  a = b[temp_int_21];

  printf( "%s", "\na = " );
  printf( "%d", a );
  temp_int_22 = a + 1;
  a = temp_int_22;

  printf( "%s", "\nO valor de 'a' é: " );
  printf( "%d", a );
  printf( "%s", "\n" );
  temp_int_23 = 7 * 2;
  temp_int_24 = temp_int_23 + 1;
  f[temp_int_24] = 3.5;

  printf( "%s", "\nf = " );
  temp_int_26 = 7 * 2;
  temp_int_27 = temp_int_26 + 1;
  printf( "%f", f[temp_int_27] );
  temp_int_29 = 7 * 2;
  temp_int_30 = temp_int_29 + 1;
  g = f[temp_int_30];

  printf( "%s", "\ng = " );
  printf( "%f", g );
  printf( "%s", "\n" );
  printf( "%s", "\n\nEntre com um numero inteiro: " );
  temp_int_32 = 1;
  scanf( "%d", &b[temp_int_32] );
  printf( "%s", "Você digitou: " );
  temp_int_33 = 1;
  printf( "%d", b[temp_int_33] );
  printf( "%s", "\n" );
  printf( "%s", "\nEntre com um numero real (float): " );
  temp_int_34 = 7 * 2;
  temp_int_35 = temp_int_34 + 1;
  scanf( "%f", &f[temp_int_35] );
  printf( "%s", "Você digitou: " );
  temp_int_37 = 7 * 2;
  temp_int_38 = temp_int_37 + 1;
  printf( "%f", f[temp_int_38] );
  printf( "%s", "\n" );
  printf( "%s", "\nAgora entre com uma palavra: " );
  scanf( "%s", s );
  printf( "%s", "Você digitou: " );
  printf( "%s", s );
  printf( "%s", "\n" );
  printf( "%d",   james(a) );
  printf( "%s", "\n" );
  printf( "%d", z );
  printf( "%s", "\n" );
  james(z);

  return 0;
}

