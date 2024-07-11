>> ### Act as ROOT (in CHROOT) and verify check_vars.sh


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/man-pages.html  
8.3. Man-pages-6.06  

```bash
cd /sources/ && tar -xvf man-pages-6.06.tar.xz && cd man-pages-6.06


rm -v man3/crypt*

make prefix=/usr install


cd /sources/ && rm -rf man-pages-6.06
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/iana-etc.html  
8.4. Iana-Etc-20240125  

```bash
cd /sources/ && tar -xvf iana-etc-20240125.tar.gz && cd iana-etc-20240125


cp services protocols /etc


cd /sources/ && rm -rf iana-etc-20240125
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/glibc.html  
8.5. Glibc-2.39  

```bash
cd /sources/ && tar -xvf glibc-2.39.tar.xz && cd glibc-2.39


patch -Np1 -i ../glibc-2.39-fhs-1.patch
mkdir -v build
cd       build

echo "rootsbindir=/usr/sbin" > configparms

../configure --prefix=/usr                            \
             --disable-werror                         \
             --enable-kernel=4.19                     \
             --enable-stack-protector=strong          \
             --disable-nscd                           \
             libc_cv_slibdir=/usr/lib

make

make check

# TEST #
grep "Timed out" -l $(find -name \*.out)
########

touch /etc/ld.so.conf

sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make install

sed '/RTLDLIST=/s@/usr@@g' -i /usr/bin/ldd

mkdir -pv /usr/lib/locale
localedef -i C -f UTF-8 C.UTF-8
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i el_GR -f ISO-8859-7 el_GR
localedef -i en_GB -f ISO-8859-1 en_GB
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_ES -f ISO-8859-15 es_ES@euro
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i is_IS -f ISO-8859-1 is_IS
localedef -i is_IS -f UTF-8 is_IS.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f ISO-8859-15 it_IT@euro
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true
localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
localedef -i nl_NL@euro -f ISO-8859-15 nl_NL@euro
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i se_NO -f UTF-8 se_NO.UTF-8
localedef -i ta_IN -f UTF-8 ta_IN.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030
localedef -i zh_HK -f BIG5-HKSCS zh_HK.BIG5-HKSCS
localedef -i zh_TW -f UTF-8 zh_TW.UTF-8

make localedata/install-locales

localedef -i C -f UTF-8 C.UTF-8
localedef -i ja_JP -f SHIFT_JIS ja_JP.SJIS 2> /dev/null || true


cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF


tar -xf ../../tzdata2024a.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward; do
    zic -L /dev/null   -d $ZONEINFO       ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix ${tz}
    zic -L leapseconds -d $ZONEINFO/right ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

tzselect

ln -sfv /usr/share/zoneinfo/Australia/Sydney /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv /etc/ld.so.conf.d


cd /sources/ && rm -rf glibc-2.39
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/zlib.html  
8.6. Zlib-1.3.1  

```bash
cd /sources/ && tar -xvf zlib-1.3.1.tar.gz && cd zlib-1.3.1


./configure --prefix=/usr

make

make check

make install

rm -fv /usr/lib/libz.a


cd /sources/ && rm -rf zlib-1.3.1
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/bzip2.html  
8.7. Bzip2-1.0.8  

```bash
cd /sources/ && tar -xvf bzip2-1.0.8.tar.gz && cd bzip2-1.0.8


patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make

make PREFIX=/usr install

cp -av libbz2.so.* /usr/lib
ln -sv libbz2.so.1.0.8 /usr/lib/libbz2.so

cp -v bzip2-shared /usr/bin/bzip2
for i in /usr/bin/{bzcat,bunzip2}; do
  ln -sfv bzip2 $i
done

rm -fv /usr/lib/libbz2.a


cd /sources/ && rm -rf bzip2-1.0.8
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/xz.html  
8.8. Xz-5.4.6  

```bash
cd /sources/ && tar -xvf xz-5.4.6.tar.xz && cd xz-5.4.6


./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.4.6

make

make check

make install


cd /sources/ && rm -rf xz-5.4.6
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/zstd.html  
8.9. Zstd-1.5.5  

```bash
cd /sources/ && tar -xvf zstd-1.5.5.tar.gz && cd zstd-1.5.5


make prefix=/usr

make check

make prefix=/usr install

rm -v /usr/lib/libzstd.a


cd /sources/ && rm -rf zstd-1.5.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/file.html  
8.10. File-5.45  

```bash
cd /sources/ && tar -xvf file-5.45.tar.gz && cd file-5.45


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf file-5.45
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/readline.html  
8.11. Readline-8.2  

```bash
cd /sources/ && tar -xvf readline-8.2.tar.gz && cd readline-8.2


sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../readline-8.2-upstream_fixes-3.patch

./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.2

make SHLIB_LIBS="-lncursesw"

make SHLIB_LIBS="-lncursesw" install

install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.2


cd /sources/ && rm -rf readline-8.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/m4.html  
8.12. M4-1.4.19  

```bash
cd /sources/ && tar -xvf m4-1.4.19.tar.xz && cd m4-1.4.19


