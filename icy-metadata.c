#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc,char *argv[]) {
  char buffer[65536];
  char buffer2[4096];
  char tmp[4096];
  FILE *pp;
  int chunks,i,n,rlen,blen;
  int readlen=atoi(argv[1]);
  if(readlen > 65536) readlen=65536;
  for(blen=0;(rlen=read(0,buffer+blen,sizeof(buffer)-blen)) > 0;) {
    blen += rlen;
    if(blen < readlen) {
      continue;
    }
    while(blen >= readlen) {
      if(write(1,buffer,readlen) <= 0) {
        return 2;
      }
      memmove(buffer,buffer+readlen,blen-readlen);
      blen-=readlen;
      if(!(pp=popen("music-nowplaying","r"))) {
        return 1;
      }
      rlen=fread(buffer2,1,4096,pp);
      buffer2[rlen]=0;//zero it out?
      //if(strchr(buffer2,'\n')) *strchr(buffer2,'\n')=0;
      pclose(pp);
      chunks = strlen(buffer2) / 16 + 2;
      if(chunks > 255) {
        chunks = 255;
        buffer2[253 * 16 + 1] = 0;
      }
      snprintf(tmp,sizeof(tmp)-1,"%cStreamTitle='%s';%n",chunks,buffer2,&n);
      write(1,tmp,strlen(tmp));
      for(i=n;i<(chunks * 16);i++) {
        write(1,"_",1);
      }
      write(1,"\n",1);
    }
  }
  return 0;
}

