compile:
	cython3 --embed -o rainfall.c -X language_level=3 rainfall.py
	PYTHON_VERSION=`ls /usr/include | grep -o 'python[3-9]\+\.[0-9]\+' | tail -1` ; \
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/$$PYTHON_VERSION -o rainfall rainfall.c -l$$PYTHON_VERSION -lpthread -lm -lutil -ldl
