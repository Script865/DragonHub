-- StealHub Full Script مؤلاي (GodMode محمي + GUI قابل للتحريك)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI Setup
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false

-- == واجهة المفتاح ==
local keyFrame = Instance.new("Frame", screenGui)
keyFrame.Size = UDim2.new(0, 250, 0, 150)
keyFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(1,-20,0,40)
textBox.Position = UDim2.new(0,10,0,20)
textBox.PlaceholderText = "اكتب المفتاح هنا"

local confirm = Instance.new("TextButton", keyFrame)
confirm.Size = UDim2.new(1,-20,0,30)
confirm.Position = UDim2.new(0,10,0,70)
confirm.Text = "تأكيد المفتاح"

-- == الواجهة الرئيسية ==
local mainGui = Instance.new("Frame", screenGui)
mainGui.Size = UDim2.new(0,250,0,500)
mainGui.Position = UDim2.new(0.05,0,0.3,0)
mainGui.BackgroundColor3 = Color3.fromRGB(40,40,40)
mainGui.Visible = false

-- أزرار التحكم
local function createButton(text,pos)
	local btn = Instance.new("TextButton", mainGui)
	btn.Size = UDim2.new(0.8,0,0.08,0)
	btn.Position = pos
	btn.Text = text
	btn.TextScaled = true
	return btn
end

local speedBtn = createButton("تفعيل السرعة",UDim2.new(0.1,0,0.2,0))
local jumpBtn = createButton("النطة العالية",UDim2.new(0.1,0,0.3,0))
local godBtn = createButton("عدم الموت",UDim2.new(0.1,0,0.4,0))
local noclipBtn = createButton("اختراق الجدران",UDim2.new(0.1,0,0.5,0))
local infiniteJumpBtn = createButton("نطات لا نهائية",UDim2.new(0.1,0,0.6,0))
local autoHookBtn = createButton("امسك الأداة تلقائي",UDim2.new(0.1,0,0.7,0))

-- صندوق تعديل السرعة فوق زر السرعة
local speedBox = Instance.new("TextBox", mainGui)
speedBox.Size = UDim2.new(0.8,0,0.08,0)
speedBox.Position = UDim2.new(0.1,0,0.1,0)
speedBox.PlaceholderText = "اكتب السرعة هنا"
speedBox.Text = "80"
speedBox.TextScaled = true

-- المفتاح
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
		hum.WalkSpeed = tonumber(speedBox.Text) or 80
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

-- GodMode محمي جدًا
local godOn = false
godBtn.MouseButton1Click:Connect(function()
	godOn = not godOn
	godBtn.Text = godOn and "عدم الموت ✅" or "عدم الموت ❌"
end)

RunService.Heartbeat:Connect(function()
	if godOn and hum.Health < hum.MaxHealth then
		hum.Health = hum.MaxHealth
		hum.PlatformStand = false
		hum.Sit = false
	end
end)

-- Noclip
local noclipOn = false
noclipBtn.MouseButton1Click:Connect(function()
	noclipOn = not noclipOn
	noclipBtn.Text = noclipOn and "اختراق الجدران ✅" or "اختراق الجدران ❌"
end)

RunService.Stepped:Connect(function()
	if noclipOn and char then
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	else
		for _, part in pairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

-- نطات لا نهائية
local infiniteJumpOn = false
infiniteJumpBtn.MouseButton1Click:Connect(function()
	infiniteJumpOn = not infiniteJumpOn
	infiniteJumpBtn.Text = infiniteJumpOn and "نطات لا نهائية ✅" or "نطات لا نهائية ❌"
end)

UIS.JumpRequest:Connect(function()
	if infiniteJumpOn then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- Grapple Hook تلقائي
local autoHookOn = false
autoHookBtn.MouseButton1Click:Connect(function()
	autoHookOn = not autoHookOn
	autoHookBtn.Text = autoHookOn and "امسك الأداة ✅" or "امسك الأداة ❌"
end)

local function equipHook()
	if autoHookOn and char then
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

-- تحقق مستمر كل ثانية
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
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(keyFrame)
makeDraggable(mainGui)
