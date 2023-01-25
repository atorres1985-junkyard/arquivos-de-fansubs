-- REC - "Cheer~Makka na kimochi~"
-- Script by demi_alucard for Okaeri Fansubs

include("karaskel.lua")

script_name = "Cheer~Makka na kimochi~"
script_description = "REC's opening karaoke for Okaeri Fansubs."
script_author = "demi_alucard"
script_version = "1.1"

-- Properties
local fadeInType  = { 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1 }
local fadeOutType = { 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1 }

function do_karaoke(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs, false)

	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		aegisub.log(4, string.format("Line: %d", i))
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			if l.styleref.name == "Romaji" then
				do_transition(subs, meta, l, true, 20)
				do_romaji(subs, meta, l)
				do_transition(subs, meta, l, false, 20)
			end
			if l.styleref.name == "Kanji" then
				do_transition(subs, meta, l, true, 640)
				do_kanji(subs, meta, l)
				do_transition(subs, meta, l, false, 640)
				-- do_furigana(subs, l)
			end
			if l.styleref.name == "Translation" then
				do_translation(subs, meta, l)
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

function do_translation(subs, meta, line)
		local l = table.copy(line)
		local x, y = line.left, 700
		
		l.text = string.format("{\\pos(%d,%d)}%s", x, y, l.text)
		subs.append(l)
		
		-- TRANSITIONS
		for j = 1, 5 do	
			-- Borderless
			if line.effect ~= "noInFx" then
				l = table.copy(line)
				l.layer = j + 5
				l.end_time = l.start_time
				l.start_time = l.start_time - 250
				l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0}%s", x - 30 - j*3, y,
					x, y, l.text_stripped)
				subs.append(l) 
			end

			if line.effect ~= "noOutFx" then
				l = table.copy(line)
				l.start_time = l.end_time
				l.end_time = l.end_time + 250
				l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1c&%s&}%s", x, y,
					x + 30 + j*3, y, line.styleref.color2, l.text)
				subs.append(l)
			end

			-- Bodyless
			if line.effect ~= "noInFx" then
				l = table.copy(line)
				l.layer = j
				l.end_time = l.start_time
				l.start_time = l.start_time - 250
				l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\bord2\\shad1}%s",
					x - 30 - j*3, y, x, y, l.text)
				subs.append(l)
			end
			
			if line.effect ~= "noOutFx" then
				l = table.copy(line)
				l.start_time = l.end_time
				l.end_time = l.end_time + 250
				l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\bord2\\shad1}%s",
					x, y, x + 30 + j*3, y, l.text)
				subs.append(l)	
			end
		end
end

function do_furigana(subs, line)
	for i = 1, #line.furi do
		local l = table.copy(line)
		local furi = l.furi[i]
		local x, y = l.left + furi.left, 590
		-- Blur
		for j = 1, 20 do
			l.layer = j
			l.text = string.format("{\\alpha&H%0x&\\bord0\\shad0\\be1\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\alpha&HFF&)}%s",
				220 + j, x+math.random(-5,5), y+math.random(-5,5), x, y, furi.start_time, furi.end_time, furi.start_time,
				furi.end_time, furi.text)
			l.style = furi.style.name
			subs.append(l)
		end
		-- Main bodyless
		l = table.copy(line)
		l.layer = 0
		l.text = string.format("{\\pos(%d,%d)\\bord3\\shad2\\1a&HFF&\\2a&HFF&\\t(%d,%d,\\3a&H00&)}%s",
			x, y, furi.start_time, furi.end_time, furi.text)
		l.style = furi.style.name
		subs.append(l)	
		
		-- Main borderlesss
		l = table.copy(line)
		l.layer = 1
		l.text = string.format("{\\pos(%d,%d)\\bord0\\shad0\\t(%d,%d,\\1c%s)}%s",
			x, y, furi.start_time, furi.end_time, line.styleref.color2, furi.text)
		l.style = furi.style.name
		subs.append(l)		
		
		-- Blast
		for j = 0, 5 do
			local l = table.copy(line)
			local scale = 100
			l.end_time = l.start_time+furi.end_time
			l.start_time = l.start_time+furi.start_time
			
			l.layer = j + 2
			l.text = string.format("{\\shad0\\bord2\\1a&HFF&\\3a&HC0&\\pos(%d,%d)\\t(\\fscx%d\\fscy%d)\\fad(0,500)}%s",
				x, y, 110 + 10*j, 110 + 10*j, furi.text)
			l.style = furi.style.name
			subs.append(l)
		end
		
		-- TRANSITIONS
		for j = 1, 5 do	
			-- Borderless
			l = table.copy(line)
			l.layer = j + 5
			l.end_time = l.start_time
			l.start_time = l.start_time - 250
			l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0}%s", x - 30 - j*3, y,
				x, y, furi.text)
			l.style = furi.style.name
			subs.append(l) 

			l = table.copy(line)
			l.start_time = l.end_time
			l.end_time = l.end_time + 250
			l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1c&%s&}%s", x, y,
				x + 30 + j*3, y, line.styleref.color2, furi.text)
			l.style = furi.style.name
			subs.append(l)

			-- Bodyless
			l = table.copy(line)
			l.layer = j
			l.end_time = l.start_time
			l.start_time = l.start_time - 250
			l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\bord2\\shad1}%s",
				x - 30 - j*3, y, x, y, furi.text)
			l.style = furi.style.name
			subs.append(l)	
			
			l = table.copy(line)
			l.start_time = l.end_time
			l.end_time = l.end_time + 250
			l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\bord2\\shad1}%s",
				x, y, x + 30 + j*3, y, furi.text)
			l.style = furi.style.name
			subs.append(l)	
		end
	end
