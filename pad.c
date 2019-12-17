#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc,char *argv[]) {
 short in;
 int i=0;
 int width=argc>1?atoi(argv[1]):80;
 char with=argc>2?argv[2][0]:' ';
 char *line=argc>3?argv[3]:0;
 if(width <= 0) width=80;
 if(!line) {
  while((in=fgetc(stdin)) != -1) {
   if(in == '\n') {
    for(;i%width || i == 0;i++) {
     putchar(with);
    }
    i=-1;
   }
   i++;
   putchar(in);
  }
 } else {
  i=strlen(line);
 }
 if(i != 0 || line) {
  if(line) fputs(line,stdout);
  for(;i%width || i == 0;i++) {
   putchar(with);
  }
 }
 return 0;
}
