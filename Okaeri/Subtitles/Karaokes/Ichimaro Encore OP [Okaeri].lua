-- Ichigo Mashimaro Encore Opening - Ichigo Splash
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "Encore Opening - Ichigo Splash"
script_description = "Ichigo Mashimaro Encore Opening for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.3"

local cores = { "&3F5CB4&","&902BF5&","&D6C570&","&198EFF&","&4EC474&","&A751CD&","&FFFFFF&" }
local esfera = "m 25 25 b 25 14 25 5 25 0 b 12 0 0 12 0 25 b 0 38 12 50 25 50 b 38 50 50 38 50 25 b 50 12 38 0 25 0 "
local leadin = 100
local leadout = 100
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
			if (l.styleref.name == "Roomanji") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl1(subs, meta, l)
				do_syl2(subs, meta, l)
				do_pesfera(subs, meta, l)
				--do_effect(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "Traducao") then
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
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center, line.middle
			local z = y + 20
			local count = syl.i % 6 + 1
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\3c%s\\bord4\\alpha&HFF&\\t(\\3a&H80&)}%s",x,z,x,y,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",x,z,x,y,cores[7], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",x,z,x,y,cores[count], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_bsyl(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
		
			local x, y = line.left+syl.center, line.middle
			local count = syl.i % 6 + 1
		
			l.end_time = l.start_time + syl.start_time
			l.start_time = l.start_time
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord4\\3a&H80&}%s",x,y,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s",x,y,cores[7],syl.text_stripped)
			l.layer = 2
			subs.append(l)

			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\c%s\\bord0}%s",x,y,cores[count], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_syl1(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			local x, y = line.left+syl.center, line.middle
			local yesfera = line.middle + 3
			local count = syl.i % 6 + 1
			l.end_time = l.start_time + syl.start_time + syl.duration/2
			l.start_time = l.start_time + syl.start_time
				
			if syl.i % 2 == 0 then
				
				local w, z = line.left+syl.center - 10, line.middle - 10
				local zesfera = yesfera - 10
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord1\\3c%s\\c%s\\p1}%s{\\p0}",x,yesfera,w,zesfera,cores[7],cores[count],esfera)
				l.layer = 0
				subs.append(l)
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\t(\\fax-0.1)}%s",x,y,w,z,cores[7],syl.text_stripped)
				l.layer = 3
				subs.append(l)
				
			else
			
				local w, z = line.left+syl.center - 10, line.middle + 10
				local zesfera = yesfera + 10
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord1\\3c%s\\c%s\\p1}%s{\\p0}",x,yesfera,w,zesfera,cores[7],cores[count],esfera)
				l.layer = 0
				subs.append(l)
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\t(\\fax0.1)}%s",x,y,w,z,cores[7],syl.text_stripped)
				l.layer = 3
				subs.append(l)
				
			end
			
		end
		
	end
	
end

function do_syl2(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center-20, line.middle
			local yesfera = line.middle + 3
			local count = syl.i % 6 + 1
			l.end_time = l.start_time + syl.end_time 
			l.start_time = l.start_time + syl.start_time + syl.duration/2
				
			if syl.i % 2 == 0 then
				
				local w, z = line.left+syl.center - 10, line.middle - 10
				local zesfera = yesfera - 10
						
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord1\\3c%s\\c%s\\p1}%s{\\p0}",w,zesfera,x,yesfera,cores[7],cores[count],esfera)
				l.layer = 0
				subs.append(l)
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\fax-0.1\\t(\\fax0)}%s",w,z,x,y,cores[7],syl.text_stripped)
				l.layer = 3
				subs.append(l)
				
			else
			
				local w, z = line.left+syl.center - 10, line.middle + 10
				local zesfera = yesfera + 10
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord1\\3c%s\\c%s\\p1}%s{\\p0}",w,zesfera,x,yesfera,cores[7],cores[count],esfera)
				l.layer = 0
				subs.append(l)
			
				l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\bord0\\c%s\\fax0.1\\t(\\fax0)}%s",w,z,x,y,cores[7],syl.text_stripped)
				l.layer = 3
				subs.append(l)
				
			end
			
		end
		
	end
	
end			

function do_pesfera(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
		
			local x, y = line.left+syl.center-20, line.middle
			local count = syl.i % 6 + 1
			local yesfera = line.middle + 3
			
			l.end_time = l.start_time + syl.end_time + leadout*2
			l.start_time = l.start_time + syl.end_time
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\bord1\\3c%s\\c%s\\t(\\fscx0\\fscy0)\\p1}%s{\\p0}",x,yesfera,cores[7],cores[count],esfera)
			l.layer = 0
			subs.append(l)

		end

	end

end

function do_psyl(subs,meta,line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
		
			local x, y = line.left+syl.center-20, line.middle
			local count = syl.i % 6 + 1
			
			l.start_time = l.start_time + syl.end_time
			l.end_time = l.end_time			
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord4\\3a&H80&}%s",x,y,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s",x,y,cores[7],syl.text_stripped)
			l.layer = 2
			subs.append(l)

			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\c%s\\bord0}%s",x,y,cores[count], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_pline(subs, meta, line)

	for i=1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center-20, line.middle
			local z = y - 20
			local count = syl.i % 6 + 1
			
			l.start_time = l.end_time
			l.end_time = l.end_time + leadout
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord4\\3a&H80&\\t(\\3a&HFF&)}%s",x,y,x,z,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2\\t(\\3a&HFF&)}%s",x,y,x,z,cores[7], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\c%s\\bord0\\t(\\alpha&HFF&)}%s",x,y,x,z,cores[count], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_blinha(subs, meta, line)

	for i=1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center, line.middle
			local z = y - 20
			local count = lcount % 6 + 1
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\3c%s\\bord5\\alpha&HFF&\\t(\\3a&H80&)}%s",x,z,x,y,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",x,z,x,y,cores[count], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\c%s\\3c%s\\bord0.5\\alpha&HFF&\\t(\\alpha&H00&)}%s",x,z,x,y,cores[7],cores[7], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_line(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
		
			local x, y = line.left+syl.center, line.middle
			local count = lcount % 6 + 1
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord5\\3a&H80&}%s",x,y,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3c%s\\bord2}%s",x,y,cores[count],syl.text_stripped)
			l.layer = 2
			subs.append(l)

			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\c%s\\3c%s\\bord0.5}%s",x,y,cores[7], cores[7], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

function do_plinha(subs, meta, line)
	
	for i=1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") then
			
			local x, y = line.left+syl.center, line.middle
			local z = y + 20
			local count = lcount % 6 + 1
			
			l.start_time = l.end_time
			l.end_time = l.end_time + leadout
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord5\\3a&H80&\\t(\\3a&HFF&)}%s",x,y,x,z,cores[count], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3c%s\\bord2\\t(\\3a&HFF&)}%s",x,y,x,z,cores[count], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\c%s\\3c%s\\bord0.5\\t(\\alpha&HFF&)}%s",x,y,x,z,cores[7], cores[7], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
		end
		
	end
	
end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)