end

function do_kanji(subs, meta, line)
	for i = 1, #line.kara do
		local syl = line.kara[i]
		local x, y = line.left + syl.left, 640
		
		local l = table.copy(line)
		-- Blur
		for j = 1, 20 do
			l.layer = j
			l.text = string.format("{\\alpha&H%0x&\\bord0\\shad0\\be1\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\alpha&HFF&)}%s",
				220 + j, x+math.random(-5,5), y+math.random(-5,5), x, y, syl.start_time, syl.end_time, syl.start_time,
				syl.end_time, syl.text_stripped)
			subs.append(l)
		end
		-- Main bodyless
		l = table.copy(line)
		l.layer = 0
		l.text = string.format("{\\pos(%d,%d)\\bord3\\shad2\\1a&HFF&\\2a&HFF&\\t(%d,%d,\\3a&H00&)}%s",
			x, y, syl.start_time, syl.end_time, syl.text_stripped)
		subs.append(l)	
		
		-- Main borderlesss
		l = table.copy(line)
		l.layer = 1
		l.text = string.format("{\\pos(%d,%d)\\bord0\\shad0\\t(%d,%d,\\1c%s)}%s",
			x, y, syl.start_time, syl.end_time, line.styleref.color2, syl.text_stripped)
		subs.append(l)		
		
		-- Blast
		for j = 0, 5 do
			local l = table.copy(line)
			local scale = 100
			l.end_time = l.start_time+syl.end_time
			l.start_time = l.start_time+syl.start_time
			
			l.layer = j + 2
			l.text = string.format("{\\shad0\\bord2\\1a&HFF&\\3a&HC0&\\pos(%d,%d)\\t(\\fscx%d\\fscy%d)\\fad(0,500)}%s",
				x, y, 110 + 10*j, 110 + 10*j, syl.text_stripped)
			subs.append(l)
		end
	end
end

function do_transition(subs, meta, line, entry, height)
	for i = 1, #line.kara do
		local syl = line.kara[i]
		local x, y = line.left + syl.left, height	-- \an1-7
		for j = 1, 5 do	
			-- Borderless
			local l = table.copy(line)
			l.layer = j + 5
			if entry == true and line.effect ~= "noInFx" then
				l.end_time = l.start_time
				l.start_time = l.start_time - 250
				l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0}%s", x - 30 - j*3, y,
					x, y, syl.text_stripped)
				subs.append(l) 
			end
			if entry == false and line.effect ~= "noOutFx" then
				l.start_time = l.end_time
				l.end_time = l.end_time + 250
				l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1c&%s&}%s", x, y,
					x + 30 + j*3, y, line.styleref.color2, syl.text_stripped)
				subs.append(l)
			end

			-- Bodyless
			l = table.copy(line)
			l.layer = j
			if entry == true  and line.effect ~= "noInFx" then
				l.end_time = l.start_time
				l.start_time = l.start_time - 250
				l.text = string.format("{\\fad(250,0)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&}%s",
					x - 30 - j*3, y, x, y, syl.text_stripped)
				subs.append(l)		
			end
			if entry == false and line.effect ~= "noOutFx" then
				l.start_time = l.end_time
				l.end_time = l.end_time + 250
				l.text = string.format("{\\fad(0,250)\\move(%d,%d,%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\bord3\\shad2}%s",
					x, y, x + 30 + j*3, y, syl.text_stripped)
				subs.append(l)		
			end
		end
	end
end

function do_romaji(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left + syl.left, 20	-- \an1-7
		-- Main bodyless
		l.layer = 0
		l.text = string.format("{\\pos(%d,%d)\\bord0\\shad0\\1a&HFF&\\2a&HFF&\\t(%d,%d,\\bord3\\shad2)}%s", x, y, syl.start_time,
			syl.end_time, syl.text_stripped)
		subs.append(l)		
		-- Blur
		for j = 1, 20 do
			l.layer = j
			l.text = string.format("{\\alpha&H%0x&\\bord0\\shad0\\be1\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\alpha&HFF&)}%s",
				220 + j, x+math.random(-5,5), y+math.random(-5,5), x, y, syl.start_time, syl.end_time, syl.start_time,
				syl.end_time, syl.text_stripped)
			subs.append(l)
		end
			
		-- Up and down effect
		for j = 1, 10 do
			local z = y
			-- Alternate
			if i % 2 == 0 then
				z = z - j*2 - 10
			else
				z = z + j*2 + 10
			end
			local s_time = syl.start_time
			local e_time = syl.end_time
			l.layer = 21+j
			l.text = string.format("{\\alpha&H28&\\t(%d,%d,\\alpha&HFF&)\\move(%d,%d,%d,%d,%d,%d)\\bord0\\shad0\\t(%d,%d,\\1c%s)}%s", s_time, e_time,
				x, y, x, z, s_time, e_time, syl.start_time, syl.end_time, line.styleref.color2, syl.text_stripped)
			subs.append(l)
		end
		
		-- Main borderlesss
		l.layer = 32
		l.text = string.format("{\\pos(%d,%d)\\bord0\\shad0\\t(%d,%d,\\1c%s)}%s",
			x, y, syl.start_time, syl.end_time, line.styleref.color2, syl.text_stripped)
		subs.append(l)
	end
end
aegisub.register_filter(script_name, script_description, 0, do_karaoke)
