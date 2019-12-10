#define _POSIX_C_SOURCE 1
#include <limits.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <sys/wait.h>

int pid;//THE child process
int direction;

#define DIR_NEXT 1
#define DIR_PREV -1

void sig_handler(int sig) {
  fprintf(stderr,"got a signal. %d\n",sig);
  switch(sig) {
    case SIGUSR1:
      if(pid > 0) kill(pid,9);
      else fprintf(stderr,"shit. pid is %d\n",pid);
      direction=DIR_PREV;
      break;
    case SIGUSR2:
      if(pid > 0) kill(pid,9);
      else fprintf(stderr,"shit. pid is %d\n",pid);
      direction=DIR_NEXT;
      break;
    default:
      //should NOT happen.
      break;
  }
}

//this is used for how far back you want to be able to go before you error out.
#define LINES 1024

int main(int argc,char *argv[]) {
  int status;
  int index=0;//index of line, not index of buffer. actual buffer index is modulo LINES
  direction=1;
  int start=0;//start of buffer after we max out the buffer.
  int lines_read=0;
  char line[LINES][PATH_MAX+1];//rather be off by one in the safe direction.
  FILE *fp;
  printf("%d\n",getpid());
  fflush(stdout);
  while(1) {//I should come up with a better condition for the main loop
    signal(SIGUSR1,sig_handler);
    signal(SIGUSR2,sig_handler);
    if(index == lines_read) {
      if(fgets(line[index % LINES],sizeof(line[index % LINES])-1,stdin) == 0) {
        fprintf(stderr,"Reached EOF on stdin.\n");
        return 0;//EOF. this is normal.
      }
      if(strchr(line[index % LINES],'\n')) *strchr(line[index % LINES],'\n')=0;
      if(lines_read > LINES) {
        start=lines_read % LINES;//start is 0 until we start looping
      }
      lines_read++;
    }
    switch(pid=fork()) {
      case -1://fuck me
        perror("fork");
        return -1;
      case 0://we're the child
        fprintf(stderr,"running line %d in pid %d: %s %s\n",index,getpid(),argv[1],line[index % LINES]);
        if(getenv("QARGS_CHILD_PIDFILE")) {
          if((fp=fopen(getenv("QARGS_CHILD_PIDFILE"),"w+"))) {
            fprintf(fp,"%d\n",getpid());
            fclose(fp);
          } else {
            fprintf(stderr,"couldn't open child pid file: %s\n",getenv("QARGS_CHILD_PIDFILE"));
          }
        } else {
          fprintf(stderr,"QARGS_CHILD_PIDFILE is not set in env. can't write pidfile for children.\n");
        }
        signal(SIGUSR1,SIG_IGN);
        signal(SIGUSR2,SIG_IGN);
        execlp(argv[1],argv[1],line[index % LINES],NULL);
	perror("execlp");
        return -2;//child failed to exec. tell it to fuck off.
        break;
      default://we're the parent
        break;
    }
    while(wait(&status) == -1) {//wait for child process to finish...
      perror("wait");
    }
    fprintf(stderr,"child %d exited. going to %d the index.\n",pid,direction);
    index+=direction;
    if(index < start) {
      fprintf(stderr,"tried to previous to before start. exiting with code of 1.\n");
      return 1;
    }
    if(index < 0) index+=LINES;
    direction=DIR_NEXT;
  }
}
