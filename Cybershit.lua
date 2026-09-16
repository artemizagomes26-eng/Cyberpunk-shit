-- Fake Desync Cheat V102 (Priority Render Fix + Absolute Accuracy)
if not game:IsLoaded() then game.Loaded:Wait() end
pcall(function() setfpscap(999) end) -- Unlock FPS

-- === SERVICES ===
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = Workspace.CurrentCamera
local DISCORD_LINK = "https://discord.gg/6Y7a8nVXEv"
local troll = "https://www.pornhub.com/model/candy-love"
-- Fonction sÃ©curisÃ©e pour copier dans le presse-papiers
local function copyToClipboard(str)
    if setclipboard then
        setclipboard(str)
        return true
    elseif toclipboard then
        toclipboard(str)
        return true
    end
    return false
end

local function SendNotification(text, duration)
    task.spawn(function()
        local NotifGui = Instance.new("ScreenGui")
        NotifGui.Name = "CyberpunksNotification"
        pcall(function() NotifGui.Parent = CoreGui end)
        if not NotifGui.Parent then NotifGui.Parent = player:WaitForChild("PlayerGui") end
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 130, 0, 40)
        Frame.Position = UDim2.new(1, 270, 1, -60)
        Frame.BackgroundColor3 = Color3.fromRGB(128, 10, 50)
        Frame.BackgroundTransparency = 0.25
        Frame.BorderSizePixel = 0
        Frame.Parent = NotifGui
        
        local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 4) Corner.Parent = Frame
        local Stroke = Instance.new("UIStroke") Stroke.Color = Color3.fromRGB(255, 255, 255) Stroke.Thickness = 1 Stroke.Transparency = 0.8 Stroke.Parent = Frame
        
        local Accent = Instance.new("Frame")
        Accent.Size = UDim2.new(0, 2, 0.6, 0)
        Accent.Position = UDim2.new(0, 6, 0.2, 0)
        Accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Accent.BorderSizePixel = 0
        Accent.Parent = Frame
        local ACorner = Instance.new("UICorner") ACorner.CornerRadius = UDim.new(1, 0) ACorner.Parent = Accent
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -25, 1, 0)
        Label.Position = UDim2.new(0, 18, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(240, 240, 240)
        Label.Font = Enum.Font.GothamMedium
        Label.TextSize = 10
        Label.TextWrapped = true
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Frame
        
        TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -280, 1, -60)}):Play()
        task.wait(duration)
        local tween = TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 270, 1, -60)})
        tween:Play()
        tween.Completed:Wait()
        NotifGui:Destroy()
    end)
end

local PartViewerEnabled = false

local function StartPartViewer()
    PartViewerEnabled = true
    SendNotification("Part Viewer started! Check F9 console for object names", 5)
    
    task.spawn(function()
        while PartViewerEnabled do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Tool") then
                    print("[PART VIEWER] Tool: " .. v.Name .. " | Parent: " .. v.Parent.Name .. " | ToolTip: " .. (v.ToolTip or "None"))
                elseif v:IsA("Model") and v:FindFirstChild("Handle") then
                    print("[PART VIEWER] Model with Handle: " .. v.Name .. " | Parent: " .. v.Parent.Name)
                end
            end
            task.wait(5) -- Print every 5 seconds
        end
    end)
end

local function StopPartViewer()
    PartViewerEnabled = false
    SendNotification("Part Viewer stopped", 3)
end

