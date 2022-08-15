all:
	v fmt . -w
	v -o vjvm.exe vjvm.v
	vjvm.exe -v