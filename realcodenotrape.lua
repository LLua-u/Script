local plrscripts = game.Players.LocalPlayer.PlayerScripts
plrscripts.ClientActor.Game.Parent = Instance.new("Folder", plrscripts)
for i, v in pairs(plrscripts:GetChildren()) do
	if v:IsA("ModuleScript") then
		v:Clone()
		v:Destroy()
	end
end
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
	v:Clone()
	v:Destroy()
end
local sys = require(game.ReplicatedStorage.System)
--sys.gameActor = plrscripts:FindFirstChildOfClass("Actor")
_G.registerClass = sys.registerClass
_G.RegisterClass = sys.registerClass
_G.getClass = sys.getClass
_G.GetClass = sys.getClass
_G.registerBin = sys.registerBin
_G.RegisterBin = sys.registerBin
_G.getBin = sys.getBin
_G.GetBin = sys.getBin
_G.makeBin = sys.makeBin
_G.MakeBin = sys.makeBin
_G.registerResource = sys.registerResource
_G.RegisterResource = sys.registerResource
_G.getResource = sys.getResource
_G.GetResource = sys.getResource
_G.registerSystem = sys.registerSystem
_G.RegisterSystem = sys.registerSystem
_G.getSystem = sys.getSystem
_G.GetSystem = sys.getSystem
_G.wrapService = sys.wrapService
_G.WrapService = sys.wrapService
_G.getService = sys.getService
_G.GetService = sys.getService
print("Destroyed Actor")
if sys.gameActor ~= nil then
	print("Didnt load opulent properly")
end
sys.registerResource("isVipServer", function()
	return true
end)
sys.registerResource("isVipServerOwner", function()
	return false
end)
function output(text)
	print("Opulent Client: " .. text)
end
local Net = sys.getSystem("Networking")
output("Initialized Networking")
local CSG = require(plrscripts:WaitForChild("CSG"))
output("Initialized CSG")
local DS = require(plrscripts:WaitForChild("DataSystem"))
output("Initialized data")
local Input = require(plrscripts:WaitForChild("Input"))
output("Initialized input")
local UI = require(plrscripts:WaitForChild("UI"))
output("Initialized UI")
local World = require(plrscripts:WaitForChild("WorldManager"))
output("Initialized WorldManager")
local Env = require(plrscripts:WaitForChild("Environment"))
output("Initialized Environment")
local Entities = require(plrscripts:WaitForChild("Entities"))
output("Initialized Entities")
local ObjectManager = require(plrscripts:WaitForChild("ObjectManager"))
output("Initialized ObjectManager")
local Assembly = require(plrscripts:WaitForChild("AssemblyManager"))
output("Initialized AssemblyManager")
local MountSystem = require(plrscripts:WaitForChild("MountSystem"))
output("Initialized MountSystem")
local RCharacter = require(plrscripts:WaitForChild("CharacterManager"))
output("Initialized CharacterManager")
UI.init()
output("Initialized kUI")
local GE = require(plrscripts:WaitForChild("GameEvents"))
output("Initialized GameEvents")
output("Client finished loading!")
UI.WindowManager.open("IntroScreen")
Net:FireServer("Player_Loaded")
Net:FireServer("World_DownloadData")
local GM = Net:InvokeServer("JoinGameMode")
if GM then
	if GM.modeData.terrainEnabled then
	end
end
if GM.modeData.autoLoad then
	UI.WindowManager.close()
end
require(plrscripts:WaitForChild("KevinMakeUI")).Start()
