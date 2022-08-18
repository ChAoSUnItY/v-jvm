.PHONY: all

all: java_classes/Main.class
	v fmt . -w
	v -g -o vjvm.exe -gc boehm_leak -keepc vjvm.v
	vjvm.exe --Xjre "C:\Program Files\Java\jre1.8.0_202" --cp java_classes Main

java_classes/Main.class: java_classes/Main.java
	""C:\Program Files (x86)\Java\jdk1.8.0_202\bin\javac.exe"" java_classes/Main.java