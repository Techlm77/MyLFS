

make prefix=/usr

if $RUN_TESTS
then
    set +e
    make check
    set -e
fi

make prefix=/usr install
rm /usr/lib/libzstd.a