./configure --prefix=/usr
make
make check
make install


cd /sources/ && rm -rf m4-1.4.19
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/bc.html  
8.13. Bc-6.7.5  

```bash
cd /sources/ && tar -xvf bc-6.7.5.tar.xz && cd bc-6.7.5


CC=gcc ./configure --prefix=/usr -G -O3 -r

make
make test
make install


cd /sources/ && rm -rf bc-6.7.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/flex.html  
8.14. Flex-2.6.4  

```bash
cd /sources/ && tar -xvf flex-2.6.4.tar.gz && cd flex-2.6.4


./configure --prefix=/usr \
            --docdir=/usr/share/doc/flex-2.6.4 \
            --disable-static

make
make check
make install

ln -sv flex   /usr/bin/lex
ln -sv flex.1 /usr/share/man/man1/lex.1


cd /sources/ && rm -rf flex-2.6.4
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/tcl.html  
8.15. Tcl-8.6.13  

```bash
cd /sources/ && tar -xvf tcl8.6.13-src.tar.gz && cd tcl8.6.13


SRCDIR=$(pwd)
cd unix
./configure --prefix=/usr           \
            --mandir=/usr/share/man

make

sed -e "s|$SRCDIR/unix|/usr/lib|" \
    -e "s|$SRCDIR|/usr/include|"  \
    -i tclConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/tdbc1.1.5|/usr/lib/tdbc1.1.5|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5/library|/usr/lib/tcl8.6|" \
    -e "s|$SRCDIR/pkgs/tdbc1.1.5|/usr/include|"            \
    -i pkgs/tdbc1.1.5/tdbcConfig.sh

sed -e "s|$SRCDIR/unix/pkgs/itcl4.2.3|/usr/lib/itcl4.2.3|" \
    -e "s|$SRCDIR/pkgs/itcl4.2.3/generic|/usr/include|"    \
    -e "s|$SRCDIR/pkgs/itcl4.2.3|/usr/include|"            \
    -i pkgs/itcl4.2.3/itclConfig.sh

unset SRCDIR

make test

make install

chmod -v u+w /usr/lib/libtcl8.6.so

make install-private-headers

ln -sfv tclsh8.6 /usr/bin/tclsh

mv /usr/share/man/man3/{Thread,Tcl_Thread}.3

cd ..
tar -xf ../tcl8.6.13-html.tar.gz --strip-components=1
mkdir -v -p /usr/share/doc/tcl-8.6.13
cp -v -r  ./html/* /usr/share/doc/tcl-8.6.13


cd /sources/ && rm -rf tcl8.6.13
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/expect.html  
8.16. Expect-5.45.4  

```bash
cd /sources/ && tar -xvf expect5.45.4.tar.gz && cd expect5.45.4


python3 -c 'from pty import spawn; spawn(["echo", "ok"])'

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make

make test

make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib


cd /sources/ && rm -rf expect5.45.4
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/dejagnu.html  
8.17. DejaGNU-1.6.3

```bash
cd /sources/ && tar -xvf dejagnu-1.6.3.tar.gz && cd dejagnu-1.6.3


mkdir -v build
cd       build

../configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html ../doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  ../doc/dejagnu.texi

make check

make install
install -v -dm755  /usr/share/doc/dejagnu-1.6.3
install -v -m644   doc/dejagnu.{html,txt} /usr/share/doc/dejagnu-1.6.3


cd /sources/ && rm -rf dejagnu-1.6.3
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/pkgconf.html  
8.18. Pkgconf-2.1.1  

```bash
cd /sources/ && tar -xvf pkgconf-2.1.1.tar.xz && cd pkgconf-2.1.1


./configure --prefix=/usr              \
            --disable-static           \
            --docdir=/usr/share/doc/pkgconf-2.1.1

make

make install

ln -sv pkgconf   /usr/bin/pkg-config
ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1


cd /sources/ && rm -rf pkgconf-2.1.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/binutils.html  
8.19. Binutils-2.42  

```bash
cd /sources/ && tar -xvf binutils-2.42.tar.xz && cd binutils-2.42


mkdir -v build
cd       build

../configure --prefix=/usr       \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib  \
             --enable-default-hash-style=gnu

make tooldir=/usr

make -k check

# TEST #
grep '^FAIL:' $(find -name '*.log')
########

make tooldir=/usr install

rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a


cd /sources/ && rm -rf binutils-2.42
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gmp.html  
8.20. GMP-6.3.0  

```bash
cd /sources/ && tar -xvf gmp-6.3.0.tar.xz && cd gmp-6.3.0


./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.3.0

make
make html

make check 2>&1 | tee gmp-check-log

# IMP TEST #
awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
############

make install
make install-html


cd /sources/ && rm -rf gmp-6.3.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/mpfr.html  
8.21. MPFR-4.2.1  

