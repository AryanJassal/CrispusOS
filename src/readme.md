# CrispusOS
This is an operating system that I am making from scratch following Poncho's YouTube tutorial (link [here](https://youtube.com/playlist?list=PLxN4E629pPnKKqYsNVXpmCza8l0Jb6l8-)), along with adding a couple of my own touches here and there.

## Compilation and running
To compile this, you need a linux computer, or you need to be in WSL if you are using Windows to emulate this.

### Requirements
You need to install the `build-essential` package. In the console, type `sudo apt-get install build-essential` in Ubuntu-based systems, or type `pacman -S build-essential` in Arch-based systems. Then, simply navigate into the `src` folder and run `make install-apt` if you are on Ubuntu, or `make install-arch` on Arch-based systems to install all the packages required to run the operating system.

### How to Run
You need to be inside the `src` directory to run this command. Type `make run` in a console window to run the operating system inside of QEmu emulator. 

*Voila!* My operating system is now ready for use!