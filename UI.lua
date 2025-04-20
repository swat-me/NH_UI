local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

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
	local ItemsFrame = Instance.new("ScrollingFrame", Background)
	local ItemsLayout = Instance.new("UIGridLayout", ItemsFrame)
	local InfoMain = Instance.new("ImageLabel", ScreenGui)
	local InfoFrame = Instance.new("Frame", InfoMain)
	local InfoFrameCorner = Instance.new("UICorner", InfoFrame)
	local InfoText = Instance.new("TextLabel", InfoFrame)
	local InfoTextConstraint = Instance.new("UITextSizeConstraint", InfoText)
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
		print("No gethui")
		success, err = pcall(function()
			ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer.PlayerGui
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
	Minimize.AutoButtonColor = false
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
	
	ItemsFrame.Name = "Items"
	ItemsFrame.BackgroundTransparency = 1
	ItemsFrame.Position = UDim2.new(.234, 0, .113, 0)
	ItemsFrame.Size = UDim2.new(.76, 0, .887, 0)
	ItemsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ItemsFrame.ScrollBarThickness = 4
	
	ItemsLayout.CellSize = UDim2.new(.95, 0, 0, 100)
	ItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder 
	
	InfoMain.Name = "InfoBox"
	InfoMain.AnchorPoint = Vector2.new(.5,.5)
	InfoMain.BackgroundTransparency = 1
	InfoMain.Size = UDim2.new(.055, 40, .045, 40)
	InfoMain.ZIndex = 999
	InfoMain.Visible = false
	InfoMain.Image = "rbxassetid://14001321443"
	InfoMain.ImageColor3 = Color3.fromRGB(33, 33, 33)
	InfoMain.ScaleType = Enum.ScaleType.Slice
	InfoMain.SliceCenter = Rect.new(150, 150, 150, 150)
	InfoMain.SliceScale = .99
	
	InfoFrame.Name = "Main"
	InfoFrame.AnchorPoint = Vector2.new(.5, .5)
	InfoFrame.BackgroundColor3 = Color3.fromRGB(31, 34, 40)
	InfoFrame.Position = UDim2.new(.5, 0, .5, 0)
	InfoFrame.Size = UDim2.new(.93, 0, .89, 0)
	InfoFrame.ZIndex = 9999
	
	InfoFrameCorner.CornerRadius = UDim.new(.08, 0)
	
	local font = Font.new("rbxasset://fonts/families/Roboto.json")
	font.Weight = Enum.FontWeight.Medium
	InfoText.Name = "Text"
	InfoText.AnchorPoint = Vector2.new(.5, .5)
	InfoText.BackgroundTransparency = 1
	InfoText.Position = UDim2.new(.5, 0, .5, 0)
	InfoText.Size = UDim2.new(1, 0, .9, 0)
	InfoText.ZIndex = 9999
	InfoText.FontFace = font
	InfoText.Text = "Info"
	InfoText.TextColor3 = Color3.fromRGB(171, 171, 171)
	InfoText.TextScaled = true
	
	InfoTextConstraint.MaxTextSize = 14
	
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
	
	local switchingTabs = false
	local function switchTabs(tab, tabItems)
		for _, item in pairs(ItemsFrame:GetChildren()) do
			if item ~= ItemsLayout then
				item:Destroy()
			end
		end

		for _, itemData in ipairs(tabItems) do
			if itemData[1] == "Button" then
				tab:NewButton(itemData[2], itemData[3], itemData[4])
			elseif itemData[1] == "Toggle" then
				tab:NewToggle(itemData[2], itemData[3], itemData[4], itemData[5])
			end
		end

		switchingTabs = false
	end
	
	function window:NewTab(tabName: string, info: string)
		local tab = {}
		
		tabName = tabName or "Tab".. #items + 1
		info = info or ""
		items[tab] = {tab, {}}
		
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
		TabButton.AutoButtonColor = false
		
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
			if switchingTabs then return end
			switchingTabs = true
			print(items)
			switchTabs(tab, items[tab][2])
		end)
		
		function tab:NewButton(name: string, info: string, callback: () -> ())
			local button = {}
			
			name = name or "Item".. #items[tab][2] + 1
			info = info or ""
			callback = callback or function() end
			local order = #ItemsFrame:GetChildren()
			
			items[tab][2][order] = {
				"Button",
				name,
				info,
				callback,
			}
			
			local buttonFrame = Instance.new("ImageLabel", ItemsFrame)
			local buttonAspectRatio = Instance.new("UIAspectRatioConstraint", buttonFrame)
			local infoButton = Instance.new("TextButton", buttonFrame)
			local infoButtonCorner = Instance.new("UICorner", infoButton)
			local buttonButton = Instance.new("TextButton", buttonFrame)
			local buttonButtonCorner = Instance.new("UICorner", buttonButton)
			local buttonButtonStroke = Instance.new("UIStroke", buttonButton)
			local buttonTitle = Instance.new("TextLabel", buttonButton)
			local buttonTitleConstraint = Instance.new("UITextSizeConstraint", buttonTitle)
			
			buttonFrame.Name = name
			buttonFrame.BackgroundTransparency = 1
			buttonFrame.Image = "rbxassetid://14001321443"
			buttonFrame.ImageColor3 = Color3.fromRGB(18, 18, 18)
			buttonFrame.ScaleType = Enum.ScaleType.Slice
			buttonFrame.SliceCenter = Rect.new(150, 150, 150, 150)
			
			buttonAspectRatio.AspectRatio = 8.18
			
			infoButton.Name = "Info"
			infoButton.BackgroundColor3 = Color3.fromRGB(34, 39, 39)
			infoButton.Position = UDim2.new(.959, 0, .011, 0)
			infoButton.Size = UDim2.new(.035, 0, .279, 0)
			infoButton.Font = Enum.Font.Roboto
			infoButton.Text = "?"
			infoButton.TextColor3 = Color3.fromRGB(190, 190, 190)
			infoButton.TextScaled = true
			infoButton.ZIndex = 2
			infoButton.AutoButtonColor = false
			infoButton.Visible = (info ~= "" and true) or false
			
			infoButtonCorner.CornerRadius = UDim.new(1, 0)
			
			buttonButton.Name = "Button"
			buttonButton.AnchorPoint = Vector2.new(.5, .5)
			buttonButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
			buttonButton.Position = UDim2.new(.5, 0, .5, 0)
			buttonButton.Size = UDim2.new(.965, 0, .726, 0)
			buttonButton.Text = ""
			buttonButton.AutoButtonColor = false
			
			buttonButtonCorner.CornerRadius = UDim.new(.15, 0)
			
			buttonButtonStroke.Color = Color3.fromRGB(6, 6, 6)
			buttonButtonStroke.Thickness = 4
			
			local font = Font.new("rbxasset://fonts/families/Roboto.json")
			font.Weight = Enum.FontWeight.Medium
			buttonTitle.Name = "Title"
			buttonTitle.BackgroundTransparency = 1
			buttonTitle.AnchorPoint = Vector2.new(.5, .5)
			buttonTitle.Position = UDim2.new(.502, 0, .5, 0)
			buttonTitle.Size = UDim2.new(.947, 0, .95, 0)
			buttonTitle.FontFace = font
			buttonTitle.Text = name
			buttonTitle.TextColor3 = Color3.fromRGB(214, 214, 214)
			buttonTitle.TextScaled = true
			
			buttonTitleConstraint.MaxTextSize = 22
			
			buttonButton.MouseEnter:Connect(function()
				buttonButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			end)
			
			buttonButton.MouseButton1Down:Connect(function()
				buttonButton.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
			end)
			
			buttonButton.MouseLeave:Connect(function()
				buttonButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
			end)
			
			buttonButton.MouseButton1Up:Connect(function()
				buttonButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			end)
			
			infoButton.MouseEnter:Connect(function()
				local mouse = UIS:GetMouseLocation()
				local inset = game:GetService("GuiService"):GetGuiInset()
				mouse = mouse - inset

				local posX = (mouse.X - InfoMain.Parent.AbsolutePosition.X) / UIScale.Scale
				local posY = (mouse.Y - InfoMain.Parent.AbsolutePosition.Y - 50) / UIScale.Scale

				InfoMain.Position = UDim2.new(0, posX, 0, posY)
				InfoText.Text = info
				InfoMain.Visible = true
			end)
			
			infoButton.MouseLeave:Connect(function()
				InfoMain.Visible = false
			end)
			
			buttonButton.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
			
			return button
		end
		
		function tab:NewToggle(name: string, info: string, initialState: boolean, callback: () -> ())
			local toggle = {}
			
			name = name or "Item".. #items[tab][2] + 1
			info = info or ""
			callback = callback or function() end
			local state = initialState or false
			local order = #ItemsFrame:GetChildren()

			items[tab][2][order] = {
				"Toggle",
				name,
				info,
				state,
				callback,
			}
			
			local ToggleFrame = Instance.new("ImageLabel", ItemsFrame)
			local ToggleAspectRatio = Instance.new("UIAspectRatioConstraint", ToggleFrame)
			local ToggleState = Instance.new("Frame", ToggleFrame)
			local ToggleStateCorner = Instance.new("UICorner", ToggleState)
			local ToggleStateStroke = Instance.new("UIStroke", ToggleState)
			local ToggleStateButton = Instance.new("TextButton", ToggleState)
			local ToggleStateButtonCorner = Instance.new("UICorner", ToggleStateButton)
			local InfoButton = Instance.new("TextButton", ToggleFrame)
			local InfoButtonCorner = Instance.new("UICorner", InfoButton)
			local ToggleButton = Instance.new("TextButton", ToggleFrame)
			local ToggleButtonCorner = Instance.new("UICorner", ToggleButton)
			local ToggleButtonStroke = Instance.new("UIStroke", ToggleButton)
			local ToggleText = Instance.new("TextLabel", ToggleButton)
			local ToggleTextConstraint = Instance.new("UITextSizeConstraint", ToggleText)
			local switchingState = false
			
			ToggleFrame.Name = name
			ToggleFrame.BackgroundTransparency = 1
			ToggleFrame.Image = "rbxassetid://14001321443"
			ToggleFrame.ImageColor3 = Color3.fromRGB(18, 18, 18)
			ToggleFrame.ScaleType = Enum.ScaleType.Slice
			ToggleFrame.SliceCenter = Rect.new(150, 150, 150, 150)
			
			ToggleAspectRatio.AspectRatio = 8.18
			
			ToggleState.Name = "State"
			ToggleState.AnchorPoint = Vector2.new(0, .5)
			ToggleState.BackgroundColor3 = Color3.fromRGB(39, 40, 44)
			ToggleState.Position = UDim2.new(.719, 0, .5, 0)
			ToggleState.Size = UDim2.new(.21, 0, .561, 0)
			ToggleState.ZIndex = 2
			
			ToggleStateCorner.CornerRadius = UDim.new(.2, 0)
			
			ToggleStateStroke.Thickness = 2
			
			ToggleStateButton.Name = "Button"
			ToggleStateButton.AutoButtonColor = false
			ToggleStateButton.BackgroundColor3 = Color3.fromRGB(231, 72, 72)
			ToggleStateButton.Position = UDim2.new(.5, 0, 0, 0)
			ToggleStateButton.Size = UDim2.new(.5, 0, 1, 0)
			ToggleStateButton.Text = ""
			ToggleStateButton.ZIndex = 2
			
			ToggleStateButtonCorner.CornerRadius = UDim.new(.25, 0)
			
			InfoButton.Name = "Info"
			InfoButton.BackgroundColor3 = Color3.fromRGB(34, 39, 39)
			InfoButton.AutoButtonColor = false
			InfoButton.Position = UDim2.new(.959, 0, .011, 0)
			InfoButton.Size = UDim2.new(.035, 0, .279, 0)
			InfoButton.ZIndex = 2
			InfoButton.Font = Enum.Font.Roboto
			InfoButton.Text = "?"
			InfoButton.TextColor3 = Color3.fromRGB(190, 190, 190)
			InfoButton.TextScaled = true
			InfoButton.Visible = (info ~= "" and true) or false

			
			InfoButtonCorner.CornerRadius = UDim.new(1, 0)
			
			ToggleButton.Name = "Button"
			ToggleButton.AnchorPoint = Vector2.new(.5, .5)
			ToggleButton.AutoButtonColor = false
			ToggleButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
			ToggleButton.Position = UDim2.new(.5, 0, .5, 0)
			ToggleButton.Size = UDim2.new(.965, 0, .726, 0)
			ToggleButton.Text = ""
			
			ToggleButtonCorner.CornerRadius = UDim.new(.15, 0)
			
			ToggleButtonStroke.Color = Color3.fromRGB(6, 6, 6)
			ToggleButtonStroke.Thickness = 4
			
			local font = Font.new("rbxasset://fonts/families/Roboto.json")
			font.Weight = Enum.FontWeight.Medium
			ToggleText.Name = "Title"
			ToggleText.AnchorPoint = Vector2.new(.5, .5)
			ToggleText.BackgroundTransparency = 1
			ToggleText.Position = UDim2.new(.369, 0, .5, 0)
			ToggleText.Size = UDim2.new(.68, 0, .95, 0)
			ToggleText.FontFace = font
			ToggleText.Text = name
			ToggleText.TextColor3 = Color3.fromRGB(214, 214, 214)
			ToggleText.TextScaled = true
			
			ToggleTextConstraint.MaxTextSize = 22
			
			ToggleButton.MouseEnter:Connect(function()
				ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			end)

			ToggleButton.MouseButton1Down:Connect(function()
				ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
			end)

			ToggleButton.MouseLeave:Connect(function()
				ToggleButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
			end)

			ToggleButton.MouseButton1Up:Connect(function()
				ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			end)

			InfoButton.MouseEnter:Connect(function()
				local mouse = UIS:GetMouseLocation()
				local inset = game:GetService("GuiService"):GetGuiInset()
				mouse = mouse - inset

				local posX = (mouse.X - InfoMain.Parent.AbsolutePosition.X) / UIScale.Scale
				local posY = (mouse.Y - InfoMain.Parent.AbsolutePosition.Y - 50) / UIScale.Scale

				InfoMain.Position = UDim2.new(0, posX, 0, posY)
				InfoText.Text = info
				InfoMain.Visible = true
			end)

			InfoButton.MouseLeave:Connect(function()
				InfoMain.Visible = false
			end)
			
			local function switchState(newState)
				items[tab][2][order] = {"Toggle", name, info, newState, callback}
				
				pcall(function()
					callback(newState)
				end)

				local stateSwitchTween = TweenService:Create(
					ToggleStateButton,
					TweenInfo.new(.2, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
					{
						["BackgroundColor3"] = (newState and Color3.fromRGB(67, 231, 100)) or Color3.fromRGB(231, 72, 72),
						["Position"] = (newState and UDim2.new(0, 0, 0, 0)) or UDim2.new(.5, 0, 0, 0)
					}
				)
				stateSwitchTween:Play()
			end
			
			ToggleButton.MouseButton1Click:Connect(function()
				state = not state
				switchState(state)
			end)
			
			ToggleStateButton.MouseButton1Click:Connect(function()
				state = not state
				switchState(state)
			end)
			
			switchState(state)
			
			return toggle
		end
		
		return tab
	end
	
	if #items > 0 then
		switchTabs(items[1], items[1][2])
	end
	
	OpenUI()
	
	return window
end

return NH_UI
