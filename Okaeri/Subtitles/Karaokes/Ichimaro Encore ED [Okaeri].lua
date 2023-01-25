-- Ichigo Mashimaro Encore Ending - Zutto, Zutto
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Encore Ending - Zutto, Zutto"
script_description = "Ichigo Mashimaro Encore Ending for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.4"

local leadin = 200
local leadout = 200
local cores = { "&HC4D8E7&", "&HA1AAB6&", "&HFFFFFF&" }
--local dot = "m 0 0 l 0 1 l 1 1 l 1 0 "

function do_karaoke(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs,true)
	
	aegisub.progress.task("Appling Effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			if (l.styleref.name == "Roomanji") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_effect(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "Traducao") then
				do_blinha(subs,meta,l)
				do_line(subs,meta,l)
				do_plinha(subs,meta,l)
			end
			maxi = maxi - 1
			subs.delete(i)
		else
		i = i + 1
		end
		ai = ai + 1
	end
	aegisub.progress.task("Finished!")
	aegisub.progress.set(100)
end

function do_bline(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center+10
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[1],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord1\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[3],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,cores[1],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_bsyl(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.start_time = l.start_time
		l.end_time = l.start_time + syl.start_time
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s",x,y,cores[1],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord1}%s",x,y,cores[3],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0}%s",x,y,cores[1],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_syl(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local alt = syl.height
		local lar = syl.width
				
		l.end_time = l.start_time + syl.end_time
		l.start_time = l.start_time + syl.start_time 
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2\\t(\\3c%s)}%s",x,y,cores[1],cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord1}%s",x,y,cores[3],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0\\t(\\1c%s)}%s",x,y,cores[1],cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--for i = 0, 10 do
		
					
			--local w = line.left+syl.left
			--local z = line.top
		
			--for j = 0, lar do
			
			--l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\frz1800\\clip(%f,%f,%f,%f)}%s", w+i, z+j, w-math.random(10,30), z+20, cores[math.random(1,4)], line.left+syl.left+j, line.top+i, line.left+syl.left+j+10, line.top+i, syl.text_stripped)
			--l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\t(\\)\\p1}%s{\\p0}", w+i, z+j, w+i-math.random(10,30), z+j+20, cores[1], dot)		
					
		--end
	end
end

function do_effect(subs, meta, line)
	
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local alt = syl.height/2
	
		l.end_time = l.start_time + syl.end_time + 200
		l.start_time = l.start_time + syl.start_time
		
		--l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord0.5\\t(0.5,\\bord2\\blur4\\fscx%d\\fscy%d\\3a&HFF&)}%s", x, y, x, y+alt, cores[1], 110, 110, syl.text_stripped)
		--l.layer = 3
		--subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\t(0.5,\\blur4\\fscx%d\\fscy%d\\3a&HFF&)}%s", x, y, x, y+alt, cores[1], 110, 110, syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end
end

function do_psyl(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.start_time = l.start_time + syl.end_time
		l.end_time = l.end_time
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s",x,y,cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord1}%s",x,y,cores[3],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0}%s",x,y,cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_pline(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center-10
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\t(\\3a&HFF&)}%s",x,y,z,y,cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1\\t(\\3a&HFF&)}%s",x,y,z,y,cores[3],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",x,y,z,y,cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_blinha(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center+10
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord3\\alpha&HFF&\\t(\\3a&HA0&)}%s",z,y,x,y,cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord1\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[2],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\3c%s\\bord0.5\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,cores[3],cores[3],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_line(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord3}%s",x,y,cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord1.5}%s",x,y,cores[2],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\3c%s\\bord0.5}%s",x,y,cores[3],cores[3],syl.text_stripped)
		l.layer = 2
		subs.append(l)
	end

end

function do_plinha(subs, meta, line)

	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center-10
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord3\\t(\\3a&HFF&)}%s",x,y,z,y,cores[2],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\t(\\3a&HFF&)}%s",x,y,z,y,cores[2],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\3c%s\\bord0.5\\t(\\alpha&HFF&)}%s",x,y,z,y,cores[3],cores[3],syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)