```bash
cd /sources/ && tar -xvf mpfr-4.2.1.tar.xz && cd mpfr-4.2.1


./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.2.1

make
make html

make check

make install
make install-html


cd /sources/ && rm -rf mpfr-4.2.1
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/mpc.html  
8.22. MPC-1.3.1  

```bash
cd /sources/ && tar -xvf mpc-1.3.1.tar.gz && cd mpc-1.3.1


./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.3.1

make
make html
make check

make install
make install-html


cd /sources/ && rm -rf mpc-1.3.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/attr.html  
8.23. Attr-2.5.2  

```bash
cd /sources/ && tar -xvf attr-2.5.2.tar.gz && cd attr-2.5.2


./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.5.2

make
make check
make install


cd /sources/ && rm -rf attr-2.5.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/acl.html  
8.24. Acl-2.3.2  

```bash
cd /sources/ && tar -xvf acl-2.3.2.tar.xz && cd acl-2.3.2


./configure --prefix=/usr         \
            --disable-static      \
            --docdir=/usr/share/doc/acl-2.3.2

make
make install


cd /sources/ && rm -rf acl-2.3.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libcap.html  
8.25. Libcap-2.69  

```bash
cd /sources/ && tar -xvf libcap-2.69.tar.xz && cd libcap-2.69


sed -i '/install -m.*STA/d' libcap/Makefile

make prefix=/usr lib=lib
make test
make prefix=/usr lib=lib install


cd /sources/ && rm -rf libcap-2.69
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libxcrypt.html  
8.26. Libxcrypt-4.4.36  

```bash
cd /sources/ && tar -xvf libxcrypt-4.4.36.tar.xz && cd libxcrypt-4.4.36


./configure --prefix=/usr                \
            --enable-hashes=strong,glibc \
            --enable-obsolete-api=no     \
            --disable-static             \
            --disable-failure-tokens

make
make check
make install


cd /sources/ && rm -rf libxcrypt-4.4.36
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/shadow.html  
8.27. Shadow-4.14.5  

```bash
cd /sources/ && tar -xvf shadow-4.14.5.tar.xz && cd shadow-4.14.5


sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;

sed -e 's:#ENCRYPT_METHOD DES:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:'                   \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}'                  \
    -i etc/login.defs

## OPTIONAL ##
sed -i 's:DICTPATH.*:DICTPATH\t/lib/cracklib/pw_dict:' etc/login.defs
##############

touch /usr/bin/passwd
./configure --sysconfdir=/etc   \
            --disable-static    \
            --with-{b,yes}crypt \
            --without-libbsd    \
            --with-group-name-max-length=32

make

make exec_prefix=/usr install
make -C man install-man

pwconv

grpconv

mkdir -p /etc/default
useradd -D --gid 999

sed -i '/MAIL/s/yes/no/' /etc/default/useradd

passwd root


cd /sources/ && rm -rf shadow-4.14.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gcc.html  
8.28. GCC-13.2.0  

```bash
cd /sources/ && tar -xvf gcc-13.2.0.tar.xz && cd gcc-13.2.0


case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac

mkdir -v build
cd       build

../configure --prefix=/usr            \
             LD=ld                    \
             --enable-languages=c,c++ \
             --enable-default-pie     \
             --enable-default-ssp     \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-fixincludes    \
             --with-system-zlib

make
#make -j16

ulimit -s 32768
chown -R tester .
su tester -c "PATH=$PATH make -k check"
../contrib/test_summary

make install

chown -v -R root:root \
    /usr/lib/gcc/$(gcc -dumpmachine)/13.2.0/include{,-fixed}

ln -svr /usr/bin/cpp /usr/lib
ln -sv gcc.1 /usr/share/man/man1/cc.1
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/13.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/

# TEST #
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
########

# CHECK #
grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
grep -B4 '^ /usr/include' dummy.log
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log
rm -v dummy.c a.out dummy.log
#########

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib


cd /sources/ && rm -rf gcc-13.2.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/ncurses.html  
8.29. Ncurses-6.4-20230520  

```bash
cd /sources/ && tar -xvf ncurses-6.4-20230520.tar.xz && cd ncurses-6.4-20230520


./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --with-cxx-shared       \
            --enable-pc-files       \
            --enable-widec          \
            --with-pkg-config-libdir=/usr/lib/pkgconfig

make

make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.4 /usr/lib
rm -v  dest/usr/lib/libncursesw.so.6.4
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i dest/usr/include/curses.h
cp -av dest/* /

for lib in ncurses form panel menu ; do
    ln -sfv lib${lib}w.so /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc    /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncursesw.so /usr/lib/libcurses.so

cp -v -R doc -T /usr/share/doc/ncurses-6.4-20230520


cd /sources/ && rm -rf ncurses-6.4-20230520
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/sed.html  
8.30. Sed-4.9  

```bash
cd /sources/ && tar -xvf sed-4.9.tar.xz && cd sed-4.9


./configure --prefix=/usr

make
make html

chown -R tester .
su tester -c "PATH=$PATH make check"