local function CreateConfirmationPrompt(text, jobId, placeId, onYes, onNo)
    task.spawn(function()
        local ConfirmGui = Instance.new("ScreenGui")
        ConfirmGui.Name = "CyberpunksConfirm"
        pcall(function() ConfirmGui.Parent = CoreGui end)
        if not ConfirmGui.Parent then ConfirmGui.Parent = player:WaitForChild("PlayerGui") end
        
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0, 300, 0, 150)
        Frame.Position = UDim2.new(0.5, -150, 0.5, -60)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        Frame.BorderSizePixel = 0
        Frame.Parent = ConfirmGui
        
        local Corner = Instance.new("UICorner") Corner.CornerRadius = UDim.new(0, 6) Corner.Parent = Frame
        local Stroke = Instance.new("UIStroke") Stroke.Color = Color3.fromRGB(40, 40, 50) Stroke.Thickness = 1 Stroke.Parent = Frame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -20, 0, 60)
        Label.Position = UDim2.new(0, 10, 0, 10)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 12
        Label.TextWrapped = true
        Label.Parent = Frame
        
        local YesBtn = Instance.new("TextButton")
        YesBtn.Size = UDim2.new(0.4, 0, 0, 30)
        YesBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
        YesBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        YesBtn.Text = "YES"
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.Font = Enum.Font.GothamBold
        YesBtn.TextSize = 10
        YesBtn.Parent = Frame
        local YCorner = Instance.new("UICorner") YCorner.CornerRadius = UDim.new(0, 4) YCorner.Parent = YesBtn
        
        local NoBtn = Instance.new("TextButton")
        NoBtn.Size = UDim2.new(0.4, 0, 0, 30)
        NoBtn.Position = UDim2.new(0.55, 0, 0.75, 0)
        NoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        NoBtn.Text = "NO"
        NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        NoBtn.Font = Enum.Font.GothamBold
        NoBtn.TextSize = 10
        NoBtn.Parent = Frame
        local NCorner = Instance.new("UICorner") NCorner.CornerRadius = UDim.new(0, 4) NCorner.Parent = NoBtn
        
        local CopyIdBtn = Instance.new("TextButton")
        CopyIdBtn.Size = UDim2.new(0.25, 0, 0, 20)
        CopyIdBtn.Position = UDim2.new(0.2, 0, 0.55, 0)
        CopyIdBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        CopyIdBtn.Text = "COPY ID"
        CopyIdBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        CopyIdBtn.Font = Enum.Font.GothamBold
        CopyIdBtn.TextSize = 8
        CopyIdBtn.Parent = Frame
        local CICorner = Instance.new("UICorner") CICorner.CornerRadius = UDim.new(0, 4) CICorner.Parent = CopyIdBtn
        
        CopyIdBtn.MouseButton1Click:Connect(function()
            if setclipboard then setclipboard(jobId) end
            CopyIdBtn.Text = "COPIED!"
            task.wait(1)
            CopyIdBtn.Text = "COPY ID"
        end)

        local CopyScriptBtn = Instance.new("TextButton")
        CopyScriptBtn.Size = UDim2.new(0.25, 0, 0, 20)
        CopyScriptBtn.Position = UDim2.new(0.55, 0, 0.55, 0)
        CopyScriptBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        CopyScriptBtn.Text = "COPY SCRIPT"
        CopyScriptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        CopyScriptBtn.Font = Enum.Font.GothamBold
        CopyScriptBtn.TextSize = 8
        CopyScriptBtn.Parent = Frame
        local CSCorner = Instance.new("UICorner") CSCorner.CornerRadius = UDim.new(0, 4) CSCorner.Parent = CopyScriptBtn
        
        CopyScriptBtn.MouseButton1Click:Connect(function()
            local scriptTxt = string.format('game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)', tostring(placeId), tostring(jobId))
            if setclipboard then setclipboard(scriptTxt) end
            CopyScriptBtn.Text = "COPIED!"
            task.wait(1)
            CopyScriptBtn.Text = "COPY SCRIPT"
        end)

        YesBtn.MouseButton1Click:Connect(function()
            if onYes then onYes() end
            ConfirmGui:Destroy()
        end)
        
        NoBtn.MouseButton1Click:Connect(function()
            if onNo then onNo() end
            ConfirmGui:Destroy()
        end)
    end)
end
local ShowKeySystem -- Forward declaration
-- === EXTERNAL HELPER FUNCTIONS (To reduce StartCheat locals) ===
local function RandomNumberRange(a)
    return math.random(-a * 100, a * 100) / 100
end

