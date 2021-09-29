prepare: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f elf64 vdisk.asm -o vdisk.o
	x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 -c "kernel.cpp" -o "kernel.o"
	x86_64-elf-ld -o kernel.tmp -Ttext 0x7e00 vdisk.o kernel.o
	objcopy -O binary kernel.tmp kernel.bin
	cat boot.bin kernel.bin > bootloader.bin

prepare-bochs: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f elf64 vdisk.asm -o vdisk.o
	x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 -c "kernel.cpp" -o "kernel.o"
	x86_64-elf-ld -o kernel.tmp -Ttext 0x7e00 vdisk.o kernel.o
	objcopy -O binary kernel.tmp kernel.bin
	cat boot.bin kernel.bin > bootloader.flp

run: prepare
	qemu-system-x86_64 -drive file=bootloader.bin,if=floppy,index=0,media=disk,format=raw
	rm *.bin
	clear

clean:
	rm *.bin
	rm *.flp
	clear