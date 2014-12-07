int main() {
  int a[3][4];
  int b[4][10];
  int i;
  int j;
  
  i = 2;
  j = 1;
  a[i][j] = 5;
  
  for (i=0; i < 3; i++) {
    for (j=0; j < 4; j++) {
      a[i][j] = i+j+0;
    }
  }
  
  printf( "a[2][3] = " + a[2][3] + "\n" );
  
 for (i=0; i < 3; i++) {
    for (j=0; j < 4; j++) {
      printf("a[" + i + "][" + j + "] = " + a[i][j] + "   ");
    }
    printf("\n");
  }
}