task.spawn(function()
repeat task.wait() until game:IsLoaded()
local VIP = cloneref(game:GetService("VirtualInputManager"))
local RunService = game:GetService("RunService")
local LogService = cloneref(game:GetService("LogService"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = cloneref(game:GetService("Players"))
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
repeat task.wait() until Player.Character
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
local Random = Random.new()

local WhitelistSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Whitelist.lua"))()
local ReturningWhitelist = WhitelistSystem:Whitelist()
if ReturningWhitelist ~= true then
    Player:Kick("Auto Farm Access Denied | The system did not return true.")
end

writefile("auto_rejoiner.txt", "https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/RealAutofarm.lua")
task.wait(.05)

if game.PlaceId ~= 15124180230 then
    Player:Kick("Auto Farm Protection | This isn't supported on regular servers.")
return end

local Cycles = 1
local MarshmallowSold = 0
local PotatoChipsSold = 0
local MoneyDifference = 0
local CardsDone = 0
local Now = os.clock()

local Runtime
local Information
local SellInfo
local HourlyRate
local HourlyRate2 = "100"

-- //  IMPORTANT!!
local GoalCashSettings = {
    ["GoalCash"] = false; -- // Enable this to enable auto kick and the settings below.
    ["SaveGoalCashOnExit"] = false; -- // If you get disconnected or leave it will memorize the money made.
    ["GoalAmount"] = 1750000; -- // How much cash should be made before it auto kicks you.
}

local Settings = {
    ["Status"] = "[ Startup ] Status: Waiting for a response from the system.";
    ["Autofarm Enabled"] = true;
    ["Old HRP Position"] = CFrame.new(HumanoidRootPart.Position);
    ["IsHealing"] = false;
    ["Cards Counter"] = 0;
    ["Potato Counter"] = 0;
    ["Ping"] = 0;
    ["Starting Cash"] = 0;
    ['Autocrouch Enabled'] = false;
    ["Auto Rejoin"] = false;
    ["Enough Cash"] = false;
    ["Rejoined"] = true;
    ["Busy"] = true;
}

task.spawn(function()
    repeat task.wait() until PlayerGui:FindFirstChild("Main") :: ScreenGui
    repeat task.wait() until PlayerGui:FindFirstChild("Main"):FindFirstChild("Money") :: Frame
    repeat task.wait() until PlayerGui:FindFirstChild("Main"):FindFirstChild("Money"):FindFirstChild("Amount") :: TextLabel
    repeat task.wait() until Settings["Busy"] ~= true
    local Result = string.gsub(PlayerGui:FindFirstChild("Main"):FindFirstChild("Money"):FindFirstChild("Amount").Text, "%D+", "")
    Settings["Starting Cash"] = tonumber(Result)
    if isfile("autogc_1" .. Player.Name .. ".txt") and isfile("autogc_2" .. Player.Name .. ".txt") and isfile("autogc_3" .. Player.Name .. ".txt") then
        local file1 = readfile("autogc_1" .. game.Players.LocalPlayer.Name .. ".txt")
        if file1 == "true" then
            GoalCashSettings["GoalCash"] = true
        else
            GoalCashSettings["GoalCash"] = false
        end
        task.wait(.05)
        local file2 = readfile("autogc_1" .. game.Players.LocalPlayer.Name .. ".txt")
        if file2 == "true" then
            GoalCashSettings["SaveGoalCashOnExit"] = true
        else
            GoalCashSettings["SaveGoalCashOnExit"] = false
        end
        local file3 = readfile("autogc_1" .. game.Players.LocalPlayer.Name .. ".txt")
        if typeof(file3) == "number" and GoalCashSettings["GoalCash"] == true then
            GoalCashSettings["GoalAmount"] = tonumber(readfile("autogc_3" .. Player.Name .. ".txt"))
        else
            GoalCashSettings["GoalAmount"] = 1750000
        end
    end
    if isfile("autofarm_" .. Player.Name .. ".txt") then
        if GoalCashSettings["SaveGoalCashOnExit"] ~= true then
            delfile("autofarm_" .. Player.Name .. ".txt")
            delfile("autogc_1" .. Player.Name .. ".txt")
            delfile("autogc_2" .. Player.Name .. ".txt")
            delfile("autogc_3" .. Player.Name .. ".txt")
        else
            GoalCashSettings["GoalAmount"] = (GoalCashSettings["GoalAmount"] - tonumber(readfile("autofarm_" .. Player.Name .. ".txt")))
        end
    end
    while task.wait() do
        if GoalCashSettings["GoalCash"] == true then
            if MoneyDifference >= GoalCashSettings["GoalAmount"] then
                if isfile("autofarm_" .. Player.Name .. ".txt") then
                    delfile("autofarm_" .. Player.Name .. ".txt")
                end
                delfile("autogc_1" .. Player.Name .. ".txt")
                delfile("autogc_2" .. Player.Name .. ".txt")
                delfile("autogc_3" .. Player.Name .. ".txt")
                warn("Goal Cash Reached.")
                game.Players.LocalPlayer:Kick("Auto Farm Protection | Reached Goal Cash : " .. tostring(GetCommaValue(GoalCashSettings["GoalAmount"])) .. " | " .. game.Players.LocalPlayer.Name)
            end
        end
        if tonumber(Result) >= 1750000 then
            Player:Kick("Auto Farm Protection | Reached Max Money : " .. Player.Name)
        return end
        if Settings["IsHealing"] ~= true then
            repeat task.wait() until PlayerGui:FindFirstChild("Main") :: ScreenGui
            repeat task.wait() until PlayerGui:FindFirstChild("Main"):FindFirstChild("Money") :: Frame
            repeat task.wait() until PlayerGui:FindFirstChild("Main"):FindFirstChild("Money"):FindFirstChild("Amount") :: TextLabe
            if tonumber(HourlyRate2) > 1000000 then Result = string.gsub(PlayerGui:FindFirstChild("Main"):FindFirstChild("Money"):FindFirstChild("Amount").Text, "%D+", ""); Settings["Starting Cash"] = tonumber(Result); Result = Settings["Starting Cash"]; end
            if tonumber(Result) > 2500 then
                Settings["Enough Cash"] = true
            elseif Settings["Rejoined"] == true then
                Settings["Enough Cash"] = true
            else
                Settings["Status"] = "[ Startup ] Status: You don't have atleast 2500 cash, waiting until the system detects you have atleast 2500 cash."
                Settings["Enough Cash"] = false
            end
            Result = string.gsub(PlayerGui:FindFirstChild("Main"):FindFirstChild("Money"):FindFirstChild("Amount").Text, "%D+", "")
            MoneyDifference = tonumber(Result) - Settings["Starting Cash"]
        end
    end
end)

task.spawn(function()
    Player.Idled:Connect(function()
        local VirtualUser = cloneref(game:GetService("VirtualUser"))
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
    Players.PlayerRemoving:Connect(function(plr)
        if plr == Player then
            if GoalCashSettings["GoalCash"] == true then
                if GoalCashSettings["SaveGoalCashOnExit"] == true then
                    if isfile("autofarm_" .. Player.Name .. ".txt") then
                        writefile("autofarm_" .. Player.Name .. ".txt", tostring(MoneyDifference + tonumber(readfile("autofarm_" .. Player.Name .. ".txt"))))
                    else
                        writefile("autofarm_" .. Player.Name .. ".txt", tostring(MoneyDifference))
                    end
                    writefile("autogc_1" .. Player.Name .. ".txt", tostring(GoalCashSettings["GoalCash"]))
                    writefile("autogc_2" .. Player.Name .. ".txt", tostring(GoalCashSettings["SaveGoalCashOnExit"]))
                    writefile("autogc_3" .. Player.Name .. ".txt", tostring(GoalCashSettings["GoalAmount"]))
                end
            end
        end
    end)
    while task.wait() do
        if Settings["Autofarm Enabled"] ~= true then
            Settings["Status"] = "[ Startup ] Status: Autofarm is stopped."
            task.wait()
        else
            task.wait()
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Settings["Autofarm Enabled"] == true then
            Settings["Ping"] = Player:GetNetworkPing()
            VIP:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
            task.wait()
            VIP:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
            task.wait()
            if Settings['Autocrouch Enabled'] == true then
                VIP:SendKeyEvent(true, Enum.KeyCode.C, false, nil)
                task.wait()
                VIP:SendKeyEvent(false, Enum.KeyCode.C, false, nil)
            end
        end
    end
end)
        
RunService.RenderStepped:Connect(function()
    if Humanoid.Health <= 80 or PlayerGui:WaitForChild("Main"):WaitForChild("CombatFrame").Visible == true then
        Settings["IsHealing"] = true
        Settings["Status"] = "[ Startup ] Status: Waiting for health to reach safe amount before continuing."
        HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
    else
        Settings["IsHealing"] = false
        if Settings["Status"] == "[ Startup ] Status: Healing." then
            Settings["Status"] = "[ Startup ] Status: Waiting for a response from the system."
        end
    end
    if HumanoidRootPart.Position.Y <= -10 or HumanoidRootPart.Position.Y >= 50 then
        HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
    end
end)

task.spawn(function()
    while Settings["Autofarm Enabled"] == true do
        for Index, Object in next, Players:GetChildren() do
            if Object.Character and Object ~= Player then
                if Object.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp1 = Object.Character:FindFirstChild("HumanoidRootPart")
                    if (hrp1.Position - HumanoidRootPart.Position).Magnitude < 3 then
                        local function ApplyHeaviness()
                            task.wait()
                            HumanoidRootPart.Anchored = true
                            task.wait()
                            HumanoidRootPart.Anchored = false
                        end
                        repeat ApplyHeaviness() until (hrp1.Position - HumanoidRootPart.Position).Magnitude >= 3
                    end
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    Humanoid.Died:Connect(function()
        if Settings["Auto Rejoin"] == true then
            writefile("AutorejoinerTXT.txt", "true")
            GoalCashSettings["SaveGoalCashOnExit"] = true
            task.wait(.1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Autoexecute.lua"))()
        end
    end)
end)

local function GetCommaValue(Number)
    local Formatted = tostring(Number)
    while true do
        Formatted, Replaced = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (Replaced == 0) then
            break
        end
    end
    return Formatted
end

local function FindAvailableApartments()
    local Available = {}
    local Owned = {}
    local Apartments = {"WH1"; "BH3"; "BH2"; "BH4"; "BH1"; "LT1";}
    local CasinoApartments = {"Home 1"; "Home 2"; "Home 3"; "Home 4"}
    for Index, Object in next, workspace:WaitForChild("Map").APTS:GetChildren() do
        if (Object:IsA("Model")) then 
            if table.find(Apartments, tostring(Object)) then
                local Board = Object:FindFirstChild("Board", Model)
                if Board.name.SurfaceGui.TextLabel.Text == "VACANT" then
                    table.insert(Available, workspace:WaitForChild("Map").Houses[tostring(Object)])
                elseif Board.name.SurfaceGui.TextLabel.Text == Player.Name then
                    table.insert(Owned, workspace:WaitForChild("Map").Houses[tostring(Object)])
                end
            elseif table.find(CasinoApartments, tostring(Object)) then
                local Board = Object:FindFirstChild("Board", Model)
                if Board.name.SurfaceGui.TextLabel.Text == "VACANT" then
                    table.insert(Available, workspace:WaitForChild("Map").Locations.Apartments[tostring(Object)])
                elseif Board.name.SurfaceGui.TextLabel.Text == Player.Name then
                    table.insert(Owned, workspace:WaitForChild("Map").Locations.Apartments[tostring(Object)])
                end
            end
        end
    end
    if #Owned >= 1 then return Owned, "Owned" end
    return Available, "Not Owned"
end

local function FindAvailableATMs()
    local ATMs = workspace:WaitForChild("Map").ATMS
    local AvailableATM
    for Index, ATM in next, ATMs:GetChildren() do
        if ATM:FindFirstChild("ATMScreen").Transparency == 0 then
            AvailableATM = ATM
        end
    end
    return AvailableATM
end

local function FindAvailableHomeless()
    Settings["Old HRP Position"] = CFrame.new(HumanoidRootPart.Position)
    HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
    task.wait(.25)
    HumanoidRootPart.CFrame = CFrame.new(899, 4, -284)
    task.wait(.15)
    HumanoidRootPart.CFrame = CFrame.new(518, 4, -295)
    task.wait(.15)
    HumanoidRootPart.CFrame = CFrame.new(135, 8, -322)
    task.wait(.15)
    HumanoidRootPart.CFrame = CFrame.new(1102, 4, 529)
    task.wait(.15)
    HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
    task.wait(.15)
    local Homeless = ReplicatedStorage:WaitForChild("Workspace").Homeless
    local AvailableHomeless = {}
    for Index, Object in next, Homeless:GetChildren() do
        if Object:IsA("Model") and tostring(Object) ~= "Six" then
            local UpperTorso = Object:FindFirstChild("UpperTorso")
            if UpperTorso.Position.Y < 2.35 and math.floor(UpperTorso.Position.Y) ~= 4 or math.floor(UpperTorso.Position.Y) ~= 3 then
                table.insert(AvailableHomeless, Object)
            end
        elseif tostring(Object) == "Six" and Object:IsA("Model") then
            local UpperTorso = Object:FindFirstChild("UpperTorso")
            if UpperTorso.Position.Y < -9 then
                table.insert(AvailableHomeless, Object)
            end
        end
    end
    return AvailableHomeless
end

local function StartMarshmallowFarm()
    repeat task.wait() until Settings["Enough Cash"] == true
    repeat task.wait() until Settings["IsHealing"] == false
    local Apartment, Owned = FindAvailableApartments()
    if #Apartment ~= 0 then
        if Settings["Autofarm Enabled"] ~= true then return end
        if Owned == "Owned" then
            Apartment = Apartment[1]
            Settings["Apartment"] = Apartment
        else
            Apartment = Apartment[Random:NextInteger(1, #Apartment)]
            Settings["Apartment"] = Apartment
        end

        if Owned == "Not Owned" then
            if Settings["Autofarm Enabled"] ~= true then return end
            local apt = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment))
            local Board = apt:FindFirstChild("Board")
            local Prompt = Board.backboard.ProximityPrompt
            HumanoidRootPart.CFrame = CFrame.new(Board.backboard.Position)
            task.wait(.5)
            repeat
                fireproximityprompt(Prompt)
                task.wait(.25)
            until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Board.name.SurfaceGui.TextLabel.Text == tostring(Player)
            if PlayerGui:WaitForChild("Main").BasicNotification.Text == "This apartment is already occupied!" then
                task.spawn(StartMarshmallowFarm)
                return false
            end
        end

        local Lock = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment)).Door.DoorLock
        local Knob = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment)).Door.Knob
        local KnobPrompt = Knob.Parent.Interact.Attachment.ProximityPrompt

        if Lock.Part.Rotation.Y ~= 0 and Lock.Part.Rotation.Y ~= 90 then
            if Settings["Autofarm Enabled"] ~= true then return end
            HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
            task.wait(.5)
            for Index = 1,5 do
                HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
                fireproximityprompt(KnobPrompt)
                task.wait()
            end
            task.wait(.75)
        end
        if Lock.Part.Rotation.X ~= 90 then
            if Settings["Autofarm Enabled"] ~= true then return end
            HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
            task.wait(.25)
            repeat
                HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
                fireproximityprompt(Lock.Part.ProximityPrompt)
                task.wait(.25)
                fireproximityprompt(KnobPrompt)
            until Lock.Part.Rotation.X == 90 or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have permission to interact with this."
            if PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 then
                task.spawn(StartMarshmallowFarm)
                return
            end
        end
        task.wait(.25)
        Settings["Busy"] = false
        HumanoidRootPart.CFrame = Settings["Old HRP Position"]
        return true
    else
        return false
    end
end

local function ScavengeInventory()
    Humanoid:UnequipTools()
    task.wait(.05)
    local Potato = 0
    local Flour = 0
    local Water = 0
    local Gelatin = 0
    local SugarBlockBag = 0
    for Index, Object in next, Player:WaitForChild("Backpack"):GetChildren() do
        if (Object.Name == "Potato") then
            Potato += 1
        end
        if (Object.Name == "Flour") then
            Flour += 1
        end
        if (Object.Name == "Water") then
            Water += 1
        end
        if (Object.Name == "Gelatin") then
            Gelatin += 1
        end
        if (Object.Name == "Sugar Block Bag") then
            SugarBlockBag += 1
        end
    end
    return Potato, Flour, Water, Gelatin, SugarBlockBag
end

local function PurchaseSkiMask()
    repeat task.wait() until Settings["Enough Cash"] == true
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    Settings["Status"] = "[ Startup ] Status: Purchasing Ski-Mask."
    Humanoid:UnequipTools()
    task.wait(.05)
    if not Player:WaitForChild("Backpack"):FindFirstChild("SkiMask") then
        HumanoidRootPart.CFrame = CFrame.new(-363, 4, -321)
        task.wait(.5)
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer("SkiMask")
        repeat task.wait(); Humanoid:UnequipTools() until Player:WaitForChild("Backpack"):FindFirstChild("SkiMask")
    end
    if not Character:FindFirstChild("SkiMask") :: Accessory then
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("SkiMask"))
        task.wait(.05)
        local Args = {
        	buffer.fromstring("\005"),
            Character:WaitForChild("SkiMask")
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RPC"):FireServer(unpack(Args))
        task.wait(.05)
        Humanoid:UnequipTools()
    end
    HumanoidRootPart.CFrame = Settings["Old HRP Position"]
    return true
end

local Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()

local function MainAutofarm()
    local Animation = Instance.new('Animation')
    Animation.AnimationId = "rbxassetid://126995783634131"
    local Track = game.Players.LocalPlayer.Character:FindFirstChild('Humanoid'):FindFirstChild('Animator'):LoadAnimation(Animation)
    Track.Priority = Enum.AnimationPriority.Action4
    Settings["Auto Rejoin"] = true
    writefile("AutorejoinerTXT.txt", "false")
    repeat task.wait() until Settings["Enough Cash"] == true
    repeat task.wait() until Settings["IsHealing"] == false
    if Settings["Apartment"] == nil then return end
    if Settings["Autofarm Enabled"] ~= true then return end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    if not Character:FindFirstChild("SkiMask") :: Accessory then
        PurchaseSkiMask()
    end
    local function BuyMarshIngredients()
        Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        if (Water < 1 or Gelatin < 1 or SugarBlockBag < 1) then
            if Settings["Autofarm Enabled"] ~= true then return end
            Settings["Status"] = "[ Marshmallows ] Status: Buying Marshmallow ingredients."
            HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            task.wait(.75)
            if (Water < 1) then
                if Settings["Autofarm Enabled"] ~= true then return end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                Settings["Status"] = "[ Marshmallows ] Status: Buying Marshmallow ingredients."
                local Arguments = {
        	        "Water";
                }
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer(unpack(Arguments))
                task.wait(.4)
                HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            end
            if (Gelatin < 1) then
                if Settings["Autofarm Enabled"] ~= true then return end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                Settings["Status"] = "[ Marshmallows ] Status: Buying Marshmallow ingredients."
                local Arguments = {
        	        "Gelatin";
                }
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer(unpack(Arguments))
                task.wait(.4)
                HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            end
            if (SugarBlockBag < 1) then
                if Settings["Autofarm Enabled"] ~= true then return end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                Settings["Status"] = "[ Marshmallows ] Status: Buying Marshmallow ingredients."
                local Arguments = {
        	        "Sugar Block Bag";
                }
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer(unpack(Arguments))
                task.wait(.4)
                HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            end
        end
    end
    BuyMarshIngredients()
    repeat
        Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        task.wait(.1)
        Settings["Potato Counter"] += 1
    until (Water >= 1 and Gelatin >= 1 and SugarBlockBag >= 1) or Settings["Potato Counter"] > 190
    Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
    if (Water < 1 or Gelatin < 1 or SugarBlockBag < 1) then
        repeat
            Settings["Status"] = "[ Marshmallows ] Status: Failed to buy ingredients, trying again."
            BuyMarshIngredients()
            repeat
                Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
                task.wait(.1)
                Settings["Potato Counter"] += 1
            until (Water >= 1 and Gelatin >= 1 and SugarBlockBag >= 1) or Settings["Potato Counter"] > 190
            Settings["Potato Counter"] = 0
            Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        until (Gelatin >= 1 and Water >= 1 and SugarBlockBag >= 1)
        Settings["Status"] = "[ Marshmallows ] Status: Successfully bought ingredients."
    else
        Settings["Status"] = "[ Marshmallows ] Status: Successfully bought ingredients."
    end
    Settings["Potato Counter"] = 0
    task.wait(.15)
    local Stove
    local CookPrompt
    local Timer
    if tostring(Settings["Apartment"]):find("Home") then
        Stove = Settings["Apartment"]:FindFirstChild("Cooking Pot")
        CookPrompt = Stove:FindFirstChild("Attachment").ProximityPrompt
        Timer = Stove:FindFirstChild("Timer").TextLabel
    else
        Stove = Settings["Apartment"]:WaitForChild("Interior"):FindFirstChild("Cooking Pot")
        CookPrompt = Stove:FindFirstChild("Attachment").ProximityPrompt
        Timer = Stove:FindFirstChild("Timer").TextLabel
    end

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Marshmallows ] Status: Pouring water."
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
    Settings["Status"] = "[ Marshmallows ] Status: Pouring water."
    task.wait(.5)
    Humanoid:UnequipTools()
    task.wait(.05)
    Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Water"))
    repeat
        if Settings["Autofarm Enabled"] ~= true then return end
        CookPrompt = Stove:FindFirstChild("Attachment").ProximityPrompt
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Water"))
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        Settings["Status"] = "[ Marshmallows ] Status: Pouring water."
        task.wait(.25)
        fireproximityprompt(CookPrompt)
        task.wait(1.25)
        Humanoid:UnequipTools()
        task.wait(.1)
    until not Player:WaitForChild("Backpack"):FindFirstChild("Water") or PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Timer.Text == "19"
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have permission to cook in this apartment." then
        StartMarshmallowFarm()
        task.spawn(MainAutofarm)
    return
    end

    local function BuyPotatoFlour()
        Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        if (Potato < 1 or Flour < 1) then
            if Settings["Autofarm Enabled"] ~= true then return end
            Settings["Status"] = "[ Potato Chips ] Status: Purchasing potato chips ingredients."
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            HumanoidRootPart.CFrame = CFrame.new(-766, 4, -197)
            Settings["Status"] = "[ Potato Chips ] Status: Purchasing potato chips ingredients."
            task.wait(1)
            if (Potato < 1) then
                if Settings["Autofarm Enabled"] ~= true then return end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                Settings["Status"] = "[ Potato Chips ] Status: Purchasing potato chips ingredients."
                local Arguments = {
        	        "Potato";
                }
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer(unpack(Arguments))
                task.wait(.6)
            end
            if (Flour < 1) then
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                Settings["Status"] = "[ Potato Chips ] Status: Purchasing potato chips ingredients."
                if Settings["Autofarm Enabled"] ~= true then return end
                local Arguments = {
        	        "Flour";
                }
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer(unpack(Arguments))
                task.wait(.6)
            end
        end
    end
    BuyPotatoFlour()
    repeat
        Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        task.wait(.1)
        Settings["Potato Counter"] += 1
    until (Potato >= 1 and Flour >= 1) or Settings["Potato Counter"] > 190
    Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
    if (Potato < 1 or Flour < 1) then
        repeat
            Settings["Status"] = "[ Potato Chips ] Status: Failed to buy ingredients, trying again."
            BuyPotatoFlour()
            repeat
                Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
                task.wait(.1)
                Settings["Potato Counter"] += 1
            until (Potato >= 1 and Flour >= 1) or Settings["Potato Counter"] > 190
            Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
        until (Potato >= 1 and Flour >= 1)
        Settings["Status"] = "[ Potato Chips ] Status: Successfully bought ingredients."
    else
        Settings["Status"] = "[ Potato Chips ] Status: Successfully bought ingredients."
    end

    local Labatory = workspace.Map.Locations["The Laboratory"]
    local Clipboard = workspace.Map.Locations["The Laboratory"].Prompts.Clipboard
    local ClipboardPrompt = workspace.Map.Locations["The Laboratory"].Prompts.Clipboard.ProximityPrompt

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Potato Chips ] Status: Claiming j*b."
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(Clipboard.Position)
    Settings["Status"] = "[ Potato Chips ] Status: Claiming j*b."
    task.wait(.75)
    for Index = 1,10 do
        fireproximityprompt(ClipboardPrompt)
        task.wait(.05)
    end

    local function PurchaseFakeID()
        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Cards ] Status: Purchasing fake ID."
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(215, 6, -332)
        Settings["Status"] = "[ Cards ] Status: Purchasing fake ID."
        task.wait(.5)
        repeat task.wait() until workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
        local FakeIDSeller = workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
        local BuyIDPrompt = FakeIDSeller.UpperTorso.Attachment.ProximityPrompt
        repeat
            if Settings["Autofarm Enabled"] ~= true then return end
            HumanoidRootPart.CFrame = CFrame.new(215, 6, -332)
            fireproximityprompt(BuyIDPrompt)
            task.wait(.05)
        until Player:WaitForChild("Backpack"):FindFirstChild("Fake ID")
        task.wait(4)
    end
    PurchaseFakeID()

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Potato Chips ] Status: Cutting potato."
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(-459, 4, -447)
    Settings["Status"] = "[ Potato Chips ] Status: Cutting potato."
    task.wait(.5)
    local PotatoCutter = Labatory["Cutting Boards"]:WaitForChild("Potato Cutter")
    local PotatoCutterPrompt = PotatoCutter:FindFirstChild("Model").Union.Attachment.ProximityPrompt

    repeat
        if Settings["Autofarm Enabled"] ~= true then return end
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Potato"))
        task.wait(.25)
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(PotatoCutterPrompt.Parent.Parent.Position)
        Settings["Status"] = "[ Potato Chips ] Status: Cutting potato."
        fireproximityprompt(PotatoCutterPrompt)
        Humanoid:UnequipTools()
        task.wait(.05)
    until not Player:WaitForChild("Backpack"):FindFirstChild("Potato") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have an active task." or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are at the wrong step."
    Humanoid:UnequipTools()
    task.wait(.05)
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are at the wrong step." and Player:WaitForChild("Backpack"):FindFirstChild("Potato") then
        Humanoid.Health = 0
        return
    end
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have an active task." then
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(Clipboard.Position)
        Settings["Status"] = "[ Potato Chips ] Status: Claiming J*b."
        task.wait(.75)
        for Index = 1,10 do
            fireproximityprompt(ClipboardPrompt)
            task.wait(.05)
        end
    end

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Potato Chips ] Status: Bagging potato."
    local PlasticBag = Labatory:WaitForChild("Prompts")["Plastic Bag"]
    local PlasticBagPrompt = PlasticBag.Attachment.ProximityPrompt

    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(PlasticBag.Position)
    Settings["Status"] = "[ Potato Chips ] Status: Bagging potato."
    task.wait(.5)
    repeat
        fireproximityprompt(PlasticBagPrompt)
        task.wait(.05)
    until not PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Grab")
    task.wait(2.75)

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Potato Chips ] Status: Mixing flour and potato."
    repeat task.wait() until Labatory:WaitForChild("Bowls"):FindFirstChildOfClass("UnionOperation")
    local Bowl = Labatory:FindFirstChild("Bowls"):FindFirstChildOfClass("UnionOperation")
    local BowlPrompt = Bowl.ProximityPrompt

    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(Bowl.Position)
    Settings["Status"] = "[ Potato Chips ] Status: Mixing flour and potato."
    task.wait(.5)
    repeat
        if Settings["Autofarm Enabled"] ~= true then return end
        HumanoidRootPart.CFrame = CFrame.new(Bowl.Position)
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Flour"))
        task.wait(.25)
        fireproximityprompt(BowlPrompt)
        Humanoid:UnequipTools()
        task.wait(.05)
    until not Player:WaitForChild("Backpack"):FindFirstChild("Flour")
    task.wait(3.75)

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Potato Chips ] Status: Cooking potato chips."
    
    local AvailablePot
    local PotTimer
    local PotPrompt

    for Index, Object in next, Labatory:WaitForChild("Pots"):GetChildren() do
        if Object:IsA("UnionOperation") then
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            HumanoidRootPart.CFrame = CFrame.new(Object.Position)
            Settings["Status"] = "[ Potato Chips ] Status: Cooking potato chips."
            task.wait(.75 + Random:NextNumber(.1, .5))
            repeat
                HumanoidRootPart.CFrame = CFrame.new(Object.Position)
                fireproximityprompt(Object.ProximityPrompt)
                Settings["Potato Counter"] += 1
                task.wait()
            until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Settings["Potato Counter"] > 100
            Settings["Potato Counter"] = 0
            if PlayerGui:WaitForChild("Main").BasicNotification.Text == "This pot is in use." then
                repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 1
            else
                AvailablePot = Object
                PotTimer = Object.Timer.TextLabel
                PotPrompt = Object.ProximityPrompt
                break
            end
        end
    end

    local function ApplyForCard()
        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Cards ] Status: Applying for credit card."
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(-48, 4, -315)
        task.wait(.5)
        repeat task.wait() until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Bank Teller")
        local BankTeller = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Bank Teller")
        local BankPrompt = BankTeller.UpperTorso.Attachment.ProximityPrompt
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Fake ID"))
        task.wait(.1)
        repeat
            if Settings["Autofarm Enabled"] ~= true then return end
            BankPrompt = BankTeller.UpperTorso.Attachment.ProximityPrompt
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            HumanoidRootPart.CFrame = CFrame.new(-48, 4, -315)
            Settings["Status"] = "[ Cards ] Status: Applying for credit card."
            Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Fake ID"))
            task.wait(.1)
            fireproximityprompt(BankPrompt)
            task.wait(.5)
            Humanoid:UnequipTools()
            task.wait(.1)
            Settings["Potato Counter"] += 1
        until not Player:WaitForChild("Backpack"):FindFirstChild("Fake ID") or Settings["Potato Counter"] > 2
        Settings["Potato Counter"] = 67
    end
    ApplyForCard()

    if Settings["Autofarm Enabled"] ~= true then return end
    Settings["Status"] = "[ Marshmallows ] Status: Adding sugar and gelatin."
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] == false
    end
    HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
    Settings["Status"] = "[ Marshmallows ] Status: Adding sugar and gelatin."
    task.wait(.5)
    repeat
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Sugar Block Bag"))
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        task.wait(.1)
        fireproximityprompt(CookPrompt)
        task.wait(1.1)
        Humanoid:UnequipTools()
        task.wait(.05)
    until not Player:WaitForChild("Backpack"):FindFirstChild("Sugar Block Bag") or PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Pour")
    Settings["Potato Counter"] = 0
    task.wait(.75)

    if Settings["Autofarm Enabled"] ~= true then return end
    repeat
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Gelatin"))
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        task.wait(.1)
        fireproximityprompt(CookPrompt)
        task.wait(1.1)
        Humanoid:UnequipTools()
        task.wait(.05)
    until not Player:WaitForChild("Backpack"):FindFirstChild("Gelatin") or Timer.Text == "44"

    Settings["Status"] = "[ Cards ] Status: Waiting for card application response."
    if Settings["Potato Counter"] == 67 then
        Settings["Potato Counter"] = 0
        repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0
    else
        repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0
    end
    task.wait(.1)
    if Settings["Autofarm Enabled"] ~= true then return end
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." then
        PurchaseFakeID()
        ApplyForCard()
        Settings["Cards Counter"] += 1
        repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0
    elseif PlayerGui:WaitForChild("Main").BasicNotification.Text ~= "Your application was successful. Please allow 30 seconds for the bank to prepare your card." then
        repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0
    end

    local function DoChipMarsh()
        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Marshmallows ] Status: Waiting for marshmallow to cook."
        repeat task.wait() until Timer.Text == "0"
        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Marshmallows ] Status: Bagging cooked marshmallow."
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        Settings["Status"] = "[ Marshmallows ] Status: Waiting for marshmallow to cook."
        task.wait(.5)
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Empty Bag"))
        task.wait(.1)
        repeat
            if Settings["Autofarm Enabled"] ~= true then return end
            CookPrompt = Stove.Attachment.ProximityPrompt
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            Settings["Status"] = "[ Marshmallows ] Status: Waiting for marshmallow to cook."
            HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
            Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Empty Bag"))
            task.wait(.1)
            fireproximityprompt(CookPrompt)
            task.wait(.25)
            Humanoid:UnequipTools()
            task.wait(.05)
        until not Player:WaitForChild("Backpack"):FindFirstChild("Empty Bag")
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] == false
        end
        HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
        task.wait(.75)
        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Marshmallows ] Status: Selling marshmallows."
        Humanoid:UnequipTools()
        for Index, Object in next, Player:WaitForChild("Backpack"):GetChildren() do
            if tostring(Object):find("Marshmallow") then
                Humanoid:UnequipTools()
                task.wait(.05)
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
                Settings["Status"] = "[ Marshmallows ] Status: Selling marshmallows."
                Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild(tostring(Object)))
                task.wait(.1)
                repeat task.wait() until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Lamont Bell")
                local LamontBell = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Lamont Bell")
                local LamontPrompt = LamontBell.UpperTorso.ProximityPrompt
                if Settings["Autofarm Enabled"] ~= true then return end
                fireproximityprompt(LamontPrompt)
                MarshmallowSold += 1
                task.wait(.25)
                Humanoid:UnequipTools()
            end
        end

        if Settings["Autofarm Enabled"] ~= true then return end
        Settings["Status"] = "[ Potato Chips ] Status: Waiting for potato chips to cook."
        if PotTimer ~= nil then
            repeat task.wait(.1); Settings["Potato Counter"] += 1 until PotTimer.Text == "0" or PotTimer.TextTransparency == 1 or Settings["Potato Counter"] > 200
            Settings["Potato Counter"] = 0
            Settings["Status"] = "[ Potato Chips ] Status: Grabbing cooked potato chips."
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            HumanoidRootPart.CFrame = CFrame.new(AvailablePot.Position)
            Settings["Status"] = "[ Potato Chips ] Status: Waiting for potato chips to cook."
            repeat
                fireproximityprompt(PotPrompt)
                HumanoidRootPart.CFrame = CFrame.new(AvailablePot.Position)
                Settings["Potato Counter"] += 1
                task.wait(.1)
            until Player:WaitForChild("Backpack"):FindFirstChild("Potato Chips") or Settings["Potato Counter"] > 100

            if Settings["Potato Counter"] > 100 then
                Settings["Potato Counter"] = 0
                for Index, Object in next, Labatory:WaitForChild("Pots"):GetChildren() do
                    HumanoidRootPart.CFrame = CFrame.new(Object.Position)
                    task.wait(.1)
                    for Index = 1,5 do
                        fireproximityprompt(Object.ProximityPrompt)
                        task.wait(.05)
                    end
                    Humanoid:UnequipTools()
                    task.wait(.1)
                    if Player:WaitForChild("Backpack"):FindFirstChild("Potato Chips") then
                        break
                    end
                end
            else
                if Settings["Autofarm Enabled"] ~= true then return end
                Settings["Status"] = "[ Potato Chips ] Status: Turning potato chips into hot chips."
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] == false
                end
                HumanoidRootPart.CFrame = CFrame.new(-36, 4, -24)
                Settings["Status"] = "[ Potato Chips ] Status: Turning potato chips into hot chips."
                task.wait(.5)
                repeat task.wait(); HumanoidRootPart.CFrame = CFrame.new(-36, 4, -24) until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Poor Guy")
                local PoorGuy = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Poor Guy")
                local PoorGuyPrompt = PoorGuy.UpperTorso.ProximityPrompt
                repeat
                    if Settings["IsHealing"] == true then
                        repeat task.wait() until Settings["IsHealing"] == false
                    end
                    HumanoidRootPart.CFrame = CFrame.new(-36, 4, -24)
                    Settings["Status"] = "[ Potato Chips ] Status: Turning potato chips into hot chips."
                    fireproximityprompt(PoorGuyPrompt)
                    task.wait(.05)
                    Settings["Potato Counter"] += 1
                until Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips") or Settings["Potato Counter"] > 160
                Settings["Potato Counter"] = 0
                task.wait(4)

                if Settings["Autofarm Enabled"] ~= true then return end
                local AvailableHomeless = FindAvailableHomeless()
                if #AvailableHomeless == 0 then
                else
                    repeat
                        if #AvailableHomeless == 0 then
                            task.wait()
                        else
                            AvailableHomeless = FindAvailableHomeless()
                            if Settings["Autofarm Enabled"] ~= true then return end
                            Settings["Status"] = "[ Potato Chips ] Status: Giving hot chips to homeless."
                            local Homeless = AvailableHomeless[Random:NextInteger(1, #AvailableHomeless)]
                            if Homeless ~= nil then
                                repeat task.wait() until Homeless:FindFirstChild("UpperTorso")
                                local UpperTorso = Homeless:WaitForChild("UpperTorso")
                                if Settings["IsHealing"] == true then
                                    repeat task.wait() until Settings["IsHealing"] == false
                                end
                                HumanoidRootPart.CFrame = CFrame.new(UpperTorso.Position)
                                Settings["Status"] = "[ Potato Chips ] Status: Giving hot chips to homeless."
                                task.wait(.25)
                                repeat
                                    if Settings["Autofarm Enabled"] ~= true then return end
                                    if Settings["IsHealing"] == true then
                                        repeat task.wait() until Settings["IsHealing"] == false
                                    end
                                    HumanoidRootPart.CFrame = CFrame.new(UpperTorso.Position)
                                    task.wait()
                                until workspace:WaitForChild("Folders").HomelessPeople:FindFirstChild(tostring(Homeless))

                                Homeless = workspace:WaitForChild("Folders").HomelessPeople:FindFirstChild(tostring(Homeless))
                                UpperTorso = Homeless:FindFirstChild("UpperTorso")
                                local UpperTorsoPrompt = UpperTorso.ProximityPrompt
                                if Settings["Autofarm Enabled"] ~= true then return end
                                Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips"))
                                task.wait(.1)
                                if Settings["Autofarm Enabled"] ~= true then return end
                                Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips"))
                                if Settings["IsHealing"] == true then
                                    repeat task.wait() until Settings["IsHealing"] == false
                                end
                                HumanoidRootPart.CFrame = CFrame.new(UpperTorso.Position)
                                Settings["Status"] = "[ Potato Chips ] Status: Giving hot chips to homeless."
                                for Index = 1,4 do
                                    if Settings["Autofarm Enabled"] ~= true then return end
                                    if Settings["IsHealing"] == true then
                                        repeat task.wait() until Settings["IsHealing"] == false
                                    end
                                    HumanoidRootPart.CFrame = CFrame.new(UpperTorso.Position)
                                    Settings["Status"] = "[ Potato Chips ] Status: Giving hot chips to homeless."
                                    fireproximityprompt(UpperTorsoPrompt)
                                    task.wait(.1)
                                end
                            end
                            task.wait(.1)
                            Humanoid:UnequipTools()
                            task.wait(.05)
                            Settings["Potato Counter"] += 1
                        end
                    until #AvailableHomeless == 0 or not Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips") or Settings["Potato Counter"] > 10
                    Settings["Potato Counter"] = 0
                    PotatoChipsSold += 1
                end
                task.wait(.5)
            end
        else
            Settings["Status"] = "[ Potato Chips ] Status: Potato Chips failed, pot was never found, skipping."
            task.wait(.5)
        end
    end

    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." then
        DoChipMarsh()
    else
        Settings["Status"] = "[ Cards ] Status: Card application successful, waiting for a response from the system."
        local function DoCards()
            if Settings["Autofarm Enabled"] ~= true then return end
            Settings["Status"] = "[ Cards ] Status: Attempting to claim card."
            local Card = workspace:WaitForChild("CardPickup")
            local CardPrompt = Card.Attachment.ProximityPrompt
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] == false
            end
            HumanoidRootPart.CFrame = CFrame.new(Card.Position)
            Settings["Status"] = "[ Cards ] Status: Attempting to claim card."
            task.wait(.5)
            repeat
                if Settings["Autofarm Enabled"] ~= true then return end
                HumanoidRootPart.CFrame = CFrame.new(Card.Position)
                CardPrompt = Card.Attachment.ProximityPrompt
                fireproximityprompt(CardPrompt)
                task.wait(.05)
            until Player:WaitForChild("Backpack"):FindFirstChild("Card") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are not on the wait list for a card."
            if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are not on the wait list for a card." and not Player:WaitForChild("Backpack"):FindFirstChild("Card") then
            else
                task.wait(2)
                repeat
                    local ATM = FindAvailableATMs()
                    if ATM ~= nil then
                        Settings["Status"] = "[ Cards ] Status: Attempting to use blank card."
                        local ATMPrompt = ATM.Attachment.ProximityPrompt
                        if Settings["Autofarm Enabled"] ~= true then return end
                        if Settings["IsHealing"] == true then
                            repeat task.wait() until Settings["IsHealing"] == false
                        end
                        HumanoidRootPart.CFrame = CFrame.new(ATM.Position)
                        Settings["Status"] = "[ Cards ] Status: Attempting to use blank card."
                        if PlayerGui:WaitForChild("Main"):FindFirstChild("ATM") then
                            PlayerGui:WaitForChild("Main"):FindFirstChild("ATM"):Destroy()
                        end
                        task.wait(.75)
                        repeat
                            if Settings["Autofarm Enabled"] ~= true then return end
                            if Settings["IsHealing"] == true then
                                repeat task.wait() until Settings["IsHealing"] == false
                            end
                            HumanoidRootPart.CFrame = CFrame.new(ATM.Position)
                            Settings["Status"] = "[ Cards ] Status: Attempting to use blank card."
                            fireproximityprompt(ATMPrompt)
                            task.wait(.1)
                        until PlayerGui:FindFirstChild("ATM")
                        task.wait(.1)
                        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Card"))
                        task.wait(.25)
                        if Settings["Autofarm Enabled"] ~= true then return end
                        replicatesignal(PlayerGui:WaitForChild("ATM").Frame.Swipe.MouseButton1Click, Player)
                    else
                        Settings["Status"] = "[ Cards ] Status: No available ATM, skipping cards."
                    end
                    task.wait(.1)
                    Humanoid:UnequipTools()
                    task.wait(.1)
                until not Player:WaitForChild("Backpack"):FindFirstChild("Card") or Settings["Status"] == "[ Cards ] Status: No available ATM, skipping cards."
                if Settings["Status"] == "[ Cards ] Status: No available ATM, skipping cards." then
                    CardsDone += 1
                else
                    CardsDone += 1
                end
            end
        end
        if Settings["Cards Counter"] == 1 then
            DoChipMarsh()
            DoCards()
            Settings["Cards Counter"] = 0
        else
            task.wait(25)
            DoCards()
            DoChipMarsh()
        end
    end
    Cycles += 1
    MainAutofarm()
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Auto Farm Hub",
   Icon = 0, 
   LoadingTitle = "Auto Farm Hub",
   LoadingSubtitle = "by T and Logan",
   ShowText = "South Bronx", 
   Theme = "Default", 

   ToggleUIKeybind = "Z",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "SBAutoFarmHub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"}
   }
})

