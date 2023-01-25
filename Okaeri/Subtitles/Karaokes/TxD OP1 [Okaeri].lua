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
--Cores: Ami, Taiga, Ryuuji, Minori, Karasu
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

do_bline(subs, meta, l)
do_bsyl(subs, meta, l)
do_syl(subs, meta, l)
do_psyl(subs, meta, l)
do_pline(subs, meta, l)