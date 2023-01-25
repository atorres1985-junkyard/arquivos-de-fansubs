-- Kodomo no Jikan OVA Opening
-- Script by demi_alucard for Okaeri Fansubs

include("karaskel.lua")

script_name = "Kodomo no Jikan OVA Opening"
script_description = "Kodomo no Jikan OVA Opening for Okaeri Fansubs"
script_author = "demi_alucard"
script_version = "1.0"

-- Properties
local leadIn = 300
local leadOut = 300

function do_karaoke(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs, true)

	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			if (l.styleref.name == "Romaji") or (l.styleref.name == "BackVocal") then
				do_effect(subs, meta, l)
				do_transition(subs, meta, l)
			end
			if (l.styleref.name == "Kanji") then
				do_effect(subs, meta, l, styles)
				do_transition(subs, meta, l)
			end
			if (l.styleref.name == "Translation") then
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

function do_transition(subs, meta, line)
	timeOut = 0
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		local mid = line.height/2

		if line.effect ~= "NoInFx" then
			l.end_time = line.start_time
			l.start_time = line.start_time - leadIn
			l.text = string.format("{\\an5\\fad(%d,0)\\1a&HFF&\\move(%d,%d,%d,%d)\\frx%d\\fry%d\\t(\\frx0\\fry0)}%s",
			leadIn,x-30+math.random(-10,10),y+math.random(-5,5), x, y, math.random(-45,45), math.random(-45,45), syl.text_stripped)
			l.layer = 0
			subs.append(l)

			l.text = string.format("{\\an5\\fad(%d,0)\\3a&HFF&\\move(%d,%d,%d,%d)\\frx%d\\fry%d\\t(\\frx0\\fry0)}%s",
			leadIn, x-30+math.random(-10,10),y+math.random(-5,5), x, y, math.random(-45,45), math.random(-45,45), syl.text_stripped)
			l.layer = 1
			subs.append(l)
		end

		if line.effect ~= "NoOutFx" then
			l.start_time = line.end_time
			l.end_time = line.end_time + leadOut
			timeIn = 0 + timeOut
			timeOut = (leadOut/#line.kara)*i

			
			for j = 0, line.height do
				if j <= mid then
					color = ass_color(255, math.abs(((255)/mid)*j), math.abs(((255)/mid)*j))
				else
					color = ass_color(255, math.abs(((-255)/mid)*(j-mid)+255), math.abs(((-255)/mid)*(j-mid)+255))
				end
				l.text = string.format("{\\an5\\bord0\\pos(%d,%d)\\t(%d,%d,\\alpha&HFF&)\\clip(0,%d,704,%d)\\1c%s\\fad(0,%d)}%s",
				x, y, timeIn, timeOut, line.top+j, line.top+j+1, color, leadOut, syl.text_stripped)
				l.layer = 0
				subs.append(l)
			end
		end
	end
end

function do_effect(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
--		if (syl.text_stripped ~= "") then
			local x, y = line.left+syl.center, line.middle
			local mid = line.height/2

			-- Halos
			for i = 1, #syl.highlights do
				hl = syl.highlights[i]
				local l = table.copy(line)
				l.end_time = l.end_time + 1000
				l.text = string.format("{\\an5\\1a&HFF&\\pos(%d,%d)\\t(%d,%d,1,\\fscx165\\fscy200\\3c&HFFFFFF&\\alpha&HFF&\\bord1)}%s",
					x, y, hl.start_time, hl.end_time+250, syl.text_stripped)
				aegisub.log(4, string.format("%s (%d,%d)\n", syl.text_stripped, x, y))
				l.layer = 0
				subs.append(l)
			end
			
			-- Gradients
			for j = 0, line.height do
				if j <= mid then
					color = ass_color(255, math.abs(((255)/mid)*j), math.abs(((255)/mid)*j))
				else
					color = ass_color(255, math.abs(((-255)/mid)*(j-mid)+255), math.abs(((-255)/mid)*(j-mid)+255))
				end
				l.text = string.format("{\\an5\\bord0\\pos(%d,%d)\\clip(0,%d,704,%d)\\1c%s}%s",
					x, y, line.top+j, line.top+j+1, color, syl.text_stripped)
				l.layer = 1
				subs.append(l)
			end

			-- Highlights
			l.text = string.format("{\\an5\\alpha&HFF&\\1c&HFFFFFF&\\bord0\\pos(%d,%d)\\t(%d,%d,\\1a&H96&)}%s",
				x, y, syl.start_time, syl.end_time, syl.text_stripped)
			l.layer = 3
			subs.append(l)
--		end
	end
end

function do_translation(subs, meta, line, style)
	local l = table.copy(line)
	
	-- Line
	l.text = string.format("%s", line.text_stripped)
	subs.append(l)
	
	-- Intro 
	l.start_time = line.start_time - leadIn
	l.end_time = line.start_time
	for j = 0, line.height do
		if (j % 2 == 0) then
			move = -30
		else
			move = 30
		end
		l.text = string.format("{\\an5\\clip(0,%d,704,%d)\\move(%d,%d,%d,%d)\\fad(%d,0)}%s",
		line.top+j, line.top+j+1, line.center + move, line.middle, line.center, line.middle, leadIn, line.text_stripped)
		subs.append(l)
	end	
	
	-- Final
	l.end_time = line.end_time + leadOut
	l.start_time = line.end_time
	for j = 0, line.height do
		if (j % 2 == 0) then
			move = -30
		else
			move = 30
		end
		l.text = string.format("{\\an5\\clip(0,%d,704,%d)\\move(%d,%d,%d,%d)\\fad(0,%d)}%s",
		line.top+j, line.top+j+1, line.center, line.middle, line.center - move, line.middle, leadOut, line.text_stripped)
		subs.append(l)
	end	
end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)
