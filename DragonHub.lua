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

-- زر التنين
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "DragonToggle"
toggleButton.Parent = mainGui
toggleButton.Size = UDim2.new(0, 120, 0, 60) -- حجم واضح
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.BackgroundTransparency = 0
toggleButton.BorderSizePixel = 0
toggleButton.Text = dragonText
toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextScaled = true

local corner = Instance.new("UICorner", toggleButton)
corner.CornerRadius = UDim.new(0, 12)

-- القائمة الرئيسية
local hubGui = Instance.new("Frame")
hubGui.Name = "DragonHub"
hubGui.Parent = mainGui
hubGui.Size = UDim2.new(0, 300, 0, 200)
hubGui.Position = UDim2.new(0.5, -150, 0.5, -100)
hubGui.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
hubGui.Visible = false
hubGui.Active = true
hubGui.Draggable = true

local hubCorner = Instance.new("UICorner", hubGui)
hubCorner.CornerRadius = UDim.new(0, 12)

-- شعار التنين (نص)
local dragonLogo = Instance.new("TextLabel")
dragonLogo.Name = "DragonLogo"
dragonLogo.Parent = hubGui
dragonLogo.Size = UDim2.new(0, 100, 0, 50)
dragonLogo.Position = UDim2.new(0, 10, 0, 10)
dragonLogo.BackgroundTransparency = 1
dragonLogo.Text = dragonText
dragonLogo.TextScaled = true
dragonLogo.Font = Enum.Font.FredokaOne
dragonLogo.TextColor3 = Color3.fromRGB(255, 0, 0)

-- عنوان الواجهة
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Parent = hubGui
title.Size = UDim2.new(1, -120, 0, 50)
title.Position = UDim2.new(0, 120, 0, 10)
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
