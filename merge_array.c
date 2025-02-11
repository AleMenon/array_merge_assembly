#include <stdio.h>

int main(){
    /*Arrays to merge*/
    int array_a[] = {2, 4, 6, 8, 10};
    int array_b[] = {1, 3, 5, 7, 9};
    int size_a=5, size_b=5;

    /*Other variables*/
    int checkpoint_a=0, checkpoint_b=0;
    int size_principal=size_a+size_b;
    int array_principal[size_principal];
    int i=0;

    while(i<size_principal){
        /*stop if array a and b fully verified*/
        if(checkpoint_a==size_a && checkpoint_b==size_b){
            i=size_principal;
            break;
        }
        /*Merging*/
        if(checkpoint_a<size_a && checkpoint_b<size_b){
            if(array_a[checkpoint_a]<array_b[checkpoint_b]){
                array_principal[i]=array_a[checkpoint_a];
                checkpoint_a++;
            }
            else{
                array_principal[i]=array_b[checkpoint_b];
                checkpoint_b++;
            }
        }
        else if(checkpoint_a>=size_a){
            array_principal[i]=array_b[checkpoint_b];
            checkpoint_b++;
        }
        else{
            if(checkpoint_b>=size_b){
                array_principal[i]=array_a[checkpoint_a];
                checkpoint_a++;
            }
        }

        /*Removing duplicates*/
        if(i>0 && array_principal[i]==array_principal[i-1]){
            i--;
            size_principal--;
        }
        i++;
    }

    /*Print the array and lowest/highest value*/
    for (i = 0; i < size_principal; i++) {
       printf("%d ", array_principal[i]);
    }
    printf("\nO menor valor do vetor eh: %d", array_principal[0]);
    printf("\nO maior valor do vetor eh: %d", array_principal[size_principal-1]);
    return 0;
}
