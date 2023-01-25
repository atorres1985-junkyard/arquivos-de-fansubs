-- AIKa Ending - More Natural
-- Script by K3nsh1n for #Okaeri Fansubs
-- © #Okaeri - All Rights to H|aruhi

include("karaskel.lua")

script_name = "AIKa Ending - More Natural"
script_description = "AIKa Ending for #Okaeri Fansubs"
script_author = "K3nsh1n_H1mur4"
script_version = "0.2"

local leadin = 200
local leadout = 200
local cores = { "&HFFFFFF&", "&H000000&", "&H84EAFF&" }

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
			if (l.styleref.name == "Part A") or (l.styleref.name == "Part B") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "A NoIn") or (l.styleref.name == "B NoIn") then
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
				do_pline(subs, meta, l)
			end
			if (l.styleref.name == "A NoOut") or (l.styleref.name == "B NoOut") then
				do_bline(subs, meta, l)
				do_bsyl(subs, meta, l)
				do_syl(subs, meta, l)
				do_psyl(subs, meta, l)
			end
			if (l.styleref.name == "Part A TL") or (l.styleref.name == "Part B TL") then
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
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part A") or (l.styleref.name == "A NoOut") then
		
			local x, y = line.left+syl.center, line.middle
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\blur3\\fscx150\\alpha&HFF&\\t(\\3a&H00&\\blur0\\fscx100)}%s",x+20,y,x,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\blur3\\fscx150\\alpha&HFF&\\t(\\alpha&H00&\\blur0\\fscx100)}%s",x+20,y,x,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part B") or (l.styleref.name == "B NoOut") then
			local x, y = line.left+syl.center, line.middle
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\blur3\\fscx150\\alpha&HFF&\\t(\\3a&H00&\\blur0\\fscx100)}%s",x-20,y,x,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\blur3\\fscx150\\alpha&HFF&\\t(\\alpha&H00&\\blur0\\fscx100)}%s",x-20,y,x,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
				
	end

end

function do_bsyl(subs, meta, line)
	
	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
			
		if (syl.text_stripped ~= " ") then
		
			l.end_time = l.start_time + syl.start_time
			l.start_time = l.start_time
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0}%s",x,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
	
	end
	
end

function do_syl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.end_time = l.start_time + syl.end_time
		l.start_time = l.start_time + syl.start_time
		
		if (syl.text_stripped ~= " ") then
	
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord10\\blur3\\t(\\bord0)}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
		
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)

			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0\\t(\\1c%s)}%s",x,y,cores[1],cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&HB0&\\3c%s\\bord4\\blur2\\t(\\fscx165\\fscy130\\3a&HFF&)}%s",x,y,cores[3], syl.text_stripped)
			l.layer = 3
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HB0&\\1c%s\\bord0\\blur2\\t(\\fscx165\\fscy130\\alpha&HFF&)}%s",x,y,cores[3], syl.text_stripped)
			l.layer = 3
			subs.append(l)
		
		end
	
	end

end

function do_psyl(subs, meta, line)

	for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		
		l.start_time = l.start_time + syl.end_time
		l.end_time = l.end_time
		
		if (syl.text_stripped ~= " ") then
	
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)

			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0}%s",x,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
		
		end
		
	end

end

function do_pline(subs, meta, line)

		for i=1, #line.kara do
	
		local l = table.copy(line)
		local syl = line.kara[i]
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part A") or (l.styleref.name == "A NoIn") then
		
			local x, y = line.left+syl.center, line.middle
			
			l.start_time = l.end_time
			l.end_time = l.end_time + leadout
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\3a&H00&\\blur0\\t(\\blur3\\fscx150\\3a&HFF&)}%s",x,y,x-20,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\alpha&H00&\\blur0\\t(\\blur3\\fscx150\\alpha&HFF&)}%s",x,y,x-20,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part B") or (l.styleref.name == "B NoIn") then
			local x, y = line.left+syl.center, line.middle
			
			l.start_time = l.end_time
			l.end_time = l.end_time + leadout
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\3a&H00&\\blur0\\t(\\blur3\\fscx150\\3a&HFF&)}%s",x,y,x+20,y,cores[1], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\alpha&H00&\\blur0\\t(\\blur3\\fscx150\\alpha&HFF&)}%s",x,y,x+20,y,cores[2], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
				
	end

end

function do_blinha(subs,meta,line)

	for i=1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part A TL") then
			
			local x, y = line.left+syl.center, line.middle
			local z = line.left+syl.center+20
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur4\\alpha&HFF&\\t(\\3a&HA0&)}%s",z,y,x,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[2], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,cores[1], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part B TL") then
			
			local x, y = line.left+syl.center, line.middle
			local z = line.left+syl.center-20
			
			l.end_time = l.start_time
			l.start_time = l.start_time - leadin
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur4\\alpha&HFF&\\t(\\3a&HA0&)}%s",z,y,x,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\alpha&HFF&\\t(\\3a&H00&)}%s",z,y,x,y,cores[2], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\alpha&HFF&\\t(\\alpha&H00&)}%s",z,y,x,y,cores[1], syl.text_stripped)
			l.layer = 2
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
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur4}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2}%s",x,y,cores[2], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\pos(%f,%f)\\1c%s\\bord0}%s",x,y,cores[1], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		
	end

end

function do_plinha(subs,meta,line)

	for i=1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		
		l.start_time = l.end_time
		l.end_time = l.end_time + leadout		
		
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part A TL") then
			
			local x, y = line.left+syl.center, line.middle
			local z = line.left+syl.center-20
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur4\\t(\\3a&HFF&)}%s",x,y,z,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\t(\\3a&HFF&)}%s",x,y,z,y,cores[2], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",x,y,z,y,cores[1], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		
		if (syl.text_stripped ~= " ") and (l.styleref.name == "Part B TL") then
			
			local x, y = line.left+syl.center, line.middle
			local z = line.left+syl.center+20
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&HA0&\\3c%s\\bord4\\blur4\\t(\\3a&HFF&)}%s",x,y,z,y,cores[1], syl.text_stripped)
			l.layer = 0
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1a&HFF&\\3a&H00&\\3c%s\\bord2\\t(\\3a&HFF&)}%s",x,y,z,y,cores[2], syl.text_stripped)
			l.layer = 1
			subs.append(l)
			
			l.text = string.format("{\\r\\an5\\move(%f,%f,%f,%f)\\1c%s\\bord0\\t(\\alpha&HFF&)}%s",x,y,z,y,cores[1], syl.text_stripped)
			l.layer = 2
			subs.append(l)
			
		end
		
	end

end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)