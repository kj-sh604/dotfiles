compile:
	cython3 --embed -o rainfall.c -X language_level=3 rainfall.py
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/python3.12 -o rainfall rainfall.c -lpython3.12 -lpthread -lm -lutil -ldl
