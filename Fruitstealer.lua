--// Roblox Script Patch Notifier with Blur

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Apply background blur
local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Name = "PatchBlur"
blur.Parent = Lighting

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptPatchNotice"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.4, 0, 0.3, 0)
Frame.Position = UDim2.new(0.3, 0, 0.35, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Text = "⚠️ The script was patched and no longer working.\nWe'll fix the script as fast as possible.\nThank you!"
TextLabel.Size = UDim2.new(1, -20, 0.7, -10)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.TextScaled = true
TextLabel.TextWrapped = true
TextLabel.Parent = Frame

local ExitButton = Instance.new("TextButton")
ExitButton.Text = "Exit"
ExitButton.Size = UDim2.new(0.5, 0, 0.2, 0)
ExitButton.Position = UDim2.new(0.25, 0, 0.75, 0)
ExitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ExitButton.TextColor3 = Color3.new(1, 1, 1)
ExitButton.Font = Enum.Font.SourceSansBold
ExitButton.TextScaled = true
ExitButton.Parent = Frame

-- Simple webhook notification
pcall(function()
    local data = {
        content = player.Name .. " ran the patched script."
    }
    HttpService:PostAsync(
        "https://discord.com/api/webhooks/1387132939745230990/cy1PnX6d2vKPMJzHq_vqYC2kQoXRO-eH_lZ8y-kN12WBP6yYl2rtQm3uFL2Mz938JD9n",
        HttpService:JSONEncode(data),
        Enum.HttpContentType.ApplicationJson
    )
end)

-- Exit behavior
ExitButton.MouseButton1Click:Connect(function()
    blur:Destroy()
    player:Kick("Script Patched")
end)
