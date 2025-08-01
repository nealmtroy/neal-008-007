local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NEALMTROY_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

-- Main Frame - posisi lebih ke atas
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.05, 0, 0.02, 0)  -- Lebih ke atas
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.BorderSizePixel = 0

-- Add corner radius for modern look
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Title Text
local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Text = "NEALMTROY"
TitleText.TextColor3 = Color3.fromRGB(100, 150, 255)
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Scaling
local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = 0.8

-- Scale Controls in Title Bar
local scaleLabel = Instance.new("TextLabel", TitleBar)
scaleLabel.Text = "Scale"
scaleLabel.TextColor3 = Color3.new(1,1,1)
scaleLabel.Size = UDim2.new(0, 40, 0, 20)
scaleLabel.Position = UDim2.new(0, 200, 0, 10)
scaleLabel.BackgroundTransparency = 1
scaleLabel.Font = Enum.Font.Gotham
scaleLabel.TextSize = 12

local scaleSlider = Instance.new("TextBox", TitleBar)
scaleSlider.Text = "80"
scaleSlider.Size = UDim2.new(0, 35, 0, 20)
scaleSlider.Position = UDim2.new(0, 245, 0, 10)
scaleSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scaleSlider.TextColor3 = Color3.new(1,1,1)
scaleSlider.Font = Enum.Font.Gotham
scaleSlider.TextSize = 11
scaleSlider.BorderSizePixel = 0

local scaleCorner = Instance.new("UICorner")
scaleCorner.CornerRadius = UDim.new(0, 4)
scaleCorner.Parent = scaleSlider

scaleSlider.FocusLost:Connect(function()
    local val = tonumber(scaleSlider.Text)
    if val and val >= 50 and val <= 100 then
        UIScale.Scale = val / 100
    end
end)

-- Minimize/Expand Button
local minimized = false
local toggleButton = Instance.new("TextButton", TitleBar)
toggleButton.Text = "−"
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -35, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.BorderSizePixel = 0

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleButton

-- Content Container (everything except title bar)
local ContentContainer = Instance.new("Frame", MainFrame)
ContentContainer.Position = UDim2.new(0, 0, 0, 40)
ContentContainer.Size = UDim2.new(1, 0, 1, -40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0

toggleButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    if minimized then
        -- Full minimize - hide everything except + button
        toggleButton.Text = "+"
        TitleText.Visible = false
        scaleLabel.Visible = false
        scaleSlider.Visible = false
        ContentContainer.Visible = false
        TitleBar.BackgroundTransparency = 1
        MainFrame.BackgroundTransparency = 1
        
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 35, 0, 35)
        })
        tween:Play()
        
        -- Reposition toggle button to center
        toggleButton.Position = UDim2.new(0, 2.5, 0, 2.5)
        
    else
        -- Full expand - show everything
        toggleButton.Text = "−"
        TitleText.Visible = true
        scaleLabel.Visible = true
        scaleSlider.Visible = true
        ContentContainer.Visible = true
        TitleBar.BackgroundTransparency = 0
        MainFrame.BackgroundTransparency = 0
        
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 400)
        })
        tween:Play()
        
        -- Reset toggle button position
        toggleButton.Position = UDim2.new(1, -35, 0, 5)
    end
end)

