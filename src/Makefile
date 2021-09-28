prepare: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f bin diskstuff.asm -o extendeddisk.bin
	cat boot.bin extendeddisk.bin > bootloader.bin

run: prepare
	qemu-system-x86_64 bootloader.bin
	rm *.bin
	clear

clean:
	rm *.bin
	clear