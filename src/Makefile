prepare: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f bin diskstuff.asm -o extendeddisk.bin
	cat boot.bin extendeddisk.bin > bootloader.bin

prepareb: bootloader.asm
	nasm -f bin bootloader.asm -o boot.bin
	nasm -f bin diskstuff.asm -o extendeddisk.bin
	cat boot.bin extendeddisk.bin > bootloader.flp

run: prepare
	qemu-system-x86_64 bootloader.bin
	rm *.bin
	clear

runb: prepareb


clean:
	rm *.bin
	rm *.flp
	clear