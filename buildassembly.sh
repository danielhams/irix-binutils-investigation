#!/usr/bin/env bash
rm -f ./*.S
rm -f ./exe*
rm -f ./core
rm -f ./readelf.*
rm -f ./*.o

#exit

GCC4_HOME=/usr/didbs/0_0_6/gbs4_1
GCC8_HOME=/usr/didbs/0_0_6/gbs8_1

GLEVEL="-g0"
OPT="-O1"

c99 $GLEVEL $OPT simple.c -S -o mipspro.S

as $GLEVEL $OPT -mips4 -n32 mipspro.S -o mipspro.o
/usr/lib32/cmplrs/ld32 $GLEVEL -n32 -L/usr/lib32/mips4 -L/usr/lib32 /usr/lib32/mips4/crt1.o mipspro.o -o exe.mipspro -lc /usr/lib32/mips4/crtn.o

GCC4_TOOLS_PATH=$GCC4_HOME/bin

$GCC4_TOOLS_PATH/gcc $GLEVEL $OPT simple.c -S -o gcc4.S

$GCC4_TOOLS_PATH/as $GLEVEL $OPT gcc4.S -o gcc4.o

$GCC4_TOOLS_PATH/ld -melf32bmipn32 --init __gcc_init -fini __gcc_fini -L/usr/lib32/mips4 -L/usr/lib32 /usr/lib32/mips4/crt1.o $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/irix-crti.o $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/crtbegin.o gcc4.o $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/libgcc.a $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/libgcc_eh.a $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/crtend.o $GCC4_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/4.7.1/irix-crtn.o /usr/lib32/mips4/crtn.o -o exe.gcc4 -lc

GCC8_TOOLS_PATH=$GCC8_HOME/bin
LD_LIBRARYN32_PATH=$GCC8_TOOLS_PATH/../../lib:$LD_LIBRARYN32_PATH

$GCC8_TOOLS_PATH/gcc $GLEVEL $OPT simple.c -S -o gcc8.S

$GCC8_TOOLS_PATH/as $GLEVEL $OPT gcc8.S -o gcc8.o

$GCC8_TOOLS_PATH/ld -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

BU232_PATH=/builds/dan/bootstrapbuilds/gbstest-binutils232/build-bu

AS232_PATH=$BU232_PATH/gas/as-new

$AS232_PATH $GLEVEL $OPT gcc8.S -o gcc8_as232.o

LD232_PATH=$BU232_PATH/ld/ld-new

$LD232_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld232 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

# Some dumps
READELF_BIN=$BU232_PATH/binutils/readelf

$READELF_BIN -a exe.mipspro >readelf.mipspro
$READELF_BIN -a exe.gcc4 >readelf.gcc4
$READELF_BIN -a exe.gcc8 >readelf.gcc8
$READELF_BIN -a exe.gcc8.ld232 >readelf.gcc8.ld232