local Tab = Window:CreateTab("Autofarm", 4483362458)
local Section = Tab:CreateSection("Autofarm")

local Toggle = Tab:CreateToggle({
   Name = "Autofarming",
   CurrentValue = true,
   Flag = "Toggle1",
   Callback = function(Value)
    Settings["Autofarm Enabled"] = Value
   end,
})

local Toggle2 = Tab:CreateToggle({
   Name = "Auto-crouch",
   CurrentValue = false,
   Flag = "Toggle2",
   Callback = function(Value)
    Settings['Autocrouch Enabled'] = Value
   end,
})

local Button = Tab:CreateButton({
   Name = "Start Autofarm",
   Callback = function()
    MainAutofarm()
   end,
})

local Section2 = Tab:CreateSection("Goal System")
local Toggle = Tab:CreateToggle({
   Name = "Goal Cash System",
   CurrentValue = false,
   Flag = "Toggle3",
   Callback = function(Value)
    GoalCashSettings["GoalCash"] = Value
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Goal Cash Memory",
   CurrentValue = false,
   Flag = "Toggle4",
   Callback = function(Value)
    GoalCashSettings["SaveGoalCashOnExit"] = Value
   end,
})
local Slider = Tab:CreateSlider({
   Name = "Target Cash",
   Range = {0, 1750000},
   Increment = 2500,
   Suffix = "Goal",
   CurrentValue = 250000,
   Flag = "Slider1",
   Callback = function(Value)
    GoalCashSettings["GoalAmount"] = Value
   end,
})

