.phony: clean

JC = javac
JFLAGS = -cp
CLASSPATH = ../lib/

all: PGConnector.class

PGConnector.class: PGConnector.java
	$(JC) $(JFLAGS) $(CLASSPATH) PGConnector.java

clean:
	$(RM) PGConnector.class