make install
install -d -m755           /usr/share/doc/sed-4.9
install -m644 doc/sed.html /usr/share/doc/sed-4.9


cd /sources/ && rm -rf sed-4.9
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/psmisc.html  
8.31. Psmisc-23.6  

```bash
cd /sources/ && tar -xvf psmisc-23.6.tar.xz && cd psmisc-23.6


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf psmisc-23.6
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gettext.html  
8.32. Gettext-0.22.4  

```bash
cd /sources/ && tar -xvf gettext-0.22.4.tar.xz && cd gettext-0.22.4


./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.22.4

make
make check
make install

chmod -v 0755 /usr/lib/preloadable_libintl.so


cd /sources/ && rm -rf gettext-0.22.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/bison.html  
8.33. Bison-3.8.2  

```bash
cd /sources/ && tar -xvf bison-3.8.2.tar.xz && cd bison-3.8.2


./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.8.2

make
make check
make install


cd /sources/ && rm -rf bison-3.8.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/grep.html  
8.34. Grep-3.11  

```bash
cd /sources/ && tar -xvf grep-3.11.tar.xz && cd grep-3.11


sed -i "s/echo/#echo/" src/egrep.sh

./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf grep-3.11
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/bash.html  
8.35. Bash-5.2.21  

```bash
cd /sources/ && tar -xvf bash-5.2.21.tar.gz && cd bash-5.2.21


patch -Np1 -i ../bash-5.2.21-upstream_fixes-1.patch

./configure --prefix=/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-5.2.21

make

chown -R tester .

su -s /usr/bin/expect tester << "EOF"
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

make install

exec /usr/bin/bash --login


cd /sources/ && rm -rf bash-5.2.21
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libtool.html  
8.36. Libtool-2.4.7  

```bash
cd /sources/ && tar -xvf libtool-2.4.7.tar.xz && cd libtool-2.4.7


./configure --prefix=/usr

make
make -k check
make install

rm -fv /usr/lib/libltdl.a


cd /sources/ && rm -rf libtool-2.4.7
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gdbm.html  
8.37. GDBM-1.23  

```bash
cd /sources/ && tar -xvf gdbm-1.23.tar.gz && cd gdbm-1.23


./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

make
make check
make install


cd /sources/ && rm -rf gdbm-1.23
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gperf.html  
8.38. Gperf-3.1  

```bash
cd /sources/ && tar -xvf gperf-3.1.tar.gz && cd gperf-3.1


./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

make
make -j1 check
make install


cd /sources/ && rm -rf gperf-3.1
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/expat.html  
8.39. Expat-2.6.0  

```bash
cd /sources/ && tar -xvf expat-2.6.0.tar.xz && cd expat-2.6.0


./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.6.0

make
make check
make install

install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.6.0


cd /sources/ && rm -rf expat-2.6.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/inetutils.html  
8.40. Inetutils-2.5  

```bash
cd /sources/ && tar -xvf inetutils-2.5.tar.xz && cd inetutils-2.5


./configure --prefix=/usr        \
            --bindir=/usr/bin    \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers

make
make check
make install

mv -v /usr/{,s}bin/ifconfig


cd /sources/ && rm -rf inetutils-2.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/less.html  
8.41. Less-643  

```bash
cd /sources/ && tar -xvf less-643.tar.gz && cd less-643


./configure --prefix=/usr --sysconfdir=/etc

make
make check
make install


cd /sources/ && rm -rf less-643
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/perl.html  
8.42. Perl-5.38.2  

```bash
cd /sources/ && tar -xvf perl-5.38.2.tar.xz && cd perl-5.38.2


export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des                                         \
             -Dprefix=/usr                                \
             -Dvendorprefix=/usr                          \
             -Dprivlib=/usr/lib/perl5/5.38/core_perl      \
             -Darchlib=/usr/lib/perl5/5.38/core_perl      \
             -Dsitelib=/usr/lib/perl5/5.38/site_perl      \
             -Dsitearch=/usr/lib/perl5/5.38/site_perl     \
             -Dvendorlib=/usr/lib/perl5/5.38/vendor_perl  \
             -Dvendorarch=/usr/lib/perl5/5.38/vendor_perl \
             -Dman1dir=/usr/share/man/man1                \
             -Dman3dir=/usr/share/man/man3                \
             -Dpager="/usr/bin/less -isR"                 \
             -Duseshrplib                                 \
             -Dusethreads

make

TEST_JOBS=$(nproc) make test_harness

make install
unset BUILD_ZLIB BUILD_BZIP2


cd /sources/ && rm -rf perl-5.38.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/xml-parser.html  
8.43. XML::Parser-2.47  

```bash
cd /sources/ && tar -xvf XML-Parser-2.47.tar.gz && cd XML-Parser-2.47


perl Makefile.PL

make
make check
make install


cd /sources/ && rm -rf XML-Parser-2.47
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/intltool.html  
8.44. Intltool-0.51.0  

```bash
cd /sources/ && tar -xvf intltool-0.51.0.tar.gz && cd intltool-0.51.0


