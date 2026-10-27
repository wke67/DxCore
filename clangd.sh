#!/bin/sh
# use Arduino IDE to create a sketch, select board / target mcu / options; then compile
# this creates compile commands / build options in the Arduino IDE cache
#
# this script gets build options from Arduino IDE cache and creates a .clangd file
# ready to be used with code completion via clangd, e.g. for zed / visual code
#
# ./clangd.sh sketch_name or nothing (latest) > .clangd
#
AVRGCC=~/.arduino15/packages/DxCore/tools/avr-gcc/7.3.0-atmel3.6.1-azduino8/bin/

if [ $# -gt 0 ]; then
  list=$(ls  ~/.cache/arduino/sketches/*/sketch/*.ino.cpp | grep $1 | tail -1)
else
  list=$(ls -tr ~/.cache/arduino/sketches/*/sketch/*.ino.cpp | tail -1)
fi

dir=${list%/*/*}
if [ ! -d "${dir}" ]; then echo $1 not found; exit 1; fi

fqbn=$( grep fqbn ${dir}/build.options.json )

echo '# ' ${list##*/}
echo '# ' $fqbn

cat <<EOF
CompileFlags:
  Remove: [-arch]
  Add:
    [
      "-target",
      "avr",
      "--include=$HOME/.arduino15/packages/DxCore/hardware/megaavr/1.6.2/cores/dxcore/Arduino.h",
      "--include=$HOME/.arduino15/packages/DxCore/tools/avr-gcc/7.3.0-atmel3.6.1-azduino8/avr/include/stdint.h",
EOF

# extract mmcu
mmcu=$( cat ${dir}/compile_commands.json  | jq  '.[0]' | grep -e "mmcu=" | sed -e 's/\"//' -e 's/\",//' )
# get symbols from pre-processor
echo 'main() {}' | ${AVRGCC}/avr-cpp ${mmcu} -dD | grep -e '__AVR_AVR' -e '__AVR_ARCH' | sed -e 's/#define /      \"-D/' -e 's/_ /_=/' -e 's/$/\",/'

# extract #define and #include
options=$( cat ${dir}/compile_commands.json  | jq  '.[0]' | grep -e "\"-D" -e "\"-I" -e "mmcu=" )
for x in $options; do
  echo "      "$x
done

# get some more includes from cpp
CI=$( ${AVRGCC}/avr-g++ -E -Wp,-v -xc /dev/null 2>&1 | sed -n -e '/#include </,/End of search list/p' | sed -n -e '/ \//p' )

for x in $CI; do
  echo "      "\"-I$x\",
done

cat <<EOF
    ]
  Compiler: /opt/LLVM-21.1.0-Linux-X64/bin/clang
EOF
