// clang -target mips-unknown-linux-gnu -c test1.c -emit-llvm -o test1.bc
// llc -march=cpu0 -relocation-model=pic -filetype=asm test1.bc -o test1.s
// llc -march=cpu0 -relocation-model=pic -filetype=obj test1.bc -o test1.o

// llc -march=cpu0 -relocation-model=pic -filetype=asm test1.bc -o test1.s
// llc -march=cpu0 -relocation-model=pic -filetype=obj test1.bc -o test1.o

/// start
int main()
{
  return 0;
}