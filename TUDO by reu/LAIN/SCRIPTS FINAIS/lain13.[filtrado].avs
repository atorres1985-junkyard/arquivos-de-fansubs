loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\vsfilter.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\DGDecode.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\Undot.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\vaguedenoiser.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\masktools.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\removegrains.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\simpleresize.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\unfilter.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\SangNom.dll")
import("C:\Arquivos de programas\AviSynth 2.5\plugins\limitedsharpen.avsi")
import("C:\Arquivos de programas\AviSynth 2.5\plugins\easyLayer.avsi")

VID_RAW_ORI = DirectShowSource("[rd2-RAWS]_Serial_Experiments_Lain_13_DVD-RIP_[A0D89A8C].mp4",fps=23.976,convertfps=true,audio=false)

VAR_VID_EP1 = VID_RAW_ORI.Trim(0,31691).ConvertToRGB32

VAR_VID_END = DirectShowSource("LAIN_ED_PNG_ROM.avi",audio=false,fps=23.976,convertfps=true).Lanczos4Resize(640,480).FlipVertical.ConvertToRGB32

VAR_VID_FIN = VAR_VID_EP1 + VAR_VID_END

VAR_VID_FIN

ConvertToYV12

EasyLayer(AviSource("lain_alpha_final.avi").ChangeFPS(23.976).Trim(200,2865), 1087)
EasyLayer(AviSource("alpha-lain13-type01-aposentadoria.avi").ChangeFPS(23.976), 15947)
EasyLayer(AviSource("lain_alpha_final.avi").ChangeFPS(23.976).Trim(1,200), 16824)

Textsub("Serial_Experiments_Lain_13_revisado[reu].ssa")
Textsub("Serial_Experiments_Lain_Creditos.ssa")
Textsub("KRK-EPI13-FX.ssa")

vaguedenoiser(nsteps=8,chromaT=0,Wiener=true)
unfilter(-10,-10)
limitedsharpen(ss_x=1,ss_y=1,smode=4,strength=100,soft=40)
fastlinedarken(thinning=0)
undot()
deblock()