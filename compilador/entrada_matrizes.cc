int main() {
  int a[3][4], b[4][10], c[3][10];
  int i, j, k, soma;
  
  for (i=0; i < 3; i++) {
    for (j=0; j < 4; j++) {
      a[i][j] = i+j;
    }
  }
  
  for (i=0; i < 4; i++) {
    for (j=0; j < 10; j++) {
      b[i][j] = i*j;
    }
  }
  
  //Calculo do produto das matrizes:
  for (i=0; i < 3; i++) {
    for (j=0; j < 10; j++) {
      soma = 0;
      for (k=0; k < 4; k++) {
        soma = soma + (a[i][k] * b[k][j]);
      }
      c[i][j] = soma;
    }
  }
  
  for (i=0; i < 3; i++) {
    for (j=0; j < 4; j++) {
      printf("a[" + i + "][" + j + "] = " + a[i][j] + "   ");
    }
    printf("\n");
  }
  
  printf("\n");
  
  for (i=0; i < 4; i++) {
    for (j=0; j < 10; j++) {
      printf("b[" + i + "][" + j + "] = " + b[i][j] + "   ");
    }
    printf("\n");
  }
  
  printf("\n");
  
  for (i=0; i < 3; i++) {
    for (j=0; j < 10; j++) {
      printf("c[" + i + "][" + j + "] = " + c[i][j] + "   ");
    }
    printf("\n");
  }
  
  printf("\n");
}
