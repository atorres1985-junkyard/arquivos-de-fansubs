-- Kiss x Sis Opening - Futari no Honey Boy
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Kiss x Sis Opening -  Futari no Honey Boy"
script_description = "Kiss x Sis Opening for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.51"

local leadin = 200
local leadout = 200
local cores = { "&HD783F3&", "&HFFFFFF&", "&H4F47E5&", "&H706AE9&", "&H6A3011&", "&H000000&" }
local haato = "m 36 13 b 32 -14 0 -1 0 24 b 0 42 18 61 36 73 b 55 61 72 42 72 24 b 72 -1 41 -14 36 13 "

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
			if (l.styleref.name == "Roomanji") or (l.styleref.name == "BackVocal") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "Traducao") or (l.styleref.name == "Traducao BV") then
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
		local z = y
				
		if syl.i % 2 == 0 then
			z = z + 2.5
		else
			z = z - 2.5
		end
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		l.text = string.format("{\\r\\an5\\1a&HFF&\\3c%s\\bord4\\frx-180\\move(%f,%f,%f,%f)\\alpha&HFF&\\t(\\3a&H40&\\frx0)}%s", cores[1], x, z, x, y, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\1a&HFF&\\3c%s\\bord2\\frx-180\\move(%f,%f,%f,%f)\\alpha&HFF&\\t(\\3a&H00&\\frx0)}%s", cores[2], x, z, x, y, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\c%s\\bord0\\frx-180\\move(%f,%f,%f,%f)\\alpha&HFF&\\t(\\alpha&H00&\\frx0)}%s", cores[1], x, z, x, y, syl.text_stripped)
		l.layer = 3
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
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H40&\\3c%s\\bord4}%s", x, y, cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s", x, y, cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\c%s\\bord0}%s", x, y, cores[1],syl.text_stripped)
		l.layer = 3
		subs.append(l)
	
	end
end

function do_syl(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local w, z = x, y
		local alt = line.height
		
		l.end_time = l.start_time + syl.end_time
		l.start_time = l.start_time + syl.start_time
		
		if syl.i % 2 == 0 then
			w = w - 10
			z = z + 1
		else
			w = w - 10
			z = z - 1
		end
		
		for k = 1, 10 do
			local xgrow, ygrow = 100, 100 
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2\\t(1.3,\\blur3\\fscx%f\\fscy%f\\3a&HFF&)\\p2}%s{\\p0}", x, y+5, x-k, z+5, cores[1], xgrow+3*k, ygrow+3*k, haato)
			l.layer = 0
			subs.append(l)
		end
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H40&\\3c%s\\bord4\\t(\\3c%s)}%s", x, y, w, z, cores[1], cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2}%s", x, y, w, z, cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord0.5}%s", x, y, w, z, cores[2], syl.text_stripped)
		--l.layer = 3
		--subs.append(l)
		
		for j = 0, alt do
			color = ass_color(0,(math.abs((255/alt)*j)), 255)
			l.text = string.format("{\\r\\an5\\1c%s\\clip(0,%d,704,%d)\\t(\\c%s\\clip(0,%f,704,%f))\\move(%f,%f,%f,%f)}%s", cores[1], line.top, line.bottom, color, line.top+j, line.top+j+1, x, y, w, z, syl.text_stripped)
			l.layer = 4
			subs.append(l)
		end
	end
end

function do_psyl(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local w, z = x, y
		local alt = line.height
		
		l.start_time = l.start_time + syl.end_time
		l.end_time = l.end_time
		
		if syl.i % 2 == 0 then
			w = w - 10
			z = z + 1
		else
			w = w - 10
			z = z - 1
		end
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H40&\\3c%s\\bord4}%s", w, z, cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s", w, z, cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord0.5}%s", w, z, cores[2], syl.text_stripped)
		--l.layer = 3
		--subs.append(l)
		
		for j = 0, alt do
			color = ass_color(0,(math.abs((255/alt)*j)), 255)
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\bord0\\clip(0,%f,704,%f)\\c%s)}%s", w, z, line.top+j, line.top+j+1, color, syl.text_stripped)
			l.layer = 4
			subs.append(l)
		end
	end
end

function do_pline(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local w, z = x, y
		local alt = line.height
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		if syl.i % 2 == 0 then
			w = w - 10
			z = z + 1
		else
			w = w - 10
			z = z - 1
		end
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H40&\\3c%s\\bord4\\t(\\3a&HFF&)}%s", w, z, w, y, cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2\\t(\\3a&HFF&)}%s", w, z, w, y, cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		for j = 0, alt do
			color = ass_color(0,(math.abs((255/alt)*j)), 255)
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\clip(0,%f,704,%f)\\c%s\\t(\\alpha&HFF&))}%s", w, z, w, y, line.top+j, line.top+j+1, color, syl.text_stripped)
			l.layer = 4
			subs.append(l)
		end
	end
end

function do_blinha(subs, meta, line)

	for i = 1, #line.kara do
		
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center - 5
		local alt = syl.height
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord5\\blur3\\alpha&HFF&\\t(\\3a&HA0&)}%s",z,y,x,y,cores[5],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[5],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\bord0\\1c%s\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--for j = 0, alt do
			
			--color = ass_color((math.abs(((-255)/alt)*(j-alt))), 255, 255)
			--l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\bord0\\clip(0,%.2f,704,%.2f)\\1c%s\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,line.top+j,line.top+j+1, color, syl.text_stripped)
			--l.layer = 2
			--subs.append(l)
			
		--end
		
	end
	
end

function do_line(subs,meta,line)

	for i = 1, #line.kara do
		
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local alt = line.height
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord5\\blur3}%s",x,y,cores[5],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5}%s",x,y,cores[5],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\c%s\\bord0}%s",x,y,cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--for j = 0, alt do
			
			--color = ass_color((math.abs(((-255)/alt)*(j-alt))), 255, 255)
			--l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\bord0\\clip(0,%.2f,704,%.2f)\\1c%s}%s",x,y,line.top+j,line.top+j+1, color, syl.text_stripped)
			--l.layer = 2
			--subs.append(l)
			
		--end
		
	end

end

function do_plinha(subs,meta,line)

	for i = 1, #line.kara do
		
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center + 5, line.middle
		local z = line.left+syl.center
		local alt = syl.height
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord5\\blur3\\t(\\3a&HFF&)}%s",z,y,x,y,cores[5],syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\t(\\3a&HFF&)}%s",z,y,x,y,cores[5],syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\c%s\\bord0\\t(\\alpha&HFF&)}%s",z,y,x,y,cores[2],syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		--for j = 0, alt do
			
			--color = ass_color((math.abs(((-255)/alt)*(j-alt))), 255, 255)
			--l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\bord0\\clip(0,%.2f,704,%.2f)\\1c%s\\t(\\alpha&HFF&)}%s",z,y,x,y,line.top+j, line.top+j+1, color, syl.text_stripped)
			--l.layer = 2
			--subs.append(l)
			
		--end
		
	end

end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)