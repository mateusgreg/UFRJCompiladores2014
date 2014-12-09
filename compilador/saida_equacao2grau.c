#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double raiz(double valor);
void calculaEquacao2Grau(double a, double b, double c){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  int temp_int_1;
  int temp_int_2;
  double temp_double_1;
  double temp_double_2;
  double temp_double_3;
  double temp_double_4;
  double temp_double_5;
  double temp_double_6;
  double temp_double_7;
  double temp_double_8;
  double temp_double_9;
  double temp_double_10;
  double temp_double_11;
  double temp_double_12;

  double delta;
  double raiz_delta;
  double raiz1;
  double raiz2;
  temp_double_1 = b * b;
  temp_double_2 = 4 * a;
  temp_double_3 = temp_double_2 * c;
  temp_double_4 = temp_double_1 - temp_double_3;
  delta = temp_double_4;

  printf( "%s", "\ndelta = " );
  printf( "%lf", delta );
  printf( "%s", "\n" );
  temp_bool_1 = delta < 0;
  if( temp_bool_1 ) goto L_if_true_1;
  goto L_if_false_1;
  L_if_true_1:
  printf( "%s", "Nao ha raizes reais para a equacao.\n\n" );
  return;
  goto L_if_fim_1;
  L_if_false_1:
  L_if_fim_1:

  raiz_delta =   raiz(delta);

  printf( "%s", "raiz de delta = " );
  printf( "%lf", raiz_delta );
  printf( "%s", "\n" );

  temp_int_1 = -1;
  temp_double_5 = temp_int_1 * b;

  temp_double_6 = temp_double_5 + raiz_delta;
  temp_double_7 = 2 * a;
  temp_double_8 = temp_double_6 / temp_double_7;
  raiz1 = temp_double_8;


  temp_int_2 = -1;
  temp_double_9 = temp_int_2 * b;

  temp_double_10 = temp_double_9 - raiz_delta;
  temp_double_11 = 2 * a;
  temp_double_12 = temp_double_10 / temp_double_11;
  raiz2 = temp_double_12;

  printf( "%s", "As raizes da equacao sao: " );
  printf( "%lf", raiz1 );
  printf( "%s", " e " );
  printf( "%lf", raiz2 );
  printf( "%s", "\n\n" );
}
double raiz(double valor){
  int x_int;
  double x_double;
  float x_float;

  int temp_bool_1;
  int temp_bool_2;
  int temp_bool_3;
  int temp_int_1;
  double temp_double_1;
  double temp_double_2;
  double temp_double_3;
  double temp_double_4;

  int n;
  double recorrencia;
  temp_bool_1 = valor == 0.0;
  if( temp_bool_1 ) goto L_if_true_2;
  goto L_if_false_2;
  L_if_true_2:
  return valor;
  goto L_if_fim_2;
  L_if_false_2:
  L_if_fim_2:

  recorrencia = valor;

  n = 0;
  L_for_cond_1:
  temp_bool_2 = n < 10;
  temp_bool_3 = !temp_bool_2;
  if( temp_bool_3 ) goto L_for_fim_1;
  temp_double_1 = recorrencia / 2;
  temp_double_2 = 2 * recorrencia;
  temp_double_3 = valor / temp_double_2;
  temp_double_4 = temp_double_1 + temp_double_3;
  recorrencia = temp_double_4;

  temp_int_1 = n + 1;
  n = temp_int_1;
  goto L_for_cond_1;
  L_for_fim_1:

  return recorrencia;
}

int main(){
  int x_int;
  double x_double;
  float x_float;


  double a;
  double b;
  double c;
  printf( "%s", "###################################\n" );
  printf( "%s", "## Calculo de equacao do 2º grau ##\n" );
  printf( "%s", "###################################\n" );
  printf( "%s", "\nFormato da equacao de 2º grau: ax² + bx + c\n\n" );
  printf( "%s", "Informe o valor do coeficiente a: " );
  scanf( "%lf", &a );
  printf( "%s", "Informe o valor do coeficiente b: " );
  scanf( "%lf", &b );
  printf( "%s", "Informe o valor do coeficiente c: " );
  scanf( "%lf", &c );
  calculaEquacao2Grau(a, b, c);

  return 0;
}

