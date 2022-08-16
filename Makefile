.PHONY: all

all: java_classes/Main.class
	v fmt . -w
	v -o vjvm.exe -gc boehm_leak -keepc vjvm.v
	vjvm.exe --Xjre "C:\Program Files\Java\jre1.8.0_202" java.lang.Object

java_classes/Main.class: java_classes/Main.java
	javac java_classes/Main.java