# sigaction(2) Egghunter
32-bit implemention of the sigaction(2) egghunter explained the the paper [Safely Searching Process Virtual Address Space](http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf) by skape

## Background
Most of the writeups I found on egghunters walked through the access(2) implementation documented in skape's paper.  For my particular problem, the access(2) implementations were too large for the space I could occupy.  The implementation of sigaction(2) takes up 32 bytes.  

## Usage
The egg in the implementation is 0x50905090.  The egghunter will look for two occurances of the egg to ensure it found the actual location in memory of the shellcode.  You can replace this egg with whatever value you would like.

### Compiling
 1. `nasm -f elf32 -o egghunter.o egghunter.nasm`
 2. `ld -o egghunter egghunter.o`
 3. `objdump -d egghunter |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'`

# Disclaimer
You are only authorized to use this tool on systems that you have permission to use it on. It was created for research purposes only.  The creator takes no responsibility of any mis-use of this program.
