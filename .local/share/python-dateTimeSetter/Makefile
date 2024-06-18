compile:
	cython3 --embed -o dateTime.c -X language_level=3 dateTime.py
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/python3.12 -o dateTime dateTime.c -lpython3.12 -lpthread -lm -lutil -ldl