local function ApplyDescriptionCustom(humanoid, description)
    local character = humanoid.Parent
    if not character then return end
    
    -- 1. Body Colors
    local bodyColors = character:FindFirstChildOfClass("BodyColors")
    if not bodyColors then
        bodyColors = Instance.new("BodyColors")
        bodyColors.Name = "Body Colors"
        bodyColors.Parent = character
    end
    bodyColors.HeadColor3 = description.HeadColor
    bodyColors.TorsoColor3 = description.TorsoColor
    bodyColors.LeftArmColor3 = description.LeftArmColor
    bodyColors.RightArmColor3 = description.RightArmColor
    bodyColors.LeftLegColor3 = description.LeftLegColor
    bodyColors.RightLegColor3 = description.RightLegColor
    
    -- 2. Clothing
    local function updateClothing(className, propName, id)
        if id and id > 0 then
            task.spawn(function()
                local success, result = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
                if success and result then
                    for _, obj in pairs(result) do
                        if obj:IsA(className) then
                            local item = character:FindFirstChildOfClass(className)
                            if not item then
                                item = Instance.new(className)
                                item.Parent = character
                            end
                            item[propName] = obj[propName]
                            break
                        end
                    end
                end
            end)
        else
            local item = character:FindFirstChildOfClass(className)
            if item then item:Destroy() end
        end
    end
    
    updateClothing("Shirt", "ShirtTemplate", description.Shirt)
    updateClothing("Pants", "PantsTemplate", description.Pants)
    updateClothing("ShirtGraphic", "Graphic", description.GraphicTShirt)
    
    -- 3. Face
    local head = character:FindFirstChild("Head")
    if head then
        local face = head:FindFirstChildOfClass("Decal")
        if description.Face and description.Face > 0 then
            if not face then
                face = Instance.new("Decal")
                face.Name = "face"
                face.Parent = head
            end
            face.Texture = "rbxassetid://" .. description.Face
        else
            if face then face:Destroy() end
        end
    end
    
    -- 4. Accessories
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Accessory") then v:Destroy() end
    end
    
    local function loadAccessories(ids)
        if not ids or ids == "" then return end
        for id in string.gmatch(ids, "([^,]+)") do
            local assetId = tonumber(id)
            if assetId then
                task.spawn(function()
                    local success, result = pcall(function() return game:GetObjects("rbxassetid://" .. assetId) end)
                    if success and result then
                        for _, obj in pairs(result) do
                            if obj:IsA("Accessory") then obj.Parent = character end
                        end
                    end
                end)
            end
        end
    end
    
    loadAccessories(description.HatAccessory)
    loadAccessories(description.HairAccessory)
    loadAccessories(description.FaceAccessory)
    loadAccessories(description.NeckAccessory)
    loadAccessories(description.ShouldersAccessory)
    loadAccessories(description.FrontAccessory)
    loadAccessories(description.BackAccessory)
    loadAccessories(description.WaistAccessory)
    
    -- 5. Body Parts (R6 & R15)
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("CharacterMesh") then v:Destroy() end
    end
    
    local function loadBodyParts(id)
        if not id or id == 0 then return end
        task.spawn(function()
            local success, result = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
            if success and result then
                for _, obj in pairs(result) do
                    local function recurse(item)
                        if item:IsA("CharacterMesh") then
                            item.Parent = character
                        elseif item:IsA("MeshPart") and humanoid.RigType == Enum.HumanoidRigType.R15 then
                            local charPart = character:FindFirstChild(item.Name)
                            if charPart and charPart:IsA("MeshPart") then
                                pcall(function() charPart.MeshId = item.MeshId end)
                                pcall(function() charPart.TextureID = item.TextureID end)
                                pcall(function() charPart.Size = item.Size end)
                            end
                        end
                        for _, child in pairs(item:GetChildren()) do
                            recurse(child)
                        end
                    end
                    recurse(obj)
                end
            end
        end)
    end
    
    loadBodyParts(description.Head)
    loadBodyParts(description.Torso)
    loadBodyParts(description.LeftArm)
    loadBodyParts(description.RightArm)
    loadBodyParts(description.LeftLeg)
    loadBodyParts(description.RightLeg)
    
    -- 6. Scales
    local function updateScale(name, val)
        if not val then return end
        local valObj = humanoid:FindFirstChild(name)
        if not valObj then
            valObj = Instance.new("NumberValue")
            valObj.Name = name
            valObj.Parent = humanoid
        end
        valObj.Value = val
    end
    
    updateScale("BodyHeightScale", description.HeightScale)
    updateScale("BodyWidthScale", description.WidthScale)
    updateScale("BodyDepthScale", description.DepthScale)
    updateScale("HeadScale", description.HeadScale)
    updateScale("BodyProportionScale", description.ProportionScale)
    updateScale("BodyTypeScale", description.BodyTypeScale)
end