sed -i 's:\\\${:\\\$\\{:' intltool-update.in

./configure --prefix=/usr

make
make check
make install

install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO


cd /sources/ && rm -rf intltool-0.51.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/autoconf.html  
8.45. Autoconf-2.72  

```bash
cd /sources/ && tar -xvf autoconf-2.72.tar.xz && cd autoconf-2.72


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf autoconf-2.72
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/automake.html  
8.46. Automake-1.16.5  

```bash
cd /sources/ && tar -xvf automake-1.16.5.tar.xz && cd automake-1.16.5


./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

make
make -j$(($(nproc)>4?$(nproc):4)) check
make install


cd /sources/ && rm -rf automake-1.16.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/openssl.html  
8.47. OpenSSL-3.2.1  

```bash
cd /sources/ && tar -xvf openssl-3.2.1.tar.gz && cd openssl-3.2.1


./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

make

HARNESS_JOBS=$(nproc) make test

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.2.1

cp -vfr doc/* /usr/share/doc/openssl-3.2.1


cd /sources/ && rm -rf openssl-3.2.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/kmod.html  
8.48. Kmod-31  

```bash
cd /sources/ && tar -xvf kmod-31.tar.xz && cd kmod-31


./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --with-openssl         \
            --with-xz              \
            --with-zstd            \
            --with-zlib

make
make install

for target in depmod insmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /usr/sbin/$target
done

ln -sfv kmod /usr/bin/lsmod


cd /sources/ && rm -rf kmod-31
```




https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libelf.html  
8.49. Libelf from Elfutils-0.190  

```bash
cd /sources/ && tar -xvf elfutils-0.190.tar.bz2 && cd elfutils-0.190


./configure --prefix=/usr                \
            --disable-debuginfod         \
            --enable-libdebuginfod=dummy

make

make check

make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a


cd /sources/ && rm -rf elfutils-0.190
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libffi.html  
8.50. Libffi-3.4.4  

```bash
cd /sources/ && tar -xvf libffi-3.4.4.tar.gz && cd libffi-3.4.4


./configure --prefix=/usr          \
            --disable-static       \
            --with-gcc-arch=native

make
make check
make install


cd /sources/ && rm -rf libffi-3.4.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/Python.html  
8.51. Python-3.12.2  

```bash
cd /sources/ && tar -xvf Python-3.12.2.tar.xz && cd Python-3.12.2


./configure --prefix=/usr        \
            --enable-shared      \
            --with-system-expat  \
            --enable-optimizations

make
make install

cat > /etc/pip.conf << EOF
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF


install -v -dm755 /usr/share/doc/python-3.12.2/html

tar --no-same-owner \
    -xvf ../python-3.12.2-docs-html.tar.bz2
