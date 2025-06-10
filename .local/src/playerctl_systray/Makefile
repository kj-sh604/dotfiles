compile:
	cython3 --embed -o playerctl_systray.c -X language_level=3 playerctl_systray.py
	PYTHON_VERSION=`ls --sort version /usr/include | grep -o 'python[3-9]\+\.[0-9]\+' | tail -1` ; \
	gcc -march=native -O2 -pipe -fno-plt -I /usr/include/$$PYTHON_VERSION -o playerctl_systray playerctl_systray.c -l$$PYTHON_VERSION -lpthread -lm -lutil -ldl `pkg-config --cflags --libs gtk+-3.0 appindicator3-0.1 dbus-1 dbus-glib-1`
