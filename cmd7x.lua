local admins = {"boombongbingy", "tacodoomsday", "100kwadaccount", "noobmankill123", "Partykidcrazy", "Daybot2" , "Partykidcrazy2", "123iloveu3231", "nawalamodfriz_alt", "wegotdatbank"}
print("Loaded Lua_u's and Quasars rtg admin handler")
function GetPlayer(name)
	for i, v in pairs(game.Players:GetPlayers()) do
		if string.match(string.lower(name), string.sub(string.lower(v.Name),0,#name)) or string.match(string.lower(name), string.sub(string.lower(v.DisplayName),0,#name)) then
			return v.Name
		end
	end
end
function log(msg)
	print("Handler: " .. "|" .. msg .. "|")
end
function boot(plr)
	local v = plr
	plr.Chatted:Connect(function(msg)
		if table.find(admins, v.Name) == nil then
			print(v.Name .. " Tried to use a cmd but doesnt have admin")
			return
		end
		if string.find(string.lower(msg), ":vr") then
			log(msg)
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
			log(msg)
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
			log(msg)
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
			log(msg)
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
			log(msg)
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
			log(msg)
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
			log(msg)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = GetPlayer(atplr)
			for i, v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("BasePart") then
					game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",v.Parent, v, game.Players[atplr].ReplicationFocus.Position)
				end
			end
		elseif string.find(string.lower(msg), ":clear") then
			log(msg)
			local v4 = {}
			for v5, v6 in pairs(game.Workspace:GetDescendants()) do
				if v6:IsA("BasePart") then
					table.insert(v4, {v6, 9e909, Vector3.new(0, 1, 0)})
				end
			end
			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
		elseif string.find(string.lower(msg), ":vec") then
			log(msg)
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
		elseif string.find(string.lower(msg), ":flung") then
			log(msg)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = GetPlayer(atplr)
			local str = contents[3] or "50"
			local range = contents[4] or "100"
			local params = OverlapParams.new()
			params.FilterDescendantsInstances = {game.Players[atplr].ReplicationFocus.Parent}
			local v4 = {}
			for v5, v6 in pairs(game.Workspace:GetPartBoundsInRadius(game.Players[atplr].ReplicationFocus.Position,tonumber(range),params)) do
				if v6:IsA("BasePart") then
					table.insert(v4, {v6, tonumber(str), Vector3.new(1, 1, 1)})
				end
			end
			game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
		elseif string.find(string.lower(msg), ":fly") then --rbxassetid://5781560536
			log(msg)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = game.Players[GetPlayer(atplr)].ReplicationFocus.Parent
			task.spawn(function()
				while task.wait(0.1) do
					if atplr.HandL.Mesh.MeshId == "rbxassetid://5781560781" then
						local vector = Vector3.new(150, 150, 150) * atplr.Head.LookVector
						local v4 = {}
						for v5, v6 in pairs(atplr:GetChildren()) do
							if v6:IsA("BasePart") then
								table.insert(v4, {v6, 1, vector})
							end
						end
						game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Leafblower_PushParts", v4)
					end
				end
			end)
		elseif string.find(string.lower(msg), ":pointer") then --rbxassetid://5781560536
			log(msg)
			local contents = string.split(string.lower(msg), " ")
			local atplr = contents[2] or plr.Name
			atplr = game.Players[GetPlayer(atplr)].ReplicationFocus.Parent
			task.spawn(function()
				while task.wait() do
					if atplr.HandL.Mesh.MeshId == "rbxassetid://5781560536" then
						local params = RaycastParams.new()
						params.FilterDescendantsInstances = {atplr, workspace.Structures}
						local ray = workspace:Raycast(atplr.Head.Position, atplr.Head.CFrame.LookVector * 50, params)
						local result = ray
						if result then
							local distance = (atplr.Head.Position - result.Position).Magnitude
							local p = Instance.new("Part", workspace)
							p.Anchored = true
							p.CanCollide = false
							p.Size = Vector3.new(0.1, 0.1, distance)
							p.CFrame = CFrame.new(atplr.Head.Position, result.Position)*CFrame.new(0, 0, -distance/2)
						end
						if ray then
							if ray.Instance then
								local hit = ray.Instance
								local char = hit
								for i = 0, 10 do
									game.ReplicatedStorage.Networking:WaitForChild("NetworkingEvent"):FireServer("Gun_ProjectileHit",char.Parent, char)
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
