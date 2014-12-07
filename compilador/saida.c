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
  char temp_string_1[256];
  char temp_string_2[256];

  int a;
int i;
int j;
  int b[2];
  float f[20];
  char s[256];
  char s1[2560];
  char s2[5376];
  s[0] = 'M';
  s[1] = 0;

  printf( "%s", s );
  strncpy( s, "\nFrase ", 255 );
  s[255] = 0;


  strncpy( temp_string_1, s, 255 );
  strncat( temp_string_1, "de", 255 );
  temp_string_1[255] = 0;


  strncpy( temp_string_2, temp_string_1, 255 );
  strncat( temp_string_2, " teste!", 255 );
  temp_string_2[255] = 0;

  strncpy( s, temp_string_2, 255 );
  s[255] = 0;

  printf( "%s", s );
  temp_int_1 = 3 * 256;
  temp_int_2 = temp_int_1 + 255;
  strncpy( &s1[temp_int_1], "Mateus", 255 );
  s1[temp_int_2] = 0;

  temp_int_3 = 5 * 256;
  temp_int_4 = temp_int_3 + 255;
  strncpy( &s1[temp_int_3], "Gregorio", 255 );
  s1[temp_int_4] = 0;

  temp_int_5 = 2 * 7;
  temp_int_6 = temp_int_5 + 5;
  temp_int_7 = temp_int_6 * 256;
  temp_int_8 = temp_int_7 + 255;
  strncpy( &s2[temp_int_7], "de Souza", 255 );
  s2[temp_int_8] = 0;

  a = 10;

  temp_int_9 = a + 1;
  a = temp_int_9;

  temp_int_10 = a + 1;
  a = temp_int_10;

  temp_int_11 = a + 3;
  a = temp_int_11;

  printf( "%s", "\nO valor de 'a' é: " );
  printf( "%d", a );
  printf( "%s", "\n" );
  i = 0;
L_for_cond_1:
  temp_bool_1 = i < 10;
  temp_bool_2 = !temp_bool_1;
  if( temp_bool_2 ) goto L_for_fim_1;
  printf( "%s", "\nEstou no for!!! Iteracao: " );
  printf( "%d", i );
  temp_int_12 = i + 1;
  i = temp_int_12;
  goto L_for_cond_1;
L_for_fim_1:

  printf( "%s", "\n" );
  i = 0;

L_while_cond_1:
  temp_bool_3 = i < 10;
  temp_bool_4 = !temp_bool_3;
  if( temp_bool_4 ) goto L_while_fim_1;
  printf( "%s", "\nEstou no while!!! Iteracao: " );
  printf( "%d", i );
  temp_int_13 = i + 1;
  i = temp_int_13;

  goto L_while_cond_1;
L_while_fim_1:

  printf( "%s", "\n" );
  i = 0;

L_do_while_inicio_1:
  printf( "%s", "\nEstou no do-while!!! Iteracao: " );
  printf( "%d", i );
  temp_int_14 = i + 1;
  i = temp_int_14;

  temp_bool_5 = i < 10;
  if( temp_bool_5 ) goto L_do_while_inicio_1;

  printf( "%s", "\n\n" );
  temp_bool_7 = 2 == 1;
  if( temp_bool_7 ) goto L_if_start_case_2;
  temp_bool_6 = 1 == 1;
  if( temp_bool_6 ) goto L_if_start_case_1;
L_if_start_case_1:
  printf( "%s", "Case 1\n" );
L_if_start_case_2:
  printf( "%s", "Case 2\n" );
  printf( "%s", "Default\n" );

L_if_fim_switch_1:

  printf( "%s", s );
  printf( "%s", "\n" );

  return 0;
}

