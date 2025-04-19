local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local NH_UI = {}
NH_UI.__index__ = NH_UI

function NH_UI:NewWindow(name: string, icon: string, bind: string)
	local window = {}
	
	local ScreenGui = Instance.new("ScreenGui")
	local UIScale = Instance.new("UIScale", ScreenGui)
	local MainFrame = Instance.new("Frame", ScreenGui)
	local AspectRatio = Instance.new("UIAspectRatioConstraint", MainFrame)
	local MainCorner = Instance.new("UICorner", MainFrame)
	local DragDetector = Instance.new("UIDragDetector", MainFrame)
	local LoadingFrame = Instance.new("Frame", MainFrame)
	local Background = Instance.new("ImageLabel", MainFrame)
	local Shadow = Instance.new("ImageLabel", MainFrame)
	local LoadingCorner = Instance.new("UICorner", LoadingFrame)
	local LoadingIcon = Instance.new("ImageLabel", LoadingFrame)
	local LoadingIconShadow = Instance.new("ImageLabel", LoadingFrame)
	local BackgroundCorner = Instance.new("UICorner", Background)
	local BackgroundStroke = Instance.new("UIStroke", Background)
	local Title = Instance.new("TextLabel", MainFrame)
	local Minimize = Instance.new("TextButton", MainFrame)
	local TabsFrame = Instance.new("ScrollingFrame", Background)
	local TabsLayout = Instance.new("UIListLayout", TabsFrame)
	local MinimizeCorner = Instance.new("UICorner", Minimize)
	local font = Font.new("rbxasset://fonts/families/Roboto.json")
	
	local items = {}
	
	local success, err = pcall(function()
		ScreenGui.Name = crypt.base64encode(`{math.random(100, 999)} NH {math.random(100, 999)}\0\2`)
	end)
	if not success then
		success, err = pcall(function()
			ScreenGui.Name = HttpService:GenerateGUID()
		end)
		if not success then warn(err) end
	end
	
	ScreenGui.DisplayOrder = 9999
	ScreenGui.ResetOnSpawn = false
	
	success, err = pcall(function()
		ScreenGui.Parent = gethui()
	end)
	if not success then
		success, err = pcall(function()
			ScreenGui.Parent = CoreGui or game.Players.LocalPlayer.PlayerGui
		end)
	end
	
	ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
	
	UIScale.Scale = 0.64
	
	MainFrame.Name = "Main"
	MainFrame.AnchorPoint = Vector2.new(.5, .5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BackgroundTransparency = 1
	MainFrame.Position = UDim2.new(.528, 0, .608, 0)
	MainFrame.Size = UDim2.new(.299, 0, .374, 0)
	MainFrame.Visible = false
	
	AspectRatio.AspectRatio = 1.55
	
	MainCorner.CornerRadius = UDim.new(.015, 0)
	
	LoadingFrame.Name = "Loading"
	LoadingFrame.BackgroundColor3 = Color3.fromRGB(23, 26, 29)
	LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
	LoadingFrame.ZIndex = 99
	
	LoadingCorner.CornerRadius = UDim.new(.025, 0)
	
	LoadingIcon.Name = "Icon"
	LoadingIcon.AnchorPoint = Vector2.new(.5, .5)
	LoadingIcon.BackgroundTransparency = 1
	LoadingIcon.Position = UDim2.new(.5, 0, .5, 0)
	LoadingIcon.Size = UDim2.new(.184, 0, .285, 0)
	LoadingIcon.ZIndex = 99
	LoadingIcon.Image = icon or "rbxassetid://73151158551827"
	LoadingIcon.ImageTransparency = 1
	
	LoadingIconShadow.Name = "Shadow"
	LoadingIconShadow.AnchorPoint = Vector2.new(.5, .5)
	LoadingIconShadow.BackgroundTransparency = 1
	LoadingIconShadow.Position = UDim2.new(.5, 0, .5, 0)
	LoadingIconShadow.Size = UDim2.new(.221, 0, .342, 0)
	LoadingIconShadow.Image = "rbxassetid://131311096880569"
	LoadingIconShadow.ImageColor3 = Color3.fromRGB(0,0,0)
	LoadingIconShadow.ImageTransparency = 1
	
	Background.Name = "Background"
	Background.AnchorPoint = Vector2.new(.5, .5)
	Background.BackgroundColor3 = Color3.fromRGB(23, 26, 29)
	Background.Position = UDim2.new(.5, 0, .5, 0)
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.ImageTransparency = 1
	
	BackgroundCorner.CornerRadius = UDim.new(.025, 0)
	
	BackgroundStroke.Thickness = 5
	BackgroundStroke.Color = Color3.fromRGB(5, 5, 5)
	
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(.5, .5)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(.5, 0, .5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = -1
	Shadow.Image = "rbxassetid://14001321443"
	Shadow.ImageColor3 = Color3.fromRGB(33, 33, 33)
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(150, 150, 150, 150)
	Shadow.SliceScale = 0.99
	
	local font = Font.new("rbxasset://fonts/families/Roboto.json")
	font.Weight = Enum.FontWeight.Bold
	font.Style = Enum.FontStyle.Italic
	Title.Name = "Title"
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(.015, 0, 0, 0)
	Title.Size = UDim2.new(.622, 0, .065, 0)
	Title.FontFace = font
	Title.Text = name or "Nihility Hub"
	Title.TextColor3 = Color3.fromRGB(216, 216, 216)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextScaled = true
	Title.ZIndex = 10
	
	Minimize.Name = "Minimize"
	Minimize.BackgroundColor3 = Color3.fromRGB(34, 39, 39)
	Minimize.Position = UDim2.new(.959, 0, .011, 0)
	Minimize.Size = UDim2.new(.035, 0, .054, 0)
	Minimize.Font = Enum.Font.Roboto
	Minimize.Text = "-"
	Minimize.TextColor3 = Color3.fromRGB(190, 190, 190)
	Minimize.TextScaled = true
	Minimize.ZIndex = 10
	
	MinimizeCorner.CornerRadius = UDim.new(1, 0)
	
	TabsFrame.Name = "Tabs"
	TabsFrame.BackgroundTransparency = 1
	TabsFrame.Position = UDim2.new(0, 0, .097, 0)
	TabsFrame.Size = UDim2.new(.2, 0, .903, 0)
	TabsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	TabsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsFrame.ScrollBarThickness = 4
	TabsFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	
	local BaseSize = MainFrame.Size
	local MinimizeDebounce = false
	
	local function OpenUI()
		MainFrame.Size = UDim2.new(0, 0, 0, 0)
		LoadingIcon.ImageTransparency = 1
		LoadingIconShadow.ImageTransparency = 1
		LoadingFrame.BackgroundTransparency = 0
		MainFrame.Visible = true
		LoadingFrame.ZIndex = 99

		local openTween = TweenService:Create(
			MainFrame,
			TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["Size"] = BaseSize
			}
		)
		openTween:Play()
		openTween.Completed:Wait()

		task.wait(.35)

		local iconTween = TweenService:Create(
			LoadingIcon,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 0
			}
		)
		local shadowTween = TweenService:Create(
			LoadingIconShadow,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 0
			}
		)
		iconTween:Play()
		shadowTween:Play()
		shadowTween.Completed:Wait()

		task.wait(.2)

		local iconSpinTween = TweenService:Create(
			LoadingIcon,
			TweenInfo.new(.85, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["Rotation"] = 360
			}
		)
		iconSpinTween:Play()
		iconSpinTween.Completed:Wait()

		task.wait(.4)

		local iconFadeTween = TweenService:Create(
			LoadingIcon,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 1
			}
		)
		local shadowFadeTween = TweenService:Create(
			LoadingIconShadow,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 1
			}
		)
		local backgroundFadeTween = TweenService:Create(
			LoadingFrame,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["BackgroundTransparency"] = 1
			}
		)
		iconFadeTween:Play()
		shadowFadeTween:Play()
		backgroundFadeTween:Play()
	end
	
	local function minimizeAndExpand(minimizing)
		if MinimizeDebounce then return end
		MinimizeDebounce = true
		
		if minimizing then
			LoadingFrame.ZIndex = 9
			
			local loadingFadeTween = TweenService:Create(
				LoadingFrame,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["BackgroundTransparency"] = 0
				}
			)
			loadingFadeTween:Play()
			loadingFadeTween.Completed:Wait()
			Background.Visible = false
			
			task.wait(.1)
			
			local minBackgroundTween = TweenService:Create(
				LoadingFrame,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Size"] = UDim2.new(1, 0, 0.077, 0)
				}
			)
			local minShadowTween = TweenService:Create(
				Shadow,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Position"] = UDim2.new(0.498, 0, 0.041, 0),
					["Size"] = UDim2.new(0.95, 40, 0.003, 40)
				}
			)
			minBackgroundTween:Play()
			minShadowTween:Play()
			minShadowTween.Completed:Wait()
			
			Minimize.Text = "+"
		else
			LoadingFrame.ZIndex = 9
			LoadingIcon.Rotation = 0

			local expBackgroundTween = TweenService:Create(
				LoadingFrame,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Size"] = UDim2.new(1, 0, 1, 0)
				}
			)
			local expShadowTween = TweenService:Create(
				Shadow,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Position"] = UDim2.new(0.5, 0, 0.5, 0),
					["Size"] = UDim2.new(1, 40, 1, 40)
				}
			)
			expBackgroundTween:Play()
			expShadowTween:Play()
			expShadowTween.Completed:Wait()
			
			Background.Visible = true
			Minimize.Text = "-"
			
			task.wait(.15)

			local iconTween = TweenService:Create(
				LoadingIcon,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 0
				}
			)
			local shadowTween = TweenService:Create(
				LoadingIconShadow,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 0
				}
			)
			iconTween:Play()
			shadowTween:Play()
			shadowTween.Completed:Wait()

			task.wait(.2)

			local iconSpinTween = TweenService:Create(
				LoadingIcon,
				TweenInfo.new(.85, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Rotation"] = 360
				}
			)
			iconSpinTween:Play()
			iconSpinTween.Completed:Wait()

			task.wait(.4)

			local iconFadeTween = TweenService:Create(
				LoadingIcon,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 1
				}
			)
			local shadowFadeTween = TweenService:Create(
				LoadingIconShadow,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 1
				}
			)
			local backgroundFadeTween = TweenService:Create(
				LoadingFrame,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["BackgroundTransparency"] = 1
				}
			)
			iconFadeTween:Play()
			shadowFadeTween:Play()
			backgroundFadeTween:Play()
			backgroundFadeTween.Completed:Wait()
		end
		
		task.wait(.15)
		
		MinimizeDebounce = false
	end
	
	Minimize.MouseButton1Click:Connect(function()	
		minimizeAndExpand(Background.Visible)
	end)
	
	function window:NewTab(tabName: string, info: string)
		local tab = {}
		
		tabName = tabName or "Tab".. #items + 1
		items[tabName] = {}
		
		local TabFrame = Instance.new("ImageLabel", TabsFrame)
		local TabButton = Instance.new("TextButton", TabFrame)
		local TabButtonCorner = Instance.new("UICorner", TabButton)
		local TabButtonStroke = Instance.new("UIStroke", TabButton)
		local TabText = Instance.new("TextLabel", TabButton)
		local TabTextConstraint = Instance.new("UITextSizeConstraint", TabText)
		
		TabFrame.Name = tabName
		TabFrame.BackgroundTransparency = 1
		TabFrame.Size = UDim2.new(1, 0, .132, 0)
		TabFrame.Image = "rbxassetid://14001321443"
		TabFrame.ImageColor3 = Color3.fromRGB(18, 18, 18)
		TabFrame.ScaleType = Enum.ScaleType.Slice
		TabFrame.SliceCenter = Rect.new(150, 150, 150, 150)
		
		TabButton.Name = "Button"
		TabButton.AnchorPoint = Vector2.new(.5, .5)
		TabButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
		TabButton.Position = UDim2.new(.5, 0, .5, 0)
		TabButton.Size = UDim2.new(.883, 0, .726, 0)
		TabButton.Text = ""
		
		TabButtonCorner.CornerRadius = UDim.new(.15, 0)
		
		TabButtonStroke.Color = Color3.fromRGB(6, 6, 6)
		TabButtonStroke.Thickness = 4
		
		local font = Font.new("rbxasset://fonts/families/Roboto.json")
		font.Weight = Enum.FontWeight.Medium
		TabText.Name = "Title"
		TabText.AnchorPoint = Vector2.new(.5, .5)
		TabText.BackgroundTransparency = 1
		TabText.Position = UDim2.new(.5, 0, .5, 0)
		TabText.Size = UDim2.new(.9, 0, .95, 0)
		TabText.FontFace = font
		TabText.Text = tabName
		TabText.TextColor3 = Color3.fromRGB(214, 214, 214)
		TabText.TextScaled = true
		
		TabTextConstraint.MaxTextSize = 22
		
		TabButton.MouseButton1Click:Connect(function()
			
		end)
		
		function tab:NewButton(name: string, info: string, callback)
			name = name or "Item".. #items[tabName] + 1
			items[tabName][name] = {name, info, callback}
			
			
		end
		
		return tab
	end
	
	OpenUI()
	
	return window
end

return NH_UI
