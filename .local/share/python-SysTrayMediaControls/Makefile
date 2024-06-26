compile:
	cython3 --embed -o SysTrayMediaControls.c -X language_level=3 SysTrayMediaControls.py
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/python3.12 -o SysTrayMediaControls SysTrayMediaControls.c -lpython3.12 -lpthread -lm -lutil -ldl `pkg-config --cflags --libs gtk+-3.0 appindicator3-0.1 dbus-1 dbus-glib-1`
