local TS = game:GetService("TweenService")
local Http = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local NH_UI = {}
NH_UI.__index = NH_UI

local function create(class, props)
	local instance = Instance.new(class)
	for prop, value in pairs(props) do
		if prop ~= "Parent" then
			if type(value) == "table" then
				instance[prop] = UDim2.new(unpack(value))
			else
				instance[prop] = value
			end
		end
	end
	instance.Parent = props.Parent or game.Players.LocalPlayer.PlayerGui
	return instance
end

local function shortenText(text, maxChars)
	local chars = string.split(text)
	
	if #chars > maxChars then
		local final = ""
		for i=1, maxChars do
			final = final.. chars[i]
		end
		
		return final.. "..."
	else
		return text
	end
end

function NH_UI:NewWindow(name: string, icon: string, bind: string)
	local window = {}
	
	local success, err, windowParent, windowName
	local font = Font.new("rbxasset://fonts/families/Roboto.json")
	
	-- Set the name of the window
	success, err = pcall(function()
		windowName = crypt.base64encode(`{math.random(100, 999)} NH {math.random(100, 999)}`)
	end)
	if not success then
		success, err = pcall(function()
			windowName = Http:GenerateGUID(false)
		end)
		if not success then warn(err) end
	end
	
	-- Get the parent for the window
	success, err = pcall(function()
		windowParent = gethui()
	end)
	if not success then
		windowParent = game.Players.LocalPlayer.PlayerGui
	end
	
	print(windowParent, windowName)
	
	-- Create window
	local screenGui = create("ScreenGui", {
		Name = windowName,
		DisplayOrder = 9999,
		ResetOnSpawn = false,
		Parent = windowParent
	})
	
	local UIScale = create("UIScale", {
		Scale = .64,
		Parent = screenGui
	})
	
	local mainFrame = create("Frame", {
		Name = "Main",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(.528, 0, .608, 0),
		Size = UDim2.new(.299, 0, .374, 0),
		Visible = false,
		Parent = screenGui
	})
	
	create("UIAspectRatioConstraint", {
		AspectRatio = 1.55,
		Parent = mainFrame
	})
	
	create("UICorner", {
		CornerRadius = UDim.new(.015, 0),
		Parent = mainFrame
	})
	
	local loadingFrame = create("Frame", {
		Name = "Loading",
		BackgroundColor3 = Color3.fromRGB(23, 26, 29),
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 99,
		Parent = mainFrame
	})
		
	local loadingIcon = create("ImageLabel", {
		Name = "Icon",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(.184, 0, .285, 0),
		ZIndex = 99,
		Image = icon or "rbxassetid://73151158551827",
		ImageTransparency = 1,
		Parent = loadingFrame
	})
	
	local loadingIconShadow = create("ImageLabel", {
		Name = "Shadow",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(.221, 0, .342, 0),
		Image = "rbxassetid://131311096880569",
		ImageColor3 = Color3.fromRGB(0,0,0),
		ImageTransparency = 1,
		Parent = loadingFrame
	})
	
	create("UICorner", {
		CornerRadius = UDim.new(.025, 0),
		Parent = loadingFrame
	})
	
	local background = create("ImageLabel", {
		Name = "Background",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundColor3 = Color3.fromRGB(23, 26, 29),
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(1, 0, 1, 0),
		ImageTransparency = 1,
		Parent = mainFrame
	})
	
	create("UICorner", {
		CornerRadius = UDim.new(.025, 0),
		Parent = background
	})
	
	create("UIStroke", {
		Thickness = 5,
		Color = Color3.fromRGB(5, 5, 5),
		Parent = background
	})
	
	create("UIDragDetector", {Parent = mainFrame})
	
	local shadow = create("ImageLabel", {
		Name = "Shadow",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(1, 40, 1, 40),
		ZIndex = -1,
		Image = "rbxassetid://14001321443",
		ImageColor3 = Color3.fromRGB(13, 13, 13),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(150, 150, 150, 150),
		SliceScale = 0.99,
		Parent = mainFrame
	})
	
	font.Weight = Enum.FontWeight.Bold
	font.Style = Enum.FontStyle.Italic
	local title = create("TextLabel", {
		Name = "Title",
		BackgroundTransparency = 1,
		Position = UDim2.new(.015, 0, 0, 0),
		Size = UDim2.new(.622, 0, .065, 0),
		FontFace = font,
		Text = name or "Nihility Hub",
		TextColor3 = Color3.fromRGB(216, 216, 216),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextScaled = true,
		ZIndex = 10,
		Parent = mainFrame
	})
	
	local minimize = create("TextButton", {
		Name = "Minimize",
		BackgroundColor3 = Color3.fromRGB(34, 39, 39),
		Position = UDim2.new(.959, 0, .011, 0),
		Size = UDim2.new(.035, 0, .054, 0),
		Font = Enum.Font.Roboto,
		Text = "-",
		TextColor3 = Color3.fromRGB(190, 190, 190),
		AutoButtonColor = false,
		TextScaled = true,
		ZIndex = 10,
		Parent = mainFrame
	})
	
	create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = minimize
	})
	
	local tabsFrame = create("ScrollingFrame", {
		Name = "Tabs",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, .097, 0),
		Size = UDim2.new(.2, 0, .903, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 4,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = background
	})
	
	local tabLayout = create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 5),
		Parent = tabsFrame
	})
	
	local itemsFrame = create("ScrollingFrame", {
		Name = "Items",
		BackgroundTransparency = 1,
		Position = UDim2.new(.234, 0, .113, 0),
		Size = UDim2.new(.76, 0, .887, 0),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 4,
		Parent = background
	})
	
	local itemsLayout = create("UIGridLayout", {
		CellSize = UDim2.new(.95, 0, 0, 100),
		SortOrder = Enum.SortOrder.LayoutOrder, 
		Parent = itemsFrame
	})
	
	local infoMain = create("ImageLabel", {
		Name = "InfoBox",
		AnchorPoint = Vector2.new(.5,.5),
		BackgroundTransparency = 1,
		Size = UDim2.new(.055, 40, .045, 40),
		ZIndex = 999,
		Visible = false,
		Image = "rbxassetid://14001321443",
		ImageColor3 = Color3.fromRGB(33, 33, 33),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(150, 150, 150, 150),
		SliceScale = .99,
		Parent = screenGui
	})
	
	local infoFrame = create("Frame", {
		Name = "Main",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundColor3 = Color3.fromRGB(31, 34, 40),
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(.93, 0, .89, 0),
		ZIndex = 9999,
		Parent = infoMain
	})
	
	create("UICorner", {
		CornerRadius = UDim.new(.08, 0),
		Parent = infoFrame
	})
	
	font.Weight = Enum.FontWeight.Medium
	font.Style = Enum.FontStyle.Normal
	local infoText = create("TextLabel", {
		Name = "Text",
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(.5, 0, .5, 0),
		Size = UDim2.new(1, 0, .9, 0),
		ZIndex = 9999,
		FontFace = font,
		Text = "Info",
		TextColor3 = Color3.fromRGB(171, 171, 171),
		TextScaled = true,
		Parent = infoFrame
	})
	
	create("UITextSizeConstraint", {
		MaxTextSize = 14,
		Parent = infoText
	})
	
	local baseSize = mainFrame.Size
	local minimizeDebounce = false
	
	local function OpenUI()
		mainFrame.Size = UDim2.new(0, 0, 0, 0)
		loadingIcon.ImageTransparency = 1
		loadingIconShadow.ImageTransparency = 1
		loadingFrame.BackgroundTransparency = 0
		mainFrame.Visible = true
		loadingFrame.ZIndex = 99
		
		local openTween = TS:Create(
			mainFrame,
			TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["Size"] = baseSize
			}
		)
		openTween:Play()
		openTween.Completed:Wait()

		task.wait(.35)

		local iconTween = TS:Create(
			loadingIcon,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 0
			}
		)
		local shadowTween = TS:Create(
			loadingIconShadow,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 0
			}
		)
		iconTween:Play()
		shadowTween:Play()
		shadowTween.Completed:Wait()

		task.wait(.2)

		local iconSpinTween = TS:Create(
			loadingIcon,
			TweenInfo.new(.85, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["Rotation"] = 360
			}
		)
		iconSpinTween:Play()
		iconSpinTween.Completed:Wait()

		task.wait(.4)

		local iconFadeTween = TS:Create(
			loadingIcon,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 1
			}
		)
		local shadowFadeTween = TS:Create(
			loadingIconShadow,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["ImageTransparency"] = 1
			}
		)
		local backgroundFadeTween = TS:Create(
			loadingFrame,
			TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
			{
				["BackgroundTransparency"] = 1
			}
		)
		iconFadeTween:Play()
		shadowFadeTween:Play()
		backgroundFadeTween:Play()
	end
	
	OpenUI()
	
	local function minimizeAndExpand(minimizing)
		if minimizeDebounce then return end
		minimizeDebounce = true

		if minimizing then
			loadingFrame.ZIndex = 9

			local loadingFadeTween = TS:Create(
				loadingFrame,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["BackgroundTransparency"] = 0
				}
			)
			loadingFadeTween:Play()
			loadingFadeTween.Completed:Wait()
			background.Visible = false

			task.wait(.1)

			local minBackgroundTween = TS:Create(
				loadingFrame,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Size"] = UDim2.new(1, 0, 0.077, 0)
				}
			)
			local minShadowTween = TS:Create(
				shadow,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Position"] = UDim2.new(0.498, 0, 0.041, 0),
					["Size"] = UDim2.new(0.95, 40, 0.003, 40)
				}
			)
			minBackgroundTween:Play()
			minShadowTween:Play()
			minShadowTween.Completed:Wait()

			minimize.Text = "+"
		else
			loadingFrame.ZIndex = 9
			loadingIcon.Rotation = 0

			local expBackgroundTween = TS:Create(
				loadingFrame,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Size"] = UDim2.new(1, 0, 1, 0)
				}
			)
			local expShadowTween = TS:Create(
				shadow,
				TweenInfo.new(.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Position"] = UDim2.new(0.5, 0, 0.5, 0),
					["Size"] = UDim2.new(1, 40, 1, 40)
				}
			)
			expBackgroundTween:Play()
			expShadowTween:Play()
			expShadowTween.Completed:Wait()

			background.Visible = true
			minimize.Text = "-"

			task.wait(.15)

			local iconTween = TS:Create(
				loadingIcon,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 0
				}
			)
			local shadowTween = TS:Create(
				loadingIconShadow,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 0
				}
			)
			iconTween:Play()
			shadowTween:Play()
			shadowTween.Completed:Wait()

			task.wait(.2)

			local iconSpinTween = TS:Create(
				loadingIcon,
				TweenInfo.new(.85, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["Rotation"] = 360
				}
			)
			iconSpinTween:Play()
			iconSpinTween.Completed:Wait()

			task.wait(.4)

			local iconFadeTween = TS:Create(
				loadingIcon,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 1
				}
			)
			local shadowFadeTween = TS:Create(
				loadingIconShadow,
				TweenInfo.new(.35, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["ImageTransparency"] = 1
				}
			)
			local backgroundFadeTween = TS:Create(
				loadingFrame,
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

		minimizeDebounce = false
	end

	minimize.MouseButton1Click:Connect(function()	
		minimizeAndExpand(background.Visible)
	end)

	local items = {}
	
	-- Buttons
	local function createButton(name, info, callback)
		local buttonFrame = create("ImageLabel", {
			Name = name,
			BackgroundTransparency = 1,
			Image = "rbxassetid://14001321443",
			ImageColor3 = Color3.fromRGB(18, 18, 18),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(150, 150, 150, 150),
			Parent = itemsFrame
		})
		
		create("UIAspectRatioConstraint", {
			AspectRatio = 8.18,
			Parent = buttonFrame
		})
		
		local infoButton = create("TextButton", {
			Name = "Info",
			BackgroundColor3 = Color3.fromRGB(34, 39, 39),
			Position = UDim2.new(.959, 0, .011, 0),
			Size = UDim2.new(.035, 0, .279, 0),
			Font = Enum.Font.Roboto,
			Text = "?",
			TextColor3 = Color3.fromRGB(190, 190, 190),
			TextScaled = true,
			ZIndex = 2,
			AutoButtonColor = false,
			Visible = (info ~= "" and true) or false,
			Parent = buttonFrame,
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(1, 0),
			Parent = infoButton
		})
		
		local buttonButton = create("TextButton", {
			Name = "Button",
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundColor3 = Color3.fromRGB(23, 23, 26),
			Position = UDim2.new(.5, 0, .5, 0),
			Size = UDim2.new(.965, 0, .726, 0),
			Text = "",
			AutoButtonColor = false,
			Parent = buttonFrame
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(.15, 0),
			Parent = buttonButton
		})
		
		create("UIStroke", {
			Color = Color3.fromRGB(6, 6, 6),
			Thickness = 4,
			Parent = buttonButton
		})
		
		font.Weight = Enum.FontWeight.Medium
		font.Style = Enum.FontStyle.Normal
		local buttonTitle = create("TextLabel", {
			Name = "Title",
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(.5, .5),
			Position = UDim2.new(.502, 0, .5, 0),
			Size = UDim2.new(.947, 0, .95, 0),
			FontFace = font,
			Text = name,
			TextColor3 = Color3.fromRGB(214, 214, 214),
			TextScaled = true,
			Parent = buttonButton
		})
		
		create("UITextSizeConstraint", {
			MaxTextSize = 22,
			Parent = buttonTitle
		})
		
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

			local posX = (mouse.X - infoMain.Parent.AbsolutePosition.X) / UIScale.Scale
			local posY = (mouse.Y - infoMain.Parent.AbsolutePosition.Y - 50) / UIScale.Scale

			infoMain.Position = UDim2.new(0, posX, 0, posY)
			infoText.Text = info
			infoMain.Visible = true
		end)

		infoButton.MouseLeave:Connect(function()
			infoMain.Visible = false
		end)

		buttonButton.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end
	
	-- Toggles
	local function createToggle(name, info, state, callback, tab, itemIndex)
		local toggleFrame = create("ImageLabel", {
			Name = name,
			BackgroundTransparency = 1,
			Image = "rbxassetid://14001321443",
			ImageColor3 = Color3.fromRGB(18, 18, 18),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(150, 150, 150, 150),
			Parent = itemsFrame
		})
		
		create("UIAspectRatioConstraint", {
			AspectRatio = 8.18,
			Parent = toggleFrame
		})
		
		local toggleState = create("Frame", {
			Name = "State",
			AnchorPoint = Vector2.new(0, .5),
			BackgroundColor3 = Color3.fromRGB(39, 40, 44),
			Position = UDim2.new(.719, 0, .5, 0),
			Size = UDim2.new(.21, 0, .561, 0),
			ZIndex = 2,
			Parent = toggleFrame
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(.2, 0),
			Parent = toggleState
		})
		
		create("UIStroke", {
			Thickness = 2,
			Parent = toggleState
		})
		
		local toggleStateButton = create("TextButton", {
			Name = "Button",
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(231, 72, 72),
			Position = UDim2.new(.5, 0, 0, 0),
			Size = UDim2.new(.5, 0, 1, 0),
			Text = "",
			ZIndex = 2,
			Parent = toggleState
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(.25, 0),
			Parent = toggleStateButton
		})
		
		local infoButton = create("TextButton", {
			Name = "Info",
			BackgroundColor3 = Color3.fromRGB(34, 39, 39),
			Position = UDim2.new(.959, 0, .011, 0),
			Size = UDim2.new(.035, 0, .279, 0),
			Font = Enum.Font.Roboto,
			Text = "?",
			TextColor3 = Color3.fromRGB(190, 190, 190),
			TextScaled = true,
			ZIndex = 2,
			AutoButtonColor = false,
			Visible = (info ~= "" and true) or false,
			Parent = toggleFrame,
		})

		create("UICorner", {
			CornerRadius = UDim.new(1, 0),
			Parent = infoButton
		}) 
		
		local toggleButton = create("TextButton", {
			Name = "Button",
			AnchorPoint = Vector2.new(.5, .5),
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(23, 23, 26),
			Position = UDim2.new(.5, 0, .5, 0),
			Size = UDim2.new(.965, 0, .726, 0),
			Text = "",
			Parent = toggleFrame
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(.15, 0),
			Parent = toggleButton
		})
		
		create("UIStroke", {
			Color = Color3.fromRGB(6, 6, 6),
			Thickness = 4,
			Parent = toggleButton
		})
		
		font.Weight = Enum.FontWeight.Medium
		font.Style = Enum.FontStyle.Normal
		local toggleText = create("TextLabel", {
			Name = "Title",
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1,
			Position = UDim2.new(.369, 0, .5, 0),
			Size = UDim2.new(.68, 0, .95, 0),
			FontFace = font,
			Text = name,
			TextColor3 = Color3.fromRGB(214, 214, 214),
			TextScaled = true,
			Parent = toggleButton
		})
		
		create("UITextSizeConstraint", {
			MaxTextSize = 22,
			Parent = toggleText
		})
		
		toggleButton.MouseEnter:Connect(function()
			toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		end)

		toggleButton.MouseButton1Down:Connect(function()
			toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
		end)

		toggleButton.MouseLeave:Connect(function()
			toggleButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
		end)

		toggleButton.MouseButton1Up:Connect(function()
			toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		end)

		infoButton.MouseEnter:Connect(function()
			local mouse = UIS:GetMouseLocation()
			local inset = game:GetService("GuiService"):GetGuiInset()
			mouse = mouse - inset

			local posX = (mouse.X - infoMain.Parent.AbsolutePosition.X) / UIScale.Scale
			local posY = (mouse.Y - infoMain.Parent.AbsolutePosition.Y - 50) / UIScale.Scale

			infoMain.Position = UDim2.new(0, posX, 0, posY)
			infoText.Text = info
			infoMain.Visible = true
		end)

		infoButton.MouseLeave:Connect(function()
			infoMain.Visible = false
		end)

		local function switchState(newState)
			print(items[tab][itemIndex])
			items[tab][itemIndex].state = newState

			pcall(function()
				callback(newState)
			end)

			local stateSwitchTween = TS:Create(
				toggleStateButton,
				TweenInfo.new(.2, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
				{
					["BackgroundColor3"] = (newState and Color3.fromRGB(67, 231, 100)) or Color3.fromRGB(231, 72, 72),
					["Position"] = (newState and UDim2.new(.5, 0, 0, 0)) or UDim2.new(0, 0, 0, 0)
				}
			)
			stateSwitchTween:Play()
		end

		toggleButton.MouseButton1Click:Connect(function()
			items[tab][itemIndex].state = not items[tab][itemIndex].state
			switchState(items[tab][itemIndex].state)
		end)

		toggleStateButton.MouseButton1Click:Connect(function()
			items[tab][itemIndex].state = not items[tab][itemIndex].state
			switchState(items[tab][itemIndex].state)
		end)
		switchState(items[tab][itemIndex].state)
	end
	
	-- Dropdowns
	local function dropdownCanvasFix(optionsFrame, tab, itemIndex)
		if optionsFrame.Visible then
			itemsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
			itemsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
			
			task.wait()
			
			itemsFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
			
			local size
			if itemIndex == #items[tab] then
				size = 105 * #items[tab] + 190
			elseif #items[tab] - itemIndex < 2 then
				size = 105 * #items[tab] + 85
			else
				itemsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
				return
			end
						
			itemsFrame.CanvasSize = UDim2.new(0, 0, 0, size)
			itemsFrame.CanvasPosition = Vector2.new(0, size)
		else
			itemsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
			itemsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		end
	end
	
	local function createDropdown(name, info, optionType, options, selected, callback, tab, itemIndex)
		local dropdownFrame = create("ImageLabel", {
			Name = name,
			BackgroundTransparency = 1,
			Image = "rbxassetid://14001321443",
			ImageColor3 = Color3.fromRGB(18,18,18),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(150, 150, 150, 150),
			SliceScale = 1,
			Parent = itemsFrame
		})
		
		create("UIAspectRatioConstraint", {
			AspectRatio = 8.18,
			Parent = dropdownFrame
		})
		
		local selectedButton = create("ImageButton", {
			AnchorPoint = Vector2.new(0, .5),
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(39, 40, 44),
			Position = UDim2.new(.691, 0, .5, 0),
			Size = UDim2.new(.265, 0, .561, 0),
			Image = "",
			ZIndex = 2,
			Parent = dropdownFrame
		}) 
		
		create("UICorner", {
			CornerRadius = UDim.new(.25, 0),
			Parent = selectedButton
		})
		
		create("UIStroke", {
			Thickness = 2,
			Parent = selectedButton
		})
		
		local arrow = create("ImageLabel", {
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1,
			Position = UDim2.new(.9, 0, .5, 0),
			Size = UDim2.new(.075, 0, .404, 0),
			Image = "rbxassetid://99975223526055",
			ZIndex = 2,
			Parent = selectedButton
		})
		
		font.Weight = Enum.FontWeight.Medium
		font.Style = Enum.FontStyle.Normal
		local selectedText = create("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(.108, 0, 0, 0),
			Size = UDim2.new(.692, 0, 1, 0),
			FontFace = font,
			Text = (typeof(selected) == "string" and shortenText(selected, 7)) or shortenText(selected[1], 7),
			TextColor3 = Color3.fromRGB(136, 136, 136),
			TextScaled = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 2,
			Parent = selectedButton
		})
		
		create("UITextSizeConstraint", {
			MaxTextSize = 18,
			Parent = selectedText
		})
		
		local infoButton = create("TextButton", {
			Name = "Info",
			BackgroundColor3 = Color3.fromRGB(34, 39, 39),
			Position = UDim2.new(.959, 0, .011, 0),
			Size = UDim2.new(.035, 0, .279, 0),
			Font = Enum.Font.Roboto,
			Text = "?",
			TextColor3 = Color3.fromRGB(190, 190, 190),
			TextScaled = true,
			ZIndex = 2,
			AutoButtonColor = false,
			Visible = (info ~= "" and true) or false,
			Parent = dropdownFrame,
		})

		create("UICorner", {
			CornerRadius = UDim.new(1, 0),
			Parent = infoButton
		})
		
		local dropdownButton = create("TextButton", {
			Name = "Button",
			AnchorPoint = Vector2.new(.5, .5),
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(23, 23, 26),
			Position = UDim2.new(.5, 0, .5, 0),
			Size = UDim2.new(.965, 0, .726, 0),
			Text = "",
			Parent = dropdownFrame
		})

		create("UICorner", {
			CornerRadius = UDim.new(.15, 0),
			Parent = dropdownButton
		})

		create("UIStroke", {
			Color = Color3.fromRGB(6, 6, 6),
			Thickness = 4,
			Parent = dropdownButton
		})
		
		local dropdownText = create("TextLabel", {
			Name = "Title",
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1,
			Position = UDim2.new(.369, 0, .5, 0),
			Size = UDim2.new(.68, 0, .95, 0),
			FontFace = font,
			Text = name,
			TextColor3 = Color3.fromRGB(214, 214, 214),
			TextScaled = true,
			Parent = dropdownButton
		})

		create("UITextSizeConstraint", {
			MaxTextSize = 22,
			Parent = dropdownText
		})
		
		local optionsFrame = create("ScrollingFrame", {
			Name = "Options",
			AutomaticSize = (#options <= 4 and Enum.AutomaticSize.Y) or Enum.AutomaticSize.None,
			BackgroundColor3 = Color3.fromRGB(39, 40, 44),
			Position = UDim2.new(.641, 0, .83, 0),
			Size = UDim2.new(.364, 0, 0, 196),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarImageColor3 = Color3.fromRGB(13, 13, 13),
			ScrollBarThickness = 4,
			Visible = false,
			ZIndex = 3,
			Parent = dropdownFrame
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(0, 10),
			Parent = optionsFrame
		})
		
		create("UIListLayout", {Parent = optionsFrame})
		
		create("UIPadding", {
			PaddingLeft = UDim.new(.05, 0),
			Parent = optionsFrame
		})
		
		create("UIStroke", {
			Thickness = 2,
			Parent = optionsFrame
		})
		
		for _, option in pairs(options) do
			if optionType == "Single" then
				local optionButton = create("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.new(.95, 0, 0, 45),
					ZIndex = 4,
					FontFace = font,
					Text = option,
					TextColor3 = Color3.fromRGB(136, 136, 136),
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = optionsFrame
				})
				
				create("UITextSizeConstraint", {
					MaxTextSize = 18,
					Parent = optionButton
				})
				
				optionButton.MouseButton1Click:Connect(function()
					items[tab][itemIndex].selected = option
					pcall(function()
						callback(option)
					end)
					
					selectedText.Text = shortenText(option, 7)
					optionsFrame.Visible = false
				end)
				
			elseif optionType == "Multiple" then
				if typeof(items[tab][itemIndex].selected) == "string" then items[tab][itemIndex].selected = {items[tab][itemIndex].selected} end
				
				local optionButton = create("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.new(.8, 0, 0, 45),
					ZIndex = 4,
					FontFace = font,
					Text = option,
					TextColor3 = Color3.fromRGB(136, 136, 136),
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = optionsFrame
				})

				create("UITextSizeConstraint", {
					MaxTextSize = 18,
					Parent = optionButton
				})
				
				local checkbox = create("ImageLabel", {
					AnchorPoint = Vector2.new(0, .5),
					BackgroundTransparency = 1,
					Position = UDim2.new(1.03, 0, .5, 0),
					Size = UDim2.new(.205, 0, .8, 0),
					ZIndex = 4,
					Image = (table.find(items[tab][itemIndex].selected, option) and "rbxassetid://106302518855268") or "rbxassetid://74919013831157",
					ImageColor3 = Color3.fromRGB(168, 168, 168),
					Parent = optionButton
				})
				
				optionButton.MouseButton1Click:Connect(function()
					if not table.find(items[tab][itemIndex].selected, option) then
						table.insert(items[tab][itemIndex].selected, option)
					else
						table.remove(items[tab][itemIndex].selected, table.find(items[tab][itemIndex].selected, option))
					end
					
					pcall(function()
						callback(items[tab][itemIndex].selected)
					end)
					
					checkbox.Image = (table.find(items[tab][itemIndex].selected, option) and "rbxassetid://106302518855268") or "rbxassetid://74919013831157"
					selectedText.Text = shortenText(items[tab][itemIndex].selected[1] or "", 7)
				end)
			end
		end
		
		dropdownButton.MouseEnter:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		end)

		dropdownButton.MouseButton1Down:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
		end)

		dropdownButton.MouseLeave:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
		end)

		dropdownButton.MouseEnter:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		end)

		dropdownButton.MouseButton1Down:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
		end)

		dropdownButton.MouseLeave:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(23, 23, 26)
		end)

		dropdownButton.MouseButton1Up:Connect(function()
			dropdownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
		end)

		infoButton.MouseEnter:Connect(function()
			local mouse = UIS:GetMouseLocation()
			local inset = game:GetService("GuiService"):GetGuiInset()
			mouse = mouse - inset

			local posX = (mouse.X - infoMain.Parent.AbsolutePosition.X) / UIScale.Scale
			local posY = (mouse.Y - infoMain.Parent.AbsolutePosition.Y - 50) / UIScale.Scale

			infoMain.Position = UDim2.new(0, posX, 0, posY)
			infoText.Text = info
			infoMain.Visible = true
		end)

		infoButton.MouseLeave:Connect(function()
			infoMain.Visible = false
		end)
		
		dropdownButton.MouseButton1Click:Connect(function()
			optionsFrame.Visible = not optionsFrame.Visible
			optionsFrame.AutomaticSize = (#options <= 4 and Enum.AutomaticSize.Y) or Enum.AutomaticSize.None
			dropdownCanvasFix(optionsFrame, tab, itemIndex)
			
			for _, item in pairs(itemsFrame:GetChildren()) do
				if item:FindFirstChild("Options") and item ~= dropdownFrame then
					item.Options.Visible = false
				end
			end
		end)
		
		selectedButton.MouseButton1Click:Connect(function()
			optionsFrame.Visible = not optionsFrame.Visible
			optionsFrame.AutomaticSize = (#options <= 4 and Enum.AutomaticSize.Y) or Enum.AutomaticSize.None
			dropdownCanvasFix(optionsFrame, tab, itemIndex)

			for _, item in pairs(itemsFrame:GetChildren()) do
				if item:FindFirstChild("Options") and item ~= dropdownFrame then
					item.Options.Visible = false
				end
			end
		end)
	end
	
	-- Tabs
	local activeTab = nil
	function window:NewTab(tabName: string, info: string)
		local tab = {}
		items[tab] = {}
		
		local function switchTab()
			if activeTab == tab then return end
			activeTab = tab
			
			-- Clear current items
			for _, item in pairs(itemsFrame:GetChildren()) do
				if item ~= itemsLayout then
					item:Destroy()
				end
			end
			
			-- Load tabs items
			for i, item in ipairs(items[tab]) do
				print(items[tab])
				if item.type == "Button" then
					createButton(item.name, item.info, item.callback)
				elseif item.type == "Toggle" then
					createToggle(item.name, item.info, item.state, item.callback, tab, i)
				elseif item.type == "Dropdown" then
					createDropdown(item.name, item.info, item.optionType, item.options, item.selected, item.callback, tab, i)
				end
			end
		end
		
		if activeTab == nil then
			switchTab()
		end
		
		local tabFrame = create("ImageLabel", {
			Name = tabName,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 70),
			Image = "rbxassetid://14001321443",
			ImageColor3 = Color3.fromRGB(18, 18, 18),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(150, 150, 150, 150),
			Parent = tabsFrame
		})
		
		local tabButton = create("TextButton", {
			Name = "Button",
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundColor3 = Color3.fromRGB(23, 23, 26),
			Position = UDim2.new(.5, 0, .5, 0),
			Size = UDim2.new(.883, 0, .726, 0),
			Text = "",
			AutoButtonColor = false,
			Parent = tabFrame
		})
		
		create("UICorner", {
			CornerRadius = UDim.new(.15, 0),
			Parent = tabButton
		})
		
		create("UIStroke", {
			Color = Color3.fromRGB(6, 6, 6),
			Thickness = 4,
			Parent = tabButton
		})
		
		font.Weight = Enum.FontWeight.Medium
		font.Style = Enum.FontStyle.Normal
		local tabText = create("TextLabel", {
			Name = "Title",
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1,
			Position = UDim2.new(.5, 0, .5, 0),
			Size = UDim2.new(.9, 0, .95, 0),
			FontFace = font,
			Text = tabName,
			TextColor3 = Color3.fromRGB(214, 214, 214),
			TextScaled = true,
			Parent = tabButton
		})
		
		create("UITextSizeConstraint", {
			MaxTextSize = 22,
			Parent = tabText
		})
		
		tabButton.MouseButton1Click:Connect(function()
			switchTab()
		end)
		
		-- Tab functions
		
		function tab:NewButton(name: string, info: string, callback: () -> ())
			local button = {}
			table.insert(items[tab], {
				type = "Button",
				name = name,
				info = info,
				callback = callback
			})
			
			if activeTab == tab then
				createButton(name, info, callback)
			end
			
			return button
		end
		
		function tab:NewToggle(name: string, info: string, initialState: boolean, callback: () -> ())
			local toggle = {}
			table.insert(items[tab], {
				type = "Toggle",
				name = name,
				info = info,
				state = initialState,
				callback = callback
			})
			
			local itemIndex = #items[tab]
			
			if activeTab == tab then
				createToggle(name, info, initialState, callback, tab, itemIndex)
			end
			
			return toggle
		end
		
		function tab:NewDropdown(name: string, info: string, optionType: string, options: SharedTable, baseText: string, callback: () -> ())
			local dropdown = {}
			table.insert(items[tab], {
				type = "Dropdown",
				name = name,
				info = info,
				optionType = optionType,
				options = options,
				selected = baseText or "",
				callback = callback
			})
			
			local itemIndex = #items[tab]
			
			if activeTab == tab then
				createDropdown(name, info, optionType, options, baseText, callback, tab, itemIndex)
			end
			
			return dropdown
		end
		
		return tab
	end
	
	return window
end

return NH_UI
