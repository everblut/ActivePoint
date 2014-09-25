#include <stdio.h>

int main(int argi,char** args){
  
   int cantidad;
   int i;
   int letras;

     printf("Cuantos nombres apuntaras? : ");
     scanf(" %d", &cantidad);
     printf("Cuantas letras tiene cada nombre aproximadamente? ");
     scanf(" %d", &letras);

     char nombres[cantidad][letras]; //creamos una matriz con [columnas][filas]
 
    //llenamos el arreglo de nombres
    for(i=0;i<cantidad;i++)
      {
	printf("\nIngresa el nombre de la %d persona: ",i+1);
	scanf(" %[^\n]", &nombres[i]);
      }
    //imprimimos los datos que acabamos de vaciar
    for(i=0;i<cantidad;i++){
      printf(" El %d nombre de la lista es %s \n ",i+1, nombres[i]);
    }

  return 0;
}
