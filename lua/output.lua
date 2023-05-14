-- Output
-- ┌──────────────────────────────────────────────────────────────┐
-- │                        2023 May 14                           │
-- ├────────┬────────┬────────┬────────┬────────┬────────┬────────┤
-- │ ☀️S Sun │ 🌕 Mon │ 🔥 Tue │ 🌊 Wed │ 🪵 Thu │ 🥇 Fri │ 🏖️ Sat │
-- ├────────┼────────┼────────┼────────┼────────┼────────┼────────┤
-- │   30   │    1   │    2   │    3   │    4   │    5   │    6   │
-- ├────────┼────────┼────────┼────────┼────────┼────────┼────────┤
-- │    7   │    8   │    9   │   10   │   11   │   12   │   13   │
-- ├────────┼────────┼────────┼────────┼────────┼────────┼────────┤
-- │ ✅(14) │   15   │   16   │   17   │   18   │   19   │   20   │
-- ├────────┼────────┼────────┼────────┼────────┼────────┼────────┤
-- │   21   │   22   │   23   │   24   │   25   │   26   │   27   │
-- ├────────┼────────┼────────┼────────┼────────┼────────┼────────┤
-- │   28   │   29   │   30   │   31   │   01   │   02   │   03   │
-- └────────┴────────┴────────┴────────┴────────┴────────┴────────┘

local M = {}

M.__Header = function(dayName, monthName, day, year)
	local outputL = string.format("%31s", (dayName .. " " .. monthName))
	local outputM = " "
	local outputR = string.format("%-30s", (day .. " " .. year))
	return "│" .. outputL .. outputM .. outputR .. "│\n"
end

M.createOutput = function()
	local date = require("date").getDate()

	local start = date.prevMonthLastDay - date.currentMonthfirstDayWday + 2
	local pos = { ["line"] = 1, ["col"] = 1 }

	local days = ""

	for i = start, date.prevMonthLastDay, 1 do
		days = days .. "│   " .. i .. "   "
		pos.col = pos.col + 1
	end

	for i = 1, date.currentMonthLastDay, 1 do
		local paddingL
		local paddingR
		local day = ""
		if i == date.day then
			day = "✅(" .. i .. ")"
			paddingL = (" "):rep((8 - string.len(day)) / 2 + (8 - string.len(day)) % 2)
			paddingR = (" "):rep((8 - string.len(day)) / 2 + 1)
		else
			day = "" .. i
			paddingL = (" "):rep((8 - string.len(day)) / 2 + (8 - string.len(day)) % 2)
			paddingR = (" "):rep((8 - string.len(day)) / 2)
		end

		days = days .. "│" .. paddingL .. day .. paddingR
		if pos.col == 7 then
			days = days
				.. "│\n"
				.. "├────────┼────────┼────────┼────────┼────────┼────────┼────────┤\n"
			pos.col = 1
			pos.line = pos.line + 1
		else
			pos.col = pos.col + 1
		end
	end

	local nextday = 1
	for i = pos.col, 7, 1 do
		days = days .. "│   " .. "0" .. nextday .. "   "
		nextday = nextday + 1
	end
	days = days .. "│\n"
	days = days
		.. "└────────┴────────┴────────┴────────┴────────┴────────┴────────┘"

	local output = (
		"┌──────────────────────────────────────────────────────────────┐\n"
		.. M.__Header(date.dayName, date.monthName, date.day, date.year)
		.. "├────────┬────────┬────────┬────────┬────────┬────────┬────────┤\n"
		.. "│ ☀️S Sun │ 🌕 Mon │ 🔥 Tue │ 🌊 Wed │ 🪵 Thu │ 🥇 Fri │ 🏖️ Sat │\n"
		.. "├────────┼────────┼────────┼────────┼────────┼────────┼────────┤\n"
		.. days
	)

	return output
end

return M