-- Sidebar (Menu)
local menuFrame = Instance.new("Frame", ContentContainer)
menuFrame.Position = UDim2.new(0, 0, 0, 0)
menuFrame.Size = UDim2.new(0, 120, 1, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menuFrame.BorderSizePixel = 0

-- Content Frame
local contentFrame = Instance.new("Frame", ContentContainer)
contentFrame.Position = UDim2.new(0, 120, 0, 0)
contentFrame.Size = UDim2.new(1, -120, 1, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentFrame.BorderSizePixel = 0

-- Utility to create menu button
local function createMenuButton(name, order)
    local btn = Instance.new("TextButton", menuFrame)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, 30 * order)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    return btn
end

-- Tabs table
local tabs = {}

-- Utility to create tab content
local function createTabContent(name)
    local tab = Instance.new("Frame", contentFrame)
    tab.Name = name
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    tabs[name] = tab
    return tab
end

-- Show Tab
local function showTab(name)
    for tabName, frame in pairs(tabs) do
        frame.Visible = (tabName == name)
    end
end

-- Utility to create styled button
local function createStyledButton(parent, text, position, size)
    local btn = Instance.new("TextButton", parent)
    btn.Size = size or UDim2.new(0, 180, 0, 30)
    btn.Position = position
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    return btn
end

-- PLAYER Tab
local playerBtn = createMenuButton("Player", 0)
local playerTab = createTabContent("Player")

-- Speed
local speedLevel = 1
local speedBtnTog = createStyledButton(playerTab, "Speed: x1", UDim2.new(0, 10, 0, 10))

speedBtnTog.MouseButton1Click:Connect(function()
    speedLevel += 1
    if speedLevel > 5 then speedLevel = 1 end
    speedBtnTog.Text = "Speed: x" .. speedLevel
    speedBtnTog.BackgroundColor3 = speedLevel > 1 and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 * speedLevel end
end)

-- Jump
local jumpLevel = 1
local jumpBtnTog = createStyledButton(playerTab, "Jump: x1", UDim2.new(0, 10, 0, 45))

jumpBtnTog.MouseButton1Click:Connect(function()
    jumpLevel += 1
    if jumpLevel > 5 then jumpLevel = 1 end
    jumpBtnTog.Text = "Jump: x" .. jumpLevel
    jumpBtnTog.BackgroundColor3 = jumpLevel > 1 and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 50 * jumpLevel end
end)

-- God Mode
local godOn = false
local godBtnTog = createStyledButton(playerTab, "God Mode: OFF", UDim2.new(0, 10, 0, 80))

godBtnTog.MouseButton1Click:Connect(function()
    godOn = not godOn
    godBtnTog.Text = godOn and "God Mode: ON" or "God Mode: OFF"
    godBtnTog.BackgroundColor3 = godOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if godOn then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
        else
            hum.MaxHealth = 100
            hum.Health = 100
        end
    end
end)

-- Auto Hunger & Thirst
local autoHungerThirstOn = false
local hungerThirstConnection = nil
local hungerBtnTog = createStyledButton(playerTab, "Auto Hunger & Thirst: OFF", UDim2.new(0, 10, 0, 115))

local function toggleAutoHungerThirst()
    autoHungerThirstOn = not autoHungerThirstOn
    hungerBtnTog.Text = autoHungerThirstOn and "Auto Hunger & Thirst: ON" or "Auto Hunger & Thirst: OFF"
    hungerBtnTog.BackgroundColor3 = autoHungerThirstOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if autoHungerThirstOn then
        hungerThirstConnection = RunService.Heartbeat:Connect(function()
            local statNames = {"Hunger", "Thirst", "hunger", "thirst", "Food", "Water", "food", "water"}
            for _, statName in pairs(statNames) do
                local stat = player:FindFirstChild(statName)
                if stat then
                    if stat:IsA("NumberValue") or stat:IsA("IntValue") then
                        stat.Value = stat:GetAttribute("MaxValue") or 100
                    elseif stat:IsA("Folder") or stat:IsA("Configuration") then
                        local valueObj = stat:FindFirstChild("Value")
                        if valueObj and (valueObj:IsA("NumberValue") or valueObj:IsA("IntValue")) then
                            valueObj.Value = valueObj:GetAttribute("MaxValue") or 100
                        end
                    end
                end
            end
        end)
    else
        if hungerThirstConnection then
            hungerThirstConnection:Disconnect()
            hungerThirstConnection = nil
        end
    end
end

hungerBtnTog.MouseButton1Click:Connect(toggleAutoHungerThirst)

-- Manual Restore
local manualRestoreBtn = createStyledButton(playerTab, "Manual Restore", UDim2.new(0, 10, 0, 150))

manualRestoreBtn.MouseButton1Click:Connect(function()
    local statNames = {"Hunger", "Thirst", "hunger", "thirst", "Food", "Water", "food", "water"}
    for _, statName in pairs(statNames) do
        local stat = player:FindFirstChild(statName)
        if stat and (stat:IsA("NumberValue") or stat:IsA("IntValue")) then
            stat.Value = stat:GetAttribute("MaxValue") or 100
        end
    end
    manualRestoreBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    wait(0.2)
    manualRestoreBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
end)

-- Noclip
local noclipOn = false
local noclipBtnTog = createStyledButton(playerTab, "Noclip: OFF", UDim2.new(0, 10, 0, 185))
local noclipConnection = nil

local function toggleNoclip()
    noclipOn = not noclipOn
    noclipBtnTog.Text = noclipOn and "Noclip: ON" or "Noclip: OFF"
    noclipBtnTog.BackgroundColor3 = noclipOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if noclipOn then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end

noclipBtnTog.MouseButton1Click:Connect(toggleNoclip)

-- Noclip speed control
local noclipSpeed = 1
local noclipSpeedBtn = createStyledButton(playerTab, "Noclip Speed: x1", UDim2.new(0, 10, 0, 220))

noclipSpeedBtn.MouseButton1Click:Connect(function()
    noclipSpeed = noclipSpeed + 1
    if noclipSpeed > 3 then noclipSpeed = 1 end
    
    noclipSpeedBtn.Text = "Noclip Speed: x" .. noclipSpeed
    noclipSpeedBtn.BackgroundColor3 = noclipSpeed > 1 and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
end)

-- Enhanced noclip flight controls
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not noclipOn or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local rootPart = player.Character.HumanoidRootPart
    local speed = 50 * noclipSpeed
    
    if input.KeyCode == Enum.KeyCode.E then
        rootPart.Velocity = rootPart.Velocity + Vector3.new(0, speed, 0)
    elseif input.KeyCode == Enum.KeyCode.Q then
        rootPart.Velocity = rootPart.Velocity + Vector3.new(0, -speed, 0)
    end
end)

-- WALK ON AIR TAB - FIXED VERSION + RIDE PLATFORM
local airBtn = createMenuButton("Walk On Air", 1)
local airTab = createTabContent("Walk On Air")

local airOn = false
local airBtnTog = createStyledButton(airTab, "Walk On Air: OFF", UDim2.new(0, 10, 0, 10))
local airPart = nil

-- Ride Platform Variables
local ridePlatformOn = false
local ridePlatform = nil
local invisibleParts = {}
local platformConnections = {}

