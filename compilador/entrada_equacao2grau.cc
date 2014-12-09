double raiz( double valor );

void calculaEquacao2Grau ( double a, double b, double c ) {
  double delta, raiz_delta, raiz1, raiz2;
  
  delta = b*b - 4*a*c;
  
  printf( "\ndelta = " + delta + "\n" );
  
  if ( delta < 0 ) {
    printf( "Nao ha raizes reais para a equacao.\n\n" );
    return;
  }
  
  raiz_delta = raiz(delta);
  printf( "raiz de delta = " + raiz_delta + "\n" );
  
  raiz1 = (-b + raiz_delta) / (2*a);
  raiz2 = (-b - raiz_delta) / (2*a);
  
  printf( "As raizes da equacao sao: " + raiz1 + " e " + raiz2 + "\n\n"); 
}

double raiz( double valor ) {
  int n;
  double recorrencia;
  
  if( valor == 0.0 )
    return valor;
  
  recorrencia = valor;
  for (n=0; n < 10; n++)
    recorrencia = recorrencia/2 + valor/(2*recorrencia);
  
  return recorrencia;
}

int main() {
  
  double a, b, c;
  
  printf( "###################################\n" );
  printf( "## Calculo de equacao do 2º grau ##\n" );
  printf( "###################################\n" );
  
  printf( "\nFormato da equacao de 2º grau: ax² + bx + c\n\n" );
  
  printf( "Informe o valor do coeficiente a: " );
  scanf( a );
  
  printf( "Informe o valor do coeficiente b: " );
  scanf( b );
  
  printf( "Informe o valor do coeficiente c: " );
  scanf( c );
  
  calculaEquacao2Grau( a, b, c );
}
