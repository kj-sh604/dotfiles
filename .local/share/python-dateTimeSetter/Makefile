compile:
	cython3 --embed -o dateTime.c -X language_level=3 dateTime.py
	PYTHON_VERSION=`ls /usr/include | grep -o 'python[3-9]\+\.[0-9]\+'` ; \
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/$$PYTHON_VERSION -o dateTime dateTime.c -l$$PYTHON_VERSION -lpthread -lm -lutil -ldl
