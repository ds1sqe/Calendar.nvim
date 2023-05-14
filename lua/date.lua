local M = {}

M.__daysBefore = { [1] = 0, [2] = 31, [3] = 59, [4] = 90, [5] = 120,
  [6] = 181, [7] = 212, [8] = 243, [9] = 273, [10] = 304, [11] = 334 }

M.__daysOfMonth= {
  [1]=31,
  [2]=29,
  [3]=31,
  [4]=30,
  [5]=31,
  [6]=30,
  [7]=31,
  [8]=31,
  [9]=30,
  [10]=31,
  [11]=30,
  [12]=31,
}

M.__monthName= {
  [1] = "January",
  [2] = "February",
  [3] = "March",
  [4] = "April",
  [5] = "May",
  [6] = "June",
  [7] = "July",
  [8] = "August",
  [9] = "September",
  [10]= "October",
  [11]= "November",
  [12]= "December",
}
M.__getDate = function (time)
  -- if time provided, return date generated with argument 
  if (time) then
  return os.date('*t',time)
  else
  -- if time not provided, return date generated with current time
  return os.date('*t')
  end
end

M.__isLeapYear = function (year)
-- All years that are divisible by 4 are leap years,
-- unless they start a new century, provided they
-- are not divisible by 400.
return !(year%4) and (year % 100) or !(year % 400)
end


M.__getLastDay= function (year,month)
  if (month==0)then
    return M.__daysOfMonth[12]
  elseif (month==2)then
    if (M.__isLeapYear(year)) then
      return (M.__daysOfMonth[month]-1)
    else
      return M.__daysOfMonth[month]
    end
  else
    return M.__daysOfMonth[month]
  end
end

M.__getMonthName = function (month)
  return M.__monthName[month]
end

M.getDate = function ()
  -- return easy-to use date data
  local date = M.__getDate()

  local D = {
  ["prevMonthLastDay"]= M.__getLastDay(date.year, date.month-1),
  ["currentMonthLastDay"] = M.__getLastDay(date.year,date.month),
  ["currentMonthfirstDayWday"] = (date.wday-(date.day)%7+7+1)%7,
  ["year"]=date.year,
  ["month"]=date.month,
  ["day"]=date.day,
  ["wday"]=date.wday,
  ["monthName"]=M.__getMonthName(date.month),
  }
  return D
end

return M
