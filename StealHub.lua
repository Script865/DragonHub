-- Script داخل StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 🟢 GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "اختفاء"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 40)
button.Position = UDim2.new(0, 10, 0, 10) -- أعلى يسار
button.Text = "اختفاء"
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = screenGui

-- 🟢 حالة الاختفاء
local isInvisible = false

-- 🟢 دالة اخفاء/اظهار الشخصية كاملة
local function setInvisible(char, state)
	if not char then return end

	for _, obj in ipairs(char:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Transparency = state and 1 or 0
			if obj.Name ~= "HumanoidRootPart" then
				obj.CanCollide = not state
			end
		elseif obj:IsA("Decal") then
			obj.Transparency = state and 1 or 0
		end
	end

	-- اخفاء الاسم فوق اللاعب
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = state and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
	end
end

-- 🟢 زر الاختفاء
button.MouseButton1Click:Connect(function()
	isInvisible = not isInvisible
	local char = player.Character
	if char then
		setInvisible(char, isInvisible)
	end
	button.Text = isInvisible and "رجوع" or "اختفاء"
end)

-- 🟢 لما يموت اللاعب يرجع مرئي
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid").Died:Connect(function()
		isInvisible = false
		setInvisible(char, false)
		button.Text = "اختفاء"
	end)
end)	local char = player.Character
	if char then
		setInvisible(char, isInvisible)
	end
	button.Text = isInvisible and "رجوع" or "اختفاء"
end)

-- 🟢 يرجع مرئي لو مات
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid").Died:Connect(function()
		isInvisible = false
		setInvisible(char, false)
		button.Text = "اختفاء"
	end)
end)
