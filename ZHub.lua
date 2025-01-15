-- ZHub Library for Roblox
local ZHub = {}

-- Function to create the main window
function ZHub:CreateWindow(settings)
    local UserInputService = game:GetService("UserInputService")
    local gui = Instance.new("ScreenGui")
    gui.Name = settings.Name or "ZHub"
    gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local windowFrame = Instance.new("Frame", gui)
    windowFrame.Size = UDim2.new(0, 600, 0, 400)
    windowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    windowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    windowFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    windowFrame.BorderSizePixel = 0
    windowFrame.ClipsDescendants = true

    -- Rounded Corners for Main Frame
    local windowCorner = Instance.new("UICorner", windowFrame)
    windowCorner.CornerRadius = UDim.new(0, 10)

    -- Title Bar
    local titleBar = Instance.new("Frame", windowFrame)
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    titleBar.BorderSizePixel = 0

    -- Rounded Corners for Title Bar
    local titleCorner = Instance.new("UICorner", titleBar)
    titleCorner.CornerRadius = UDim.new(0, 10)

    local titleLabel = Instance.new("TextLabel", titleBar)
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Text = settings.Name or "ZHub"
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Draggable Feature
    local isDragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = windowFrame.Position
        end
    end)

    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            windowFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Tab Container
    local tabContainer = Instance.new("Frame", windowFrame)
    tabContainer.Size = UDim2.new(0, 120, 1, -40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabContainer.BorderSizePixel = 0

    -- Rounded Corners for Tab Container
    local tabCorner = Instance.new("UICorner", tabContainer)
    tabCorner.CornerRadius = UDim.new(0, 10)

    -- Tab Content
    local tabContent = Instance.new("Frame", windowFrame)
    tabContent.Size = UDim2.new(1, -120, 1, -40)
    tabContent.Position = UDim2.new(0, 120, 0, 40)
    tabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabContent.BorderSizePixel = 0

    -- Rounded Corners for Tab Content
    local contentCorner = Instance.new("UICorner", tabContent)
    contentCorner.CornerRadius = UDim.new(0, 10)

    local tabPages = {}

    -- Tab Button List Layout
    local tabButtonList = Instance.new("UIListLayout", tabContainer)
    tabButtonList.SortOrder = Enum.SortOrder.LayoutOrder
    tabButtonList.Padding = UDim.new(0, 5)

    -- Create Tab Function
    function ZHub:CreateTab(tabName)
        local tabButton = Instance.new("TextButton", tabContainer)
        tabButton.Size = UDim2.new(1, 0, 0, 40)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabButton.TextColor3 = Color3.fromRGB(240, 240, 240)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.BorderSizePixel = 0

        -- Rounded Corners for Tab Button
        local buttonCorner = Instance.new("UICorner", tabButton)
        buttonCorner.CornerRadius = UDim.new(0, 10)

        local tabPage = Instance.new("ScrollingFrame", tabContent)
        tabPage.Size = UDim2.new(1, 0, 1, 0)
        tabPage.BackgroundTransparency = 1
        tabPage.Visible = false
        tabPage.ScrollBarThickness = 5
        tabPage.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 50)

        local pageLayout = Instance.new("UIListLayout", tabPage)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 10)

        tabButton.MouseButton1Click:Connect(function()
            for _, page in pairs(tabPages) do
                page.Visible = false
            end
            tabPage.Visible = true
        end)

        table.insert(tabPages, tabPage)
        return tabPage
    end

    -- Create Section Function
    function ZHub:CreateSection(tabPage, sectionName)
        local sectionFrame = Instance.new("Frame", tabPage)
        sectionFrame.Size = UDim2.new(1, -20, 0, 50)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        sectionFrame.BorderSizePixel = 0

        -- Rounded Corners for Section Frame
        local sectionCorner = Instance.new("UICorner", sectionFrame)
        sectionCorner.CornerRadius = UDim.new(0, 10)

        local sectionLabel = Instance.new("TextLabel", sectionFrame)
        sectionLabel.Text = sectionName
        sectionLabel.Font = Enum.Font.GothamBold
        sectionLabel.TextSize = 16
        sectionLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        sectionLabel.Size = UDim2.new(1, -10, 0, 30)
        sectionLabel.Position = UDim2.new(0, 10, 0, 10)
        sectionLabel.BackgroundTransparency = 1
        sectionLabel.TextXAlignment = Enum.TextXAlignment.Left

        return sectionFrame
    end

    -- Create Button Function
    function ZHub:CreateButton(section, buttonName, callback)
        local button = Instance.new("TextButton", section)
        button.Size = UDim2.new(1, -20, 0, 40)
        button.Position = UDim2.new(0, 10, 0, 40)
        button.Text = buttonName
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(240, 240, 240)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.BorderSizePixel = 0

        -- Rounded Corners for Button
        local buttonCorner = Instance.new("UICorner", button)
        buttonCorner.CornerRadius = UDim.new(0, 10)

        button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)

        return button
    end

    -- Notify Function
    function ZHub:Notify(notificationSettings)
        print("Notification:", notificationSettings.Title, notificationSettings.Content)
    end

    return ZHub
end

return ZHub