airBtnTog.MouseButton1Click:Connect(function()
    airOn = not airOn
    airBtnTog.Text = airOn and "Walk On Air: ON" or "Walk On Air: OFF"
    airBtnTog.BackgroundColor3 = airOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if airOn then
        airPart = Instance.new("Part")
        airPart.Anchored = true
        airPart.Size = Vector3.new(8, 1, 8)
        airPart.Transparency = 1
        airPart.CanCollide = true
        airPart.Parent = workspace
        
        airConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then 
                airPart.Position = hrp.Position - Vector3.new(0, 3.5, 0)
            end
        end)
    else
        if airConnection then airConnection:Disconnect() end
        if airPart then airPart:Destroy() end
    end
end)

-- Ride Platform Toggle Button
local ridePlatformBtnTog = createStyledButton(airTab, "Ride Platform: OFF", UDim2.new(0, 10, 0, 50))

ridePlatformBtnTog.MouseButton1Click:Connect(function()
    ridePlatformOn = not ridePlatformOn
    ridePlatformBtnTog.Text = ridePlatformOn and "Ride Platform: ON" or "Ride Platform: OFF"
    ridePlatformBtnTog.BackgroundColor3 = ridePlatformOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if ridePlatformOn then
        -- Create Ride Platform (Kasur Terbang)
        if not ridePlatform then
            ridePlatform = Instance.new("Part")
            ridePlatform.Name = "RidePlatform_" .. player.Name
            ridePlatform.Size = Vector3.new(8, 1.5, 8)
            ridePlatform.Anchored = true
            ridePlatform.CanCollide = true
            ridePlatform.Transparency = 0.1
            ridePlatform.Color = Color3.fromRGB(150, 0, 255)
            ridePlatform.Material = Enum.Material.ForceField
            ridePlatform.Parent = workspace
            
            -- Add mesh for style
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.Brick
            mesh.Scale = Vector3.new(1, 0.8, 1)
            mesh.Parent = ridePlatform
            
            -- Create invisible support parts
            invisibleParts = {}
            for i = 1, 4 do
                local invPart = Instance.new("Part")
                invPart.Size = Vector3.new(2, 6, 2)
                invPart.Anchored = true
                invPart.CanCollide = true
                invPart.Transparency = 1
                invPart.Parent = workspace
                invPart.Name = "InvisibleSupport_" .. i
                table.insert(invisibleParts, invPart)
            end
        end
    else
        -- Remove Ride Platform
        if ridePlatform then
            ridePlatform:Destroy()
            ridePlatform = nil
        end
        
        -- Remove invisible parts
        for _, part in pairs(invisibleParts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        invisibleParts = {}
        
        -- Disconnect connections
        for _, connection in pairs(platformConnections) do
            connection:Disconnect()
        end
        platformConnections = {}
    end
end)

-- Platform Height Control
local platformHeight = 2
local heightLabel = Instance.new("TextLabel", airTab)
heightLabel.Size = UDim2.new(0, 80, 0, 20)
heightLabel.Position = UDim2.new(0, 10, 0, 90)
heightLabel.Text = "Height: " .. platformHeight
heightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
heightLabel.BackgroundTransparency = 1
heightLabel.Font = Enum.Font.Gotham
heightLabel.TextSize = 11
heightLabel.TextXAlignment = Enum.TextXAlignment.Left

local heightUpBtn = createStyledButton(airTab, "↑", UDim2.new(0, 30, 0, 20), UDim2.new(0, 30, 0, 20))
heightUpBtn.Position = UDim2.new(0, 90, 0, 90)
heightUpBtn.TextSize = 16

local heightDownBtn = createStyledButton(airTab, "↓", UDim2.new(0, 30, 0, 20), UDim2.new(0, 30, 0, 20))
heightDownBtn.Position = UDim2.new(0, 125, 0, 90)
heightDownBtn.TextSize = 16

heightUpBtn.MouseButton1Click:Connect(function()
    platformHeight = math.min(platformHeight + 0.5, 10)
    heightLabel.Text = "Height: " .. platformHeight
end)

heightDownBtn.MouseButton1Click:Connect(function()
    platformHeight = math.max(platformHeight - 0.5, 0.5)
    heightLabel.Text = "Height: " .. platformHeight
end)

-- Multi Player Toggle
local multiPlayerMode = false
local multiPlayerBtn = createStyledButton(airTab, "Multi-Player: OFF", UDim2.new(0, 10, 0, 120))

multiPlayerBtn.MouseButton1Click:Connect(function()
    multiPlayerMode = not multiPlayerMode
    multiPlayerBtn.Text = multiPlayerMode and "Multi-Player: ON" or "Multi-Player: OFF"
    multiPlayerBtn.BackgroundColor3 = multiPlayerMode and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
end)

-- Enhanced Movement System
RunService.RenderStepped:Connect(function()
    -- Regular Air Walk - Enhanced Jetpack Style
    if airOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and airPart then
        local rootPart = player.Character.HumanoidRootPart
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            -- Position platform below player
            airPart.CFrame = CFrame.new(rootPart.Position.X, rootPart.Position.Y - 3.5, rootPart.Position.Z)
            
            -- Jetpack-style movement without messing with character pose
            if humanoid.Jump then
                -- Smooth upward jetpack movement
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 25, rootPart.Velocity.Z)
                humanoid.Jump = false -- Prevent animation loop
            else
                -- Prevent falling - maintain current Y velocity or set to 0 if falling
                local currentVelocity = rootPart.Velocity
                if currentVelocity.Y < -2 then
                    rootPart.Velocity = Vector3.new(currentVelocity.X, 0, currentVelocity.Z)
                end
            end
        end
    end
    
    -- Ride Platform Movement
    if ridePlatformOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and ridePlatform then
        local hrp = player.Character.HumanoidRootPart
        local pos = hrp.Position - hrp.CFrame.LookVector * 4 - Vector3.new(0, platformHeight, 0)
        ridePlatform.Position = Vector3.new(pos.X, pos.Y, pos.Z)
        ridePlatform.CFrame = CFrame.new(ridePlatform.Position, ridePlatform.Position + hrp.CFrame.LookVector)
        
        -- Update invisible support parts
        if multiPlayerMode and #invisibleParts > 0 then
            local corners = {
                Vector3.new(3, 0, 3),
                Vector3.new(-3, 0, 3),
                Vector3.new(3, 0, -3),
                Vector3.new(-3, 0, -3)
            }
            
            for i, part in pairs(invisibleParts) do
                if part and part.Parent and corners[i] then
                    part.Position = ridePlatform.Position + corners[i]
                end
            end
        end
        
        -- Multi-player support
        if multiPlayerMode then
            for _, otherPlayer in pairs(Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local otherRoot = otherPlayer.Character.HumanoidRootPart
                    local distance = (otherRoot.Position - ridePlatform.Position).Magnitude
                    
                    if distance < 10 then
                        local platformTop = ridePlatform.Position + Vector3.new(0, ridePlatform.Size.Y/2 + 3, 0)
                        otherRoot.CFrame = CFrame.new(platformTop.X, platformTop.Y, platformTop.Z)
                        otherRoot.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end
end)

-- FLASHLIGHT
local flashBtn = createMenuButton("Flashlight", 2)
local flashTab = createTabContent("Flashlight")

local flashlight = nil
local flashlightLevel = 1
local flashlightOn = false

local flashlightBtnTog = createStyledButton(flashTab, "Flashlight: OFF", UDim2.new(0, 10, 0, 10))

flashlightBtnTog.MouseButton1Click:Connect(function()
    flashlightOn = not flashlightOn
    
    if flashlightOn then
        flashlightBtnTog.Text = "Flashlight: ON"
        flashlightBtnTog.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        if player.Character and player.Character:FindFirstChild("Head") then
            if flashlight then flashlight:Destroy() end
            flashlight = Instance.new("SpotLight")
            flashlight.Angle = 60  -- Lebih fokus
            flashlight.Brightness = flashlightLevel * 3  
            flashlight.Range = 80  
            flashlight.Color = Color3.fromRGB(255, 255, 200)
            flashlight.Face = Enum.NormalId.Front
            flashlight.Shadows = true  
            flashlight.Parent = player.Character.Head
        end
    else
        flashlightBtnTog.Text = "Flashlight: OFF"
        flashlightBtnTog.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
        
        if flashlight then
            flashlight:Destroy()
            flashlight = nil
        end
    end
end)

local brightnessBtnTog = createStyledButton(flashTab, "Brightness: x1", UDim2.new(0, 10, 0, 50))

brightnessBtnTog.MouseButton1Click:Connect(function()
    flashlightLevel = flashlightLevel + 1
    if flashlightLevel > 5 then flashlightLevel = 1 end
    
    brightnessBtnTog.Text = "Brightness: x" .. flashlightLevel
    brightnessBtnTog.BackgroundColor3 = flashlightLevel > 1 and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if flashlight then
        flashlight.Brightness = flashlightLevel * 3
    end
end)

-- Color Cycle Button
local colorLevel = 1
local colors = {
    {Color3.fromRGB(255, 255, 200), "Warm White"},  -- Putih hangat
    {Color3.fromRGB(255, 255, 255), "Cool White"},  -- Putih dingin
    {Color3.fromRGB(255, 200, 100), "Yellow"},      -- Kuning
    {Color3.fromRGB(100, 150, 255), "Blue"},        -- Biru
    {Color3.fromRGB(255, 100, 100), "Red"}          -- Merah
}

local colorBtnTog = createStyledButton(flashTab, "Color: Warm White", UDim2.new(0, 10, 0, 90))

colorBtnTog.MouseButton1Click:Connect(function()
    colorLevel = colorLevel + 1
    if colorLevel > #colors then colorLevel = 1 end
    
    colorBtnTog.Text = "Color: " .. colors[colorLevel][2]
    
    if flashlight then
        flashlight.Color = colors[colorLevel][1]
    end
end)

-- TELEPORT TAB
local tpBtn = createMenuButton("Teleport", 3)
local tpTab = createTabContent("Teleport")

-- Checkpoint Detection Variables
local checkpoints = {}
local currentCheckpoint = 1
local autoCheckpointEnabled = false

-- Fungsi deteksi apakah sebuah part milik NPC
local function isNPC(part)
	local model = part:FindFirstAncestorOfClass("Model")
	return model and model:FindFirstChildOfClass("Humanoid")
end

local function scanCheckpoints()
	checkpoints = {}

	local checkpointNames = {
		"Checkpoint", "checkpoint", "CheckPoint", "CHECKPOINT", "Check_Point", "check_point", "CP", "cp",
		"Spawn", "spawn", "SpawnPoint", "SpawnLocation", "SPAWN", "spawn_point", "Respawn", "ReSpawn", "SpawnPart",
		"Stage", "stage", "STAGE", "StagePart", "Level", "level", "LEVEL", "LevelPart", "Lvl", "lvl", "StagePoint",
		"Position", "Pos", "pos", "POS", "Waypoint", "waypoint", "Progress", "progress", "Check", "check", "Safe", "safe",
        "Camp", "camp", "CAMP", "Basecamp", "basecamp", "Base", "base", "SafeZone", "safezone", "RestStop", "RestArea",
		"Teleporter", "teleporter", "TELEPORTER", "Teleport", "teleport", "TP", "tp", "Gate", "Portal", "portal",
		"SavePoint", "Save", "save", "SAVE", "ProgressPoint"
	}

	local player = game.Players.LocalPlayer
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local function isNPC(part)
		local model = part:FindFirstAncestorOfClass("Model")
		return model and model:FindFirstChildOfClass("Humanoid")
	end

	local function scanFolder(folder)
		for _, obj in pairs(folder:GetChildren()) do
			if (obj:IsA("BasePart") or obj:IsA("SpawnLocation")) and not isNPC(obj) then
				for _, keyword in pairs(checkpointNames) do
					if string.find(obj.Name:lower(), keyword:lower()) then
						table.insert(checkpoints, obj)
						break
					end
				end
			elseif obj:IsA("Folder") or obj:IsA("Model") then
				scanFolder(obj)
			end
		end
	end

	scanFolder(workspace)

	-- Urutkan berdasarkan jarak dari player
	table.sort(checkpoints, function(a, b)
		return (root.Position - a.Position).Magnitude < (root.Position - b.Position).Magnitude
	end)

	-- Tangani nama duplikat tanpa angka bawaan
	local nameCount = {}
	for _, part in ipairs(checkpoints) do
		local baseName = part.Name
		local hasNumber = string.match(baseName, "%d+")
		if not hasNumber then
			nameCount[baseName] = (nameCount[baseName] or 0) + 1
			part.Name = baseName .. tostring(nameCount[baseName])
		end
	end

	return #checkpoints
end

-- Label nama Checkpoint
local checkpointLabel = Instance.new("TextLabel", tpTab)
checkpointLabel.Size = UDim2.new(0, 300, 0, 25)
checkpointLabel.Position = UDim2.new(0, 20, 0, 7)
checkpointLabel.TextColor3 = Color3.new(1, 1, 1)
checkpointLabel.BackgroundTransparency = 1
checkpointLabel.Font = Enum.Font.GothamBold
checkpointLabel.TextSize = 14
checkpointLabel.TextXAlignment = Enum.TextXAlignment.Left
checkpointLabel.Text = "Checkpoint: -"

-- Tombol ← Checkpoint
local leftCheckpointBtn = createStyledButton(tpTab, "←", UDim2.new(0, 20, 0, 37), UDim2.new(0, 35, 0, 25))

-- Tombol Teleport Checkpoint
local tpCheckpointBtn = createStyledButton(tpTab, "Teleport", UDim2.new(0, 60, 0, 37), UDim2.new(0, 100, 0, 25))

-- Tombol → Checkpoint
local rightCheckpointBtn = createStyledButton(tpTab, "→", UDim2.new(0, 170, 0, 37), UDim2.new(0, 35, 0, 25))

-- Tombol Scan Checkpoints
local scanCheckpointBtn = createStyledButton(tpTab, "Scan Checkpoints", UDim2.new(0, 20, 0, 72))

scanCheckpointBtn.MouseButton1Click:Connect(function()
	local count = scanCheckpoints()
	if count > 0 then
		currentCheckpoint = 1
		checkpointLabel.Text = "Checkpoint: " .. checkpoints[currentCheckpoint].Name
	else
		checkpointLabel.Text = "No checkpoints found!"
	end
end)

-- Tombol ← event
leftCheckpointBtn.MouseButton1Click:Connect(function()
	if #checkpoints == 0 then return end
	currentCheckpoint = currentCheckpoint - 1
	if currentCheckpoint < 1 then
		currentCheckpoint = #checkpoints
	end
	checkpointLabel.Text = "Checkpoint: " .. checkpoints[currentCheckpoint].Name
end)

-- Tombol → event
rightCheckpointBtn.MouseButton1Click:Connect(function()
	if #checkpoints == 0 then return end
	currentCheckpoint = currentCheckpoint + 1
	if currentCheckpoint > #checkpoints then
		currentCheckpoint = 1
	end
	checkpointLabel.Text = "Checkpoint: " .. checkpoints[currentCheckpoint].Name
end)

-- Tombol Teleport event
tpCheckpointBtn.MouseButton1Click:Connect(function()
	if #checkpoints == 0 then return end
	local checkpoint = checkpoints[currentCheckpoint]
	local player = game.Players.LocalPlayer
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if root and checkpoint then
		root.CFrame = checkpoint.CFrame + Vector3.new(0, 5, 0)
	end
end)

-- Auto Checkpoint Toggle
local autoCheckpointBtn = createStyledButton(tpTab, "Auto Mode: OFF", UDim2.new(0, 20, 0, 107))
autoCheckpointBtn.MouseButton1Click:Connect(function()
    autoCheckpointEnabled = not autoCheckpointEnabled
    autoCheckpointBtn.Text = autoCheckpointEnabled and "Auto Mode: ON" or "Auto Mode: OFF"
    autoCheckpointBtn.BackgroundColor3 = autoCheckpointEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
end)

-- Auto Mode Logic
task.spawn(function()
    while true do
        task.wait(2)
        if autoCheckpointEnabled and #checkpoints > 0 and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local nextIndex = currentCheckpoint + 1
            if nextIndex <= #checkpoints then
                local nextCP = checkpoints[nextIndex]
                local dist = (root.Position - nextCP.part.Position).Magnitude
                if dist < 10 then
                    currentCheckpoint = nextIndex
                    root.CFrame = nextCP.part.CFrame + Vector3.new(0, 5, 0)
                    checkpointLabel.Text = "Auto TP: " .. nextCP.name
                end
            end
        end
    end
end)

-- Daftar gunung dan koordinatnya
local mountains = {
    { name = "GUNUNG YAMIN",      pos = Vector3.new(-735, 928, -803) },
    { name = "GUNUNG KENCANA",    pos = Vector3.new(5673, 1968, 439) },
    { name = "GUNUNG DAUN",       pos = Vector3.new(-3117, 1730, -2598) },
    { name = "GUNUNG ANTARTIKA",  pos = Vector3.new(10400, 557, 61) },
    { name = "GUNUNG ARUNIKA",    pos = Vector3.new(288, 318, 689) },
    { name = "GUNUNG BORNEO",     pos = Vector3.new(252, 2369, 6818) },
    { name = "GUNUNG KAHUNG",     pos = Vector3.new(1176, 952, -478) },
    { name = "GUNUNG EDEN",     pos = Vector3.new(-806, 1937, -939) },
    { name = "GUNUNG KRAKATAU",     pos = Vector3.new(1276, 844, -140) },
}

local currentIndex = 1

-- Label nama gunung
local gunungLabel = Instance.new("TextLabel", tpTab)
gunungLabel.Size = UDim2.new(0, 300, 0, 25)
gunungLabel.Position = UDim2.new(0, 260, 0, 5)
gunungLabel.TextColor3 = Color3.new(1, 1, 1)
gunungLabel.BackgroundTransparency = 1
gunungLabel.Font = Enum.Font.GothamBold
gunungLabel.TextSize = 14
gunungLabel.TextXAlignment = Enum.TextXAlignment.Left
gunungLabel.Text = "Gunung: " .. mountains[currentIndex].name

-- Tombol Kiri
local leftBtn = createStyledButton(tpTab, "←", UDim2.new(0, 260, 0, 35), UDim2.new(0, 35, 0, 25))

-- Tombol Teleport
local tpGunung = createStyledButton(tpTab, "Teleport", UDim2.new(0, 300, 0, 35), UDim2.new(0, 100, 0, 25))

-- Tombol Kanan
local rightBtn = createStyledButton(tpTab, "→", UDim2.new(0, 405, 0, 35), UDim2.new(0, 35, 0, 25))

-- Event tombol ←
leftBtn.MouseButton1Click:Connect(function()
    currentIndex = currentIndex - 1
    if currentIndex < 1 then
        currentIndex = #mountains
    end
    gunungLabel.Text = "Gunung: " .. mountains[currentIndex].name
end)

-- Event tombol →
rightBtn.MouseButton1Click:Connect(function()
    currentIndex = currentIndex + 1
    if currentIndex > #mountains then
        currentIndex = 1
    end
    gunungLabel.Text = "Gunung: " .. mountains[currentIndex].name
end)

-- Event tombol Teleport
tpGunung.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(mountains[currentIndex].pos)
    end
end)

