int main() {
  
  int a, i;
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
    printf("\nEstou no for!!!");
  }
}
