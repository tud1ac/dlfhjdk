local Aiming = loadstring(game:HttpGet("https://gist.githubusercontent.com/diegxw/d870997929af2a1483180013f688c771/raw/ebd11cce0600c1a140f411f7e1b9e8d4a7320037/module"))()
Aiming.TeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings = {
    SilentAim = true,
    AutoPrediction = true
}
getgenv().DaHoodSettings = DaHoodSettings

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
end)

if getgenv().AutoPrediction == true then
    local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local split = string.split(pingvalue,'(')
    local ping = tonumber(split[1])
    if ping < 130 then
        getgenv().Prediction = 0.130340
    elseif ping < 125 then
        getgenv().Prediction = 0.130340
    elseif ping < 110 then
        getgenv().Prediction = 0.130340
    elseif ping < 105 then
        getgenv().Prediction = 0.130340
    elseif ping < 90 then
        getgenv().Prediction = 0.130340
    elseif ping < 80 then
        getgenv().Prediction = 0.1347
    elseif ping < 70 then
        getgenv().Prediction = 0.1347
    elseif ping < 60 then
        getgenv().Prediction = 0.125
    elseif ping < 50 then
        getgenv().Prediction = 0.125
    elseif ping < 40 then
        getgenv().Prediction = 0.1345
    end
end
