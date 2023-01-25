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

VID_RAW_ORI = DirectShowSource("inuyasha166-167.wmv",fps=23.976,convertfps=true,audio=false)

VAR_VID_EPI = VID_RAW_ORI.Trim(0,67614)

VAR_VID_FIN = VAR_VID_EPI

VAR_VID_FIN

fastlayer(AviSource("INU_OP_61_alpha_lagarith2.avi").ChangeFPS(23.976), 590, 763)

Textsub("creditosINU166.ssa")
Textsub("inu166-revisado[reu].ssa")
Textsub("karaoke_open_6_final.ass")
Textsub("Inuyasha_-_END_-_by_X-Gaara_EPI_FINAL.ssa")
Textsub("InuYasha_Ending_7_-_by_kt_EPI_FINAL.ass")

vaguedenoiser(nsteps=8,chromaT=0,Wiener=true)
unfilter(-10,-10)
limitedsharpen(ss_x=1,ss_y=1,smode=4,strength=100,soft=40)
fastlinedarken(thinning=0)
undot()
deblock()