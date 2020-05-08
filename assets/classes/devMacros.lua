-- Macro below (uncommented) removes all print statements
--print @ |--|

function debugInfo()
	local debuginfo = debug.getinfo(3)
	local short_src = debuginfo.short_src and debuginfo.short_src or "unknown"
	local currentline = debuginfo.currentline and debuginfo.currentline or -1
	local name = debuginfo.name and debuginfo.name or "unknown"
	return ("%s:%d: %s"):format(short_src, currentline, name)
end

LEVEL_DEBUG @ 3
LEVEL_INFO @ 2
LEVEL_ERROR @ 1
LEVEL_NONE @ 0

OUTPUT_LEVEL @ LEVEL_DEBUG

function DEBUG(...)
	if OUTPUT_LEVEL >= LEVEL_DEBUG then
		print(debugInfo(), "DEBUG", unpack(arg)) 
	end
end

function INFO(...)
	if OUTPUT_LEVEL >= LEVEL_INFO then
		print(debugInfo(), "INFO", unpack(arg)) 
	end
end

function ERROR(...)
	if OUTPUT_LEVEL >= LEVEL_ERROR then
		print(debugInfo(), "ERROR", unpack(arg)) 
	end
end

--DEBUG("output turned on" )
--INFO("output turned on")
--ERROR("output turned on")

-- for all debugging related to connected play
REMOTE_DEBUG @ true
function DEBUG_C(...)
	if OUTPUT_LEVEL >= LEVEL_DEBUG and REMOTE_DEBUG then
		local ip = serverlink and serverlink.ip or "no ip"
		local host = serverlink and serverlink.host or "no host"
		print(debugInfo(), ip, host, unpack(arg)) 
	end
end

-- Make the client or server player autmatically make no move (rest in place) if true
CLIENT_REST @ false
SERVER_REST @ false -- not implemented

function ASSERT_EQUAL(...)
	local e1, e2 = unpack(arg)
	if e1 ~= e2 then
		print(debugInfo(), "ASSERT_EQUAL fail", unpack(arg))
		return false
	end
	return true
end

function ASSERT_NOT_EQUAL(...)
	local e1, e2 = unpack(arg)
	if e1 == e2 then
		print(debugInfo(), "ASSERT_NOT_EQUAL fail", unpack(arg)) 
		return false
	end
	return true
end

function ASSERT_TRUE(...)
	local condition = unpack(arg)
	if not condition then
		print(debugInfo(), "ASSERT_TRUE fail", unpack(arg))
		return false
	end
	return true
end

--ASSERT_EQUAL(1,1,"1 and 1")
--ASSERT_EQUAL(1,0,"1 and 0")
--ASSERT_NOT_EQUAL(1,1,"1 and 1")
--ASSERT_NOT_EQUAL(1,0,"1 and 0")
--ASSERT_TRUE(true, "True") -- Will do nothing
--ASSERT_TRUE(false, "False") -- will print message to console

-- Benchmarking
time_ @ |local _time_ = os.timer()|
_time @ |print("TIME:", os.timer() - _time_)|

--[[ Usage:
local x = 0
time_ for i = 1, 1e8 do x = x + i end _time
--]]

function boolToString(value)
 return value == true and "true" or value == false and "false"
end

function stringToBoolean(string)
	if string=="true" then return true elseif string=="false" then return false else return nil end
end

function dump(t,indent)
    local names = {}
    if not indent then indent = "" end
    for n,g in pairs(t) do
        table.insert(names,n)
    end
    table.sort(names)
    for i,n in pairs(names) do
        local v = t[n]
        if type(v) == "table" then
            if(v==t) then -- prevent endless loop if table contains reference to itself
                print(indent..tostring(n)..": <-")
            else
                print(indent..tostring(n)..":")
                dump(v,indent.."   ")
            end
        else
            if type(v) == "function" then
                print(indent..tostring(n).."()")
            else
                print(indent..tostring(n)..": "..tostring(v))
            end
        end
    end
end
