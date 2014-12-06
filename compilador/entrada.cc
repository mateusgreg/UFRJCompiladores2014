int main() {
  
  int a, i, j;
  int b[2];
  float f[10][2];
  
  string s;
  string s1[10];
  string s2[3][7];
  
  s = 'M';
  printf(s);
  
  s = "\nFrase ";
  s = s + "de" + " teste!\n";
  printf(s);
  
  s1[3] = "Mateus ";
  s1[5] = "Gregorio ";
  printf(s1[3]);
  
  //s1[3] = s1[5];
  //printf(s1[3]);
  
  s2[2][5] = "de Souza";
  printf(s2[2][5]);
    
  a = 10;
  printf("\na = " + a);
  
  b[1] = 50;
  a = b[1];
  printf("\na = " + a);
  
  a++;
  printf("\nO valor de 'a' é: " + a + "\n");
  
  printf("\n" + s + "\n");
  scanf(i);
  scanf(s);
}
