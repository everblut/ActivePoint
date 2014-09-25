#include<stdio.h>
int main()
{
    int i;
    int numero;
    printf("Conjetura de Ulam\n");
    printf("Dado un numero entero cualquiera, se siguen dos pasos simples:\n\n-Si es Par, se divide entre dos. \n-Si es Impar, se multiplica por 3 y se suma 1.\n");
 printf("\nLa conjetura siempre llega al 1 para cualquier numero con el que comencemos.\n\n");
 printf("\nIngrese un numero: ");
 scanf("%d",&numero);
 while(numero>1)
 {
  if(numero%2==0)
      numero=numero/2;
  else 
      numero=numero*3+1;
  printf("\n");
  printf("El  Numero= %d", numero);
 }
}
