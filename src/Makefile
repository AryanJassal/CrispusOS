prepare: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f elf64 vdisk.asm -o vdisk.o
	x86_64-elf-gcc -Ttext 0x8000 -ffreestanding -mno-red-zone -m64 -c "kernel.cpp" -o "kernel.o"
	x86_64-elf-ld -T "linker.ld"
	cat boot.bin kernel.bin > bootloader.bin

run: prepare
	qemu-system-x86_64 -drive file=bootloader.bin,if=floppy,index=0,media=disk,format=raw
	make clean

clean:
	rm *.bin
	rm *.o
	clear