local Paragraph = Tab:CreateParagraph({Title = "Status Information", Content = "[ Startup ] Status: none"})
local Paragraph2 = Tab:CreateParagraph({Title = "Runtime Information", Content = "Runtime: nil  |  Cycle: nil  |  Money Made: nil"})
local Paragraph3 = Tab:CreateParagraph({Title = "Sold Information", Content = "Potato Chips Fed: nil | Marshmallows Sold: nil | Credit Cards Used: nil"})
local Paragraph4 = Tab:CreateParagraph({Title = "Hourly Rate Information", Content = "Hourly Rate: nil"})

task.spawn(function()
    while task.wait() do
        Runtime = os.clock() - Now
        Information = "Runtime: " .. tostring(math.floor(Runtime)) .. " seconds  |  Cycle: " .. tostring(Cycles) .. "  |  Money Made: " .. tostring(GetCommaValue(MoneyDifference)) .. " Cash"
        SellInfo = "Potato Chips Fed: " .. PotatoChipsSold .. " | Marshmallows Sold: " .. MarshmallowSold .. " | Credit Cards Used: " .. CardsDone
        HourlyRate = "Hourly Rate: " .. tostring(GetCommaValue(math.floor(3600/math.floor(Runtime) * MoneyDifference))) .. " Cash"
        HourlyRate2 = tostring(math.floor(3600/math.floor(Runtime) * MoneyDifference))
        Paragraph:Set({Title = "Status Information", Content = Settings["Status"]})
        Paragraph2:Set({Title = "Runtime Information", Content = Information})
        Paragraph3:Set({Title = "Sold Information", Content = SellInfo})
        Paragraph4:Set({Title = "Hourly Rate Information", Content = HourlyRate})
    end
end)

