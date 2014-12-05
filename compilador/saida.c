#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  char temp_string_1[256];
  char temp_string_2[256];

  int a;
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

  a = 0;


  temp_bool_1 = !a;

  printf( "\nO valor é %d\n", temp_bool_1 );

  return 0;
}

