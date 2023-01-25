@echo off
echo video 01/01 - 1st pass: lain13.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 1 --bitrate 900 --stats "LAIN_13.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse none --qpmin 16 --me dia --merange 16 --progress --no-psnr --output NUL "lain13.[filtrado].avs"
echo video 01/01 - 2nd pass: lain13.[filtrado].avs
echo video size: 160701 KB - audio size: 17123 KB
"C:\Arquivos de programas\x264\x264.exe" --pass 2 --bitrate 900 --stats "LAIN_13.log" --trellis 1 --bframes 5 --b-pyramid --nf --subme 1 --weightb --analyse all  --8x8dct --qpmin 16 --me hex --merange 16 --progress --no-psnr --output "LAIN_13.264" "lain13.[filtrado].avs"
echo video 01/01 - Muxing: LAIN_13.264 + LAIN_13.mp4
"C:\Arquivos de programas\x264\MP4Box_20060202\MP4Box.exe" -add "LAIN_13.264" -add "LAIN_13.mp4":lang=jap -fps 23.976 -new "LAIN13final.mp4"
echo ================================================================================

pause
