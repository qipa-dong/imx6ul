@echo off
echo 为bin文件添加ivt与dcd
::bin\dcdgen.exe bin\dcd.config bin\dcd.bin
if not exist bin\dcd.bin bin\dcdgen.exe bin\dcd.config bin\dcd.bin

for /f "delims=" %%a in ('dir/a-d/od/b *.bin') do set f=%%a
echo 最后修改的BIN文件为:%f%
::bin\imgutil.exe --combine base_addr=0x80000000 ivt_offset=0x400 app_offset=0x2000 dcd_file=bin\dcd.bin app_file=hello_world.bin ofile=sdkapp.img image_entry_point=0x80002000
bin\imgutil.exe --combine base_addr=0x80000000 ivt_offset=0x400 app_offset=0x2000 dcd_file=bin\dcd.bin app_file=%f% ofile=sdkapp.img image_entry_point=0x80002000

echo 将生成的bin文件复制到mfgtools下载目录中
copy sdkapp.img "..\..\mfgtools\Profiles\none\OS Firmware\files"
echo -------------------提示---------------------
echo 下载程序可在Linux下使用:
echo dd if=$FILE of=/dev/mmcblk0 bs=1k seek=1 skip=1
pause