-- Auto Muncak
local isMuncakRunning = false
local muncakThread = nil

-- Tombol Muncak
local muncakBtn = createStyledButton(tpTab, "Muncak", UDim2.new(0, 200, 0, 65), UDim2.new(0, 70, 0, 25))
-- Tombol Stop
local stopBtn = createStyledButton(tpTab, "Stop", UDim2.new(0, 280, 0, 65), UDim2.new(0, 70, 0, 25))

muncakBtn.MouseButton1Click:Connect(function()
    if isMuncakRunning then return end
    isMuncakRunning = true

    muncakThread = task.spawn(function()
        while isMuncakRunning do
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
            if root and hum then
                -- Teleport ke gunung
                root.CFrame = CFrame.new(mountains[currentIndex].pos)
                task.wait(1)

                -- Gerak ke kanan/kiri secara acak
                local direction = math.random(0, 1) == 1 and Vector3.new(3, 0, 0) or Vector3.new(-3, 0, 0)
                for i = 1, math.random(20, 30) do
                    root.Velocity = direction * 5
                    task.wait(0.1)
                end
                root.Velocity = Vector3.zero

                -- Paksa mati
                hum.Health = 0
                task.wait(5)
            else
                task.wait(2)
            end
        end
    end)
end)

stopBtn.MouseButton1Click:Connect(function()
    isMuncakRunning = false
    if muncakThread then
        task.cancel(muncakThread)
        muncakThread = nil
    end
end)

