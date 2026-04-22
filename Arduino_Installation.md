# Installation for Development using Arduino IDE on Linux

To allow DxCore development using Arduino IDE and arduino-cli on a Linux system (e.g. Debian 13.4 trixie, ArchLinux), you can follow these steps:
- install DxCore \<latest\> e.g. 1.6.2 from Arduino IDE
- close Arduino IDE
- create a folder *hardware* in the Arduino/Sketchbook folder
- in that folder clone the *DxCore* repository
- copy *~/.arduino15/packages/DxCore/hardware/megaavr/\<latest\>/installed.json* to the *DxCore* repository *megaavr* folder
- remove *~/.arduino15/packages/DxCore/megaavr/\<latest\>* directory
- in *~/.arduino15/packages/DxCore/megaavr* create a symbolc link named *\<latest\>* to the repository *DxCore/megaavr* folder

Hints: the sketchbook folder can be found by looking at File->Preferences in the Arduino IDE menu  
Here is what this looks like:  
```shell
cd ~
mkdir Arduino/sketchbook/hardware
cd Arduino/sketchbook/hardware
git clone https://github.com/SpenceKonde/DxCore
copy ~/.arduino15/packages/DxCore/hardware/megaavr/1.6.2/installed.json DxCore/
cd ~/.arduino15/packages/DxCore/hardware/megaavr
rm -rf 1.6.2
ln -s ~/Arduino/sketchbook/hardware/DxCore/megaavr  1.6.2
```
