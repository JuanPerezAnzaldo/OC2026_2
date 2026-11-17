#include <stdio.h>
#include <time.h>
#define MAX 5

extern void set_bit(unsigned char *value, unsigned char bit);
extern unsigned char get_bit(unsigned char value, unsigned char bit);

void update_temp( int *temps);
void update_flags( int *temps,int *last_temps, unsigned char *flags);

int main(void)
{
    int arreglo[MAX];
    int n = 0;

    unsigned char banderas[2];
    int ultima_lectura[2];
    int tem_sensores[2];

    printf("Cantidad de elementos (maximo %d): ", MAX);
    scanf("%d", &n);

    for (int i = 0; i < n; i++) {
        printf("Elemento [%d]: ", i);
        scanf("%d", &arreglo[i]);
    }

    printf("\n ARREGLO: ");  
    for (int i = 0; i < n; i++)
        printf("%d ", arreglo[i]);

    printf("\n\r Minimo: %d", minimoC(arreglo, n));
    printf("\n\r Minimo Ensamblador: %d", _minimo(arreglo, n));

    printf("\n\r Maximo: %d", maximoC(arreglo, n));
    printf("\n\r Maximo Ensamblador: %d", _maximo(arreglo, n));

    printf("\n\r Sumatoria: %d", sumatoriaC(arreglo, n));
    printf("\n\r Sumatoria Ensamblador: %d\n\r", _sumatoria(arreglo, n));

    return 0;
}

int minimoC(int *arreglo, int len)
{
    int min = arreglo[0];
    for (int i = 0; i < len; i++)
    {
        if (arreglo[i] < min)
            min = arreglo[i];
    }
    return min;
}

int maximoC(int *arreglo, int len)
{
    int max = arreglo[0];
    for (int i = 0; i < len; i++)
    {
        if (arreglo[i] > max)
            max = arreglo[i];
    }
    return max;
}

int sumatoriaC(int *arreglo, int len)
{
    int suma = 0;
    for (int i = 0; i < len; i++)
    {
        suma += arreglo[i];
    }
    return suma;
}