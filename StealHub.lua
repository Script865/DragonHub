-- Script داخل StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

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

-- 🟢 دالة اخفاء/اظهار الشخصية
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

	-- الاسم فوق اللاعب
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = state and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
	end
end

-- 🟢 دالة تخفي أي Brainrot مربوط باللاعب
local function setBrainrotInvisible(state)
	for _, obj in ipairs(workspace:GetChildren()) do
		if obj.Name:lower():find("brainrot") and obj:IsA("Model") or obj:IsA("Part") then
			-- تحقق إذا مربوط باللاعب
			if obj:FindFirstChildWhichIsA("WeldConstraint") or obj:FindFirstChildWhichIsA("Weld") then
				local weld = obj:FindFirstChildWhichIsA("WeldConstraint") or obj:FindFirstChildWhichIsA("Weld")
				if weld.Part0 and weld.Part0:IsDescendantOf(player.Character) or weld.Part1 and weld.Part1:IsDescendantOf(player.Character) then
					for _, p in ipairs(obj:GetDescendants()) do
						if p:IsA("BasePart") then
							p.Transparency = state and 1 or 0
						elseif p:IsA("Decal") then
							p.Transparency = state and 1 or 0
						end
					end
				end
			end
		end
	end
end

-- 🟢 زر الاختفاء
button.MouseButton1Click:Connect(function()
	isInvisible = not isInvisible
	local char = player.Character
	if char then
		setInvisible(char, isInvisible)
		setBrainrotInvisible(isInvisible)
	end
	button.Text = isInvisible and "رجوع" or "اختفاء"
end)

-- 🟢 عند الموت يرجع مرئي
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid").Died:Connect(function()
		isInvisible = false
		setInvisible(char, false)
		setBrainrotInvisible(false)
		button.Text = "اختفاء"
	end)
end)
