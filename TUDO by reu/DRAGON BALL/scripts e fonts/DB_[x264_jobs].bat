@echo off
echo video 01/01 - 1st pass: db153.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 1 --bitrate 900 --stats "DB_153.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse none --qpmin 16 --me dia --merange 16 --progress --no-psnr --output NUL "db153.[filtrado].avs"
echo video 01/01 - 2nd pass: db153.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 2 --bitrate 900 --stats "DB_153.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse all  --8x8dct --qpmin 16 --me hex --merange 16 --progress --no-psnr --output "DB_153.264" "db153.[filtrado].avs"
echo video 01/01 - Muxing: DB_153.264 + DB_153.mp4
"C:\Arquivos de programas\x264\MP4Box_20060202\MP4Box.exe" -add "DB_153.264" -add "DB_153.mp4":lang=jap -fps 23.976 -new "DB153final.mp4"
echo ================================================================================

pause
