# Gettext Phase 4
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.21.1

make

if $RUN_TESTS
then
    set +e
    make check
    set -e
fi

make install
chmod -v 0755 /usr/lib/preloadable_libintl.so

