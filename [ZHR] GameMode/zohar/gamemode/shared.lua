//Noyau commun (serveur-client) Zohar Engine
//Auteur: Rodovali
//Version: 0.1.3

GM.Name = "Zohar Engine"
GM.Author = "Studio FCS"
GM.Email = ""
GM.Website = "http://futurcraftteam.livehost.fr/"

DeriveGamemode("sandbox")
ZHR = {}
ZHR.MFolder = GM.FolderName.."/gamemode/modules/"
function ServerInit()
if (SERVER) then
	print(" ____________________________________ ")
	print("| ZOHAR ENGINE SERVER INITIALIZATION |")
	print("|____________________________________|")
	local _, directories = file.Find("gamemodes/"..ZHR.MFolder.."*", "GAME")
	for k,v in pairs(directories) do
		local zhr_find_start, zhr_find_end = string.find(v, "zhr_")
		if zhr_find_start == 1 and zhr_find_end == 4 then
			if file.Exists("gamemodes/"..ZHR.MFolder..v.."/sv_init.lua", "GAME") then
				include(ZHR.MFolder..v.."/sv_init.lua")
				print("• Module "..v.." loaded server-side")
			end
			if file.Exists("gamemodes/"..ZHR.MFolder..v.."/cl_init.lua", "GAME") then
				AddCSLuaFile(ZHR.MFolder..v.."/cl_init.lua")
			end
		end
	end
end
end

function ClientInit()
	if (CLIENT) then
		print(" ____________________________________ ")
		print("| ZOHAR ENGINE CLIENT INITIALIZATION |")
		print("|____________________________________|")
		local _, directories = file.Find(ZHR.MFolder.."zhr_*", "LUA")
		for _, dir in pairs(directories) do
			for _,File in pairs(file.Find(ZHR.MFolder..dir.."/cl_init.lua","LUA")) do
				include(ZHR.MFolder..dir.."/"..File)
				print("• Module "..dir.." loaded client-side")
			end
		end
	end
end

ServerInit()
hook.Add("InitPostEntity","ClientInit", ClientInit)