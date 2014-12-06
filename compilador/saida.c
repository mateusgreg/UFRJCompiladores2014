#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(){
  int x_int;
  double x_double;
  float x_float;

  int temp_int_1;
  char temp_string_1[256];
  char temp_string_2[256];

  int a;
int i;
int j;
  int b[2];
  float f[20];
  float g;
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
  strncat( temp_string_2, " teste!\n", 255 );
  temp_string_2[255] = 0;

  strncpy( s, temp_string_2, 255 );
  s[255] = 0;

  printf( "%s", s );
  strncpy( &s1[768], "Mateus ", 255 );
  s1[1023] = 0;

  strncpy( &s1[1280], "Gregorio ", 255 );
  s1[1535] = 0;

  printf( "%s", &s1[768] );
  printf( "%s", "\n" );
  strncpy( &s1[768], &s1[1280], 255 );
  s1[1023] = 0;

  printf( "%s", &s1[768] );
  printf( "%s", "\n" );
  strncpy( &s2[4864], "de Souza", 255 );
  s2[5119] = 0;

  printf( "%s", &s2[4864] );
  printf( "%s", "\n" );
  strncpy( s, &s2[4864], 255 );
  s[255] = 0;

  printf( "%s", s );
  a = 10;

  printf( "%s", "\na = " );
  printf( "%d", a );
  b[ 1] = 50;

  a = b[1];

  printf( "%s", "\na = " );
  printf( "%d", a );
  temp_int_1 = a + 1;
  a = temp_int_1;

  printf( "%s", "\nO valor de 'a' é: " );
  printf( "%d", a );
  printf( "%s", "\n" );
  f[ 15] = 3.5;

  printf( "%s", "\nf = " );
  printf( "%f", f[15] );
  g = f[15];

  printf( "%s", "\ng = " );
  printf( "%f", g );
  printf( "%s", "\n\nEntre com um numero inteiro: " );
  scanf( "%d", &b[1] );
  printf( "%s", "Você digitou: " );
  printf( "%d", b[1] );
  printf( "%s", "\n" );
  printf( "%s", "\nEntre com um numero real (float): " );
  scanf( "%f", &f[15] );
  printf( "%s", "Você digitou: " );
  printf( "%f", f[15] );
  printf( "%s", "\n" );
  printf( "%s", "\nAgora entre com uma palavra: " );
  scanf( "%s", &s );
  printf( "%s", "Você digitou: " );
  printf( "%s", s );
  printf( "%s", "\n" );

  return 0;
}

