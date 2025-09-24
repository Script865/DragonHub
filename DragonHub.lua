-- Dragon -- ضع هذا في LocalScript داخل StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- نص التنين
local dragonText = "Dragon"

-- واجهة أولى (زر التنين)
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DragonMainGui"
mainGui.ResetOnSpawn = false -- مهم لضمان استمرار GUI عند إعادة الدخول
mainGui.Parent = playerGui

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "DragonToggle"
toggleButton.Parent = mainGui
toggleButton.Size = UDim2.new(0, 100, 0, 50) -- حجم أكبر لتراه بسهولة
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundTransparency = 0.2
toggleButton.BorderSizePixel = 0
toggleButton.AutoButtonColor = true
toggleButton.Text = dragonText
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.FredokaOne
toggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, 10)

-- واجهة ثانية (القائمة الرئيسية)
local hubGui = Instance.new("Frame")
hubGui.Name = "DragonHub"
hubGui.Parent = mainGui
hubGui.Size = UDim2.new(0, 300, 0, 200)
hubGui.Position = UDim2.new(0.5, -150, 0.5, -100) -- يظهر في وسط الشاشة
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
dragonLogo.Size = UDim2.new(0, 80, 0, 50) -- حجم أكبر ليراه الجميع
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
title.Size = UDim2.new(1, -100, 0, 50)
title.Position = UDim2.new(0, 100, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Dragon Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.FredokaOne

-- زر الفتح/الإغلاق
local opened = false
toggleButton.MouseButton1Click:Connect(function()
	opened = not opened
	hubGui.Visible = opened
end)
