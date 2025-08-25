-- StealHub Script (نسخة ثابتة Grapple Hook)

-- المفتاح
local Key = "StealHub"

-- إنشاء الواجهة الأولى (مفتاح)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "StealHubGui"

local keyFrame = Instance.new("Frame", mainGui)
keyFrame.Size = UDim2.new(0, 250, 0, 150)
keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.Visible = true

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0.3, 0)
keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
keyBox.PlaceholderText = "ادخل المفتاح"
keyBox.TextScaled = true

local confirmBtn = Instance.new("TextButton", keyFrame)
confirmBtn.Size = UDim2.new(0.6, 0, 0.3, 0)
confirmBtn.Position = UDim2.new(0.2, 0, 0.6, 0)
confirmBtn.Text = "تأكيد المفتاح"
confirmBtn.TextScaled = true
confirmBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 50)

-- الواجهة الرئيسية
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Visible = false

-- زر السرعة
local speedBtn = Instance.new("TextButton", mainFrame)
speedBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
speedBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
speedBtn.Text = "السرعة (80)"
speedBtn.TextScaled = true
speedBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)

-- زر رفع عالي
local upBtn = Instance.new("TextButton", mainFrame)
upBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
upBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
upBtn.Text = "رفع عالياً"
upBtn.TextScaled = true
upBtn.BackgroundColor3 = Color3.fromRGB(120, 80, 80)

-- زر نزول
local downBtn = Instance.new("TextButton", mainFrame)
downBtn.Size = UDim2.new(0.8, 0, 0.3, 0)
downBtn.Position = UDim2.new(0.1, 0, 0.85, -25)
downBtn.Text = "نزول"
downBtn.TextScaled = true
downBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 80)

-- وظيفة تأكيد المفتاح
confirmBtn.MouseButton1Click:Connect(function()
	if string.lower(keyBox.Text) == string.lower(Key) then
		keyFrame.Visible = false
		mainFrame.Visible = true
	end
end)

-- وظيفة إمساك Grapple Hook دائماً
local function HoldGrapple()
	task.wait()
	if player.Character then
		local tool = player.Backpack:FindFirstChild("Grapple Hook") or player.Character:FindFirstChild("Grapple Hook")
		if tool then
			tool.Parent = player.Character
		end
	end
end

-- يراقب الأغراض طول الوقت
task.spawn(function()
	while task.wait(1) do
		HoldGrapple()
	end
end)

-- السرعة
local speedEnabled = false
local speedValue = 80
speedBtn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
	if speedEnabled then
		speedBtn.Text = "السرعة ON ("..speedValue..")"
		player.Character.Humanoid.WalkSpeed = speedValue
		HoldGrapple()
	else
		speedBtn.Text = "السرعة OFF"
		player.Character.Humanoid.WalkSpeed = 16
	end
end)

-- GodMode ضد الموت
player.CharacterAdded:Connect(function(char)
	task.wait(1)
	if char:FindFirstChild("Humanoid") then
		char.Humanoid.Health = 100
		char.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			char.Humanoid.Health = 100
		end)
	end
end)

-- حفظ الارتفاع
local savedY = nil

upBtn.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		savedY = hrp.Position.Y
		HoldGrapple()
		hrp.CFrame = hrp.CFrame + Vector3.new(0, 150, 0) -- رفع قوي
	end
end)

downBtn.MouseButton1Click:Connect(function()
	if savedY and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		HoldGrapple()
		hrp.CFrame = CFrame.new(hrp.Position.X, savedY, hrp.Position.Z)
	end
end)
