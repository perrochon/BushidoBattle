-- Macro below (uncommented) removes all print statements
--print @ |--|

-- uncomment inside the macro if level not desired, e.g. |--print|
-- TODO use inspection to automatically include code location

DEBUG @ |print| -- Various manually added DEBUG statements
INFO @ |print|  -- Print all message box messages to console
ERROR @ |--print|

DEBUG("DEBUG output turned on")
INFO("INFO output turned on")
ERROR("ERROR output turned on")

-- Benchmarking
time_ @ |local _time_ = os.timer()|
_time @ |print("TIME:", os.timer() - _time_)|

--[[ Usage:
local x = 0
time_ for i = 1, 1e8 do x = x + i end _time
]]

function boolToString(value)
 return value == true and "true" or value == false and "false"
end