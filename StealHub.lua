-- StealHub Full Script مع زر النزول (حفظ ارتفاع فقط)
local player = game.Players.LocalPlayer

-- GUI الأساسي
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StealHub"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame إدخال المفتاح
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
keyFrame.Parent = screenGui

-- TextBox لكتابة المفتاح
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8, 0, 0.3, 0)
keyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
keyBox.PlaceholderText = "اكتب المفتاح هنا"
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.Parent = keyFrame

-- زر التأكيد
local confirmBtn = Instance.new("TextButton")
confirmBtn.Size = UDim2.new(0.5, 0, 0.25, 0)
confirmBtn.Position = UDim2.new(0.25, 0, 0.6, 0)
confirmBtn.Text = "تأكيد المفتاح"
confirmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
confirmBtn.TextScaled = true
confirmBtn.Parent = keyFrame

-- GUI الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 250)
mainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- صندوق لكتابة السرعة
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.8, 0, 0.2, 0)
speedBox.Position = UDim2.new(0.1, 0, 0.05, 0)
speedBox.Text = "80"
speedBox.TextScaled = true
speedBox.Parent = mainFrame

-- زر السرعة
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0.8, 0, 0.18, 0)
speedBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
speedBtn.Text = "تفعيل السرعة"
speedBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
speedBtn.TextScaled = true
speedBtn.Parent = mainFrame

-- زر الرفع
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.8, 0, 0.18, 0)
flyBtn.Position = UDim2.new(0.1, 0, 0.52, 0)
flyBtn.Text = "الرفع عالياً"
flyBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
flyBtn.TextScaled = true
flyBtn.Parent = mainFrame

-- زر النزول
local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0.8, 0, 0.18, 0)
downBtn.Position = UDim2.new(0.1, 0, 0.74, 0)
downBtn.Text = "النزول"
downBtn.BackgroundColor3 = Color3.fromRGB(0,0,200)
downBtn.TextScaled = true
downBtn.Parent = mainFrame

-- المفتاح الصحيح
local correctKey = "stealhub"

-- حفظ الارتفاع الأصلي
local oldY = nil

-- التأكد من Grapple Hook
local function getHook()
	local backpack = player:WaitForChild("Backpack")
	local hook = backpack:FindFirstChild("Grapple Hook") or (player.Character and player.Character:FindFirstChild("Grapple Hook"))
	if hook then
		player.Character.Humanoid:EquipTool(hook)
	end
end

-- وظيفة التأكيد
confirmBtn.MouseButton1Click:Connect(function()
	if string.lower(keyBox.Text) == string.lower(correctKey) then
		keyFrame.Visible = false
		mainFrame.Visible = true
	end
end)

-- زر السرعة
speedBtn.MouseButton1Click:Connect(function()
	getHook()
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local newSpeed = tonumber(speedBox.Text) or 80
		humanoid.WalkSpeed = newSpeed
	end
end)

-- زر الرفع
flyBtn.MouseButton1Click:Connect(function()
	getHook()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		oldY = player.Character.HumanoidRootPart.Position.Y -- حفظ الارتفاع
		player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0,150,0)
	end
end)

-- زر النزول (ينزل بنفس المكان الحالي لكن على الارتفاع القديم)
downBtn.MouseButton1Click:Connect(function()
	if oldY and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		getHook()
		local root = player.Character.HumanoidRootPart
		local pos = root.Position
		root.CFrame = CFrame.new(pos.X, oldY, pos.Z) * root.CFrame.Rotation
	end
end)

-- إذا حاول يشيل Grapple Hook يرجعه
player.CharacterAdded:Connect(function(char)
	char.ChildRemoved:Connect(function(child)
		if child.Name == "Grapple Hook" then
			task.wait(0.2)
			getHook()
		end
	end)
end)
