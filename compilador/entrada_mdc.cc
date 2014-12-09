int mdc( int x, int y );

int mdc( int x, int y ) {
  int a, b, c, resp;
  
  if ( x > y ) {
    a = x;
    b = y;
  }else {
    a = y;
    b = x;
  }
  
  if( a%b == 0) {
    resp = b;
  }else {
    c = a%b;
    resp = mdc( b, c );
  }
  
  return resp;
}

int main() {
  int x, y, resp;
  x = 50;
  y = 15;
  
  resp = mdc( x, y );
  printf ( "O MDC entre " + x + " e " + y + " é: " + resp + "\n" );
}