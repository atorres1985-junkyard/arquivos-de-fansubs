-- Toradora Opening 01 - Pre-Parade
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Toradora Opening 01 - Pre-Parade"
script_description = "Toradora Opening 01 for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.1"

local leadin = 150
local leadout = 150
local pcolor = { "&HD8D5FF&","&HD7B8FF&","&HBCD3FF&","&HFFF4C5&","&HBBE5F2&","&HE8FFB3&","&HFFFFFF&" }
local bcolor = { "&H1910BD&","&H42009A&","&H1A5CD3&","&HBC9800&","&H007D9C&","&H6A9800&" }
--Cores: Ami, Taiga, Ryuuji, Minori, Karasu, other
local sphere = "m 4 4 b 4 3 4 1 4 0 b 2 0 0 2 0 4 b 0 6 2 8 4 8 b 6 8 8 6 8 4 b 8 2 6 0 4 0 "
local lcount = 1

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
			if (l.styleref.name == "Primary") or (l.styleref.name == "Back Vocal") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "TL") or (l.styleref.name == "TL BV") then
				do_blinha(subs,meta,l)
				do_line(subs,meta,l)
				do_plinha(subs,meta,l)
			end
			lcount = lcount + 1
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
		local z = line.left+syl.center - 20
		local count = lcount % 5 + 1
				
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		if (l.styleref.name == "Primary") then
		
			pcor = pcolor[count]
			bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "Back Vocal") then
		
			pcor = pcolor[6]
			bcor = bcolor[6]
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,pcor, syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,pcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_bsyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local count = lcount % 5 + 1
		
		l.end_time = l.start_time + syl.start_time
		l.start_time = l.start_time
		
		if (l.styleref.name == "Primary") then
		
			pcor = pcolor[count]
			bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "Back Vocal") then
		
			pcor = pcolor[6]
			bcor = bcolor[6]
		
		end
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3}%s",x,y,pcor, syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\c%s\\bord0}%s",x,y,pcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

function do_syl(subs, meta, line) 

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center, line.middle
			local count = lcount % 5 + 1
		
			l.end_time = l.start_time + syl.end_time
			l.start_time = l.start_time + syl.start_time
		
			if (l.styleref.name == "Primary") then
		
				local pcor = pcolor[count]
				local bcor = bcolor[count]
		
			end	
		
			if (l.styleref.name == "Back Vocal") then
			
				local pcor = pcolor[6]
				local bcor = bcolor[6]
		
			end
		
			l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3\\t(\\bord6\\fscx132.5\\fscy150\\alpha&HFF&)}%s",x,y,pcor, syl.text_stripped)
			l.layer = 0
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,bcor, syl.text_stripped)
			l.layer = 1
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\c%s\\bord0\\t(\\c%s)}%s",x,y,pcolor[7],pcor,syl.text_stripped)
			l.layer = 2
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3c%s\\bord4\\fscx0\\fscy0\\t(0.7,\\fscx382.5\\fscy400)\\p1}%s{\\p0}",x,y,pcolor[syl.i%5+1],sphere)
			l.layer = 3
			subs.append(l)
			
		end
		
	end

end

function do_psyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
		local x, y = line.left+syl.center, line.middle
		local count = lcount % 5 + 1
		
		l.start_time = l.start_time + syl.end_time
		l.end_time = l.end_time
		
		if (l.styleref.name == "Primary") then
		
			local pcor = pcolor[count]
			local bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "Back Vocal") then
		
			local pcor = pcolor[6]
			local bcor = bcolor[6]
		
		end
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\t(0.5,\\be10)}%s",x,y,bcor,syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\c%s\\bord0}%s",x,y,pcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3c%s\\bord4\\fscx382.5\\fscy400\\t(0,150,\\fscx482.5\\fscy500\\alpha&HFF&)\\p1}%s{\\p0}",x,y,pcolor[syl.i%5+1],sphere)
		l.layer = 3
		subs.append(l)
		
		end
		
	end

end

function do_pline(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local z, y = line.left+syl.center, line.middle
		local x = line.left+syl.center + 20
		local count = lcount % 5 + 1
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		if (l.styleref.name == "Primary") then
		
			local pcor = pcolor[count]
			local bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "Back Vocal") then
		
			local pcor = pcolor[6]
			local bcor = bcolor[6]
		
		end
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\be10\\t(\\3a&HFF&)}%s",z,y,x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\c%s\\bord0\\t(\\alpha&HFF&)}%s",z,y,x,y,pcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

function do_blinha(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local z = line.left+syl.center - 20
		local count = lcount % 5 + 1
		local tcor = pcolor[7]
				
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		if (l.styleref.name == "TL") then
		
			pcor = pcolor[count]
			bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "TL BV") then
		
			pcor = pcolor[6]
			bcor = bcolor[6]
		
		end
		
		--l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,pcor, syl.text_stripped)
		--l.layer = 0
		--subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\be10\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,tcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_line(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local count = lcount % 5 + 1
		local tcor = pcolor[7]
		
		if (l.styleref.name == "TL") then
		
			pcor = pcolor[count]
			bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "TL BV") then
		
			pcor = pcolor[6]
			bcor = bcolor[6]
		
		end
		
		--l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3}%s",x,y,pcor, syl.text_stripped)
		--l.layer = 0
		--subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\be10}%s",x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\c%s\\bord0}%s",x,y,tcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

function do_plinha(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local z, y = line.left+syl.center, line.middle
		local x = line.left+syl.center - 20
		local count = lcount % 5 + 1
		local tcor = pcolor[7]
				
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		if (l.styleref.name == "TL") then
		
			pcor = pcolor[count]
			bcor = bcolor[count]
		
		end
		
		if (l.styleref.name == "TL BV") then
		
			pcor = pcolor[6]
			bcor = bcolor[6]
		
		end
		
		--l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord3\\t(\\3a&HFF&)}%s",z,y,x,y,pcor, syl.text_stripped)
		--l.layer = 0
		--subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\be10\\t(\\3a&HFF&)}%s",z,y,x,y,bcor, syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\c%s\\bord0\\t(\\alpha&HFF&)}%s",z,y,x,y,tcor, syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)