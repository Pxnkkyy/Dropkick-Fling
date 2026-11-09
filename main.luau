local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local keybind = Enum.KeyCode.Q --Change this to any keybind you wish

local function DropKick()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local Animator = Humanoid:WaitForChild("Animator")

    if Humanoid.Health <= 0 then return end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://133566007754001"

	local track = Animator:LoadAnimation(animation)
	track:Play()

    while track.IsPlaying do
    --ALL CREDITS TO INFINITE YIELD I DID NOT MAKE THIS FLING
        RunService.Heartbeat:Wait()

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then break end

        local vel, movel = nil, 0.1

        vel = HumanoidRootPart.Velocity
		HumanoidRootPart.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

		RunService.RenderStepped:Wait()
		if Character and Character.Parent and HumanoidRootPart and HumanoidRootPart.Parent then
			HumanoidRootPart.Velocity = vel
		end

		RunService.Stepped:Wait()
		if Character and Character.Parent and HumanoidRootPart and HumanoidRootPart.Parent then
			HumanoidRootPart.Velocity = vel + Vector3.new(0, movel, 0)
			movel = -movel
		end
    end

    animation:Destroy()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == keybind then
        task.spawn(DropKick)
    end
end)
