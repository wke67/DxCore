# Installation for Development using Arduino IDE on Linux

To allow DxCore development using Arduino IDE and arduino-cli on a Linux system (e.g. Debian 13.4 trixie, ArchLinux), you can follow these steps:
- install DxCore \<latest\> e.g. 1.6.2 from Arduino IDE
- close Arduino IDE
- clone the *DxCore* repository locally
- copy *~/.arduino15/packages/DxCore/hardware/megaavr/\<latest\>/installed.json* to the *DxCore* repository *megaavr* folder
- remove *~/.arduino15/packages/DxCore/megaavr/\<latest\>* directory
- in *~/.arduino15/packages/DxCore/megaavr* create a symbolic link named *\<latest\>* to the repository *DxCore/megaavr* folder

Here is what this looks like:<br />
```shell
cd ~
git clone https://github.com/SpenceKonde/DxCore
copy ~/.arduino15/packages/DxCore/hardware/megaavr/1.6.2/installed.json DxCore/
cd ~/.arduino15/packages/DxCore/hardware/megaavr
rm -rf 1.6.2
ln -s ~/DxCore/megaavr  1.6.2
```
