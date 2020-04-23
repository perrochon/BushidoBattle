-- Macro below (uncommented) removes all print statements
--print @ |--|

-- uncomment inside the macro if level not desired, e.g. |--print|
-- TODO use inspection to automatically include code location

-- 1 = DEBUG, 2 = INFO, 3 = ERROR
OUTPUT_LEVEL @ 1

function DEBUG(...)
	if OUTPUT_LEVEL > 0 then
		local debuginfo = debug.getinfo(2)
		local short_src = debuginfo.short_src and debuginfo.short_src or "unknown"
		local currentline = debuginfo.currentline and debuginfo.currentline or -1
		local name = debuginfo.name and debuginfo.name or "unknown"
		print(("%s:%d: %s"):format(short_src, currentline, name), unpack(arg)) 
	end
end

-- for all debugging related to connected play
function DEBUG_C(...)
	local ip = "no serverlink"
	local host ="no host"
	if serverlink then
		ip = serverlink.ip
		host = serverlink.host
	else
		DEBUG("serverlink is nil in DEBUG_C")
	end

	if OUTPUT_LEVEL > 0 then
		local debuginfo = debug.getinfo(2)
		local short_src = debuginfo.short_src and debuginfo.short_src or "unknown"
		local currentline = debuginfo.currentline and debuginfo.currentline or -1
		local name = debuginfo.name and debuginfo.name or "unknown"
		print(("%s:%d: %s"):format(short_src, currentline, name), ip, host, unpack(arg)) 
	end
end

-- DEBUG @ |printLineNumber| -- Various manually added DEBUG statements
INFO @ |print|  -- Print all message box messages to console
ERROR @ |print|

--DEBUG("DEBUG output turned on" )
--INFO("INFO output turned on")
--ERROR("ERROR output turned on")

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