cp -R --no-preserve=mode python-3.12.2-docs-html/* \
    /usr/share/doc/python-3.12.2/html


cd /sources/ && rm -rf Python-3.12.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/flit-core.html  
8.52. Flit-Core-3.9.0  

```bash
cd /sources/ && tar -xvf flit_core-3.9.0.tar.gz && cd flit_core-3.9.0


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist flit_core


cd /sources/ && rm -rf flit_core-3.9.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/wheel.html  
8.53. Wheel-0.42.0  

```bash
cd /sources/ && tar -xvf wheel-0.42.0.tar.gz && cd wheel-0.42.0


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links=dist wheel


cd /sources/ && rm -rf wheel-0.42.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/setuptools.html  
8.54. Setuptools-69.1.0  

```bash
cd /sources/ && tar -xvf setuptools-69.1.0.tar.gz && cd setuptools-69.1.0


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links dist setuptools


cd /sources/ && rm -rf setuptools-69.1.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/ninja.html  
8.55. Ninja-1.11.1  

```bash
cd /sources/ && tar -xvf ninja-1.11.1.tar.gz && cd ninja-1.11.1


export NINJAJOBS=4

sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

python3 configure.py --bootstrap

./ninja ninja_test
./ninja_test --gtest_filter=-SubprocessTest.SetWithLots

install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja


cd /sources/ && rm -rf ninja-1.11.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/meson.html  
8.56. Meson-1.3.2  

```bash
cd /sources/ && tar -xvf meson-1.3.2.tar.gz && cd meson-1.3.2


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --find-links dist meson
install -vDm644 data/shell-completions/bash/meson /usr/share/bash-completion/completions/meson
install -vDm644 data/shell-completions/zsh/_meson /usr/share/zsh/site-functions/_meson


cd /sources/ && rm -rf meson-1.3.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/coreutils.html  
8.57. Coreutils-9.4  

```bash
cd /sources/ && tar -xvf coreutils-9.4.tar.xz && cd coreutils-9.4


patch -Np1 -i ../coreutils-9.4-i18n-1.patch

sed -e '/n_out += n_hold/,+4 s|.*bufsize.*|//&|' \
    -i src/split.c

autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

make

make NON_ROOT_USERNAME=tester check-root

groupadd -g 102 dummy -U tester

chown -R tester . 

su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"

groupdel dummy

make install

mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8


cd /sources/ && rm -rf coreutils-9.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/check.html  
8.58. Check-0.15.2  

```bash
cd /sources/ && tar -xvf check-0.15.2.tar.gz && cd check-0.15.2


./configure --prefix=/usr --disable-static
make
make check
make docdir=/usr/share/doc/check-0.15.2 install


cd /sources/ && rm -rf check-0.15.2
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/diffutils.html  
8.59. Diffutils-3.10  

```bash
cd /sources/ && tar -xvf diffutils-3.10.tar.xz && cd diffutils-3.10


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf diffutils-3.10
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gawk.html  
8.60. Gawk-5.3.0  

```bash
cd /sources/ && tar -xvf gawk-5.3.0.tar.xz && cd gawk-5.3.0


sed -i 's/extras//' Makefile.in

./configure --prefix=/usr

make

chown -R tester .
su tester -c "PATH=$PATH make check"

rm -f /usr/bin/gawk-5.3.0
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1

mkdir -pv                                   /usr/share/doc/gawk-5.3.0
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.3.0


cd /sources/ && rm -rf gawk-5.3.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/findutils.html  
8.61. Findutils-4.9.0  

```bash
cd /sources/ && tar -xvf findutils-4.9.0.tar.xz && cd findutils-4.9.0


./configure --prefix=/usr --localstatedir=/var/lib/locate

make

chown -R tester .
su tester -c "PATH=$PATH make check"

make install


cd /sources/ && rm -rf findutils-4.9.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/groff.html  
8.62. Groff-1.23.0  

```bash
cd /sources/ && tar -xvf groff-1.23.0.tar.gz && cd groff-1.23.0


PAGE=A4 ./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf groff-1.23.0
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/grub.html  
8.63. GRUB-2.12  

```bash
cd /sources/ && tar -xvf grub-2.12.tar.xz && cd grub-2.12


unset {C,CPP,CXX,LD}FLAGS

echo depends bli part_gpt > grub-core/extra_deps.lst

./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

make

make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions


cd /sources/ && rm -rf grub-2.12
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/gzip.html  
8.64. Gzip-1.13  

```bash
cd /sources/ && tar -xvf gzip-1.13.tar.xz && cd gzip-1.13


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf gzip-1.13
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/iproute2.html  
8.65. IPRoute2-6.7.0  

```bash
cd /sources/ && tar -xvf iproute2-6.7.0.tar.xz && cd iproute2-6.7.0


sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

make NETNS_RUN_DIR=/run/netns

make SBINDIR=/usr/sbin install

mkdir -pv             /usr/share/doc/iproute2-6.7.0
cp -v COPYING README* /usr/share/doc/iproute2-6.7.0


cd /sources/ && rm -rf iproute2-6.7.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/kbd.html  
8.66. Kbd-2.6.4  

```bash
cd /sources/ && tar -xvf kbd-2.6.4.tar.xz && cd kbd-2.6.4


patch -Np1 -i ../kbd-2.6.4-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make
make check
make install

cp -R -v docs/doc -T /usr/share/doc/kbd-2.6.4


cd /sources/ && rm -rf kbd-2.6.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/libpipeline.html  
8.67. Libpipeline-1.5.7  

```bash
cd /sources/ && tar -xvf libpipeline-1.5.7.tar.gz && cd libpipeline-1.5.7


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf libpipeline-1.5.7
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/make.html  
8.68. Make-4.4.1  

```bash
cd /sources/ && tar -xvf make-4.4.1.tar.gz && cd make-4.4.1


./configure --prefix=/usr

make

chown -R tester .
su tester -c "PATH=$PATH make check"

make install


cd /sources/ && rm -rf make-4.4.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/patch.html  
8.69. Patch-2.7.6  

```bash
cd /sources/ && tar -xvf patch-2.7.6.tar.xz && cd patch-2.7.6


./configure --prefix=/usr

make
make check
make install


cd /sources/ && rm -rf patch-2.7.6
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/tar.html  
8.70. Tar-1.35  

```bash
cd /sources/ && tar -xvf tar-1.35.tar.xz && cd tar-1.35


FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr

make
make check
make install

make -C doc install-html docdir=/usr/share/doc/tar-1.35


cd /sources/ && rm -rf tar-1.35
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/texinfo.html  
8.71. Texinfo-7.1  

```bash
cd /sources/ && tar -xvf texinfo-7.1.tar.xz && cd texinfo-7.1


./configure --prefix=/usr

make
make check
make install

make TEXMF=/usr/share/texmf install-tex

pushd /usr/share/info
  rm -v dir
  for f in *
    do install-info $f dir 2>/dev/null
  done
popd


cd /sources/ && rm -rf texinfo-7.1
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/vim.html  
8.72. Vim-9.1.0041  

```bash
cd /sources/ && tar -xvf vim-9.1.0041.tar.gz && cd vim-9.1.0041


echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr

make
chown -R tester .

su tester -c "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" \
   &> vim-test.log

make install

ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim91/doc /usr/share/doc/vim-9.1.0041


cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

# TEST #
vim -c ':options'
########


cd /sources/ && rm -rf vim-9.1.0041
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/markupsafe.html  
8.73. MarkupSafe-2.1.5  

```bash
cd /sources/ && tar -xvf MarkupSafe-2.1.5.tar.gz && cd MarkupSafe-2.1.5


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist Markupsafe


cd /sources/ && rm -rf MarkupSafe-2.1.5
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/jinja2.html  
8.74. Jinja2-3.1.3  

```bash
cd /sources/ && tar -xvf Jinja2-3.1.3.tar.gz && cd Jinja2-3.1.3


pip3 wheel -w dist --no-cache-dir --no-build-isolation --no-deps $PWD

pip3 install --no-index --no-user --find-links dist Jinja2


cd /sources/ && rm -rf Jinja2-3.1.3
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/udev.html  
8.75. Udev from Systemd-255  

```bash
cd /sources/ && tar -xvf systemd-255.tar.gz && cd systemd-255


sed -i -e 's/GROUP="render"/GROUP="video"/' \
       -e 's/GROUP="sgx", //' rules.d/50-udev-default.rules.in

sed '/systemd-sysctl/s/^/#/' -i rules.d/99-systemd.rules.in

sed '/NETWORK_DIRS/s/systemd/udev/' -i src/basic/path-lookup.h

mkdir -p build
cd       build

meson setup \
      --prefix=/usr                 \
      --buildtype=release           \
      -Dmode=release                \
      -Ddev-kvm-mode=0660           \
      -Dlink-udev-shared=false      \
      -Dlogind=false                \
      -Dvconsole=false              \
      ..

export udev_helpers=$(grep "'name' :" ../src/udev/meson.build | \
                      awk '{print $3}' | tr -d ",'" | grep -v 'udevadm')

ninja udevadm systemd-hwdb                                           \
      $(ninja -n | grep -Eo '(src/(lib)?udev|rules.d|hwdb.d)/[^ ]*') \
      $(realpath libudev.so --relative-to .)                         \
      $udev_helpers

install -vm755 -d {/usr/lib,/etc}/udev/{hwdb.d,rules.d,network}
install -vm755 -d /usr/{lib,share}/pkgconfig
install -vm755 udevadm                             /usr/bin/
install -vm755 systemd-hwdb                        /usr/bin/udev-hwdb
ln      -svfn  ../bin/udevadm                      /usr/sbin/udevd
cp      -av    libudev.so{,*[0-9]}                 /usr/lib/
install -vm644 ../src/libudev/libudev.h            /usr/include/
install -vm644 src/libudev/*.pc                    /usr/lib/pkgconfig/
install -vm644 src/udev/*.pc                       /usr/share/pkgconfig/
install -vm644 ../src/udev/udev.conf               /etc/udev/
install -vm644 rules.d/* ../rules.d/README         /usr/lib/udev/rules.d/
install -vm644 $(find ../rules.d/*.rules \
                      -not -name '*power-switch*') /usr/lib/udev/rules.d/
install -vm644 hwdb.d/*  ../hwdb.d/{*.hwdb,README} /usr/lib/udev/hwdb.d/
install -vm755 $udev_helpers                       /usr/lib/udev
install -vm644 ../network/99-default.link          /usr/lib/udev/network

tar -xvf ../../udev-lfs-20230818.tar.xz
make -f udev-lfs-20230818/Makefile.lfs install

tar -xf ../../systemd-man-pages-255.tar.xz                            \
    --no-same-owner --strip-components=1                              \
    -C /usr/share/man --wildcards '*/udev*' '*/libudev*'              \
                                  '*/systemd.link.5'                  \
                                  '*/systemd-'{hwdb,udevd.service}.8

