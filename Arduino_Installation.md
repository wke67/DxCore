## Arduino Installation for Development

To allow DxCore development using Arduino IDE and arduino-cli on a Linux system (Debian 13.4 trixie), you can follow these steps:
- install DxCore \<latest\> e.g. 1.6.2 from Arduino IDE
- close Arduino IDE
- create a folder *hardware* in the Arduino/Sketchbook folder
- in that folder clone the *DxCore* repository 
- copy *~/.arduino15/packages/DxCore/megaavr/\<latest\>/installed.json* to the *DxCore* repository *megaavr* folder
- remove *~/.arduino15/packages/DxCore/megaavr/\<latest\>* directory
- in *~/.arduino15/packages/DxCore/megaavr* create a symbolc link named *\<latest\>* to the repository *DxCore/megaavr* folder
