VID_RAW_ORI = DirectShowSource("[rd2-RAWS]_InuYasha_147-148_DVD-RIP_[B0FB35E8].mp4",fps=23.976,convertfps=true,audio=false)

VID_RAW_OR1 = DirectShowSource("[rd2-RAWS]_InuYasha_146_DVD-RIP_[01068D89].mp4",fps=23.976,convertfps=true,audio=false)

VAR_VID_EPI = VID_RAW_ORI.Trim(0,67804)

VAR_VID_PRE = VID_RAW_OR1.Trim(34239,34955)

VAR_VID_TSU = VID_RAW_ORI.Trim(67812,67979)

VAR_VID_FIN = VAR_VID_EPI + VAR_VID_PRE + VAR_VID_TSU

VAR_VID_FIN

AUD1 = WavSource("INU_147_01.wav")

AUD2 = WavSource("INU_147_02.wav")

AUD3 = WavSource("INU_147_03.wav")

AUDF = AUD1 + AUD2 + AUD3

AudioDub(VAR_VID_FIN,AUDF)