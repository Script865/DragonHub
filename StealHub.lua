-- Script داخل StarterPlayerScripts
-- يعمل كل شيء بدون RemoteEvent

local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- 🟢 إنشاء GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "اختفاء"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "ToggleButton"
button.Size = UDim2.new(0, 100, 0, 40)
button.Position = UDim2.new(0, 10, 0, 10) -- أعلى يسار
button.Text = "اختفاء"
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = screenGui

-- 🟢 حالة الاختفاء
local isInvisible = false

-- 🟢 دالة اخفاء/اظهار
local function setInvisible(char, state)
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = state and 1 or 0
			if part.Name ~= "HumanoidRootPart" then
				part.CanCollide = not state
			end
		elseif part:IsA("Decal") then
			part.Transparency = state and 1 or 0
		end
	end

	-- الاسم فوق اللاعب
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = state and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
	end

	-- اخفاء Brainrot لو اللاعب يسرق
	local brainrot = char:FindFirstChild("Brainrot") or char:FindFirstChild("BrainrotTool")
	if brainrot then
		for _, p in ipairs(brainrot:GetDescendants()) do
			if p:IsA("BasePart") or p:IsA("Decal") then
				p.Transparency = state and 1 or 0
			end
		end
	end

	-- اخفاء كلمة stole لو موجودة
	local stole = char:FindFirstChild("stole")
	if stole and stole:IsA("BasePart") then
		stole.Transparency = state and 1 or 0
	end
end

-- 🟢 عند ضغط الزر
button.MouseButton1Click:Connect(function()
	isInvisible = not isInvisible
	local char = player.Character
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
