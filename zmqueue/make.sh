#!/bin/bash

gcc -I/usr/local/include -L/usr/local/lib -O2 -D_REENTRANT -D_GNU_SOURCE -Wall -Wno-unused -fno-strict-aliasing -DBASE_THREADSAFE \
	msgqueue.c -o msgqueue \
	-Wl,--start-group -lpthread -lm -lrt -lcrypt -luuid -Wl,--end-group -L. -L. -L. -lpthread -lm -lrt -lcrypt -luuid -lczmq -lzmq
