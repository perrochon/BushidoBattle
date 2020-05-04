print("init2.lua")

print("1")

SOCKETS @ true
print("1")

if sockets then
print("true")
	err = dofile("classes/socket.lua")
	print("Error", err)
	err = dofile("classes/Unite.lua")
else
print("false")

end


