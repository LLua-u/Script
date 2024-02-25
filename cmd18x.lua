local admins = {"boombongbingy", "tacodoomsday", "100kwadaccount", "noobmankill123", "Partykidcrazy", "Daybot2" , "Partykidcrazy2", "123iloveu3231", "nawalamodfriz_alt", "wegotdatbank"}
print("Loaded Lua_u's and Quasars rtg admin handler")
function GetPlayer(name)
	for i, v in pairs(game.Players:GetPlayers()) do
		if string.match(string.lower(name), string.sub(string.lower(v.Name),0,#name)) or string.match(string.lower(name), string.sub(string.lower(v.DisplayName),0,#name)) then
			return v.Name
		end
	end
end
function log(msg, plr)
	if table.find(admins, plr.Name) == nil then
		print(plr.Name .. " Tried to use a cmd but doesnt have admin")
		return
	end
	print(plr.Name .. ": " .. "|" .. msg .. "|")
end
function boot(plr)
	local v = plr
	plr.Chatted:Connect(function(msg)
		if string.find(string.lower(msg), ":vr") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local item = contents[3]
			local atplr = contents[2] or plr.Name
			if item == "true" then
				item = true
			else
				item = false
			end
			if atplr == "me" then
				atplr = plr.Name
			end
			if atplr == "all" then
				for i, v in pairs(game.Players:GetPlayers()) do
					game.ReplicatedStorage.Networking.NetworkingEvent:FireServer("Character_SetVREnabled", v.ReplicationFocus.Parent, item)
				end
				return
			end
			atplr = GetPlayer(atplr)
			game.ReplicatedStorage.Networking.NetworkingEvent:FireServer("Character_SetVREnabled", game.Players[atplr].ReplicationFocus.Parent, item)
		elseif string.find(string.lower(msg), ":fling") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			local str = contents[3] or "400"
			if atplr == "all" then
				local v4 = {}
				for v5, v6 in pairs(game.Workspace:GetDescendants()) do
					if v6:IsA("BasePart") then
						table.insert(v4, {v6, tonumber(str), Vector3.new(1, 1, 1)})
					end
				end
				game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
				return
			end

			atplr = GetPlayer(atplr)

			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", { {game.Players[atplr].ReplicationFocus}, str, Vector3.new(1,1,1) })
		elseif string.find(string.lower(msg), ":kill") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			if atplr == "all" then
				for i, v in pairs(game.Players:GetPlayers()) do
					pcall(function()
						local char = v.ReplicationFocus
						for i = 0, 10 do
							game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",char.Parent, char)
						end
					end)
				end
				return
			end

			atplr = GetPlayer(atplr)

			local char = game.Players[atplr].ReplicationFocus
			for i = 0, 10 do
				game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",char.Parent, char)
			end
		elseif string.find(string.lower(msg), ":poison") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			local time = tonumber(contents[3]) or 10
			if atplr == "all" then
				for i, v in pairs(game.Players:GetPlayers()) do
					task.spawn(function()
						local char = v.ReplicationFocus
						for i = 0, 10 do
							game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",char.Parent, char)
							task.wait(time/10)
						end
					end)
				end
				return
			end

			atplr = GetPlayer(atplr)

			local char = game.Players[atplr].ReplicationFocus
			for i = 0, 10 do
				game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",char.Parent, char)
				task.wait(time/10)
			end
		elseif string.find(string.lower(msg),":admin") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			if atplr == "all" then
				for i, v in pairs(game.Players:GetPlayers()) do
					table.insert(admins,v.Name)
				end
				return
			end
			atplr = GetPlayer(atplr)
			table.insert(admins,atplr)
		elseif string.find(string.lower(msg),":unadmin") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			if atplr == "all" then
				for i, v in pairs(game.Players:GetPlayers()) do
					table.remove(admins,table.find(admins,v.Name))
				end
				return
			end
			atplr = GetPlayer(atplr)
			table.remove(admins,table.find(admins,game.Players[atplr].Name))
		elseif string.find(string.lower(msg),":nuke") then
			for i, v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",v.Parent, v)
				end
			end
		elseif string.find(string.lower(msg),":icbm") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = GetPlayer(atplr)
			for i, v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",v.Parent, v, game.Players[atplr].ReplicationFocus.Position)
				end
			end
		elseif string.find(string.lower(msg), ":clear") then
			log(msg, plr)
			local v4 = {}
			for v5, v6 in pairs(game.Workspace:GetDescendants()) do
				if v6:IsA("BasePart") then
					table.insert(v4, {v6, 9e909, Vector3.new(0, 1, 0)})
				end
			end
			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
		elseif string.find(string.lower(msg), ":vec") then
			log(msg, plr)
			local v4 = {}
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = GetPlayer(atplr)
			atplr = game.Players[atplr]
			local y = contents[3] or "1"
			local x = contents[4] or "1"
			local z = contents[5] or "1"
			for v5, v6 in pairs(atplr.ReplicationFocus.Parent:GetChildren()) do
				if v6:IsA("BasePart") then
					table.insert(v4, {v6, 1, Vector3.new(tonumber(x), tonumber(y), tonumber(z))})
				end
			end
			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4) --game.Workspace:GetPartBoundsInRadius()
		elseif string.find(string.lower(msg), "domain expansion") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = plr
			local str = "5000"
			local range = "100"
			local params = OverlapParams.new()
			params.FilterDescendantsInstances = {atplr.ReplicationFocus.Parent}
			local v4 = {}
			for v5, v6 in pairs(game.Workspace:GetPartBoundsInRadius(atplr.ReplicationFocus.Position,tonumber(range),params)) do
				if v6:IsA("BasePart") then
					table.insert(v4, {v6, tonumber(str), Vector3.new(0, 1, 0)})
				end
			end
			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
			task.spawn(function()
				wait(5)
				for i, v in pairs(v4) do
					v = v[1]
					game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",v.Parent, v)
				end
			end)
		elseif string.find(string.lower(msg), ":thumb") then --rbxassetid://5781560662
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			local plr = game.Players[GetPlayer(atplr)]
			local hrp = game.Players[GetPlayer(atplr)].ReplicationFocus
			atplr = game.Players[GetPlayer(atplr)].ReplicationFocus.Parent
			task.spawn(function()
				while task.wait(0.05) do
					if atplr.HandL.Mesh.MeshId == "rbxassetid://5781560781" then
						local speed = 1500
						if plr:FindFirstChild("Speed") then
							speed = plr.Speed.Value
						end
						local vector = Vector3.new(speed, 0, speed) * hrp.CFrame.LookVector
						local v4 = {}
						table.insert(v4, {hrp, 1, vector})
						game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
					end
				end
			end)
		elseif string.find(string.lower(msg), ":thumbspeed") then
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			local speed = contents[3] or "1500"
			atplr = game.Players[GetPlayer(atplr)]
			if atplr:FindFirstChild("Speed") then
				atplr.Speed.Value = tonumber(speed)
				return
			end
			local spd = Instance.new("NumberValue", atplr)
			spd.Name = "Speed"
			spd.Value = tonumber(speed)
		elseif string.find(string.lower(msg), ":pointer") then --rbxassetid://5781560536
			log(msg, plr)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = game.Players[GetPlayer(atplr)].ReplicationFocus.Parent
			local detector = Instance.new("Part", atplr)
			detector.Name = "Detect"
			task.spawn(function()
				while task.wait() do
					detector.CFrame = atplr.Head.CFrame
				end
			end)
			detector.Size = Vector3.new(1,1,2000)
			detector.CanCollide = false
			detector.Anchored = true
			task.spawn(function()
				while task.wait(0.1) do
					if atplr.HandL.Mesh.MeshId == "rbxassetid://5781560536" then
						local params = OverlapParams.new()
						params.FilterDescendantsInstances = {atplr, workspace.Structures}
						local stf = workspace:GetPartsInPart(detector,params)
						if #stf >= 1 then
							for i, v in pairs(stf) do
								if v:IsDescendantOf(game.Workspace.WorldObjects) then
									game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",v.Parent, v)
								end
							end
						end
					end
					if atplr.HandR.Mesh.MeshId == "rbxassetid://5781560662" then
						local params = OverlapParams.new()
						params.FilterDescendantsInstances = {atplr, workspace.Structures}
						local stf = workspace:GetPartsInPart(detector,params)
						if #stf >= 1 then
							for i, v in pairs(stf) do
								if v:IsDescendantOf(game.Workspace.WorldObjects) then
									local v4 = {}
									table.insert(v4, {v, 1, Vector3.new(0, 5000, 0)})
									game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
								end
							end
						end
					end
				end
			end)
		end
	end)
end
for i, v in pairs(game.Players:GetPlayers()) do
	boot(v)
end

game.Players.PlayerAdded:Connect(function(v)
	boot(v)
end)
