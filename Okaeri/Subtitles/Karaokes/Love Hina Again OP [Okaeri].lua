include("karaskel.lua")

script_name = "Love Hina Again OP"
script_description = "Love Hina Again opening karaoke for Okaeri Fansubs"
script_author = "demi_alucard"
script_version = "1.0"

function do_karaoke(subs)
	aegisub.progress.task("Getting header data...")
	local meta, styles = karaskel.collect_head(subs)

	aegisub.progress.task("Applying effect...")
	local i, ai, maxi, maxai = 1, 1, #subs, #subs
	while i <= maxi do
		aegisub.progress.task(string.format("Applying effect (%d/%d)...", ai, maxai))
		aegisub.progress.set((ai-1)/maxai*100)
		local l = subs[i]
		if l.class == "dialogue" and not l.comment then
			karaskel.preproc_line(subs, meta, styles, l)
			if l.styleref.name == "Romaji" then
				do_romaji(subs, meta, l)
			end
			if l.styleref.name == "Kanji" then
			end
			if l.styleref.name == "Translation" then
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

function do_romaji(subs, meta, line)
	for i = 1, #line.kara do
		local l = table.copy(line)
		local syl = line.kara[i]
		local x, y = line.left+syl.center, line.middle
		-- Explosions
		l.text = string.format("{\\an5\\pos(%d,%d)\\be1\\2c%s\\t(%d,%d,0.5,\\1c%s\\alpha&HFF&\\fscx150\\fscy123.75)}%s",
			x, y, line.styleref.color2, syl.start_time, syl.end_time, line.styleref.color1, syl.text_stripped)
		l.layer = #line.kara - i + 3
		subs.append(l)
		-- Body
		l.text = string.format("{\\an5\\pos(%d,%d)\\shad0\\bord0\\2c%s\\t(%d,%d,\\1c%s\\fscx112.5\\fscy92.8125)}%s",
			x, y, line.styleref.color1, syl.start_time, syl.start_time+syl.duration/2, line.styleref.color2,
			syl.text_stripped)
		l.layer = 2
		subs.append(l)
		-- Border
		l.text = string.format("{\\an5\\pos(%d,%d)\\1a&HFF&\\2a&HFF&\\2c%s\\t(%d,%d,\\1c%s\\fscx112.5\\fscy92.8125)}%s",
			x, y, line.styleref.color1, syl.start_time, syl.start_time+syl.duration/2, line.styleref.color2,
			syl.text_stripped)
		l.layer = 1
		subs.append(l)
		-- Leaf
		for j = 1, 32 do
			l.text = string.format("{\\an5\\be1\\1a&HFF&\\t(%d,%d,\\1a&H00&)\\move(%d,%d,%d,%d,%d,%d)\\t(%d,%d,\\alpha&HFF&)\\3a&HFF&\\4a&HFF&\\1c%s}%s",
				syl.start_time, syl.start_time*1.1,
				x+math.random(-10,10), y+math.random(-15,15), x+math.random(-50,50)+math.sin(j), y+math.random(-45.25,45.25), syl.start_time, syl.end_time,
				syl.start_time, syl.start_time+syl.duration/1.5,
				"\\1c&HFFFFFF&", "{\\p1}m 0 0 l 2 0 2 2 0 2{\\p0}")
			l.layer = 0
			l.end_time = line.end_time  + 10000
			subs.append(l)
		end
		
	end
end

aegisub.register_filter(script_name, script_description, 0, do_karaoke)