task.spawn(function()
    Player.CharacterAdded:Connect(function()
        Character = Player.Character
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    end)
end)

PurchaseSkiMask()
Settings['Autocrouch Enabled'] = false
if Settings["IsHealing"] == true then
    repeat task.wait() until Settings["IsHealing"] == false
end
local StartMarshmallowfarm = StartMarshmallowFarm()
if StartMarshmallowfarm == true then
    Settings["Status"] = "[ Startup ] Status: Apartment found."
else
    Settings["Status"] = "[ Startup ] Status: Apartment not found, waiting."
    repeat 
        StartMarshmallowfarm = StartMarshmallowFarm() 
        task.wait(.25) 
    until StartMarshmallowfarm == true
    Settings["Status"] = "[ Startup ] Status: Apartment found."
end

writefile("AutorejoinerTXT.txt", "true")
task.wait(.25)
if readfile("AutorejoinerTXT.txt") == "true" then
    local Player = game.Players.LocalPlayer
    local PlayerGui = Player.PlayerGui
    repeat task.wait() until PlayerGui:FindFirstChild("IntroUI") or PlayerGui:FindFirstChild("Main")
    if PlayerGui:FindFirstChild("Main").Enabled == true then
        MainAutofarm()
        return
    end
    repeat
        mousemoveabs(425, 625)
        VIP:SendMouseButtonEvent(425, 625, 1, true, nil, 1)
        VIP:SendMouseButtonEvent(425, 625, 1, false, nil, 1)
        task.wait(.1)
        mousemoveabs(430, 625)
        VIP:SendMouseButtonEvent(430, 625, 1, true, nil, 1)
        VIP:SendMouseButtonEvent(430, 625, 1, false, nil, 1)
        task.wait(.1)
        mouse1click()
        VIP:SendMouseButtonEvent(430, 625, 1, true, nil, 1)
        VIP:SendMouseButtonEvent(430, 625, 1, false, nil, 1)
    until not PlayerGui:FindFirstChild("IntroUI")
    MainAutofarm()
    return
end

LogService.MessageOut:Connect(function(Message, MessageType)
    if MessageType == Enum.MessageType.MessageError then
        if tostring(Message):match("Server Kick Message:") then
            if Settings["Autofarm Enabled"] ~= true then return end
            if Settings["Auto Rejoin"] ~= true then return end
            writefile("AutorejoinerTXT.txt", "true")
            GoalCashSettings["SaveGoalCashOnExit"] = true
            task.wait(.1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Autoexecute.lua"))()
        end
    end
end)
end)
