@echo off
echo Ϊbin�ļ����ivt��dcd
::bin\dcdgen.exe bin\dcd.config bin\dcd.bin
if not exist bin\dcd.bin bin\dcdgen.exe bin\dcd.config bin\dcd.bin

for /f "delims=" %%a in ('dir/a-d/od/b *.bin') do set f=%%a
echo ����޸ĵ�BIN�ļ�Ϊ:%f%
::bin\imgutil.exe --combine base_addr=0x80000000 ivt_offset=0x400 app_offset=0x2000 dcd_file=bin\dcd.bin app_file=hello_world.bin ofile=sdkapp.img image_entry_point=0x80002000
bin\imgutil.exe --combine base_addr=0x80000000 ivt_offset=0x400 app_offset=0x2000 dcd_file=bin\dcd.bin app_file=%f% ofile=sdkapp.img image_entry_point=0x80002000

echo �����ɵ�bin�ļ����Ƶ�mfgtools����Ŀ¼��
copy sdkapp.img "..\..\mfgtools\Profiles\none\OS Firmware\files"
echo -------------------��ʾ---------------------
echo ���س������Linux��ʹ��:
echo dd if=$FILE of=/dev/mmcblk0 bs=1k seek=1 skip=1
pause