-- TextBox untuk input nama pemain
local tpBox = Instance.new("TextBox", tpTab)
tpBox.Size = UDim2.new(0, 180, 0, 30)
tpBox.Position = UDim2.new(0, 260, 0, 70)
tpBox.PlaceholderText = "Name to TP"
tpBox.Text = ""
tpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpBox.TextColor3 = Color3.new(1, 1, 1)
tpBox.Font = Enum.Font.Gotham
tpBox.TextSize = 12
tpBox.BorderSizePixel = 0

local tpBoxCorner = Instance.new("UICorner")
tpBoxCorner.CornerRadius = UDim.new(0, 6)
tpBoxCorner.Parent = tpBox

-- Tombol Teleport by Name
local tpByName = createStyledButton(tpTab, "Teleport by Name", UDim2.new(0, 260, 0, 110), UDim2.new(0, 180, 0, 30))

tpByName.MouseButton1Click:Connect(function()
    local target = Players:FindFirstChild(tpBox.Text)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        player.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

-- Tombol Get Koordinat (Clipboard)
local getCoordBtn = createStyledButton(tpTab, "Get Koordinat", UDim2.new(0, 20, 0, 142))

-- Fungsi notifikasi 5 detik
local function showNotification(text)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 300, 0, 30)
    notif.Position = UDim2.new(0.5, -150, 0, 10)
    notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notif.BackgroundTransparency = 0.3
    notif.TextColor3 = Color3.new(1, 1, 1)
    notif.TextStrokeTransparency = 0.5
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 14
    notif.Text = text
    notif.AnchorPoint = Vector2.new(0.5, 0)
    notif.Parent = tpTab

    task.delay(5, function()
        if notif then notif:Destroy() end
    end)
