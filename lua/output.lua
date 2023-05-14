-- Output
-- ┌──────────────────────────────────────────────────────────────┐
-- │                           2023 May                           │
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

M.__yearMonth = function(year, monthName)
	local outputL = string.format("%30s", year)
	local outputM = "  "
	local outputR = string.format("%-30s", monthName)
	return "│" .. outputL .. outputM .. outputR .. "│\n"
end

M.createOutput = function()
	local date = require("date").getDate()

	local start = date.prevMonthLastDay - date.currentMonthfirstDayWday + 1
	local pos = { ["line"] = 1, ["col"] = 1 }

	local days = ""

	for i = start, date.prevMonthLastDay, 1 do
		days = days .. "│   " .. i .. "   "
		pos.col = pos.col + 1
	end

	for i = 1, date.currentMonthLastDay, 1 do
		local day = ""
		if i == date.day then
			day = "✅(" .. i .. ")"
		else
			day = "" .. i
		end
		local paddingL = (" "):rep((8 - string.len(day)) / 2 + (8 - string.len(day)) % 2)
		local paddingR = (" "):rep((8 - string.len(day)) / 2)

		days = days .. "│" .. paddingL .. day .. paddingR
		if pos.col == 7 then
			days = days
				.. "│\n"
				.. "├────────┼────────┼────────┼────────┼────────┼────────┼────────┤\n"
			pos.col = 1
			pos.line = pos.line + 1
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
		.. M.__yearMonth(date.year, date.monthName)
		.. "├────────┬────────┬────────┬────────┬────────┬────────┬────────┤\n"
		.. "│ ☀️S Sun │ 🌕 Mon │ 🔥 Tue │ 🌊 Wed │ 🪵 Thu │ 🥇 Fri │ 🏖️ Sat │\n"
		.. "├────────┼────────┼────────┼────────┼────────┼────────┼────────┤\n"
		.. days
	)

	return output
end

return M
