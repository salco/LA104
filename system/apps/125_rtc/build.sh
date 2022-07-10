set -e
#https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads


mkdir -p build
cd build

arm-none-eabi-g++ -Os -Werror -fno-common -mcpu=cortex-m3 -mthumb -msoft-float -fno-exceptions -fno-rtti -fno-threadsafe-statics -Wno-psabi -MD -D LA104 -D _ARM -D STM32F10X_HD -c \
  ../source/main.cpp \
  ../source/lib/PCF8563.cpp \
  ../source/lib/DateTime.cpp \
  ../source/lib/Arduino.cpp \
  ../../../os_host/source/framework/Wnd.cpp \
  -I../../../os_library/include/ \
  -I../source/ \
  -I../source/lib

arm-none-eabi-gcc -Os -fPIC -mcpu=cortex-m3 -mthumb -o output.elf -nostartfiles -T ../source/app.lds \
  ./main.o \
  ./Wnd.o \
  ./PCF8563.o \
  ./Arduino.o \
  ./DateTime.o  \
  -lbios_la104 -L../../../os_library/build -lm

arm-none-eabi-objdump -d -S output.elf > output.asm
arm-none-eabi-readelf -all output.elf > output.txt

find . -type f -name '*.o' -delete
find . -type f -name '*.d' -delete

../../../../tools/elfstrip/elfstrip output.elf 125rtc.elf

nm --print-size --size-sort -gC output.elf | grep " B " > symbols_ram.txt
nm --print-size --size-sort -gC output.elf | grep " T " > symbols_rom.txt
nm --print-size --size-sort -gC output.elf > symbols_all.txt
#cat symbols_all.txt | grep _address
#objdump -s -j .dynamic output.elf
