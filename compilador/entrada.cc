int main() {
  
  int a;
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
  
  a = 0;
  printf("\nO valor é %d\n", !a);  
}