local function disableDamageBlock(part)
    if part:IsA("BasePart") then
        local name = part.Name:lower()
        local parentName = part.Parent and part.Parent.Name:lower() or ""
        local shouldDisable = false
        
        -- Detect Damage Zones (Expanded Keywords + Parent Check)
        local damageKeywords = {"lava", "magma", "acid", "water", "damage", "burn", "kill", "death", "hurt", "void", "spike", "fire", "flame", "trap", "laser"}
        for _, kw in pairs(damageKeywords) do
            if (string.find(name, kw) or string.find(parentName, kw)) and not string.find(name, "safe") and not string.find(name, "spawn") then
                shouldDisable = true
                break
            end
        end
        
        if part.Material == Enum.Material.CrackedLava or part.Material == Enum.Material.Water then shouldDisable = true end
        
        -- Check Children (Textures/Decals) as requested by user
        if not shouldDisable then
            for _, child in pairs(part:GetChildren()) do
                if child:IsA("Texture") or child:IsA("Decal") then
                    local texName = child.Name:lower()
                    for _, kw in pairs(damageKeywords) do
                        if string.find(texName, kw) then shouldDisable = true break end
                    end
                end
                if shouldDisable then break end
            end
        end
        
        if shouldDisable then
            pcall(function()
                part.CanTouch = false
                part.Material = Enum.Material.Plastic -- Bypass FloorMaterial checks
                part.Name = "SafeZone_Bypassed" -- Bypass Name checks
                if part:FindFirstChildOfClass("TouchInterest") then
                    part:FindFirstChildOfClass("TouchInterest"):Destroy()
                end
            end)
        end
    end
end

-- ==================================================================
--                          MAIN CHEAT FUNCTION
-- ==================================================================

local function StartCheat(keyDuration, keyString, isWhitelisted)
    -- === CONFIGURATION ===
    
    -- Forward declaration pour Ã©viter les erreurs de scope dans les hooks
    local getClosestPlayerToMouse

    local Config = {
        IsRunning = true,
        IsWhitelisted = isWhitelisted,
        IsAdmin = true,
        -- Anti Buddha / Desync
        MasterSwitch = true,
        
        -- Settings / Mods
        SpeedKey = Enum.KeyCode.Unknown, -- Attention: V est aussi une macro key
        StandardFlyKey = Enum.KeyCode.Unknown,
        
        SpeedHack = false,
        Zoom = 10000,
        WalkSpeedValue = 0,
        JumpPowerValue = 0,
        
        StandardFly = true,
        FlySpeedValue = 82, -- Max 75
        
        InfJump = true,
        
        -- Players Tab (Aim Lock & Kill Aura & NoClip)
        LockKey = Enum.KeyCode.Unknown,
        EasyLock = false,
        FollowDistance = 0,
        TargetName = "None",
        
        KillAura = false,
        AuraRange = 15000,
        TeamCheck = false,
        
        NoClip = true,
        AntiLava = true,
        WalkWater = true,
        AntiChair = true,
        AntiStun = true,
        FastM1Auto = true,
              
        InstantRespawn = false,
        AirFlashStep = false,
        AirFlashStepRange = 200,
        
        InfiniteFlashStep = false,
        
        -- Ice Water (WaterWalking attribute)
        IceWater = false,
        
        -- Unbreakable All
        UnbreakableAll = true,
        
        -- Orbit Player
        OrbitPlayer = false,
        OrbitPlayerKey = Enum.KeyCode.Unknown,
        OrbitPlayerTarget = "",
        
        FakeLag = false,
        FakeLagKey = Enum.KeyCode.Unknown,
        
        -- Visuals (ESP)
        ESPBox = false,
        ESPName = false,
        ESPLvl = false,
        ESPHP = false,
        ESPChams = false,
        ESPDot = false,
        ESPNPC = false,
        ESPTracers = false,
        ESPFruit = false,
        PotatoGraphics = false,
        FOVValue = 100,
        RemoveFog = false,
        NoAnim = true,
        ESPSize = 10,
        ESPColorR = 255,
        ESPColorG = 255,
        ESPColorB = 255,
        CustomCursorId = "",
        CursorName = "",
        InspectorName = "",
        ShowMoney = false,
        ShowFragments = false,
        ShowBounty = false,
        
        -- Server Stats
        ShowFPS = false,
        ShowPing = false,
        ShowUptime = false,
        ShowServer = false,
        
        -- Hitbox Preset
        HitboxPreset = false,
        TorsoSize = 0,
        
        -- Trigger Bot & Silent Aim
        TriggerBot = false,
        TriggerDistance = 0,
        
        SilentAim = false,
        SilentFOV = 0,
        SilentRange = 0,
        ShowFOV = false,
        SilentAimKey = Enum.KeyCode.Unknown, -- Touche de Lock
        
        -- Hitbox Extender
        HitboxExpander = false,
        HitboxSize = 300,
        HitboxTransparency = 1,
       