sed 's|systemd/network|udev/network|'                                 \
    /usr/share/man/man5/systemd.link.5                                \
  > /usr/share/man/man5/udev.link.5

sed 's/systemd\(\\\?-\)/udev\1/' /usr/share/man/man8/systemd-hwdb.8   \
                               > /usr/share/man/man8/udev-hwdb.8

sed 's|lib.*udevd|sbin/udevd|'                                        \
    /usr/share/man/man8/systemd-udevd.service.8                       \
  > /usr/share/man/man8/udevd.8

rm /usr/share/man/man*/systemd*

unset udev_helpers

udev-hwdb update


cd /sources/ && rm -rf systemd-255
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/man-db.html  
8.76. Man-DB-2.12.0  

```bash
cd /sources/ && tar -xvf man-db-2.12.0.tar.xz && cd man-db-2.12.0


./configure --prefix=/usr                         \
            --docdir=/usr/share/doc/man-db-2.12.0 \
            --sysconfdir=/etc                     \
            --disable-setuid                      \
            --enable-cache-owner=bin              \
            --with-browser=/usr/bin/lynx          \
            --with-vgrind=/usr/bin/vgrind         \
            --with-grap=/usr/bin/grap             \
            --with-systemdtmpfilesdir=            \
            --with-systemdsystemunitdir=

make
make check
make install


cd /sources/ && rm -rf man-db-2.12.0
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/procps-ng.html  
8.77. Procps-ng-4.0.4  

```bash
cd /sources/ && tar -xvf procps-ng-4.0.4.tar.xz && cd procps-ng-4.0.4


