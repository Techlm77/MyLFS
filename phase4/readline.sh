# Readline Phase 4
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../$(basename $PATCH_READLINE)

./configure --prefix=/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-8.2

make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw" install

install -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.2

