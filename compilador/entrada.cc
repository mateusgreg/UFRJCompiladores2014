//int james(int& x){
//  printf("James\n");
//  x++;
//  return x;
//}

int foo(int y, int w, int xpto) {
  int z;
  w = 10;
  z = y + w + xpto;
  
  return z;
}

int main() {
  
  int a, i, j, b[2];
  float f[10][2], g;
  
  int z, x;
  
  string s;
  string s1[10];
  string s2[3][7];
  
  z = 0;
  
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
  //b[0] = 2;
  a = b[1];
  printf("\na = " + a);
  
  a++;
  printf("\nO valor de 'a' é: " + a + "\n");
  
  f[7][1] = 3.5;
  printf("\nf = " + f[7][1]);
  
  g = f[7][1];
  printf("\ng = " + g);
  
  printf("\n");
  
  printf("\n\nEntre com um numero inteiro: ");
  scanf(b[1]);
  printf("Você digitou: " + b[1] + "\n");
  
  printf("\nEntre com um numero real (float): ");
  scanf(f[7][1]);
  printf("Você digitou: " + f[7][1] + "\n");
  
  printf("\nAgora entre com uma palavra: ");
  scanf(s);
  printf("Você digitou: " + s + "\n");

  //printf(james(&a));
  //printf("\n" + z + "\n");
  //james(&z);
  
  printf("\n");
  
  interval (z = 1..10){
    printf(z + "\n");
  }
  
  printf("\n");
  
  forEach (x in b){
    printf(x + "\n");
  }
  
  z = 17;
  
  printf("\n");
  //printf(james(&z) + "\n");
  
  printf("\n");
  printf("foo: " + foo(1, z, 20) + "\n");
  
  printf("\n");
  printf("z: " + z + "\n");
}
