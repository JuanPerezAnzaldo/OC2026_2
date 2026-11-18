
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define SENSORS 2
 
#define N 0
#define O 1
#define T 2
#define G 3
#define D 4
#define U 5
 
extern void _setbit(unsigned char*,unsigned char);
extern unsigned char _getbit(unsigned char,unsigned char);
void update_temp( int *temps);
void update_flags( int *temps,int *last_temps, unsigned char *flags);
void print_flag(unsigned char flags);
 
int main(void)
{
	srand(time(NULL));
	int temps[SENSORS] = {25,25};
	int last_temps[SENSORS] = {25,25};
	unsigned char flags[SENSORS] = {0b00000001,0b00000001};
	int opcion = 0;
 
	do
	{
		printf("\n\r SENSOR 1: ~%d °C",temps[0]);
		print_flag(flags[0]);
		printf("\n\r SENSOR 2: ~%d °C",temps[1]);
		print_flag(flags[1]);
 
		printf("\n\n\r [1] Actualizar");
		printf("\n\r [2] Salir");
		printf("\n\n\r Seleccionar opcion: ");
		if(scanf("%d",&opcion) != 1)
			opcion = 2;
 
		if(opcion == 1)
		{
			update_temp(temps);
			update_flags(temps,last_temps,flags);
		}
		printf("\n\r");
	}while(opcion != 2);
 
	printf("\n\rFIN DE PROGRAMA\n\n\r");
	return 0;
}
 
 
 
 
void update_temp( int *temps)
{
	int min = -5,max = 5;
	for(int i = 0 ; i < SENSORS; i++)
	{
		temps[i]+=rand() % (max - min + 1) + min;
	}
}
 
 
void update_flags( int *temps,int *last_temps, unsigned char *flags)
{
	for(int i = 0 ; i < SENSORS; i++)
	{
		int dif = temps[i] - last_temps[i];
		flags[i] = 0;
 
		if(dif == 0)
			_setbit(&flags[i],N);
		else
		{
			if(dif > 0)
				_setbit(&flags[i],U);
			else
			{
				_setbit(&flags[i],D);
				dif = -dif;
			}
 
			if(dif == 1)
				_setbit(&flags[i],O);
			else if(dif == 2)
				_setbit(&flags[i],T);
			else
				_setbit(&flags[i],G);
		}
 
		last_temps[i] = temps[i];
	}
}
 
 
void print_flag(unsigned char flag)
{
	char simbolos[4] = "-";
	char c = '>';
	int n = 1;
 
	if(!_getbit(flag,N))
	{
		if(_getbit(flag,D))
			c = '<';
 
		if(_getbit(flag,T))
			n = 2;
		else if(_getbit(flag,G))
			n = 3;
 
		for(int i = 0 ; i < n; i++)
			simbolos[i] = c;
		simbolos[n] = '\0';
	}
 
	printf(" %s",simbolos);
}
 