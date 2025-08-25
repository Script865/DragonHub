-- StealHub Script Full Control

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local uis = game:GetService("UserInputService")

-- GUI Setup
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false

-- == واجهة المفتاح ==
local keyFrame = Instance.new("Frame", screenGui)
keyFrame.Size = UDim2.new(0, 250, 0, 150)
keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(1, -20, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 20)
textBox.PlaceholderText = "اكتب المفتاح هنا"
textBox.Text = ""

local confirm = Instance.new("TextButton", keyFrame)
confirm.Size = UDim2.new(1, -20, 0, 30)
confirm.Position = UDim2.new(0, 10, 0, 70)
confirm.Text = "تأكيد المفتاح"

-- == الواجهة الرئيسية ==
local mainGui = Instance.new("Frame")
mainGui.Size = UDim2.new(0, 250, 0, 300)
mainGui.Position = UDim2.new(0.05, 0, 0.3, 0)
mainGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainGui.Visible = false
mainGui.Parent = screenGui

-- زر السرعة
local speedBtn = Instance.new("TextButton", mainGui)
speedBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
speedBtn.Position = UDim2.new(0.1, 0, 0.05, 0)
speedBtn.Text = "تفعيل السرعة"

-- زر النطة العالية
local jumpBtn = Instance.new("TextButton", mainGui)
jumpBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
jumpBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
jumpBtn.Text = "نطة عالية"

-- زر GodMode
local godBtn = Instance.new("TextButton", mainGui)
godBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
godBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
godBtn.Text = "عدم الموت"

-- زر مسك الأداة تلقائي
local autoEquipBtn = Instance.new("TextButton", mainGui)
autoEquipBtn.Size = UDim2.new(0.8, 0, 0.15, 0)
autoEquipBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
autoEquipBtn.Text = "امسك الأداة تلقائي"

-- زر مفتاح الدخول
local KEY = "stealhub"
confirm.MouseButton1Click:Connect(function()
	if string.lower(textBox.Text) == KEY then
		keyFrame.Visible = false
		mainGui.Visible = true
	end
end)

-- السرعة
local speedOn = false
speedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	if speedOn then
		hum.WalkSpeed = 80
		speedBtn.Text = "إيقاف السرعة"
	else
		hum.WalkSpeed = 16
		speedBtn.Text = "تفعيل السرعة"
	end
end)

-- النطة العالية
jumpBtn.MouseButton1Click:Connect(function()
	hum.JumpPower = 300
	hum:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- GodMode Toggle
local godModeOn = false
godBtn.MouseButton1Click:Connect(function()
	godModeOn = not godModeOn
	godBtn.Text = godModeOn and "عدم الموت ✅" or "عدم الموت ❌"
end)

hum.HealthChanged:Connect(function(h)
	if godModeOn and h < hum.MaxHealth then
		hum.Health = hum.MaxHealth
	end
end)

-- مسك الأداة تلقائي Toggle
local autoEquipOn = false
autoEquipBtn.MouseButton1Click:Connect(function()
	autoEquipOn = not autoEquipOn
	autoEquipBtn.Text = autoEquipOn and "امسك الأداة ✅" or "امسك الأداة ❌"
end)

local function equipHook()
	if autoEquipOn and char then
		local tool = char:FindFirstChild("Grapple Hook") or player.Backpack:FindFirstChild("Grapple Hook")
		if tool and tool.Parent ~= char then
			hum:EquipTool(tool)
		end
	end
end

player.CharacterAdded:Connect(function(c)
	char = c
	hum = char:WaitForChild("Humanoid")
end)

-- تحقق مستمر
while task.wait(1) do
	equipHook()
end

-- Draggable GUI
local function makeDraggable(gui)
	local dragging, dragInput, dragStart, startPos
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(keyFrame)
makeDraggable(mainGui)
