#!/usr/bin/env bash
rm -f ./*.S
rm -f ./exe*
rm -f ./core
rm -f ./readelf.*
rm -f ./*.o

#exit

GCC4_HOME=/builds/dan/bootstrapinstall/gbs4_1
GCC8_HOME=/builds/dan/bootstrapinstall/gbs8_1

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

#LD219_PATH=/builds/dan/bootstrapbuilds/gbs4_1-binutils/build-bu/ld/ld-new

#echo "Doing 219 link"

#$LD219_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld219 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

LD221_PATH=/builds/dan/bootstrapbuilds/gbstest-binutils221/build-bu/ld/ld-new

echo "Doing 221 link"

$LD221_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld221 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

LD226_PATH=/builds/dan/bootstrapbuilds/gbstest-binutils226/build-bu/ld/ld-new

echo "Doing 226 link"

$LD226_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld226 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

LD229_PATH=/builds/dan/bootstrapbuilds/gbstest-binutils229/build-bu/ld/ld-new

echo "Doing 229 link"

$LD229_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld229 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

echo "Doing 232 link"

$LD232_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld232 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

export LD_LIBRARYN32_PATH=$GCC8_HOME/lib:$LD_LIBRARYN32_PATH

#GOLD232_PATH=$BU232_PATH/gold/ld-new
#
##$GOLD232_PATH -call_shared -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc8.ld232 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc8_as232.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1
#$GOLD232_PATH -melf32bmipn32 -init __gcc_init -fini __gcc_fini -o exe.gcc4.gold232 /usr/lib32/mips4/crt1.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crti.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtbegin.o -L$GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0 gcc4.o -lgcc -lgcc_eh -lm -lc -lgcc -lgcc_eh -lm $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/crtend.o $GCC8_TOOLS_PATH/../lib/gcc/mips-sgi-irix6.5/8.2.0/irix-crtn.o /usr/lib32/mips4/crtn.o || exit -1

# Some dumps
READELF_BIN=$BU232_PATH/binutils/readelf

$READELF_BIN -a exe.mipspro >readelf.mipspro
$READELF_BIN -a exe.gcc4 >readelf.gcc4
$READELF_BIN -a exe.gcc8 >readelf.gcc8
#$READELF_BIN -a exe.gcc8.ld219 >readelf.gcc8.ld219
$READELF_BIN -a exe.gcc8.ld221 >readelf.gcc8.ld221
$READELF_BIN -a exe.gcc8.ld226 >readelf.gcc8.ld226
$READELF_BIN -a exe.gcc8.ld229 >readelf.gcc8.ld229
$READELF_BIN -a exe.gcc8.ld232 >readelf.gcc8.ld232
