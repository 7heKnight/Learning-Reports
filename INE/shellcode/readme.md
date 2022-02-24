## *Linux Assembly compiling instruction:*
- For **x32**:

```bash
$ nasm -f elf32 <file_assembly.asm> -o <output_file.o>
$ ld -m elf_i386 <asm_output_file.o> -o <binary_name>
```

- For **x64**:

```bash
$ nasm -f elf_x86_64 <file_assembly.asm> -o <output_file.o>
$ nasm -m elf_x86_64 <asm_output_file.o> -o <binary_name>
```

---
## *Get Hex value*:

```bash
if [ -z "$1" ]
then
  echo "Usage: $0 <path to executable>"
  exit
fi
 objdump -d $1 | grep '[0-9a-f]:' | grep -v 'file' | cut -f2 -d: | cut -f1-6 -d' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | paste -d '' -s |  sed 's/^/"/' | sed 's/$/"/g'
 ```
 
 ---
 ## *Shellcode Tester* (**Not work for me ParotOS**):
 
 ```c
 char shellcode[] = "HexValue";
int main(){
    (*(void(*)())shellcode)();
    return 0;
}
 ```
 - Compile with `gcc`:
 
 ```bash
 $ gcc -m<32/64> -z execstack -fno-stack-protector -no-pie <test_shell.c> -o <test_shell_binary>
 ```
 
 ---
