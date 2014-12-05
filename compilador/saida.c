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
  int temp_int_1;
  int temp_int_2;
  int temp_int_3;
  int temp_int_4;
  int temp_int_5;
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
  strncpy( &s1[768], "Mateus", 255 );
  s1[1023] = 0;

  strncpy( &s1[1280], "Gregorio", 255 );
  s1[1535] = 0;

  strncpy( &s2[4864], "de Souza", 255 );
  s2[5119] = 0;

  a = 10;

  temp_int_1 = a + 1;
  a = temp_int_1;

  temp_int_2 = a + 1;
  a = temp_int_2;

  temp_int_3 = a + 3;
  a = temp_int_3;

  printf( "\nO valor de 'a' é: %d\n", a );
  i = 0;
L_for_cond_1:
  temp_bool_1 = i < 10;
  temp_bool_2 = !temp_bool_1;
  if( temp_bool_2 ) goto L_for_fim_1;
  printf( "\nEstou no for!!! Iteracao: %d", i );
  temp_int_4 = i + 1;
  i = temp_int_4;
  goto L_for_cond_1;
L_for_fim_1:

  printf( "%s", "\n" );
  i = 0;

L_while_cond_1:
  temp_bool_3 = i < 10;
  temp_bool_4 = !temp_bool_3;
  if( temp_bool_4 ) goto L_while_fim_1;
  printf( "\nEstou no while!!! Iteracao: %d", i );
  temp_int_5 = i + 1;
  i = temp_int_5;

  goto L_while_cond_1;
L_while_fim_1:

  printf( "%s", "\n" );

  return 0;
}