end

-- Event klik
getCoordBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local msg = string.format("X = %d, Y = %d, Z = %d", pos.X, pos.Y, pos.Z)

        -- Coba salin ke clipboard
        local success, err = pcall(function()
            setclipboard(msg)
        end)

        if success then
            showNotification("📋 Koordinat tersalin ke clipboard!")
        else
            showNotification("Gagal salin: "..tostring(err))
        end
    else
        showNotification("HumanoidRootPart tidak ditemukan!")
    end
end)

-- SPECTATE TAB
local spectateBtn = createMenuButton("Spectate", 4)
local spectateTab = createTabContent("Spectate")

local index = 1
local spectating = nil
local spectateMode = false

-- Spectate Display
local SpectateDisplay = Instance.new("Frame", ScreenGui)
SpectateDisplay.Name = "SpectateDisplay"
SpectateDisplay.Size = UDim2.new(0, 280, 0, 45)
SpectateDisplay.Position = UDim2.new(0.5, -240/2, 1, -120)
SpectateDisplay.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpectateDisplay.BackgroundTransparency = 0.1
SpectateDisplay.BorderSizePixel = 0
SpectateDisplay.Visible = false

local SpectateCorner = Instance.new("UICorner")
SpectateCorner.CornerRadius = UDim.new(0, 10)
SpectateCorner.Parent = SpectateDisplay

