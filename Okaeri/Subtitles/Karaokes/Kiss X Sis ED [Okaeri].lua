-- Kiss x Sis Ending - Hoshizora Monogatari
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Kiss x Sis Ending - Hoshizora Monogatari"
script_description = "Kiss x Sis Ending for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.2"

local leadin = 200
local leadout = 200
local cores = { "&HFDF6DA&", "&HFFFFFF&", "&HFD6F34&" }
local tcores = { "&H6BEEB2&", "&HFFFFFF&", "&H4CA223&" }

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
			if (l.actor == "Roomanji") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.actor == "BV") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_shine(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.actor == "Traducao") or (l.actor == "TL BV") then
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

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		if (l.actor == "Roomanji") then
		
			z = z - 10
		
		else
		
			z = z + 10
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\alpha&HFF&\\t\\(\\3a&HA0&)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\alpha&HFF&\\t\\(\\3a&H00&)}%s",z,y,x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\alpha&HFF&\\t\\(\\alpha&H00&)}%s",z,y,x,y,cores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_bsyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
				
		l.end_time = l.start_time + syl.start_time
		l.start_time = l.start_time		
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_syl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.end_time = l.start_time + syl.end_time
		l.start_time = l.start_time + syl.start_time
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0\\t(\\1c%s)}%s",x,y,cores[1],cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0\\t(\\fscx150\\fscy150\\blur4)\\t(%d,%d,1.5,\\alpha&HFF&)}%s",x,y,cores[1],syl.duration/2,syl.duration,syl.text_stripped)
		l.layer = 3
		subs.append(l)
		
	end
	
end

function do_shine(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.end_time = l.start_time + syl.end_time
		l.start_time = l.start_time + syl.start_time
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur1\\t(\\fscx165\\fscy130)\\t(%d,%d,1.5,\\3a&HFF&)}%s",x,y,cores[1],syl.duration/2,syl.duration, syl.text_stripped)
		l.layer = 3
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HA0&\\1c%s\\bord0\\blur1\\t(\\fscx165\\fscy130)\\t(%d,%d,1.5,\\alpha&HFF&)}%s",x,y,cores[1],syl.duration/2,syl.duration, syl.text_stripped)
		l.layer = 3
		subs.append(l)
		
	end
	
end

function do_psyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle

		l.start_time = l.start_time	+ syl.end_time
		l.end_time = l.end_time
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_pline(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local z, y = line.left+syl.center, line.middle
		local x = line.left+syl.center
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		if (l.actor == "Roomanji") then
		
			x = x + 10
		
		else
		
			x = x - 10
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\t(\\3a&HFF&)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\t(\\3a&HFF&)}%s",z,y,x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_blinha(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		if (l.actor == "Roomanji") then
		
			z = z - 10
		
		else
		
			z = z + 10
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur1\\alpha&HFF&\\t\\(\\3a&HA0&)}%s",z,y,x,y,tcores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\alpha&HFF&\\t\\(\\3a&H00&)}%s",z,y,x,y,tcores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\alpha&HFF&\\t\\(\\alpha&H00&)}%s",z,y,x,y,tcores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_line(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur1}%s",x,y,tcores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5}%s",x,y,tcores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,tcores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_plinha(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local z, y = line.left+syl.center, line.middle
		local x = line.left+syl.center
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		if (l.actor == "Roomanji") then
		
			x = x + 10
		
		else
		
			x = x - 10
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur1\\t(\\3a&HFF&)}%s",z,y,x,y,tcores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\t(\\3a&HFF&)}%s",z,y,x,y,tcores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",z,y,x,y,tcores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)