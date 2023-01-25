@echo off
echo video 01/01 - 1st pass: inu.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 1 --bitrate 930 --stats "INU_166.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse none --qpmin 16 --me dia --merange 16 --progress --no-psnr --output NUL "inu.[filtrado].avs"
echo video 01/01 - 2nd pass: inu.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 2 --bitrate 930 --stats "INU_166.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse all  --8x8dct --qpmin 16 --me hex --merange 16 --progress --no-psnr --output "INU_166.264" "inu.[filtrado].avs"
echo video 01/01 - Muxing: INU_166.264 + INU_166.mp4
"C:\Arquivos de programas\x264\MP4Box_20060202\MP4Box.exe" -add "INU_166.264" -add "INU_166.mp4":lang=jap -fps 23.976 -new "INU166final.mp4"
echo ================================================================================
pause
