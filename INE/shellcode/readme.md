## *Linux Assembly compiling instruction:*
- For **x32**:

```bash
$ nasm -f elf32 <file_assembly.asm> -o <output_file.o>
$ nasm -m elf_i386 <asm_output_file.o> -o <binary_name>
```

- For **x64**:

```bash
$ nasm -f elf_x86_64 <file_assembly.asm> -o <output_file.o>
$ nasm -m elf_x86_64 <asm_output_file.o> -o <binary_name>
```

- Get Hex value:

```bash
if [ -z "$1" ]
then
  echo "Usage: $0 <path to executable>"
  exit
fi
 objdump -d $1 | grep '[0-9a-f]:' | grep -v 'file' | cut -f2 -d: | cut -f1-6 -d' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | paste -d '' -s |  sed 's/^/"/' | sed 's/$/"/g'
 ```
 
 ---
