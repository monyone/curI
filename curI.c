#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "aa.h"

int main(int argc, char* argv[]){
	int use = 0;

	srand((unsigned)time(NULL));
	use = rand() % AA_SIZE;
	
	printf("%s", aa_array[use]);
	
	return 0;
}
