-- StealHub Ultimate Powerful Script
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local function createGUI()
    -- حذف أي GUI قديم
    if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("StealHub") then
        player.PlayerGui.StealHub:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "StealHub"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Frame إدخال المفتاح
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 300, 0, 150)
    keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    keyFrame.Parent = screenGui

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8,0,0.3,0)
    keyBox.Position = UDim2.new(0.1,0,0.2,0)
    keyBox.PlaceholderText = "اكتب المفتاح هنا"
    keyBox.Text = ""
    keyBox.TextScaled = true
    keyBox.Parent = keyFrame

    local confirmBtn = Instance.new("TextButton")
    confirmBtn.Size = UDim2.new(0.5,0,0.25,0)
    confirmBtn.Position = UDim2.new(0.25,0,0.6,0)
    confirmBtn.Text = "تأكيد المفتاح"
    confirmBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
    confirmBtn.TextScaled = true
    confirmBtn.Parent = keyFrame

    -- GUI الرئيسي
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0,250,0,250)
    mainFrame.Position = UDim2.new(0.05,0,0.3,0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    mainFrame.Visible = false
    mainFrame.Parent = screenGui

    local speedBox = Instance.new("TextBox")
    speedBox.Size = UDim2.new(0.8,0,0.2,0)
    speedBox.Position = UDim2.new(0.1,0,0.05,0)
    speedBox.Text = "80"
    speedBox.TextScaled = true
    speedBox.Parent = mainFrame

    local speedBtn = Instance.new("TextButton")
    speedBtn.Size = UDim2.new(0.8,0,0.18,0)
    speedBtn.Position = UDim2.new(0.1,0,0.3,0)
    speedBtn.Text = "تفعيل السرعة"
    speedBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
    speedBtn.TextScaled = true
    speedBtn.Parent = mainFrame

    local flyBtn = Instance.new("TextButton")
    flyBtn.Size = UDim2.new(0.8,0,0.18,0)
    flyBtn.Position = UDim2.new(0.1,0,0.52,0)
    flyBtn.Text = "الرفع عالياً"
    flyBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    flyBtn.TextScaled = true
    flyBtn.Parent = mainFrame

    local downBtn = Instance.new("TextButton")
    downBtn.Size = UDim2.new(0.8,0,0.18,0)
    downBtn.Position = UDim2.new(0.1,0,0.74,0)
    downBtn.Text = "النزول"
    downBtn.BackgroundColor3 = Color3.fromRGB(0,0,200)
    downBtn.TextScaled = true
    downBtn.Parent = mainFrame

    local correctKey = "stealhub"

    local oldY = nil
    local speedActive = false
    local originalSpeed = 16
    local canLift = true

    local function getHook()
        local backpack = player:WaitForChild("Backpack")
        local hook = backpack:FindFirstChild("Grapple Hook") or (player.Character and player.Character:FindFirstChild("Grapple Hook"))
        if hook and player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(hook)
            end
        end
    end

    confirmBtn.MouseButton1Click:Connect(function()
        if string.lower(keyBox.Text) == string.lower(correctKey) then
            keyFrame.Visible = false
            mainFrame.Visible = true
        end
    end)

    speedBtn.MouseButton1Click:Connect(function()
        getHook()
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if not speedActive then
                speedActive = true
                originalSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = tonumber(speedBox.Text) or 80
                speedBtn.Text = "إيقاف السرعة"
            else
                speedActive = false
                humanoid.WalkSpeed = originalSpeed
                speedBtn.Text = "تفعيل السرعة"
            end
        end
    end)

    flyBtn.MouseButton1Click:Connect(function()
        if not canLift then return end
        canLift = false
        getHook()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            oldY = root.Position.Y
            -- دفعة قوية وفورية
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Velocity = Vector3.new(0, 500, 0) -- دفعة قوية جداً
            bv.Parent = root
            task.wait(0.1)
            bv:Destroy()
        end
    end)

    downBtn.MouseButton1Click:Connect(function()
        getHook()
        if oldY and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            local pos = root.Position
            root.CFrame = CFrame.new(pos.X, oldY, pos.Z)
            canLift = true
        end
    end)

    -- Grapple Hook دائمًا
    player.CharacterAdded:Connect(function(char)
        char.ChildRemoved:Connect(function(child)
            if child.Name == "Grapple Hook" then
                task.wait(0.2)
                getHook()
            end
        end)
    end)
end

-- إنشاء GUI عند البداية
createGUI()

-- إعادة إنشاء GUI بعد Respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    createGUI()
end)
