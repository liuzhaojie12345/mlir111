mkdir setest0;
for ((j=1; j<8; j++))
do
	sed -i '/^[0-9]/d' params.h
	sed -i "2i 800," params.h
	for ((i=0; i<100; i++))
	do 
		sed -i "3i 800," params.h
		g++ mlp_test.cpp -L./build/src -ldnnl -O2 -o setest0/test_$[i]_matmul_$[j * 4]_core
		LD_PRELOAD=./build/src/libdnnl.so taskset -c 28-$[27+4 * j] ./setest0/test_$[i]_matmul_$[j * 4]_core
	done
done

