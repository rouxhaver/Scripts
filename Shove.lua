--[[
Made by Rouxhaver
Equip the tool to enter Shovemode™ and push people off cliffs, buildings, and other tall structures with ease.
(Basically fling except funnier, game MUST have player collision for it to work)
Exiting Shovemode™ may result in death or injury.
]]

local ShoveForce = 200 -- Adjust to your liking

local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local LocalPlayer = PlayerService.LocalPlayer

local Animation = Instance.new("Animation")

if LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then do
		Animation.AnimationId = "rbxassetid://2739366170"
	end else
	Animation.AnimationId = "rbxassetid://183294396"
end

local track = LocalPlayer.Character.Humanoid:LoadAnimation(Animation)
track.Priority = Enum.AnimationPriority.Action
track.Looped = false

local ShoveTool = Instance.new("Tool", LocalPlayer.Backpack)
ShoveTool.Name = "Shove"
ShoveTool.RequiresHandle = false

local Root = LocalPlayer.Character.HumanoidRootPart

local Unequip = false

ShoveTool.Unequipped:Connect(function()
	track:Stop()
	Unequip = true
end)

ShoveTool.Equipped:Connect(function()
	track:Play()
	track:AdjustSpeed(0)
	repeat RunService.Heartbeat:Wait()

		local Velocity = Root.Velocity
		Root.Velocity = Root.CFrame.LookVector * ShoveForce

		RunService.RenderStepped:Wait()
		Root.Velocity = Velocity

		RunService.Stepped:Wait()
		Root.Velocity = Velocity

	until Unequip
	Unequip = false
end)
