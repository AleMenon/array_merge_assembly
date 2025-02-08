#include <stdio.h>

int main(){
    int array_a[] = {1,2,3,4,5};
    int array_b[] = {4,5,6,7,8};
    int size_a=5, size_b=5;
    int checkpoint_a=0, checkpoint_b=0;

    int size_principal=size_a+size_b;
    int array_principal[size_principal];
    int array_temp[size_principal];

    int i=0, j=0;

    while(i<size_principal){
        if(checkpoint_a==size_a && checkpoint_b==size_b){
            i=size_principal;
            break;
        }

        if(checkpoint_a<size_a && array_a[checkpoint_a]<array_b[checkpoint_b]){
            array_temp[i]=array_a[checkpoint_a];
            checkpoint_a++;
        }
        else{
            if(checkpoint_b<size_b){
                array_temp[i]=array_b[checkpoint_b];
                checkpoint_b++;
            }
        }
        i++;
    }

    i=j=1;
    array_principal[0] = array_temp[0];

    while(i<size_principal){
        if (array_temp[i] != array_temp[i - 1]){
          array_principal[j] = array_temp[i];
          j++;
       }
       i++;
    }

    for (i = 0; i < j; i++) {
       printf("%d ", array_principal[i]);
    }
    printf("\nO menor valor do vetor eh: %d", array_principal[0]);
    printf("\nO maior valor do vetor eh: %d", array_principal[j-1]);
    return 0;
}
