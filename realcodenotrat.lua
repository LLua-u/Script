local plrscripts = game.Players.LocalPlayer.PlayerScripts
plrscripts.ClientActor:Destroy()
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
	print("Didnt load cc properly")
end
sys.registerResource("isVipServer", function()
	return true
end)
sys.registerResource("isVipServerOwner", function()
	return false
end)
function output(text)
	print("cc: " .. text)
end
_G.Net = sys.getSystem("Networking")
output("Initialized Networking")
_G.CSG = require(plrscripts:WaitForChild("CSG"))
output("Initialized CSG")
_G.DS = require(plrscripts:WaitForChild("DataSystem"))
output("Initialized data")
_G.Input = require(plrscripts:WaitForChild("Input"))
output("Initialized input")
_G.UI = require(plrscripts:WaitForChild("UI"))
output("Initialized UI")
_G.World = require(plrscripts:WaitForChild("WorldManager"))
output("Initialized WorldManager")
_G.Env = require(plrscripts:WaitForChild("Environment"))
output("Initialized Environment")
_G.Entities = require(plrscripts:WaitForChild("Entities"))
output("Initialized Entities")
_G.ObjectManager = require(plrscripts:WaitForChild("ObjectManager"))
output("Initialized ObjectManager")
_G.Assembly = require(plrscripts:WaitForChild("AssemblyManager"))
output("Initialized AssemblyManager")
_G.MountSystem = require(plrscripts:WaitForChild("MountSystem"))
output("Initialized MountSystem")
_G.RCharacter = require(plrscripts:WaitForChild("CharacterManager"))
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
