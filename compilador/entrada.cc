int main() {
  
  int a, i, j;
  int b[2];
  float f[10][2];
  float g;
  
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
  printf(s1[3] + "\n");
  
  s1[3] = s1[5];
  printf(s1[3] + "\n");
  
  s2[2][5] = "de Souza";
  printf(s2[2][5] + "\n");
  
  s = s2[2][5];
  printf(s);
  
  a = 10;
  printf("\na = " + a);
  
  b[1] = 50;
  a = b[1];
  printf("\na = " + a);
  
  a++;
  printf("\nO valor de 'a' é: " + a + "\n");
  
  f[7][1] = 3.5;
  printf("\nf = " + f[7][1]);
  
  g = f[7][1];
  printf("\ng = " + g);
  
  printf("\n\nEntre com um numero inteiro: ");
  scanf(b[1]);
  printf("Você digitou: " + b[1] + "\n");
  
  printf("\nEntre com um numero real (float): ");
  scanf(f[7][1]);
  printf("Você digitou: " + f[7][1] + "\n");
  
  printf("\nAgora entre com uma palavra: ");
  scanf(s);
  printf("Você digitou: " + s + "\n");
}
