-- Gui + نظام المفتاح
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local uis = game:GetService("UserInputService")

-- حماية من الموت (GodMode)
hum.Health = 100
hum:GetPropertyChangedSignal("Health"):Connect(function()
	if hum.Health <= 0 then
		hum.Health = 100
	end
end)

-- صنع واجهة المفتاح
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(1, -20, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 20)
textBox.PlaceholderText = "اكتب المفتاح هنا"
textBox.Text = ""

local confirm = Instance.new("TextButton", frame)
confirm.Size = UDim2.new(1, -20, 0, 30)
confirm.Position = UDim2.new(0, 10, 0, 70)
confirm.Text = "تأكيد المفتاح"

-- الواجهة الرئيسية
local mainGui = Instance.new("Frame")
mainGui.Size = UDim2.new(0, 200, 0, 200)
mainGui.Position = UDim2.new(0.05, 0, 0.3, 0)
mainGui.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainGui.Visible = false
mainGui.Parent = screenGui

-- زر السرعة
local speedLabel = Instance.new("TextLabel", mainGui)
speedLabel.Size = UDim2.new(1, 0, 0, 30)
speedLabel.Text = "السرعة: 80"
speedLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local speedBtn = Instance.new("TextButton", mainGui)
speedBtn.Size = UDim2.new(1, -20, 0, 30)
speedBtn.Position = UDim2.new(0, 10, 0, 40)
speedBtn.Text = "تفعيل السرعة"

-- زر النطة العالية
local jumpBtn = Instance.new("TextButton", mainGui)
jumpBtn.Size = UDim2.new(1, -20, 0, 30)
jumpBtn.Position = UDim2.new(0, 10, 0, 80)
jumpBtn.Text = "نطة عالية"

-- مفتاح الدخول
local KEY = "stealhub"

confirm.MouseButton1Click:Connect(function()
	if string.lower(textBox.Text) == KEY then
		frame.Visible = false
		mainGui.Visible = true
	end
end)

-- نظام السرعة
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

-- نظام النطة العالية
jumpBtn.MouseButton1Click:Connect(function()
	hum.JumpPower = 300 -- نطة عالية جدًا
	hum:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- إمساك دائم لـ Grapple Hook
local function equipHook()
	task.wait(0.1)
	local backpack = player:WaitForChild("Backpack")
	local char = player.Character
	local hook = backpack:FindFirstChild("Grapple Hook") or (char and char:FindFirstChild("Grapple Hook"))
	if hook then
		hum:EquipTool(hook)
	end
end

player.CharacterAdded:Connect(function(c)
	char = c
	hum = char:WaitForChild("Humanoid")
	equipHook()
end)

-- تحقق مستمر
while task.wait(1) do
	equipHook()
end

-- 🟢 نظام التحريك (Draggable GUI)
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

makeDraggable(frame)   -- واجهة المفتاح
makeDraggable(mainGui) -- الواجهة الرئيسية
