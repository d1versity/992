-- 922

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Library = {
    Name = "992",
    Toggled = true,
    Accent = Color3.fromRGB(255, 255, 255),
    Background = Color3.fromRGB(0, 0, 0),
    LineColor = Color3.fromRGB(45, 45, 45),
    Font = Enum.Font.GothamMedium,
    TextSize = 13
}

local ParentGui = (gethui and gethui()) or (RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui")) or CoreGui
if ParentGui:FindFirstChild("992_UI") then
    ParentGui:FindFirstChild("992_UI"):Destroy()
end

function Library:CreateWindow(TitleText)
    local Window = {}
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "992_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = ParentGui

    local Wrapper = Instance.new("Frame")
    Wrapper.Name = "Wrapper"
    Wrapper.Size = UDim2.new(0, 400, 0, 250)
    Wrapper.Position = UDim2.new(0.5, -200, 0.5, -125)
    Wrapper.BackgroundTransparency = 1
    Wrapper.Parent = ScreenGui

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://4743306732"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 1
    Shadow.SliceCenter = Rect.new(35, 35, 35, 35)
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.Parent = Wrapper

    local MainFrame = Instance.new("CanvasGroup")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(1, 0, 1, 0)
    MainFrame.BackgroundColor3 = Library.Background
    MainFrame.GroupTransparency = 1
    MainFrame.Parent = Wrapper

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Color = Library.LineColor
    MainStroke.Thickness = 1
    MainStroke.Transparency = 1 
    MainStroke.Parent = MainFrame

    local TopBarHeight = 35
    local TabAreaWidth = 120

    local HorizontalLine = Instance.new("Frame")
    HorizontalLine.Name = "TopDivider"
    HorizontalLine.BackgroundColor3 = Library.LineColor
    HorizontalLine.BorderSizePixel = 0
    HorizontalLine.Size = UDim2.new(1, 0, 0, 1)
    HorizontalLine.Position = UDim2.new(0, 0, 0, TopBarHeight)
    HorizontalLine.Parent = MainFrame

    local VerticalLine = Instance.new("Frame")
    VerticalLine.Name = "TabDivider"
    VerticalLine.BackgroundColor3 = Library.LineColor
    VerticalLine.BorderSizePixel = 0
    VerticalLine.Size = UDim2.new(0, 1, 1, -TopBarHeight)
    VerticalLine.Position = UDim2.new(0, TabAreaWidth, 0, TopBarHeight)
    VerticalLine.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, TopBarHeight)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -15, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = TitleText
    TitleLabel.TextColor3 = Library.Accent
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Size = UDim2.new(0, TabAreaWidth, 1, -TopBarHeight - 1)
    TabContainer.Position = UDim2.new(0, 0, 0, TopBarHeight + 1)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = MainFrame

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.Padding = UDim.new(0, 6)
    TabList.Parent = TabContainer
    
    local TabSpacer = Instance.new("UIPadding")
    TabSpacer.PaddingTop = UDim.new(0, 8)
    TabSpacer.Parent = TabContainer

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -TabAreaWidth - 1, 1, -TopBarHeight - 1)
    ContentContainer.Position = UDim2.new(0, TabAreaWidth + 1, 0, TopBarHeight + 1)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Wrapper.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            Wrapper.Position = Wrapper.Position:Lerp(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 0.2)
        end
    end)

    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
    TweenService:Create(MainStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    TweenService:Create(Shadow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0.3}):Play()

    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Insert then
            Library.Toggled = not Library.Toggled
            MainFrame.Interactable = Library.Toggled 

            local targetTransparency = Library.Toggled and 0 or 1
            local shadowTransparency = Library.Toggled and 0.3 or 1

            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {GroupTransparency = targetTransparency}):Play()
            TweenService:Create(MainStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = targetTransparency}):Play()
            TweenService:Create(Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = shadowTransparency}):Play()
        end
    end)

    local Tabs = {}
    local FirstTab = true

    function Window:CreateTab(TabName)
        local Tab = {}
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -16, 0, 26)
        TabBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Library.Accent 
        TabBtn.TextSize = Library.TextSize
        TabBtn.Font = Library.Font
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = TabContainer

        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)
        
        local TabStroke = Instance.new("UIStroke")
        TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        TabStroke.Color = Library.LineColor
        TabStroke.Parent = TabBtn

        local TabCanvas = Instance.new("CanvasGroup")
        TabCanvas.Size = UDim2.new(1, 0, 1, 0)
        TabCanvas.BackgroundTransparency = 1
        TabCanvas.GroupTransparency = FirstTab and 0 or 1
        TabCanvas.Visible = FirstTab
        TabCanvas.Parent = ContentContainer

        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.ScrollBarThickness = 0 
        ScrollFrame.BorderSizePixel = 0
        ScrollFrame.Parent = TabCanvas

        local ScrollLayout = Instance.new("UIListLayout")
        ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ScrollLayout.Padding = UDim.new(0, 8)
        ScrollLayout.Parent = ScrollFrame

        local ScrollPadding = Instance.new("UIPadding")
        ScrollPadding.PaddingTop = UDim.new(0, 10)
        ScrollPadding.PaddingBottom = UDim.new(0, 10)
        ScrollPadding.PaddingLeft = UDim.new(0, 15)
        ScrollPadding.PaddingRight = UDim.new(0, 15)
        ScrollPadding.Parent = ScrollFrame
        
        ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 20)
            TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 20)
        end)

        local TabData = {
            Button = TabBtn, 
            Canvas = TabCanvas, 
            Stroke = TabStroke, 
            IsActive = FirstTab
        }
        
        if FirstTab then TabStroke.Color = Library.Accent FirstTab = false end
        table.insert(Tabs, TabData)

        TabBtn.MouseEnter:Connect(function()
            if not TabData.IsActive then TweenService:Create(TabStroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play() end
        end)
        TabBtn.MouseLeave:Connect(function()
            if not TabData.IsActive then TweenService:Create(TabStroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play() end
        end)

        TabBtn.MouseButton1Click:Connect(function()
            if TabData.IsActive then return end 

            for _, t in pairs(Tabs) do
                if t.IsActive then
                    t.IsActive = false
                    TweenService:Create(t.Stroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play()
                    
                    local oldCanvas = t.Canvas
                    task.spawn(function()
                        local tw = TweenService:Create(oldCanvas, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1})
                        tw:Play()
                        tw.Completed:Wait()
                        if not t.IsActive then oldCanvas.Visible = false end
                    end)
                end
            end
            
            TabData.IsActive = true
            TabCanvas.Visible = true
            TweenService:Create(TabCanvas, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
            TweenService:Create(TabStroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play()
        end)

        function Tab:CreateLabel(text)
            local Lbl = Instance.new("TextLabel")
            Lbl.Size = UDim2.new(1, 0, 0, 16)
            Lbl.BackgroundTransparency = 1
            Lbl.Text = text
            Lbl.TextColor3 = Library.Accent
            Lbl.TextSize = Library.TextSize
            Lbl.Font = Library.Font
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.Parent = ScrollFrame
            return { Update = function(newText) Lbl.Text = newText end }
        end

        function Tab:CreateButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -2, 0, 28)
            Btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            Btn.Text = text
            Btn.TextColor3 = Library.Accent 
            Btn.TextSize = Library.TextSize
            Btn.Font = Library.Font
            Btn.AutoButtonColor = false
            Btn.Parent = ScrollFrame
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
            
            local Stroke = Instance.new("UIStroke")
            Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            Stroke.Color = Library.LineColor
            Stroke.Parent = Btn
            
            Btn.MouseEnter:Connect(function() TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play() end)
            Btn.MouseLeave:Connect(function() TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play() end)
            Btn.MouseButton1Click:Connect(callback)
        end

        function Tab:CreateToggle(text, default, callback)
            local state = default or false
            
            local TogFrame = Instance.new("TextButton")
            TogFrame.Size = UDim2.new(1, -2, 0, 24)
            TogFrame.BackgroundTransparency = 1
            TogFrame.Text = ""
            TogFrame.AutoButtonColor = false
            TogFrame.Parent = ScrollFrame

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -40, 1, 0)
            Title.BackgroundTransparency = 1
            Title.Text = text
            Title.TextColor3 = Library.Accent
            Title.TextSize = Library.TextSize
            Title.Font = Library.Font
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = TogFrame

            local SwitchBg = Instance.new("Frame")
            SwitchBg.Size = UDim2.new(0, 36, 0, 16)
            SwitchBg.AnchorPoint = Vector2.new(1, 0.5)
            SwitchBg.Position = UDim2.new(1, -2, 0.5, 0)
            SwitchBg.BackgroundColor3 = state and Library.Accent or Color3.fromRGB(20, 20, 20)
            SwitchBg.Parent = TogFrame
            Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)
            
            local SwitchStroke = Instance.new("UIStroke")
            SwitchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SwitchStroke.Color = Library.LineColor
            SwitchStroke.Parent = SwitchBg

            local Circle = Instance.new("Frame")
            Circle.Size = UDim2.new(0, 12, 0, 12)
            Circle.AnchorPoint = Vector2.new(0, 0.5)
            Circle.Position = UDim2.new(0, state and 22 or 2, 0.5, 0)
            Circle.BackgroundColor3 = state and Library.Background or Color3.fromRGB(180, 180, 180)
            Circle.Parent = SwitchBg
            Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

            local function UpdateVisuals()
                TweenService:Create(SwitchBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = state and Library.Accent or Color3.fromRGB(20, 20, 20)}):Play()
                TweenService:Create(SwitchStroke, TweenInfo.new(0.2), {Color = state and Library.Accent or Library.LineColor}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, state and 22 or 2, 0.5, 0)}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = state and Library.Background or Color3.fromRGB(180, 180, 180)}):Play()
            end

            TogFrame.MouseButton1Click:Connect(function()
                state = not state
                UpdateVisuals()
                callback(state)
            end)

            return { Update = function(s) state = s UpdateVisuals() callback(state) end }
        end

        function Tab:CreateSlider(text, min, max, default, callback)
            local value = default or min
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, -2, 0, 36)
            SliderFrame.BackgroundTransparency = 1
            SliderFrame.Parent = ScrollFrame

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -40, 0, 18)
            Title.BackgroundTransparency = 1
            Title.Text = text
            Title.TextColor3 = Library.Accent
            Title.TextSize = Library.TextSize
            Title.Font = Library.Font
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 40, 0, 18)
            ValueLabel.Position = UDim2.new(1, -40, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Library.Accent
            ValueLabel.TextSize = Library.TextSize
            ValueLabel.Font = Library.Font
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = SliderFrame

            local BarBg = Instance.new("TextButton")
            BarBg.Size = UDim2.new(1, 0, 0, 6)
            BarBg.Position = UDim2.new(0, 0, 1, -10)
            BarBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            BarBg.Text = ""
            BarBg.AutoButtonColor = false
            BarBg.Parent = SliderFrame
            Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)
            
            local BarStroke = Instance.new("UIStroke")
            BarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            BarStroke.Color = Library.LineColor
            BarStroke.Parent = BarBg

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Library.Accent
            Fill.Parent = BarBg
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
            
            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 12, 0, 12)
            Knob.AnchorPoint = Vector2.new(0.5, 0.5)
            Knob.Position = UDim2.new(1, 0, 0.5, 0)
            Knob.BackgroundColor3 = Library.Accent
            Knob.Parent = Fill
            Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function updateDrag(input)
                local percent = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * percent)
                ValueLabel.Text = tostring(value)
                TweenService:Create(Fill, TweenInfo.new(0.05), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
                callback(value)
            end

            BarBg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true updateDrag(i) end end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
            UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then updateDrag(i) end end)

            return { Update = function(v) value = math.clamp(v, min, max) Fill.Size = UDim2.new((value - min)/(max - min), 0, 1, 0) ValueLabel.Text = tostring(value) callback(value) end }
        end

        function Tab:CreateDropdown(text, options, callback)
            local DropFrame = Instance.new("Frame")
            -- +4 offset for breathing room to completely avoid outline clipping
            DropFrame.Size = UDim2.new(1, 0, 0, 32)
            DropFrame.BackgroundTransparency = 1
            DropFrame.ClipsDescendants = true
            DropFrame.Parent = ScrollFrame
            
            local MainBtn = Instance.new("TextButton")
            MainBtn.Size = UDim2.new(1, -4, 0, 28)
            MainBtn.Position = UDim2.new(0, 2, 0, 2) -- Safely offsets the button inside the clipping frame
            MainBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            MainBtn.Text = "  " .. text
            MainBtn.TextColor3 = Library.Accent
            MainBtn.TextSize = Library.TextSize
            MainBtn.Font = Library.Font
            MainBtn.TextXAlignment = Enum.TextXAlignment.Left
            MainBtn.AutoButtonColor = false
            MainBtn.Parent = DropFrame
            Instance.new("UICorner", MainBtn).CornerRadius = UDim.new(0, 4)
            
            local Stroke = Instance.new("UIStroke")
            Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            Stroke.Color = Library.LineColor
            Stroke.Parent = MainBtn
            
            MainBtn.MouseEnter:Connect(function() TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play() end)
            MainBtn.MouseLeave:Connect(function() TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play() end)
            
            local Icon = Instance.new("TextLabel")
            Icon.Size = UDim2.new(0, 20, 0, 20)
            Icon.AnchorPoint = Vector2.new(1, 0.5)
            Icon.Position = UDim2.new(1, -5, 0.5, 0)
            Icon.BackgroundTransparency = 1
            Icon.Text = "+"
            Icon.TextColor3 = Library.Accent
            Icon.TextSize = 16
            Icon.Font = Library.Font
            Icon.Parent = MainBtn
            
            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, -4, 0, 0)
            OptionContainer.Position = UDim2.new(0, 2, 0, 32)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.Parent = DropFrame
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Padding = UDim.new(0, 4)
            ListLayout.Parent = OptionContainer
            
            local open = false
            local function toggleDrop()
                open = not open
                Icon.Text = open and "-" or "+"
                -- Dynamically adjust total height, leaving 2px blank space at the bottom for safety
                local targetHeight = open and (32 + (#options * 24) + 2) or 32
                TweenService:Create(DropFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
            end
            
            MainBtn.MouseButton1Click:Connect(toggleDrop)
            
            local function renderOptions(opts)
                for _, child in pairs(OptionContainer:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
                for _, opt in pairs(opts) do
                    local optBtn = Instance.new("TextButton")
                    optBtn.Size = UDim2.new(1, 0, 0, 20)
                    optBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                    optBtn.Text = opt
                    optBtn.TextColor3 = Library.Accent
                    optBtn.TextSize = 12
                    optBtn.Font = Library.Font
                    optBtn.AutoButtonColor = false
                    optBtn.Parent = OptionContainer
                    Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 3)
                    
                    local optStroke = Instance.new("UIStroke")
                    optStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    optStroke.Color = Library.LineColor
                    optStroke.Parent = optBtn

                    optBtn.MouseEnter:Connect(function() TweenService:Create(optStroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play() end)
                    optBtn.MouseLeave:Connect(function() TweenService:Create(optStroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play() end)

                    optBtn.MouseButton1Click:Connect(function()
                        MainBtn.Text = "  " .. text .. " : " .. opt
                        toggleDrop()
                        callback(opt)
                    end)
                end
            end
            renderOptions(options)
            
            return { Update = function(newOpts) options = newOpts renderOptions(options) if open then DropFrame.Size = UDim2.new(1, 0, 0, 32 + (#options * 24) + 2) end end }
        end

        function Tab:CreateKeybind(text, default, callback)
            local key = default
            local KeyFrame = Instance.new("Frame")
            KeyFrame.Size = UDim2.new(1, -2, 0, 28)
            KeyFrame.BackgroundTransparency = 1
            KeyFrame.Parent = ScrollFrame

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -60, 1, 0)
            Title.BackgroundTransparency = 1
            Title.Text = text
            Title.TextColor3 = Library.Accent
            Title.TextSize = Library.TextSize
            Title.Font = Library.Font
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = KeyFrame
            
            local KeyBtn = Instance.new("TextButton")
            KeyBtn.Size = UDim2.new(0, 50, 0, 20)
            KeyBtn.AnchorPoint = Vector2.new(1, 0.5)
            KeyBtn.Position = UDim2.new(1, -2, 0.5, 0)
            KeyBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            KeyBtn.Text = key.Name
            KeyBtn.TextColor3 = Library.Accent
            KeyBtn.TextSize = 11
            KeyBtn.Font = Library.Font
            KeyBtn.AutoButtonColor = false
            KeyBtn.Parent = KeyFrame
            Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 4)
            
            local Stroke = Instance.new("UIStroke")
            Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            Stroke.Color = Library.LineColor
            Stroke.Parent = KeyBtn

            local listening = false

            KeyBtn.MouseEnter:Connect(function() 
                if not listening then TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play() end
            end)
            KeyBtn.MouseLeave:Connect(function() 
                if not listening then TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play() end
            end)

            KeyBtn.MouseButton1Click:Connect(function()
                listening = true
                KeyBtn.Text = "..."
                TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.Accent}):Play()
            end)

            UserInputService.InputBegan:Connect(function(input)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    key = input.KeyCode
                    KeyBtn.Text = key.Name
                    listening = false
                    TweenService:Create(Stroke, TweenInfo.new(0.2), {Color = Library.LineColor}):Play()
                    callback(key)
                elseif not listening and input.KeyCode == key then
                    callback(key)
                end
            end)

            return { Update = function(k) key = k KeyBtn.Text = key.Name end }
        end

        return Tab
    end
    
    return Window
end

return Library
