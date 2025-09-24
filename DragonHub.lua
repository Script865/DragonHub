-- ضع هذا LocalScript داخل StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local dragonText = "Dragon"

-- إنشاء ScreenGui
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DragonMainGui"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui
mainGui.IgnoreGuiInset = true -- مهم للظهور فوق كل شيء

-- زر التنين
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "DragonToggle"
toggleButton.Parent = mainGui
toggleButton.Size = UDim2.new(0, 150, 0, 60)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.BackgroundTransparency = 0
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.Text = dragonText
toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextScaled = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = toggleButton

-- القائمة الرئيسية
local hubGui = Instance.new("Frame")
hubGui.Name = "DragonHub"
hubGui.Parent = mainGui
hubGui.Size = UDim2.new(0, 350, 0, 220)
hubGui.Position = UDim2.new(0.5, -175, 0.5, -110)
hubGui.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hubGui.Visible = false
hubGui.Active = true
hubGui.Draggable = true

local hubCorner = Instance.new("UICorner")
hubCorner.CornerRadius = UDim.new(0, 12)
hubCorner.Parent = hubGui

-- شعار التنين (نص)
local dragonLogo = Instance.new("TextLabel")
dragonLogo.Name = "DragonLogo"
dragonLogo.Parent = hubGui
dragonLogo.Size = UDim2.new(0, 120, 0, 60)
dragonLogo.Position = UDim2.new(0, 10, 0, 10)
dragonLogo.BackgroundTransparency = 0
dragonLogo.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
dragonLogo.Text = dragonText
dragonLogo.TextScaled = true
dragonLogo.Font = Enum.Font.FredokaOne
dragonLogo.TextColor3 = Color3.fromRGB(255, 0, 0)
dragonLogo.BorderSizePixel = 2
dragonLogo.BorderColor3 = Color3.fromRGB(255, 0, 0)

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 10)
logoCorner.Parent = dragonLogo

-- عنوان الواجهة
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = hubGui
title.Size = UDim2.new(1, -140, 0, 50)
title.Position = UDim2.new(0, 140, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Dragon Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.FredokaOne

-- زر الفتح والإغلاق
local opened = false
toggleButton.MouseButton1Click:Connect(function()
    opened = not opened
    hubGui.Visible = opened
end)