-- Stroke untuk outline
local SpectateStroke = Instance.new("UIStroke")
SpectateStroke.Color = Color3.fromRGB(100, 150, 255)
SpectateStroke.Thickness = 2
SpectateStroke.Parent = SpectateDisplay

local SpectateLeftBtn = Instance.new("TextButton", SpectateDisplay)
SpectateLeftBtn.Size = UDim2.new(0, 35, 1, 0)
SpectateLeftBtn.Position = UDim2.new(0, 0, 0, 0)
SpectateLeftBtn.Text = "◀"
SpectateLeftBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
SpectateLeftBtn.TextSize = 16
SpectateLeftBtn.Font = Enum.Font.GothamBold
SpectateLeftBtn.BackgroundTransparency = 1

local SpectateRightBtn = Instance.new("TextButton", SpectateDisplay)
SpectateRightBtn.Size = UDim2.new(0, 35, 1, 0)
SpectateRightBtn.Position = UDim2.new(1, -35, 0, 0)
SpectateRightBtn.Text = "▶"
SpectateRightBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
SpectateRightBtn.TextSize = 16
SpectateRightBtn.Font = Enum.Font.GothamBold
SpectateRightBtn.BackgroundTransparency = 1

local SpectateUsername = Instance.new("TextLabel", SpectateDisplay)
SpectateUsername.Size = UDim2.new(1, -70, 1, 0)
SpectateUsername.Position = UDim2.new(0, 35, 0, 0)
SpectateUsername.Text = "Player"
SpectateUsername.TextColor3 = Color3.new(1, 1, 1)
SpectateUsername.TextSize = 16
SpectateUsername.Font = Enum.Font.GothamBold
SpectateUsername.BackgroundTransparency = 1
SpectateUsername.TextXAlignment = Enum.TextXAlignment.Center

local function updateSpectate()
    local all = Players:GetPlayers()
    local validPlayers = {}
    
    -- Get valid players (exclude self)
    for _, p in pairs(all) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            table.insert(validPlayers, p)
        end
    end
    
    if #validPlayers == 0 then return end
    if index > #validPlayers then index = 1 end
    if index < 1 then index = #validPlayers end
    
    spectating = validPlayers[index]
    camera.CameraSubject = spectating.Character.Humanoid
    SpectateUsername.Text = spectating.Name .. " (" .. index .. "/" .. #validPlayers .. ")"
end

-- Spectate Mode Toggle
local spectateModeBtn = createStyledButton(spectateTab, "Spectate Mode: OFF", UDim2.new(0, 10, 0, 10))

spectateModeBtn.MouseButton1Click:Connect(function()
    spectateMode = not spectateMode
    spectateModeBtn.Text = spectateMode and "Spectate Mode: ON" or "Spectate Mode: OFF"
    spectateModeBtn.BackgroundColor3 = spectateMode and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if spectateMode then
        SpectateDisplay.Visible = true
        index = 1
        updateSpectate()
    else
        SpectateDisplay.Visible = false
        camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
    end
end)

