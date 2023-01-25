-- Toradora Ending 01 - Vanilla Salt
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Toradora Ending 01 - Vanilla Salt"
script_description = "Toradora Ending 01 for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.1"

local leadin = 200
local leadout = 200
local cores = { "&HE9DBFF&","&H52317B&","&HFFFFFF&" }

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
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "TL") then
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
		local z = x + 10
		
		l.end_time = l.start_time
		l.start_time = l.start_time - leadin
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\alpha&HFF&\\frz-90\\t(\\3a&H00&\\frz0)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5\\alpha&HFF&\\frz-90\\t(\\3a&H00&\\frz0)}%s",z,y,x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\alpha&HFF&\\frz-90\\t(\\alpha&H00&\\frz0)}%s",z,y,x,y,cores[1], syl.text_stripped)
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
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5}%s",x,y,cores[3], syl.text_stripped)
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
		
		--l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5}%s",x,y,cores[2], syl.text_stripped)
		--l.layer = 0
		--subs.append(l)
		
		--l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5}%s",x,y,cores[3], syl.text_stripped)
		--l.layer = 1
		--subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0\\fscx107.5\\fscy125}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord1.5\\fscx107.5\\fscy125}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 3
		subs.append(l)
		
	end

end


function do_psyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.start_time = l.start_time + syl.end_time
		l.end_time = l.end_time
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_pline(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local z, y = line.left+syl.center, line.middle
		local x = z - 10
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\t(\\3a&HFF&\\frz90)}%s",z,y,x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5\\t(\\3a&HFF&\\frz90)}%s",z,y,x,y,cores[3], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\move(%.2f,%.2f,%.2f,%.2f)\\1c%s\\bord0\\t(\\alpha&HFF&\\frz90)}%s",z,y,x,y,cores[1], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

function do_blinha(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
				
		l.end_time = l.start_time 
		l.start_time = l.start_time - leadin 
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\alpha&HFF&\\t(\\3a&H00&)}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5\\alpha&HFF&\\t(\\3a&H00&)}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

function do_line(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end
	
end

function do_plinha(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.start_time = l.end_time 
		l.end_time = l.end_time + leadout
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2.5\\t(\\3a&HFF&)}%s",x,y,cores[2], syl.text_stripped)
		l.layer = 0
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1a&HFF&\\3a&H00&\\3c%s\\bord0.5\\t(\\3a&HFF&)}%s",x,y,cores[1], syl.text_stripped)
		l.layer = 1
		subs.append(l)
		
		l.text = string.format("{\\r\\an5\\pos(%.2f,%.2f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",x,y,cores[3], syl.text_stripped)
		l.layer = 2
		subs.append(l)
		
	end

end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)
