# ··· Configuración ···

cf = 1
rs_x = 640
rs_y = 480

bOP = 0
eOP = 2603
bED = 32408
eED = 34728

loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\vaguedenoiser.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\masktools.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\removegrains.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\simpleresize.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\unfilter.dll")
loadplugin("C:\Arquivos de programas\AviSynth 2.5\plugins\undot.dll")
import("C:\Arquivos de programas\AviSynth 2.5\plugins\limitedsharpen.avsi")
import("C:\Arquivos de programas\AviSynth 2.5\plugins\fastlinedarken.avsi")



# ··· Funciones de filtrado ···

function antialias(clip e,int "AA"){

	AA = default(AA,10)

	rs_x = e.width
	rs_y = e.height

	e = e.lanczos4resize(rs_x*2,rs_y*2)
	e = e.turnleft
	e = e.sangnom(AA)
	e = e.turnright
	e = e.sangnom(AA)
	e = e.simpleresize(rs_x,rs_y)
	return e
}

function filt_SR2(clip e){
	rs_x = e.width
	rs_y = e.height
	
	e = e.vaguedenoiser(nsteps=8,chromaT=0,Wiener=true)
	e = e.antialias()
	e = e.unfilter(-10,-10)
	e = e.limitedsharpen(ss_x=1,ss_y=1,smode=4,strength=100,soft=40)
	e = e.fastlinedarken(thinning=0)
	e = e.undot()

	return e
}

function filt_SR2_OPED(clip e){
	e = e.unfilter(10,10)
	e = e.vaguedenoiser()
	return e
}

# ··· Delimitación ···

raw = directshowsource("db153.avs")

p1 = raw.trim(eOP+1,bED-1).filt_SR2()

OP = raw.trim(bOP,eOP).filt_SR2_OPED()
ED = raw.trim(bED,eED).filt_SR2_OPED()

# ··· [FINAL] ···

final = OP+p1+ED
return final