-- Connect spectate display buttons
SpectateLeftBtn.MouseButton1Click:Connect(function()
    if spectateMode then
        index -= 1
        updateSpectate()
    end
end)

SpectateRightBtn.MouseButton1Click:Connect(function()
    if spectateMode then
        index += 1
        updateSpectate()
    end
end)

local tpToBtn = createStyledButton(spectateTab, "TP to Spectated", UDim2.new(0, 10, 0, 50))

tpToBtn.MouseButton1Click:Connect(function()
    if spectating and spectating.Character and spectating.Character:FindFirstChild("HumanoidRootPart") then
        player.Character:FindFirstChild("HumanoidRootPart").CFrame = spectating.Character.HumanoidRootPart.CFrame
    end
end)

local resetBtn = createStyledButton(spectateTab, "Reset Camera", UDim2.new(0, 10, 0, 90))

resetBtn.MouseButton1Click:Connect(function()
    spectateMode = false
    spectateModeBtn.Text = "Spectate Mode: OFF"
    spectateModeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    SpectateDisplay.Visible = false
    camera.CameraSubject = player.Character and player.Character:FindFirstChild("Humanoid")
end)

-- SETTINGS TAB
local settingsBtn = createMenuButton("Settings", 5)
local settingsTab = createTabContent("Settings")

-- ANTI LAG FUNCTION
local function applyAntiLag()
    local toRemove = {"Tree", "tree", "Pohon", "Grass", "Leaf", "Leaves", "Daun", "Wind", "Particle", "Smoke", "Sparkles", "SunRays", "Blur", "Shadow"}

    -- Hapus semua object berat
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj:Destroy()
        elseif obj:IsA("Sound") then
            obj:Stop()
            obj.Looped = false
        else
            for _, name in pairs(toRemove) do
                if string.lower(obj.Name):find(string.lower(name)) then
                    pcall(function() obj:Destroy() end)
                end
            end
        end
    end

    -- Nonaktifkan efek visual
    local lighting = game:GetService("Lighting")
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") then
            v.Enabled = false
        end
    end
    lighting.GlobalShadows = false
end

-- ANTILAG BUTTON
local antiLagBtn = createStyledButton(settingsTab, "Apply Anti-Lag", UDim2.new(0, 10, 0, 10))
antiLagBtn.MouseButton1Click:Connect(function()
    applyAntiLag()
    antiLagBtn.Text = "Anti-Lag Applied"
    antiLagBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    task.delay(1, function()
        antiLagBtn.Text = "Apply Anti-Lag"
        antiLagBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    end)
end)

-- ANTI AFK BUTTON
local antiAFKOn = false
local antiAFKBtn = createStyledButton(settingsTab, "Anti-AFK: OFF", UDim2.new(0, 10, 0, 60))
antiAFKBtn.MouseButton1Click:Connect(function()
    antiAFKOn = not antiAFKOn
    antiAFKBtn.Text = antiAFKOn and "Anti-AFK: ON" or "Anti-AFK: OFF"
    antiAFKBtn.BackgroundColor3 = antiAFKOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)

    if antiAFKOn then
        local VirtualUser = game:GetService("VirtualUser")
        player.Idled:Connect(function()
            if antiAFKOn then
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end
        end)
    end
end)


-- Make GUI draggable
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Keyboard controls for spectate (when spectate mode is active)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if spectateMode then
        if input.KeyCode == Enum.KeyCode.Comma then -- <
            index -= 1
            updateSpectate()
        elseif input.KeyCode == Enum.KeyCode.Period then -- >
            index += 1
            updateSpectate()
        end
    end
end)

-- Default open tab
showTab("Player")

-- Connect menu buttons
local menuButtons = {
    [playerBtn] = "Player",
    [airBtn] = "Walk On Air",
    [flashBtn] = "Flashlight",
    [tpBtn] = "Teleport",
    [spectateBtn] = "Spectate",
    [settingsBtn] = "Settings"
}

for btn, name in pairs(menuButtons) do
    btn.MouseButton1Click:Connect(function()
        showTab(name)
    end)
end

-- Character respawn handling
player.CharacterAdded:Connect(function(character)
    wait(1)
    if character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = 16 * speedLevel
        character.Humanoid.JumpPower = 50 * jumpLevel
        
        if flashlightOn and character:FindFirstChild("Head") then
            if flashlight then flashlight:Destroy() end
            flashlight = Instance.new("SpotLight")
            flashlight.Angle = 60
            flashlight.Brightness = flashlightLevel * 3
            flashlight.Range = 80
            flashlight.Color = colors[colorLevel][1]
            flashlight.Face = Enum.NormalId.Front
            flashlight.Shadows = true
            flashlight.Parent = character.Head
        end
        
        if godOn then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            hum.Health = math.huge
            hum.MaxHealth = math.huge
        else
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            hum.MaxHealth = 100
            hum.Health = 100
        end
        
        -- Reapply noclip if enabled
        if noclipOn then
            wait(0.1)
            toggleNoclip()
            toggleNoclip()
        end
        
        -- Reapply auto hunger/thirst if enabled
        if autoHungerThirstOn then
            wait(0.1)
            toggleAutoHungerThirst()
            toggleAutoHungerThirst()
        end
    end
end)

print("NEALMTROY has been loaded successfully!")
