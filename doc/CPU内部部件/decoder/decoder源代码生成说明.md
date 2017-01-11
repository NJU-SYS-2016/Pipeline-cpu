### decoder.v文件生成过程

在设计阶段，先完成了指令信号表，现在需要完成vivado源代码，为了避免重复编码，decoder.v文件是用c生成的。现在给出具体的过程。

1. 首先利用Excel2013自带工具将译码信号表从xlsx格式转成csv文件格式，即原来表格中每一行的每一个表格的数据用逗号隔开；

2. 将上面的csv格式文件保存为文本格式，并命名为decoder_table.txt，并用文本编辑器(VIM)打开；

3. 在文本编辑器中对文件进行一些修改。首先去掉所有的汉字，然后去掉文件开头的逗号，此时文件每一行都应该以汇编指令开头，最后将所有的“逗号”
	替换为“逗号 + 空格”；
	VIM操作：
	```
		:%s/^,//
		:%s/,/, /g
	```

4. 根据MIPS指令手册完成指令的译码工作，并完成vivado的框架格式，保存到decoder_frame.v文件中；

5. 将decoder_table.txt, decoder_frame.v和fill_table.c放在同一个目录下，编译fill_table.c，运行生成的可执行文件，生成的vivado源文件输出到
	控制台，将输出重定向到decoder.v文件中，便得到的源文件；
	```
		gcc fill_table.c -o fill_table.exe
		./fill_tabel.exe > decoder.v
	```

6. 经过上述步骤生成的代码大部分没有问题，不过表格中非数字的数据需要手动修改，另外，生成的代码中最后的无效指令(invalid instruction)对应的
	控制信号需要自己填充；
	
7. 利用Vivado IDE的纠错功能检验有没有出现一些语法错误，并进行改正。