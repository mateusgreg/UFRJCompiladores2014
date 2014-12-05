int main() {
  
  int a, i, j;
  int b[2];
  float f[10][2];
  
  string s;
  string s1[10];
  string s2[3][7];
  
  s = 'M';
  printf("%s", s);
  
  s = "\nFrase ";
  s = s + "de" + " teste!";
  printf("%s", s);
  
  s1[3] = "Mateus";
  s1[5] = "Gregorio";
  //printf(s1[3]);
  
  s2[2][5] = "de Souza";
  
  a = 10;
  a++;
  a++;
  a = a+3;
  
  printf("\nO valor de 'a' é: %d\n", a);
  
  for ( i=0; i<10; i++) {
    printf("\nEstou no for!!! Iteracao: %d", i);
  }
  
  printf("\n");
  
  i=0;
  while ( i<10 ) {
    printf("\nEstou no while!!! Iteracao: %d", i);
    i++;
  }
  
  printf("\n");
  
  i=0;
  do {
    printf("\nEstou no do-while!!! Iteracao: %d", i);
    i++;
  }while( i<10 );
  
  printf("\n\n");
  
  switch(1) {
    case 1: printf("Case 1\n");
    case 2: printf("Case 2\n");
    default: printf("Default\n");
  }
  
  printf("%s\n", s);
}
