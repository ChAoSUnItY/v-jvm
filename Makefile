.PHONY: all

all: java_classes/Sum.class
	v fmt . -w
	v -enable-globals -cg -o vjvm.exe -gc boehm_leak -keepc vjvm.v
	vjvm.exe --Xjre "C:\Program Files\Java\jre1.8.0_202" --cp java_classes Sum

java_classes/Sum.class: java_classes/Sum.java
	""C:\Program Files (x86)\Java\jdk1.8.0_202\bin\javac.exe"" java_classes/Sum.java