compile:
	cython3 --embed -o SysTrayMediaControls.c -X language_level=3 SysTrayMediaControls.py
	PYTHON_VERSION=`ls /usr/include | grep -o 'python[3-9]\+\.[0-9]\+'` ; \
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/$$PYTHON_VERSION -o SysTrayMediaControls SysTrayMediaControls.c -l$$PYTHON_VERSION -lpthread -lm -lutil -ldl `pkg-config --cflags --libs gtk+-3.0 appindicator3-0.1 dbus-1 dbus-glib-1`
