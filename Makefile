main : DBconnect.o main.o
	g++ -o main DBconnect.o main.o 
I2C_API.o : DBconnect.cpp
	g++ -c -o DBconnect.o DBconnect.cpp
main.o : main.cpp
	g++ -c -o main.o main.cpp 
clean:
	rm *.o main