./configure --prefix=/usr                           \
            --docdir=/usr/share/doc/procps-ng-4.0.4 \
            --disable-static                        \
            --disable-kill

make
make check
make install


cd /sources/ && rm -rf procps-ng-4.0.4
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/util-linux.html  
8.78. Util-linux-2.39.3  

```bash
cd /sources/ && tar -xvf util-linux-2.39.3.tar.xz && cd util-linux-2.39.3


sed -i '/test_mkfds/s/^/#/' tests/helpers/Makemodule.am

./configure --bindir=/usr/bin    \
            --libdir=/usr/lib    \
            --runstatedir=/run   \
            --sbindir=/usr/sbin  \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir        \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.39.3

make


# OMIT # This below line show be executed after LFS first boot
bash tests/run.sh --srcdir=$PWD --builddir=$PWD
########

# TEST # Ignore and try to run above after first boot
chown -R tester .
su tester -c "make -k check"
########

make install


cd /sources/ && rm -rf util-linux-2.39.3
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/e2fsprogs.html  
8.79. E2fsprogs-1.47.0  

```bash
cd /sources/ && tar -xvf e2fsprogs-1.47.0.tar.gz && cd e2fsprogs-1.47.0


mkdir -v build
cd       build

../configure --prefix=/usr           \
             --sysconfdir=/etc       \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck

make
make check
make install

rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
install -v -m644 doc/com_err.info /usr/share/info
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info

sed 's/metadata_csum_seed,//' -i /etc/mke2fs.conf


cd /sources/ && rm -rf e2fsprogs-1.47.0
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/sysklogd.html  
8.80. Sysklogd-1.5.1  

```bash
cd /sources/ && tar -xvf sysklogd-1.5.1.tar.gz && cd sysklogd-1.5.1


sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
sed -i 's/union wait/int/' syslogd.c

make

make BINDIR=/sbin install

cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF


cd /sources/ && rm -rf sysklogd-1.5.1
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/sysvinit.html  
8.81. Sysvinit-3.08  

```bash
cd /sources/ && tar -xvf sysvinit-3.08.tar.xz && cd sysvinit-3.08


patch -Np1 -i ../sysvinit-3.08-consolidated-1.patch

make
make install


cd /sources/ && rm -rf sysvinit-3.08
```


https://www.linuxfromscratch.org/lfs/view/stable/chapter08/cleanup.html
8.84. Cleaning Up

```bash

rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester

```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/stripping.html  
8.83. Stripping

```bash
#cd /sources/ && tar -xvf filen && cd filename

#SKIPPING FOR MOMENT - (You can visit this next time)

save_usrlib="$(cd /usr/lib; ls ld-linux*[^g])
             libc.so.6
             libthread_db.so.1
             libquadmath.so.0.0.0
             libstdc++.so.6.0.32
             libitm.so.1.0.0
             libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug --compress-debug-sections=zlib $LIB $LIB.dbg
    cp $LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    objcopy --add-gnu-debuglink=$LIB.dbg /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

online_usrbin="bash find strip"
online_usrlib="libbfd-2.42.so
               libsframe.so.1.0.0
               libhistory.so.8.2
               libncursesw.so.6.4-20230520
               libm.so.6
               libreadline.so.8.2
               libz.so.1.3.1
               libzstd.so.1.5.5
               $(cd /usr/lib; find libnss*.so* -type f)"

for BIN in $online_usrbin; do
    cp /usr/bin/$BIN /tmp/$BIN
    strip --strip-unneeded /tmp/$BIN
    install -vm755 /tmp/$BIN /usr/bin
    rm /tmp/$BIN
done

for LIB in $online_usrlib; do
    cp /usr/lib/$LIB /tmp/$LIB
    strip --strip-unneeded /tmp/$LIB
    install -vm755 /tmp/$LIB /usr/lib
    rm /tmp/$LIB
done

for i in $(find /usr/lib -type f -name \*.so* ! -name \*dbg) \
         $(find /usr/lib -type f -name \*.a)                 \
         $(find /usr/{bin,sbin,libexec} -type f); do
    case "$online_usrbin $online_usrlib $save_usrlib" in
        *$(basename $i)* )
            ;;
        * ) strip --strip-unneeded $i
            ;;
    esac
done

unset BIN LIB save_usrlib online_usrbin online_usrlib

#cd /sources/ && rm -rf filename
```

https://www.linuxfromscratch.org/lfs/view/stable/chapter08/cleanup.html  
8.84. Cleaning Up

```bash
rm -rf /tmp/*

find /usr/lib /usr/libexec -name \*.la -delete

find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf

userdel -r tester
```