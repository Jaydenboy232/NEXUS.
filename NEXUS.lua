
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if not player then
    warn("LocalPlayer not found. Run this as a client script.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

-- Remove old copy
local old = playerGui:FindFirstChild("MyCustomGUI")
if old then
    old:Destroy()
end

-- Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MyCustomGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 100
gui.Parent = playerGui

-- Grey background
local main = Instance.new("Frame")
main.Name = "MainBackground"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Size = UDim2.fromOffset(550, 350)
main.Position = UDim2.fromScale(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(65, 65, 70)
main.BackgroundTransparency = 0.1
main.BorderSizePixel = 0
main.Visible = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

print("MyCustomGUI loaded successfully!")


-- LEFT SIDEBAR TABS + CLOSE CONFIRMATION

-- Sidebar background
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 125, 1, -20)
sidebar.Position = UDim2.new(0, 10, 0, 10)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
sidebar.BackgroundTransparency = 0.15
sidebar.BorderSizePixel = 0
sidebar.Parent = main

Instance.new("UICorner", sidebar).CornerRadius =
    UDim.new(0, 8)

-- Tabs in requested order
local tabNames = {
    "Home",
    "Players",
    "Theme",
    "Keybinds",
    "Macro"
}

local selectedTab

for index, name in ipairs(tabNames) do
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, -12, 0, 36)
    tab.Position = UDim2.new(0, 6, 0, 8 + (index - 1) * 43)
    tab.BackgroundColor3 = Color3.fromRGB(75, 75, 85)
    tab.BackgroundTransparency = 0.25
    tab.BorderSizePixel = 0
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(240, 240, 245)
    tab.TextSize = 14
    tab.Font = Enum.Font.GothamMedium
    tab.Parent = sidebar

    Instance.new("UICorner", tab).CornerRadius =
        UDim.new(0, 6)

    tab.Activated:Connect(function()
        if selectedTab then
            selectedTab.BackgroundColor3 =
                Color3.fromRGB(75, 75, 85)
        end

        selectedTab = tab
        tab.BackgroundColor3 = Color3.fromRGB(115, 115, 135)

        print("Selected tab:", name)
    end)

    if index == 1 then
        selectedTab = tab
        tab.BackgroundColor3 = Color3.fromRGB(115, 115, 135)
    end
end

-- Small X close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.fromOffset(25, 25)
closeButton.Position = UDim2.new(1, -33, 0, 7)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 55, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 5
closeButton.Parent = main

Instance.new("UICorner", closeButton).CornerRadius =
    UDim.new(0, 6)

-- Confirmation popup
local confirm = Instance.new("Frame")
confirm.Name = "CloseConfirmation"
confirm.Size = UDim2.fromOffset(260, 125)
confirm.AnchorPoint = Vector2.new(0.5, 0.5)
confirm.Position = UDim2.fromScale(0.5, 0.5)
confirm.BackgroundColor3 = Color3.fromRGB(40, 40, 46)
confirm.BorderSizePixel = 0
confirm.Visible = false
confirm.ZIndex = 10
confirm.Parent = main

Instance.new("UICorner", confirm).CornerRadius =
    UDim.new(0, 10)

local confirmStroke = Instance.new("UIStroke", confirm)
confirmStroke.Color = Color3.fromRGB(100, 100, 115)
confirmStroke.Thickness = 1

local question = Instance.new("TextLabel")
question.Size = UDim2.new(1, -12, 0, 48)
question.Position = UDim2.fromOffset(6, 8)
question.BackgroundTransparency = 1
question.Text = "Really want to close this GUI?"
question.TextColor3 = Color3.new(1, 1, 1)
question.TextSize = 14
question.Font = Enum.Font.GothamMedium
question.TextWrapped = true
question.ZIndex = 11
question.Parent = confirm

local yes = Instance.new("TextButton")
yes.Size = UDim2.fromOffset(100, 32)
yes.Position = UDim2.new(0, 20, 1, -42)
yes.BackgroundColor3 = Color3.fromRGB(55, 155, 75)
yes.Text = "Yes"
yes.TextColor3 = Color3.new(1, 1, 1)
yes.TextSize = 14
yes.Font = Enum.Font.GothamBold
yes.ZIndex = 11
yes.Parent = confirm

Instance.new("UICorner", yes).CornerRadius =
    UDim.new(0, 6)

local no = Instance.new("TextButton")
no.Size = UDim2.fromOffset(100, 32)
no.Position = UDim2.new(1, -120, 1, -42)
no.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
no.Text = "No"
no.TextColor3 = Color3.new(1, 1, 1)
no.TextSize = 14
no.Font = Enum.Font.GothamBold
no.ZIndex = 11
no.Parent = confirm

Instance.new("UICorner", no).CornerRadius =
    UDim.new(0, 6)

closeButton.Activated:Connect(function()
    confirm.Visible = true
end)

no.Activated:Connect(function()
    confirm.Visible = false
end)

yes.Activated:Connect(function()
    gui:Destroy()
end)

print("Sidebar and close confirmation loaded!")


-- MINIMIZE + REOPEN BUTTON

-- Floating reopen icon
local reopen = Instance.new("TextButton")
reopen.Name = "ReopenGUI"
reopen.Size = UDim2.fromOffset(46, 46)
reopen.Position = UDim2.new(0, 12, 0.5, -23)
reopen.BackgroundColor3 = Color3.fromRGB(65, 65, 70)
reopen.BackgroundTransparency = 0.1
reopen.BorderSizePixel = 0
reopen.Text = "N"
reopen.TextColor3 = Color3.fromRGB(230, 230, 240)
reopen.TextSize = 22
reopen.Font = Enum.Font.GothamBold
reopen.Visible = false
reopen.Parent = gui

Instance.new("UICorner", reopen).CornerRadius =
    UDim.new(1, 0)

local reopenStroke = Instance.new("UIStroke", reopen)
reopenStroke.Color = Color3.fromRGB(150, 150, 165)
reopenStroke.Thickness = 1.5

-- Minimize button
local minimize = Instance.new("TextButton")
minimize.Name = "MinimizeButton"
minimize.Size = UDim2.fromOffset(25, 25)
minimize.Position = UDim2.new(1, -63, 0, 7)
minimize.BackgroundColor3 = Color3.fromRGB(65, 65, 70)
minimize.BorderSizePixel = 0
minimize.Text = "−"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.ZIndex = 5
minimize.Parent = main

Instance.new("UICorner", minimize).CornerRadius =
    UDim.new(0, 6)

-- Minimize the GUI
minimize.Activated:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)

-- Reopen the GUI
reopen.Activated:Connect(function()
    main.Visible = true
    reopen.Visible = false
end)

print("Minimize and reopen buttons loaded!")

-- end end end end end end end yes


-- MENU KEYBIND: BOTTOM-LEFT CORNER

local UserInputService = game:GetService("UserInputService")

local oldPanel = main:FindFirstChild("MenuKeybindPanel")
if oldPanel then
    oldPanel:Destroy()
end

local panel = Instance.new("Frame")
panel.Name = "MenuKeybindPanel"
panel.AnchorPoint = Vector2.new(0, 1)
panel.Position = UDim2.new(0, 10, 1, -10)
panel.Size = UDim2.fromOffset(175, 38)
panel.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
panel.BackgroundTransparency = 0.1
panel.BorderSizePixel = 0
panel.ZIndex = 2
panel.Parent = main

Instance.new("UICorner", panel).CornerRadius =
    UDim.new(0, 6)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -55, 1, 0)
label.Position = UDim2.fromOffset(8, 0)
label.BackgroundTransparency = 1
label.Text = "Menu Keybind:"
label.TextColor3 = Color3.fromRGB(235, 235, 240)
label.TextSize = 12
label.Font = Enum.Font.GothamMedium
label.TextXAlignment = Enum.TextXAlignment.Left
label.ZIndex = 3
label.Parent = panel

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.fromOffset(38, 26)
keyButton.Position = UDim2.new(1, -44, 0.5, -13)
keyButton.BackgroundColor3 = Color3.fromRGB(75, 75, 85)
keyButton.BorderSizePixel = 0
keyButton.Text = "M"
keyButton.TextColor3 = Color3.new(1, 1, 1)
keyButton.TextSize = 13
keyButton.Font = Enum.Font.GothamBold
keyButton.ZIndex = 3
keyButton.Parent = panel

Instance.new("UICorner", keyButton).CornerRadius =
    UDim.new(0, 5)

local menuKey = Enum.KeyCode.M
local listening = false

keyButton.Activated:Connect(function()
    listening = true
    keyButton.Text = "..."
end)

UserInputService.InputBegan:Connect(function(input)
    if listening then
        if input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode ~= Enum.KeyCode.Unknown then

            menuKey = input.KeyCode
            keyButton.Text = menuKey.Name
            listening = false
        end
        return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard
        and input.KeyCode == menuKey then

        if main.Visible then
            main.Visible = false
            reopen.Visible = true
        else
            main.Visible = true
            reopen.Visible = false
        end
    end
end)


-- FIX: HEADER ABOVE THE MAIN WINDOW

local oldHeader = gui:FindFirstChild("NexusHeader")
if oldHeader then
    oldHeader:Destroy()
end

local header = Instance.new("Frame")
header.Name = "NexusHeader"
header.AnchorPoint = Vector2.new(0.5, 1)
header.Position = UDim2.new(
    main.Position.X.Scale,
    main.Position.X.Offset,
    main.Position.Y.Scale,
    main.Position.Y.Offset - main.AbsoluteSize.Y / 2 - 8
)
header.Size = UDim2.new(0, main.AbsoluteSize.X + 24, 0, 58)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
header.BorderSizePixel = 0
header.ZIndex = 20
header.Parent = gui

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 10)

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 32)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 65, 82)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 32))
})
gradient.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -24, 0, 32)
title.Position = UDim2.fromOffset(14, 3)
title.BackgroundTransparency = 1
title.Text = "N E X U S"
title.TextColor3 = Color3.fromRGB(245, 242, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 21
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -28, 0, 15)
subtitle.Position = UDim2.fromOffset(16, 35)
subtitle.BackgroundTransparency = 1
subtitle.Text = "P R E M I U M   I N T E R F A C E"
subtitle.TextColor3 = Color3.fromRGB(180, 175, 200)
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 21
subtitle.Parent = header

local line = Instance.new("Frame")
line.Position = UDim2.new(0, 12, 1, -3)
line.Size = UDim2.new(1, -24, 0, 2)
line.BackgroundColor3 = Color3.fromRGB(155, 115, 255)
line.BorderSizePixel = 0
line.ZIndex = 21
line.Parent = header

-- Keep the header above the GUI when minimized/reopened
main:GetPropertyChangedSignal("Visible"):Connect(function()
    header.Visible = main.Visible
end)

print("Header repositioned above the GUI!")


-- NEXUS KEY SYSTEM

local correctKey = "NEXUSKEY5123"

-- Hide the main GUI until unlocked
main.Visible = false
reopen.Visible = false

-- Prevent duplicate key windows
local oldKeyGui = gui:FindFirstChild("NexusKeySystem")
if oldKeyGui then
    oldKeyGui:Destroy()
end

local keyFrame = Instance.new("Frame")
keyFrame.Name = "NexusKeySystem"
keyFrame.Size = UDim2.fromOffset(350, 210)
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.fromScale(0.5, 0.5)
keyFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
keyFrame.BorderSizePixel = 0
keyFrame.ZIndex = 50
keyFrame.Parent = gui

Instance.new("UICorner", keyFrame).CornerRadius =
    UDim.new(0, 12)

local stroke = Instance.new("UIStroke", keyFrame)
stroke.Color = Color3.fromRGB(145, 105, 255)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 38)
title.Position = UDim2.fromOffset(10, 12)
title.BackgroundTransparency = 1
title.Text = "N E X U S"
title.TextColor3 = Color3.fromRGB(240, 235, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 24
title.ZIndex = 51
title.Parent = keyFrame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 22)
subtitle.Position = UDim2.fromOffset(10, 49)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Enter your access key to continue"
subtitle.TextColor3 = Color3.fromRGB(175, 175, 195)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.ZIndex = 51
subtitle.Parent = keyFrame

local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -40, 0, 38)
input.Position = UDim2.fromOffset(20, 82)
input.BackgroundColor3 = Color3.fromRGB(23, 23, 29)
input.BorderSizePixel = 0
input.PlaceholderText = "Enter key..."
input.PlaceholderColor3 = Color3.fromRGB(130, 130, 145)
input.Text = ""
input.TextColor3 = Color3.new(1, 1, 1)
input.TextSize = 14
input.Font = Enum.Font.Gotham
input.ClearTextOnFocus = false
input.ZIndex = 51
input.Parent = keyFrame

Instance.new("UICorner", input).CornerRadius =
    UDim.new(0, 7)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 18)
status.Position = UDim2.fromOffset(20, 122)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 90, 100)
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.ZIndex = 51
status.Parent = keyFrame

local unlock = Instance.new("TextButton")
unlock.Size = UDim2.new(1, -40, 0, 34)
unlock.Position = UDim2.fromOffset(20, 151)
unlock.BackgroundColor3 = Color3.fromRGB(100, 75, 165)
unlock.BorderSizePixel = 0
unlock.Text = "UNLOCK NEXUS"
unlock.TextColor3 = Color3.new(1, 1, 1)
unlock.TextSize = 13
unlock.Font = Enum.Font.GothamBold
unlock.ZIndex = 51
unlock.Parent = keyFrame

Instance.new("UICorner", unlock).CornerRadius =
    UDim.new(0, 7)

local function checkKey()
    if input.Text == correctKey then
        status.TextColor3 = Color3.fromRGB(100, 230, 150)
        status.Text = "Access granted!"

        task.wait(0.25)

        keyFrame:Destroy()
        main.Visible = true
        reopen.Visible = false
    else
        status.TextColor3 = Color3.fromRGB(255, 90, 100)
        status.Text = "Invalid key. Try again."
        input.Text = ""
    end
end

unlock.Activated:Connect(checkKey)

input.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        checkKey()
    end
end)

print("Nexus key system loaded!")


-- NEXUS: FULL-SCREEN LOADING EXPERIENCE

local TweenService = game:GetService("TweenService")

-- Hide the key screen until loading finishes
keyFrame.Visible = false

local loading = Instance.new("Frame")
loading.Name = "NexusLoadingScreen"
loading.Size = UDim2.fromScale(1, 1)
loading.Position = UDim2.fromScale(0, 0)
loading.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
loading.BorderSizePixel = 0
loading.ZIndex = 100
loading.Parent = gui

-- Background gradient
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 15)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(29, 22, 44)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 20))
})
bgGradient.Rotation = 35
bgGradient.Parent = loading

-- Decorative glow circles
local function makeGlow(size, position, color)
    local glow = Instance.new("Frame")
    glow.Size = UDim2.fromOffset(size, size)
    glow.Position = position
    glow.BackgroundColor3 = color
    glow.BackgroundTransparency = 0.78
    glow.BorderSizePixel = 0
    glow.ZIndex = 101
    glow.Parent = loading

    Instance.new("UICorner", glow).CornerRadius =
        UDim.new(1, 0)

    local gradient = Instance.new("UIGradient")
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(1, 1)
    })
    gradient.Parent = glow

    return glow
end

local glow1 = makeGlow(
    300,
    UDim2.new(0.5, -150, 0.5, -220),
    Color3.fromRGB(115, 65, 220)
)

local glow2 = makeGlow(
    240,
    UDim2.new(0.5, -120, 0.5, 50),
    Color3.fromRGB(45, 105, 220)
)

-- Center content
local content = Instance.new("Frame")
content.Name = "LoadingContent"
content.AnchorPoint = Vector2.new(0.5, 0.5)
content.Position = UDim2.fromScale(0.5, 0.5)
content.Size = UDim2.fromOffset(420, 270)
content.BackgroundTransparency = 1
content.ZIndex = 102
content.Parent = loading

-- Logo icon
local logo = Instance.new("Frame")
logo.Size = UDim2.fromOffset(66, 66)
logo.Position = UDim2.new(0.5, -33, 0, 0)
logo.BackgroundColor3 = Color3.fromRGB(105, 72, 175)
logo.BorderSizePixel = 0
logo.ZIndex = 103
logo.Parent = content

Instance.new("UICorner", logo).CornerRadius =
    UDim.new(0, 18)

local logoGradient = Instance.new("UIGradient")
logoGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(155, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 125, 235))
})
logoGradient.Rotation = 45
logoGradient.Parent = logo

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.fromScale(1, 1)
logoText.BackgroundTransparency = 1
logoText.Text = "N"
logoText.TextColor3 = Color3.new(1, 1, 1)
logoText.TextSize = 38
logoText.Font = Enum.Font.GothamBlack
logoText.ZIndex = 104
logoText.Parent = logo

-- Main title
local title = Instance.new("TextLabel")
title.Position = UDim2.new(0, 0, 0, 82)
title.Size = UDim2.new(1, 0, 0, 44)
title.BackgroundTransparency = 1
title.Text = "N E X U S"
title.TextColor3 = Color3.fromRGB(248, 245, 255)
title.TextSize = 32
title.Font = Enum.Font.GothamBlack
title.ZIndex = 103
title.Parent = content

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.new(0, 0, 0, 125)
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.BackgroundTransparency = 1
subtitle.Text = "PREMIUM INTERFACE"
subtitle.TextColor3 = Color3.fromRGB(165, 155, 190)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.GothamMedium
subtitle.ZIndex = 103
subtitle.Parent = content

-- Loading status
local status = Instance.new("TextLabel")
status.Position = UDim2.new(0, 0, 0, 177)
status.Size = UDim2.new(1, -10, 0, 20)
status.BackgroundTransparency = 1
status.Text = "Initializing interface..."
status.TextColor3 = Color3.fromRGB(205, 200, 220)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.ZIndex = 103
status.Parent = content

local percentage = Instance.new("TextLabel")
percentage.Position = UDim2.new(1, -65, 0, 177)
percentage.Size = UDim2.fromOffset(65, 20)
percentage.BackgroundTransparency = 1
percentage.Text = "0%"
percentage.TextColor3 = Color3.fromRGB(185, 145, 255)
percentage.TextSize = 12
percentage.Font = Enum.Font.GothamBold
percentage.TextXAlignment = Enum.TextXAlignment.Right
percentage.ZIndex = 103
percentage.Parent = content

-- Progress bar background
local barBack = Instance.new("Frame")
barBack.Position = UDim2.new(0, 0, 0, 207)
barBack.Size = UDim2.new(1, 0, 0, 6)
barBack.BackgroundColor3 = Color3.fromRGB(42, 39, 53)
barBack.BorderSizePixel = 0
barBack.ClipsDescendants = true
barBack.ZIndex = 103
barBack.Parent = content

Instance.new("UICorner", barBack).CornerRadius =
    UDim.new(1, 0)

-- Progress bar fill
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(155, 100, 255)
bar.BorderSizePixel = 0
bar.ZIndex = 104
bar.Parent = barBack

Instance.new("UICorner", bar).CornerRadius =
    UDim.new(1, 0)

local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 75, 230)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 165, 255))
})
barGradient.Parent = bar

-- Footer
local footer = Instance.new("TextLabel")
footer.AnchorPoint = Vector2.new(0.5, 1)
footer.Position = UDim2.new(0.5, 0, 1, -24)
footer.Size = UDim2.new(1, -20, 0, 20)
footer.BackgroundTransparency = 1
footer.Text = "NEXUS  •  YOUR INTERFACE, YOUR RULES"
footer.TextColor3 = Color3.fromRGB(105, 105, 130)
footer.TextSize = 10
footer.Font = Enum.Font.GothamMedium
footer.ZIndex = 102
footer.Parent = loading

-- Animate loading progress
task.spawn(function()
    local steps = {
        {25, "Initializing interface..."},
        {48, "Preparing components..."},
        {72, "Loading visual theme..."},
        {90, "Preparing access system..."},
        {100, "Ready!"}
    }

    for _, step in ipairs(steps) do
        if not loading.Parent then
            return
        end

        status.Text = step[2]
        percentage.Text = step[1] .. "%"

        local tween = TweenService:Create(
            bar,
            TweenInfo.new(
                0.55,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {Size = UDim2.new(step[1] / 100, 0, 1, 0)}
        )

        tween:Play()
        tween.Completed:Wait()
        task.wait(0.3)
    end

    task.wait(0.45)

    -- Fade out the loading screen
    for _, object in ipairs(loading:GetDescendants()) do
        if object:IsA("TextLabel") then
            TweenService:Create(
                object,
                TweenInfo.new(0.4),
                {TextTransparency = 1}
            ):Play()
        elseif object:IsA("Frame") then
            TweenService:Create(
                object,
                TweenInfo.new(0.4),
                {BackgroundTransparency = 1}
            ):Play()
        end
    end

    TweenService:Create(
        loading,
        TweenInfo.new(0.45),
        {BackgroundTransparency = 1}
    ):Play()

    task.wait(0.5)

    if loading.Parent then
        loading:Destroy()
    end

    -- Show the existing key-entry screen
    if keyFrame and keyFrame.Parent then
        keyFrame.Visible = true
    end
end)

print("Nexus full-screen loader started!")


-- NEXUS: ADVANCED KEYBIND MANAGER

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Remove an old copy
local oldManager = main:FindFirstChild("NexusKeybindManager")
if oldManager then
    oldManager:Destroy()
end

-- Main manager panel
local manager = Instance.new("Frame")
manager.Name = "NexusKeybindManager"
manager.Position = UDim2.fromOffset(145, 42)
manager.Size = UDim2.new(1, -160, 1, -54)
manager.BackgroundColor3 = Color3.fromRGB(32, 32, 39)
manager.BackgroundTransparency = 0.08
manager.BorderSizePixel = 0
manager.Visible = false
manager.ClipsDescendants = true
manager.Parent = main

Instance.new("UICorner", manager).CornerRadius =
    UDim.new(0, 10)

local outline = Instance.new("UIStroke", manager)
outline.Color = Color3.fromRGB(125, 95, 180)
outline.Transparency = 0.45
outline.Thickness = 1

-- Header
local heading = Instance.new("TextLabel")
heading.Position = UDim2.fromOffset(14, 10)
heading.Size = UDim2.new(1, -28, 0, 30)
heading.BackgroundTransparency = 1
heading.Text = "KEYBIND MANAGER"
heading.TextColor3 = Color3.fromRGB(240, 235, 255)
heading.TextSize = 17
heading.Font = Enum.Font.GothamBold
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = manager

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(14, 39)
subtitle.Size = UDim2.new(1, -28, 0, 22)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Customize your NEXUS controls"
subtitle.TextColor3 = Color3.fromRGB(155, 150, 170)
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = manager

-- Divider
local divider = Instance.new("Frame")
divider.Position = UDim2.new(0, 14, 0, 67)
divider.Size = UDim2.new(1, -28, 0, 1)
divider.BackgroundColor3 = Color3.fromRGB(75, 70, 90)
divider.BackgroundTransparency = 0.3
divider.BorderSizePixel = 0
divider.Parent = manager

-- Menu key setting row
local row = Instance.new("Frame")
row.Name = "MenuToggleSetting"
row.Position = UDim2.fromOffset(12, 80)
row.Size = UDim2.new(1, -24, 0, 64)
row.BackgroundColor3 = Color3.fromRGB(44, 43, 53)
row.BackgroundTransparency = 0.1
row.BorderSizePixel = 0
row.Parent = manager

Instance.new("UICorner", row).CornerRadius =
    UDim.new(0, 8)

local rowTitle = Instance.new("TextLabel")
rowTitle.Position = UDim2.fromOffset(12, 8)
rowTitle.Size = UDim2.new(1, -100, 0, 22)
rowTitle.BackgroundTransparency = 1
rowTitle.Text = "Menu Toggle"
rowTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
rowTitle.TextSize = 13
rowTitle.Font = Enum.Font.GothamMedium
rowTitle.TextXAlignment = Enum.TextXAlignment.Left
rowTitle.Parent = row

local rowInfo = Instance.new("TextLabel")
rowInfo.Position = UDim2.fromOffset(12, 32)
rowInfo.Size = UDim2.new(1, -100, 0, 18)
rowInfo.BackgroundTransparency = 1
rowInfo.Text = "Show or hide the main window"
rowInfo.TextColor3 = Color3.fromRGB(155, 150, 170)
rowInfo.TextSize = 10
rowInfo.Font = Enum.Font.Gotham
rowInfo.TextXAlignment = Enum.TextXAlignment.Left
rowInfo.Parent = row

local capture = Instance.new("TextButton")
capture.Name = "MenuKeyCapture"
capture.AnchorPoint = Vector2.new(1, 0.5)
capture.Position = UDim2.new(1, -10, 0.5, 0)
capture.Size = UDim2.fromOffset(68, 32)
capture.BackgroundColor3 = Color3.fromRGB(82, 65, 120)
capture.BorderSizePixel = 0
capture.Text = "M"
capture.TextColor3 = Color3.new(1, 1, 1)
capture.TextSize = 13
capture.Font = Enum.Font.GothamBold
capture.Parent = row

Instance.new("UICorner", capture).CornerRadius =
    UDim.new(0, 7)

-- Reset button
local reset = Instance.new("TextButton")
reset.Name = "ResetKeybind"
reset.Position = UDim2.fromOffset(12, 156)
reset.Size = UDim2.new(1, -24, 0, 34)
reset.BackgroundColor3 = Color3.fromRGB(48, 47, 58)
reset.BorderSizePixel = 0
reset.Text = "Reset Default Keybind"
reset.TextColor3 = Color3.fromRGB(215, 210, 230)
reset.TextSize = 12
reset.Font = Enum.Font.GothamMedium
reset.Parent = manager

Instance.new("UICorner", reset).CornerRadius =
    UDim.new(0, 7)

-- Status message
local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(14, 198)
status.Size = UDim2.new(1, -28, 0, 34)
status.BackgroundTransparency = 1
status.Text = "●  Menu shortcut ready"
status.TextColor3 = Color3.fromRGB(145, 205, 165)
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextWrapped = true
status.Parent = manager

-- Keybind state
local defaultKey = Enum.KeyCode.M
local menuKey = defaultKey
local listening = false
local capturedInput = nil

local function setStatus(message, color)
    status.Text = message
    status.TextColor3 = color
end

local function setKey(key)
    menuKey = key
    capture.Text = key.Name
    setStatus(
        "●  Menu shortcut set to " .. key.Name,
        Color3.fromRGB(145, 205, 165)
    )
end

capture.Activated:Connect(function()
    listening = true
    capturedInput = nil
    capture.Text = "..."
    capture.BackgroundColor3 = Color3.fromRGB(120, 85, 190)
    setStatus(
        "⌨  Press any keyboard key...",
        Color3.fromRGB(200, 175, 255)
    )
end)

reset.Activated:Connect(function()
    listening = false
    capturedInput = nil
    capture.BackgroundColor3 = Color3.fromRGB(82, 65, 120)
    setKey(defaultKey)
end)

-- Capture and handle the menu shortcut
UIS.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if listening then
        if input.KeyCode == Enum.KeyCode.Unknown then
            return
        end

        menuKey = input.KeyCode
        capturedInput = input.KeyCode
        listening = false

        capture.Text = menuKey.Name
        capture.BackgroundColor3 = Color3.fromRGB(82, 65, 120)

        setStatus(
            "●  Shortcut updated successfully",
            Color3.fromRGB(145, 205, 165)
        )
        return
    end

    if processed then
        return
    end

    if input.KeyCode == menuKey then
        -- The original script already handles M.
        -- Avoid toggling twice when M is the selected key.
        if menuKey == Enum.KeyCode.M then
            return
        end

        main.Visible = not main.Visible
        reopen.Visible = not main.Visible
    end
end)

-- Open manager only on the Keybinds tab
for _, tab in ipairs(sidebar:GetChildren()) do
    if tab:IsA("TextButton") then
        tab.Activated:Connect(function()
            manager.Visible = (tab.Name == "KeybindsTab")
        end)
    end
end

setKey(defaultKey)

print("NEXUS Keybind Manager loaded!")
 -- yessss boyyyyy

 -- REMOVE OLD CORNER KEYBIND PANEL

local oldPanel = main:FindFirstChild("MenuKeybindPanel", true)

if oldPanel then
    oldPanel:Destroy()
    print("Old corner keybind removed!")
else
    print("No old corner keybind panel found.")
end

-- very goooooddddd


-- NEXUS FIX: REMOVE THE OLD M SHORTCUT

-- Disable the legacy M keybind by using a replacement listener
-- Note: Roblox input connections cannot be disconnected unless
-- their RBXScriptConnection was saved when it was created.

local UIS = game:GetService("UserInputService")

-- Create a single authoritative menu keybind
local activeMenuKey = Enum.KeyCode.M
local waitingForMenuKey = false

-- Find the Keybind Manager controls
local manager = main:FindFirstChild("NexusKeybindManager")
local capture = manager and manager:FindFirstChild("MenuToggleSetting")
    and manager.MenuToggleSetting:FindFirstChild("MenuKeyCapture")

if capture then
    capture.Activated:Connect(function()
        waitingForMenuKey = true
        capture.Text = "..."
    end)
end

-- This listener handles the new key, but the old listener
-- must be disconnected in the original script to fully fix M.
UIS.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if waitingForMenuKey then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            activeMenuKey = input.KeyCode
            waitingForMenuKey = false
            if capture then
                capture.Text = activeMenuKey.Name
            end
        end
        return
    end

    if processed then
        return
    end

    if input.KeyCode == activeMenuKey then
        main.Visible = not main.Visible
        reopen.Visible = not main.Visible
    end
end)

print("Replacement menu keybind listener added.")


-- sussssssyyy


-- NEXUS: KEYBIND MANAGER FIX

local UIS = game:GetService("UserInputService")

local manager = main:FindFirstChild("NexusKeybindManager")
local row = manager and manager:FindFirstChild("MenuToggleSetting")
local capture = row and row:FindFirstChild("MenuKeyCapture")

if not capture then
    warn("Keybind capture button not found.")
    return
end

-- Replace the manager UI and its key handling.
-- This listener supports M and every other keyboard key.
local selectedKey = Enum.KeyCode.M
local listeningForKey = false

capture.Text = selectedKey.Name

capture.Activated:Connect(function()
    listeningForKey = true
    capture.Text = "..."
end)

UIS.InputBegan:Connect(function(input, processed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then
        return
    end

    if listeningForKey then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            selectedKey = input.KeyCode
            capture.Text = selectedKey.Name
            listeningForKey = false
        end
        return
    end

    if processed then
        return
    end

    if input.KeyCode == selectedKey then
        main.Visible = not main.Visible
        reopen.Visible = not main.Visible
    end
end)

print("Keybind capture updated.")

-- susssssyyyyy


-- NEXUS: PERMANENT M KEYBIND NOTE

local manager = main:FindFirstChild("NexusKeybindManager")

if manager then
    local oldNote = manager:FindFirstChild("PermanentKeyNote")
    if oldNote then
        oldNote:Destroy()
    end

    local note = Instance.new("TextLabel")
    note.Name = "PermanentKeyNote"
    note.Position = UDim2.new(0, 14, 0, 238)
    note.Size = UDim2.new(1, -28, 0, 30)
    note.BackgroundTransparency = 1
    note.Text = "●  M will always stay as a Keybind!"
    note.TextColor3 = Color3.fromRGB(90, 220, 125)
    note.TextSize = 11
    note.Font = Enum.Font.GothamMedium
    note.TextXAlignment = Enum.TextXAlignment.Left
    note.TextWrapped = true
    note.Parent = manager

    print("Permanent M keybind note added!")
else
    warn("NEXUS Keybind Manager not found.")
end

-- olalala secret message


-- NEXUS: FULL PLAYER PROFILE / HOME DASHBOARD

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Remove previous copy
local oldProfile = main:FindFirstChild("NexusHomeProfile")
if oldProfile then
    oldProfile:Destroy()
end

-- Main Home page
local home = Instance.new("Frame")
home.Name = "NexusHomeProfile"
home.Position = UDim2.fromOffset(145, 42)
home.Size = UDim2.new(1, -160, 1, -54)
home.BackgroundColor3 = Color3.fromRGB(32, 32, 39)
home.BackgroundTransparency = 0.05
home.BorderSizePixel = 0
home.Visible = true
home.ClipsDescendants = true
home.Parent = main

Instance.new("UICorner", home).CornerRadius =
    UDim.new(0, 10)

local outline = Instance.new("UIStroke", home)
outline.Color = Color3.fromRGB(115, 85, 175)
outline.Transparency = 0.55
outline.Thickness = 1

-- Header
local heading = Instance.new("TextLabel")
heading.Position = UDim2.fromOffset(16, 12)
heading.Size = UDim2.new(1, -32, 0, 30)
heading.BackgroundTransparency = 1
heading.Text = "PLAYER PROFILE"
heading.TextColor3 = Color3.fromRGB(242, 238, 255)
heading.Font = Enum.Font.GothamBlack
heading.TextSize = 18
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = home

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(17, 41)
subtitle.Size = UDim2.new(1, -34, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Welcome to your personal NEXUS dashboard."
subtitle.TextColor3 = Color3.fromRGB(160, 155, 175)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = home

-- Profile card
local card = Instance.new("Frame")
card.Name = "ProfileCard"
card.Position = UDim2.fromOffset(12, 72)
card.Size = UDim2.new(1, -24, 0, 125)
card.BackgroundColor3 = Color3.fromRGB(43, 42, 53)
card.BorderSizePixel = 0
card.Parent = home

Instance.new("UICorner", card).CornerRadius =
    UDim.new(0, 9)

local cardGradient = Instance.new("UIGradient")
cardGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(53, 45, 72)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(37, 39, 51))
})
cardGradient.Rotation = 15
cardGradient.Parent = card

-- Avatar portrait
local avatar = Instance.new("ImageLabel")
avatar.Name = "PlayerAvatar"
avatar.Position = UDim2.fromOffset(14, 17)
avatar.Size = UDim2.fromOffset(88, 88)
avatar.BackgroundColor3 = Color3.fromRGB(65, 58, 85)
avatar.BorderSizePixel = 0
avatar.Image = ""
avatar.ScaleType = Enum.ScaleType.Crop
avatar.Parent = card

Instance.new("UICorner", avatar).CornerRadius =
    UDim.new(0, 12)

local avatarStroke = Instance.new("UIStroke", avatar)
avatarStroke.Color = Color3.fromRGB(165, 115, 255)
avatarStroke.Thickness = 2

-- Display name
local displayName = Instance.new("TextLabel")
displayName.Name = "DisplayName"
displayName.Position = UDim2.fromOffset(115, 18)
displayName.Size = UDim2.new(1, -127, 0, 27)
displayName.BackgroundTransparency = 1
displayName.Text = player.DisplayName
displayName.TextColor3 = Color3.fromRGB(250, 248, 255)
displayName.TextSize = 19
displayName.Font = Enum.Font.GothamBold
displayName.TextXAlignment = Enum.TextXAlignment.Left
displayName.TextTruncate = Enum.TextTruncate.AtEnd
displayName.Parent = card

-- Username
local username = Instance.new("TextLabel")
username.Name = "Username"
username.Position = UDim2.fromOffset(116, 47)
username.Size = UDim2.new(1, -128, 0, 21)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.TextColor3 = Color3.fromRGB(185, 170, 220)
username.TextSize = 12
username.Font = Enum.Font.GothamMedium
username.TextXAlignment = Enum.TextXAlignment.Left
username.TextTruncate = Enum.TextTruncate.AtEnd
username.Parent = card

-- Online status
local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(116, 76)
status.Size = UDim2.new(1, -128, 0, 22)
status.BackgroundTransparency = 1
status.Text = "●  SCRIPT USER"
status.TextColor3 = Color3.fromRGB(100, 225, 145)
status.TextSize = 11
status.Font = Enum.Font.GothamBold
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = card

-- Information section heading
local infoHeading = Instance.new("TextLabel")
infoHeading.Position = UDim2.fromOffset(15, 210)
infoHeading.Size = UDim2.new(1, -30, 0, 24)
infoHeading.BackgroundTransparency = 1
infoHeading.Text = "ACCOUNT INFORMATION"
infoHeading.TextColor3 = Color3.fromRGB(220, 215, 235)
infoHeading.TextSize = 12
infoHeading.Font = Enum.Font.GothamBold
infoHeading.TextXAlignment = Enum.TextXAlignment.Left
infoHeading.Parent = home

-- Create information rows
local function createInfoRow(name, y, labelText, valueText)
    local row = Instance.new("Frame")
    row.Name = name
    row.Position = UDim2.fromOffset(12, y)
    row.Size = UDim2.new(1, -24, 0, 32)
    row.BackgroundColor3 = Color3.fromRGB(43, 42, 51)
    row.BackgroundTransparency = 0.15
    row.BorderSizePixel = 0
    row.Parent = home

    Instance.new("UICorner", row).CornerRadius =
        UDim.new(0, 6)

    local left = Instance.new("TextLabel")
    left.Position = UDim2.fromOffset(10, 0)
    left.Size = UDim2.new(0.48, -10, 1, 0)
    left.BackgroundTransparency = 1
    left.Text = labelText
    left.TextColor3 = Color3.fromRGB(165, 160, 180)
    left.TextSize = 11
    left.Font = Enum.Font.Gotham
    left.TextXAlignment = Enum.TextXAlignment.Left
    left.Parent = row

    local right = Instance.new("TextLabel")
    right.Name = "Value"
    right.Position = UDim2.new(0.48, 0, 0, 0)
    right.Size = UDim2.new(0.52, -10, 1, 0)
    right.BackgroundTransparency = 1
    right.Text = valueText
    right.TextColor3 = Color3.fromRGB(240, 237, 250)
    right.TextSize = 11
    right.Font = Enum.Font.GothamMedium
    right.TextXAlignment = Enum.TextXAlignment.Right
    right.TextTruncate = Enum.TextTruncate.AtEnd
    right.Parent = row

    return right
end

local userIdValue = createInfoRow(
    "UserIdRow", 240, "Roblox User ID", tostring(player.UserId)
)

local ageValue = createInfoRow(
    "AccountAgeRow", 278, "Account Age",
    tostring(player.AccountAge) .. " days"
)

local membership = "Standard"
if player.MembershipType == Enum.MembershipType.Premium then
    membership = "Roblox Premium"
end

local membershipValue = createInfoRow(
    "MembershipRow", 316, "Membership", membership
)

-- Load the executing player's Roblox avatar
task.spawn(function()
    local success, image = pcall(function()
        return Players:GetUserThumbnailAsync(
            player.UserId,
            Enum.ThumbnailType.AvatarBust,
            Enum.ThumbnailSize.Size180x180
        )
    end)

    if success and avatar.Parent then
        avatar.Image = image
    end
end)

-- Make the Home profile appear only on the Home tab
local sidebar = main:FindFirstChild("Sidebar")

if sidebar then
    for _, tab in ipairs(sidebar:GetChildren()) do
        if tab:IsA("TextButton") then
            tab.Activated:Connect(function()
                home.Visible = (tab.Name == "HomeTab")
            end)
        end
    end
end

print("NEXUS player profile loaded!")

-- susy script reader


-- NEXUS: MAKE HOME PROFILE SCROLLABLE

local home = main:FindFirstChild("NexusHomeProfile")

if not home then
    warn("NEXUS Home profile not found!")
    return
end

-- Prevent duplicate scroll containers
local oldScroll = home:FindFirstChild("ProfileScroll")
if oldScroll then
    oldScroll:Destroy()
end

-- Create scrolling area below the fixed header
local scroll = Instance.new("ScrollingFrame")
scroll.Name = "ProfileScroll"
scroll.Position = UDim2.fromOffset(0, 65)
scroll.Size = UDim2.new(1, 0, 1, -65)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = Color3.fromRGB(145, 105, 225)
scroll.CanvasSize = UDim2.new(0, 0, 0, 390)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
scroll.Parent = home

-- Move all existing profile content except the header labels
for _, child in ipairs(home:GetChildren()) do
    if child ~= scroll
        and child.Name ~= "UIStroke"
        and child:IsA("GuiObject") then

        if child.Name == "ProfileCard" then
            child.Parent = scroll
            child.Position = UDim2.fromOffset(12, 7)

        elseif child.Name == "AccountInformation"
            or child.Name == "UserIdRow"
            or child.Name == "AccountAgeRow"
            or child.Name == "MembershipRow" then

            child.Parent = scroll
        end
    end
end

-- Place the information heading and rows inside the scroll
local infoHeading = home:FindFirstChild("ACCOUNT INFORMATION")
if infoHeading then
    infoHeading.Parent = scroll
    infoHeading.Position = UDim2.fromOffset(15, 142)
end

local userRow = home:FindFirstChild("UserIdRow")
if userRow then
    userRow.Position = UDim2.fromOffset(12, 172)
end

local ageRow = home:FindFirstChild("AccountAgeRow")
if ageRow then
    ageRow.Position = UDim2.fromOffset(12, 210)
end

local membershipRow = home:FindFirstChild("MembershipRow")
if membershipRow then
    membershipRow.Position = UDim2.fromOffset(12, 248)
end

print("NEXUS Home profile is now scrollable!")

-- stop reading right now lil boy


-- NEXUS: FIX HOME PROFILE SCROLL LAYOUT

local home = main:FindFirstChild("NexusHomeProfile")
local scroll = home and home:FindFirstChild("ProfileScroll")

if not home or not scroll then
    warn("Home profile or scroll container not found!")
    return
end

-- Move the account heading into the scrolling container
local infoHeading = home:FindFirstChild("ACCOUNT INFORMATION")
    or scroll:FindFirstChild("ACCOUNT INFORMATION")

if infoHeading then
    infoHeading.Parent = scroll
    infoHeading.Position = UDim2.fromOffset(15, 140)
    infoHeading.Size = UDim2.new(1, -30, 0, 24)
end

-- Keep the profile card at the top
local card = scroll:FindFirstChild("ProfileCard")
if card then
    card.Position = UDim2.fromOffset(12, 7)
    card.Size = UDim2.new(1, -24, 0, 125)
end

-- Bring information rows directly beneath the card
local rowPositions = {
    UserIdRow = 170,
    AccountAgeRow = 207,
    MembershipRow = 244
}

for name, y in pairs(rowPositions) do
    local row = scroll:FindFirstChild(name)
        or home:FindFirstChild(name)

    if row then
        row.Parent = scroll
        row.Position = UDim2.fromOffset(12, y)
        row.Size = UDim2.new(1, -24, 0, 32)
    end
end

-- Ensure the scrolling area contains all rows
scroll.AutomaticCanvasSize = Enum.AutomaticSize.None
scroll.CanvasSize = UDim2.new(0, 0, 0, 290)

-- Make sure only the main title and subtitle stay fixed
for _, child in ipairs(home:GetChildren()) do
    if child:IsA("TextLabel")
        and (child.Text == "PLAYER PROFILE"
        or child.Text == "Welcome to your personal NEXUS dashboard.") then
        child.Visible = true
    end
end

print("NEXUS profile layout corrected!")


-- NEXUS: MAKE ACCOUNT INFORMATION SCROLL TOO

local home = main:FindFirstChild("NexusHomeProfile")
local scroll = home and home:FindFirstChild("ProfileScroll")

if not home or not scroll then
    warn("Home profile scroll area not found!")
    return
end

-- Find the heading whether it's inside or outside the scroll
local heading

for _, obj in ipairs(home:GetDescendants()) do
    if obj:IsA("TextLabel")
        and obj.Text == "ACCOUNT INFORMATION" then
        heading = obj
        break
    end
end

if heading then
    heading.Parent = scroll
    heading.Position = UDim2.fromOffset(15, 140)
    heading.Size = UDim2.new(1, -30, 0, 24)
    heading.Visible = true
else
    -- Create it if the old heading cannot be found
    heading = Instance.new("TextLabel")
    heading.Name = "AccountInformationHeading"
    heading.Position = UDim2.fromOffset(15, 140)
    heading.Size = UDim2.new(1, -30, 0, 24)
    heading.BackgroundTransparency = 1
    heading.Text = "ACCOUNT INFORMATION"
    heading.TextColor3 = Color3.fromRGB(220, 215, 235)
    heading.TextSize = 12
    heading.Font = Enum.Font.GothamBold
    heading.TextXAlignment = Enum.TextXAlignment.Left
    heading.Parent = scroll
end

-- Ensure scrolling extends beyond the information section
scroll.AutomaticCanvasSize = Enum.AutomaticSize.None
scroll.CanvasSize = UDim2.new(0, 0, 0, 290)

print("Account Information now scrolls with the profile!")

-- i said STOP :RAGE: IM SO MAD BRO 


-- NEXUS: RENAME PLAYERS TAB TO EXPLOITS

local sidebar = main:FindFirstChild("Sidebar")

if sidebar then
    local playersTab = sidebar:FindFirstChild("PlayersTab")

    if playersTab and playersTab:IsA("TextButton") then
        playersTab.Text = "Exploits"
        playersTab.Name = "ExploitsTab"
        print("Players tab renamed to Exploits!")
    else
        warn("PlayersTab not found in Sidebar.")
    end
end

-- Update the explorer page to respond to the new tab name
local explorer = main:FindFirstChild("NexusPlayersExplorer")

if explorer and sidebar then
    local exploitsTab = sidebar:FindFirstChild("ExploitsTab")

    if exploitsTab then
        exploitsTab.Activated:Connect(function()
            explorer.Visible = true
        end)
    end
end

-- okay keep reading i will let you


-- NEXUS: STANDALONE INFINITE JUMP TOGGLE

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Find the existing GUI
local gui = player:WaitForChild("PlayerGui"):FindFirstChild("MyCustomGUI")
local main = gui and gui:FindFirstChild("MainBackground")

if not main then
    warn("NEXUS: MainBackground not found!")
    return
end

-- Remove old copy
local old = main:FindFirstChild("NexusInfiniteJump")
if old then
    old:Destroy()
end

-- Standalone panel
local panel = Instance.new("Frame")
panel.Name = "NexusInfiniteJump"
panel.Size = UDim2.fromOffset(300, 76)
panel.Position = UDim2.new(1, -315, 1, -90)
panel.BackgroundColor3 = Color3.fromRGB(38, 36, 49)
panel.BorderSizePixel = 0
panel.ZIndex = 20
panel.Parent = main

Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(145, 90, 245)
stroke.Transparency = 0.6

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(13, 10)
title.Size = UDim2.new(1, -95, 0, 23)
title.BackgroundTransparency = 1
title.Text = "Infinite Jump"
title.TextColor3 = Color3.fromRGB(245, 240, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 21
title.Parent = panel

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(13, 36)
subtitle.Size = UDim2.new(1, -95, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Repeated jumping while airborne"
subtitle.TextColor3 = Color3.fromRGB(165, 155, 185)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 21
subtitle.Parent = panel

local switch = Instance.new("TextButton")
switch.Size = UDim2.fromOffset(55, 29)
switch.Position = UDim2.new(1, -68, 0.5, -14)
switch.BackgroundColor3 = Color3.fromRGB(65, 62, 76)
switch.Text = ""
switch.AutoButtonColor = false
switch.ZIndex = 21
switch.Parent = panel

Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame")
knob.Size = UDim2.fromOffset(23, 23)
knob.Position = UDim2.fromOffset(3, 3)
knob.BackgroundColor3 = Color3.fromRGB(245, 242, 255)
knob.BorderSizePixel = 0
knob.ZIndex = 22
knob.Parent = switch

Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local enabled = false
local jumpConnection

local function setEnabled(value)
    enabled = value

    TweenService:Create(knob, TweenInfo.new(0.18), {
        Position = enabled
            and UDim2.new(1, -26, 0, 3)
            or UDim2.fromOffset(3, 3)
    }):Play()

    TweenService:Create(switch, TweenInfo.new(0.18), {
        BackgroundColor3 = enabled
            and Color3.fromRGB(145, 85, 245)
            or Color3.fromRGB(65, 62, 76)
    }):Play()

    stroke.Transparency = enabled and 0.15 or 0.6

    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end

    if enabled then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            local character = player.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")

            if humanoid and humanoid.Health > 0 then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

switch.Activated:Connect(function()
    setEnabled(not enabled)
end)

setEnabled(false)

print("NEXUS: Standalone Infinite Jump loaded successfully!")

-- sussy reader


-- NEXUS: MOVE INFINITE JUMP INTO EXPLOITS TAB

local gui = game:GetService("Players").LocalPlayer
    :WaitForChild("PlayerGui"):FindFirstChild("MyCustomGUI")

local main = gui and gui:FindFirstChild("MainBackground")
local floating = main and main:FindFirstChild("NexusInfiniteJump")
local togglePanel = main and main:FindFirstChild("NexusTogglePanel")
local toggleList = togglePanel and togglePanel:FindFirstChild("ToggleList")

if floating and toggleList then
    -- Move the existing toggle into the Exploits list
    floating.Parent = toggleList
    floating.Name = "InfiniteJumpToggle"
    floating.Position = UDim2.new(0, 0, 0, 0)
    floating.Size = UDim2.new(1, -4, 0, 66)
    floating.LayoutOrder = 100
    floating.ZIndex = 1

    for _, obj in ipairs(floating:GetDescendants()) do
        if obj:IsA("GuiObject") then
            obj.ZIndex = 2
        end
    end

    print("Infinite Jump moved into the Exploits toggle list!")
else
    warn("Could not find the floating toggle or Exploits ToggleList.")
    warn("Check that NexusTogglePanel and ToggleList exist.")
end

-- aayyoooooooooooooooo this is so sussyyyyyyyy


-- NEXUS: REBUILD EXPLOITS PAGE + INFINITE JUMP

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui"):FindFirstChild("MyCustomGUI")
local main = gui and gui:FindFirstChild("MainBackground")
local sidebar = main and main:FindFirstChild("Sidebar")

if not main or not sidebar then
    warn("NEXUS: MainBackground or Sidebar not found.")
    return
end

local exploitsTab = sidebar:FindFirstChild("ExploitsTab")
    or sidebar:FindFirstChild("PlayersTab")

if not exploitsTab then
    warn("NEXUS: Couldn't find the Exploits sidebar button.")
    return
end

-- Ensure correct tab name and text
exploitsTab.Name = "ExploitsTab"
exploitsTab.Text = "Exploits"

-- Remove previous versions
for _, name in ipairs({
    "NexusInfiniteJump",
    "NexusTogglePanel",
    "NexusExploitsPage"
}) do
    local old = main:FindFirstChild(name)
    if old then old:Destroy() end
end

-- Create Exploits page
local page = Instance.new("Frame")
page.Name = "NexusExploitsPage"
page.Position = UDim2.fromOffset(145, 42)
page.Size = UDim2.new(1, -160, 1, -54)
page.BackgroundColor3 = Color3.fromRGB(32, 32, 39)
page.BackgroundTransparency = 0.05
page.BorderSizePixel = 0
page.Visible = false
page.Parent = main

Instance.new("UICorner", page).CornerRadius = UDim.new(0, 10)

local pageStroke = Instance.new("UIStroke", page)
pageStroke.Color = Color3.fromRGB(135, 90, 220)
pageStroke.Transparency = 0.45

local heading = Instance.new("TextLabel")
heading.Position = UDim2.fromOffset(14, 12)
heading.Size = UDim2.new(1, -28, 0, 28)
heading.BackgroundTransparency = 1
heading.Text = "EXPLOITS"
heading.TextColor3 = Color3.fromRGB(240, 235, 255)
heading.Font = Enum.Font.GothamBlack
heading.TextSize = 18
heading.TextXAlignment = Enum.TextXAlignment.Left
heading.Parent = page

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(15, 40)
subtitle.Size = UDim2.new(1, -30, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Movement and gameplay options"
subtitle.TextColor3 = Color3.fromRGB(160, 153, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = page

-- Scrollable options list
local list = Instance.new("ScrollingFrame")
list.Name = "ToggleList"
list.Position = UDim2.fromOffset(12, 70)
list.Size = UDim2.new(1, -24, 1, -82)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.ScrollBarImageColor3 = Color3.fromRGB(145, 100, 235)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = page

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 5)
padding.Parent = list

-- Infinite Jump toggle card
local row = Instance.new("Frame")
row.Name = "InfiniteJumpToggle"
row.Size = UDim2.new(1, -4, 0, 66)
row.BackgroundColor3 = Color3.fromRGB(43, 42, 53)
row.BorderSizePixel = 0
row.Parent = list

Instance.new("UICorner", row).CornerRadius = UDim.new(0, 9)

local rowStroke = Instance.new("UIStroke", row)
rowStroke.Color = Color3.fromRGB(145, 90, 245)
rowStroke.Transparency = 0.7

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(12, 9)
title.Size = UDim2.new(1, -95, 0, 21)
title.BackgroundTransparency = 1
title.Text = "Infinite Jump"
title.TextColor3 = Color3.fromRGB(245, 240, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = row

local desc = Instance.new("TextLabel")
desc.Position = UDim2.fromOffset(12, 32)
desc.Size = UDim2.new(1, -95, 0, 19)
desc.BackgroundTransparency = 1
desc.Text = "Jump repeatedly while airborne"
desc.TextColor3 = Color3.fromRGB(165, 155, 185)
desc.Font = Enum.Font.Gotham
desc.TextSize = 10
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.Parent = row

local switch = Instance.new("TextButton")
switch.Name = "Switch"
switch.Size = UDim2.fromOffset(54, 28)
switch.Position = UDim2.new(1, -66, 0.5, -14)
switch.BackgroundColor3 = Color3.fromRGB(62, 60, 72)
switch.Text = ""
switch.AutoButtonColor = false
switch.Parent = row

Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame")
knob.Size = UDim2.fromOffset(22, 22)
knob.Position = UDim2.fromOffset(3, 3)
knob.BackgroundColor3 = Color3.fromRGB(240, 238, 248)
knob.BorderSizePixel = 0
knob.Parent = switch

Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local enabled = false
local jumpConnection

local function setEnabled(value)
    enabled = value

    TweenService:Create(knob, TweenInfo.new(0.18), {
        Position = enabled and UDim2.new(1, -25, 0, 3)
            or UDim2.fromOffset(3, 3)
    }):Play()

    TweenService:Create(switch, TweenInfo.new(0.18), {
        BackgroundColor3 = enabled
            and Color3.fromRGB(145, 85, 245)
            or Color3.fromRGB(62, 60, 72)
    }):Play()

    rowStroke.Transparency = enabled and 0.15 or 0.7

    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end

    if enabled then
        jumpConnection = UIS.JumpRequest:Connect(function()
            local character = player.Character
            local humanoid = character
                and character:FindFirstChildOfClass("Humanoid")

            if humanoid and humanoid.Health > 0 then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

switch.Activated:Connect(function()
    setEnabled(not enabled)
end)

-- Open the new page when Exploits is selected
exploitsTab.Activated:Connect(function()
    page.Visible = true
end)

-- Hide this page when another sidebar tab is selected
for _, tab in ipairs(sidebar:GetChildren()) do
    if tab:IsA("TextButton") and tab ~= exploitsTab then
        tab.Activated:Connect(function()
            page.Visible = false
        end)
    end
end

setEnabled(false)

print("NEXUS: New Exploits page and Infinite Jump loaded.")

-- okay stop reading now were at 2k code lines :rage:


-- NEXUS: FINAL INFINITE JUMP HOLD FIX

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = player:WaitForChild("PlayerGui"):WaitForChild("MyCustomGUI")
local main = gui:WaitForChild("MainBackground")
local page = main:FindFirstChild("NexusExploitsPage")
local list = page and page:FindFirstChild("ToggleList")
local row = list and list:FindFirstChild("InfiniteJumpToggle")

if not row then
    warn("NEXUS: Exploits Infinite Jump toggle not found.")
    return
end

local switch = row:FindFirstChild("Switch")
if not switch then
    warn("NEXUS: Infinite Jump switch not found.")
    return
end

-- Disable the old Infinite Jump handlers by destroying
-- and rebuilding the toggle with one clean input handler.
local newRow = row:Clone()
row:Destroy()
newRow.Parent = list

switch = newRow:WaitForChild("Switch")

local knob = switch:FindFirstChildOfClass("Frame")
local stroke = newRow:FindFirstChildOfClass("UIStroke")

local enabled = false
local held = false
local connections = {}

local function connect(connection)
    table.insert(connections, connection)
end

local function updateSwitch()
    if knob then
        knob.Position = enabled
            and UDim2.new(1, -25, 0, 3)
            or UDim2.fromOffset(3, 3)
    end

    switch.BackgroundColor3 = enabled
        and Color3.fromRGB(145, 85, 245)
        or Color3.fromRGB(62, 60, 72)

    if stroke then
        stroke.Transparency = enabled and 0.15 or 0.7
    end
end

connect(switch.Activated:Connect(function()
    enabled = not enabled
    held = false
    updateSwitch()
end))

connect(UIS.InputBegan:Connect(function(input, processed)
    if not enabled or processed or held then return end

    if input.KeyCode ~= Enum.KeyCode.Space
        and input.KeyCode ~= Enum.KeyCode.ButtonA then
        return
    end

    held = true

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid and humanoid.Health > 0 then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

connect(UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space
        or input.KeyCode == Enum.KeyCode.ButtonA then
        held = false
    end
end))

-- Keep the patch's connections available for cleanup
_G.NexusJumpHoldConnections = connections

updateSwitch()

print("NEXUS: Press-and-release Infinite Jump patch loaded!")

-- hello you little guy :Scream:


-- NEXUS: SAFE NOCLIP ADDITION

task.spawn(function()
    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local player = Players.LocalPlayer

        local gui = player:WaitForChild("PlayerGui")
            :WaitForChild("MyCustomGUI")

        local main = gui:WaitForChild("MainBackground")
        local page = main:WaitForChild("NexusExploitsPage")
        local list = page:WaitForChild("ToggleList")

        local old = list:FindFirstChild("NoclipToggle")
        if old then old:Destroy() end

        local card = Instance.new("Frame")
        card.Name = "NoclipToggle"
        card.Size = UDim2.new(1, -4, 0, 66)
        card.BackgroundColor3 = Color3.fromRGB(43, 42, 53)
        card.BorderSizePixel = 0
        card.LayoutOrder = 2
        card.Parent = list

        Instance.new("UICorner", card).CornerRadius =
            UDim.new(0, 9)

        local title = Instance.new("TextLabel")
        title.Position = UDim2.fromOffset(12, 9)
        title.Size = UDim2.new(1, -85, 0, 22)
        title.BackgroundTransparency = 1
        title.Text = "Noclip"
        title.TextColor3 = Color3.fromRGB(245, 240, 255)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 12
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = card

        local subtitle = Instance.new("TextLabel")
        subtitle.Position = UDim2.fromOffset(12, 33)
        subtitle.Size = UDim2.new(1, -85, 0, 18)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "Pass through solid objects"
        subtitle.TextColor3 = Color3.fromRGB(165, 155, 185)
        subtitle.Font = Enum.Font.Gotham
        subtitle.TextSize = 10
        subtitle.TextXAlignment = Enum.TextXAlignment.Left
        subtitle.Parent = card

        local button = Instance.new("TextButton")
        button.Name = "Switch"
        button.Size = UDim2.fromOffset(54, 28)
        button.Position = UDim2.new(1, -66, 0.5, -14)
        button.BackgroundColor3 = Color3.fromRGB(62, 60, 72)
        button.Text = "OFF"
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 10
        button.Font = Enum.Font.GothamBold
        button.Parent = card

        Instance.new("UICorner", button).CornerRadius =
            UDim.new(1, 0)

        local enabled = false
        local connection
        local saved = {}

        local function restore()
            for part, original in pairs(saved) do
                if part.Parent then
                    part.CanCollide = original
                end
            end
            table.clear(saved)
        end

        local function setEnabled(value)
            enabled = value

            if connection then
                connection:Disconnect()
                connection = nil
            end

            if enabled then
                connection = RunService.Stepped:Connect(function()
                    local character = player.Character
                    if not character then return end

                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            if saved[part] == nil then
                                saved[part] = part.CanCollide
                            end
                            part.CanCollide = false
                        end
                    end
                end)

                button.Text = "ON"
                button.BackgroundColor3 =
                    Color3.fromRGB(45, 175, 125)
            else
                restore()
                button.Text = "OFF"
                button.BackgroundColor3 =
                    Color3.fromRGB(62, 60, 72)
            end
        end

        button.Activated:Connect(function()
            setEnabled(not enabled)
        end)

        player.CharacterAdded:Connect(function()
            restore()
        end)

        gui.Destroying:Connect(function()
            setEnabled(false)
        end)

        print("NEXUS: Safe Noclip addition loaded!")
    end)

    if not success then
        warn("NEXUS Noclip error: " .. tostring(err))
    end
end)

-- uuuuu sussy reader 3000001


-- NEXUS: SPEED + JUMP POWER SLIDERS

task.spawn(function()
    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        local gui = player:WaitForChild("PlayerGui")
            :WaitForChild("MyCustomGUI")

        local main = gui:WaitForChild("MainBackground")
        local page = main:WaitForChild("NexusExploitsPage")
        local list = page:WaitForChild("ToggleList")

        -- Ensure the options list scrolls vertically
        list.ScrollingDirection = Enum.ScrollingDirection.Y
        list.AutomaticCanvasSize = Enum.AutomaticSize.Y
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        list.ScrollBarThickness = 5
        list.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable

        -- Remove previous copies if this addition is run again
        for _, name in ipairs({"SpeedSlider", "JumpPowerSlider"}) do
            local old = list:FindFirstChild(name)
            if old then old:Destroy() end
        end

        local function makeSlider(name, titleText, minValue, maxValue, initialValue, callback)
            local card = Instance.new("Frame")
            card.Name = name
            card.Size = UDim2.new(1, -4, 0, 88)
            card.BackgroundColor3 = Color3.fromRGB(43, 42, 53)
            card.BorderSizePixel = 0
            card.LayoutOrder = 10
            card.Parent = list

            Instance.new("UICorner", card).CornerRadius =
                UDim.new(0, 9)

            local title = Instance.new("TextLabel")
            title.Position = UDim2.fromOffset(12, 8)
            title.Size = UDim2.new(1, -70, 0, 20)
            title.BackgroundTransparency = 1
            title.Text = titleText
            title.TextColor3 = Color3.fromRGB(245, 240, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 12
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = card

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Position = UDim2.new(1, -58, 0, 8)
            valueLabel.Size = UDim2.fromOffset(46, 20)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = Color3.fromRGB(170, 125, 255)
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 12
            valueLabel.Text = tostring(initialValue)
            valueLabel.Parent = card

            local track = Instance.new("Frame")
            track.Position = UDim2.new(0, 12, 0, 43)
            track.Size = UDim2.new(1, -24, 0, 8)
            track.BackgroundColor3 = Color3.fromRGB(67, 64, 79)
            track.BorderSizePixel = 0
            track.Parent = card

            Instance.new("UICorner", track).CornerRadius =
                UDim.new(1, 0)

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(
                (initialValue - minValue) / (maxValue - minValue),
                0, 1, 0
            )
            fill.BackgroundColor3 = Color3.fromRGB(145, 85, 245)
            fill.BorderSizePixel = 0
            fill.Parent = track

            Instance.new("UICorner", fill).CornerRadius =
                UDim.new(1, 0)

            local knob = Instance.new("Frame")
            knob.AnchorPoint = Vector2.new(0.5, 0.5)
            knob.Position = UDim2.new(
                (initialValue - minValue) / (maxValue - minValue),
                0, 0.5, 0
            )
            knob.Size = UDim2.fromOffset(16, 16)
            knob.BackgroundColor3 = Color3.fromRGB(250, 247, 255)
            knob.BorderSizePixel = 0
            knob.Parent = track

            Instance.new("UICorner", knob).CornerRadius =
                UDim.new(1, 0)

            local hitbox = Instance.new("TextButton")
            hitbox.Name = "SliderInput"
            hitbox.Position = UDim2.new(0, 0, 0, -12)
            hitbox.Size = UDim2.new(1, 0, 1, 24)
            hitbox.BackgroundTransparency = 1
            hitbox.Text = ""
            hitbox.Parent = track
            hitbox.ZIndex = 5

            local UIS = game:GetService("UserInputService")
            local dragging = false
            local connections = {}

            local function setFromX(x)
                local width = track.AbsoluteSize.X
                if width <= 0 then return end

                local alpha = math.clamp(
                    (x - track.AbsolutePosition.X) / width,
                    0, 1
                )

                local value = math.floor(
                    minValue + alpha * (maxValue - minValue) + 0.5
                )

                alpha = (value - minValue) / (maxValue - minValue)
                fill.Size = UDim2.new(alpha, 0, 1, 0)
                knob.Position = UDim2.new(alpha, 0, 0.5, 0)
                valueLabel.Text = tostring(value)
                callback(value)
            end

            hitbox.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    setFromX(input.Position.X)
                end
            end)

            UIS.InputChanged:Connect(function(input)
                if dragging and (
                    input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch
                ) then
                    setFromX(input.Position.X)
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            callback(initialValue)
        end

        local function getHumanoid()
            local character = player.Character
            return character and character:FindFirstChildOfClass("Humanoid")
        end

        local speedValue = 16
        local jumpValue = 50

        makeSlider(
            "SpeedSlider",
            "Walk Speed",
            16, 100, 16,
            function(value)
                speedValue = value
                local humanoid = getHumanoid()
                if humanoid then
                    humanoid.WalkSpeed = value
                end
            end
        )

        makeSlider(
            "JumpPowerSlider",
            "Jump Power",
            50, 150, 50,
            function(value)
                jumpValue = value
                local humanoid = getHumanoid()
                if humanoid then
                    humanoid.UseJumpPower = true
                    humanoid.JumpPower = value
                end
            end
        )

        -- Reapply chosen settings after respawn
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid", 10)
            if humanoid then
                humanoid.WalkSpeed = speedValue
                humanoid.UseJumpPower = true
                humanoid.JumpPower = jumpValue
            end
        end)

        print("NEXUS: Speed and Jump Power sliders loaded!")
    end)

    if not success then
        warn("NEXUS slider error: " .. tostring(err))
    end
end)

-- uiiii whatscha doing on line 2484


-- NEXUS: THEME EDITOR

task.spawn(function()
    local ok, err = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local gui = player:WaitForChild("PlayerGui"):WaitForChild("MyCustomGUI")
        local main = gui:WaitForChild("MainBackground")
        local sidebar = main:WaitForChild("Sidebar")

        local themeTab = sidebar:FindFirstChild("ThemeTab")
        if not themeTab then
            for _, v in ipairs(sidebar:GetChildren()) do
                if v:IsA("TextButton") and v.Text == "Theme" then
                    themeTab = v
                    break
                end
            end
        end
        assert(themeTab, "Theme tab not found")

        local old = main:FindFirstChild("NexusThemePage")
        if old then old:Destroy() end

        local presets = {
            ["Void Purple"] = Color3.fromRGB(168,117,255),
            ["Cyber Cyan"] = Color3.fromRGB(66,221,245),
            ["Neon Rose"] = Color3.fromRGB(255,92,138),
            ["Matrix"] = Color3.fromRGB(85,230,154)
        }

        local selected = "Void Purple"
        local glow = true
        local transparency = 0.4

        local page = Instance.new("Frame")
        page.Name = "NexusThemePage"
        page.Position = UDim2.fromOffset(145,42)
        page.Size = UDim2.new(1,-160,1,-54)
        page.BackgroundColor3 = Color3.fromRGB(32,30,42)
        page.BorderSizePixel = 0
        page.Visible = false
        page.ClipsDescendants = true
        page.Parent = main
        Instance.new("UICorner",page).CornerRadius = UDim.new(0,10)

        local outline = Instance.new("UIStroke",page)
        outline.Thickness = 1.5

        local heading = Instance.new("TextLabel")
        heading.Size = UDim2.new(1,-24,0,30)
        heading.Position = UDim2.fromOffset(12,10)
        heading.BackgroundTransparency = 1
        heading.Text = "THEME STUDIO"
        heading.TextColor3 = Color3.new(1,1,1)
        heading.Font = Enum.Font.GothamBlack
        heading.TextSize = 19
        heading.TextXAlignment = Enum.TextXAlignment.Left
        heading.Parent = page

        local scroll = Instance.new("ScrollingFrame")
        scroll.Name = "ThemeOptions"
        scroll.Position = UDim2.fromOffset(10,48)
        scroll.Size = UDim2.new(1,-20,1,-58)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 4
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.CanvasSize = UDim2.new(0,0,0,0)
        scroll.Parent = page

        local layout = Instance.new("UIListLayout",scroll)
        layout.Padding = UDim.new(0,8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local function card(name,height)
            local f = Instance.new("Frame")
            f.Name = name
            f.Size = UDim2.new(1,-6,0,height)
            f.BackgroundColor3 = Color3.fromRGB(48,44,61)
            f.BorderSizePixel = 0
            f.Parent = scroll
            Instance.new("UICorner",f).CornerRadius = UDim.new(0,8)
            return f
        end

        local function label(parent,text,pos,size)
            local l = Instance.new("TextLabel")
            l.Position = pos
            l.Size = size
            l.BackgroundTransparency = 1
            l.Text = text
            l.TextColor3 = Color3.fromRGB(245,240,255)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 12
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = parent
            return l
        end

        local presetCard = card("Presets",120)
        label(presetCard,"COLOR PRESETS",UDim2.fromOffset(10,6),UDim2.new(1,-20,0,20))

        local function applyTheme()
            local accent = presets[selected]
            outline.Color = accent
            outline.Transparency = glow and 0.1 or 0.85
            heading.TextColor3 = accent
            main.BackgroundTransparency = transparency

            for _,v in ipairs(scroll:GetChildren()) do
                if v:IsA("Frame") and v.Name ~= "Presets" then
                    local s = v:FindFirstChildOfClass("UIStroke")
                    if s then
                        s.Color = accent
                        s.Transparency = glow and 0.3 or 0.85
                    end
                end
            end
        end

        local names = {"Void Purple","Cyber Cyan","Neon Rose","Matrix"}
        for i,name in ipairs(names) do
            local b = Instance.new("TextButton")
            b.Name = name:gsub("%s","").."Button"
            b.Size = UDim2.new(0.5,-16,0,30)
            b.Position = UDim2.new((i-1)%2*0.5,10,0,30+math.floor((i-1)/2)*36)
            b.BackgroundColor3 = presets[name]
            b.BorderSizePixel = 0
            b.Text = name
            b.TextColor3 = Color3.fromRGB(25,25,30)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 10
            b.Parent = presetCard
            Instance.new("UICorner",b).CornerRadius = UDim.new(0,6)
            b.Activated:Connect(function()
                selected = name
                applyTheme()
            end)
        end

        local transCard = card("Transparency",76)
        label(transCard,"BACKGROUND TRANSPARENCY",UDim2.fromOffset(10,5),UDim2.new(1,-20,0,20))

        local valueLabel = label(transCard,"40%",UDim2.new(1,-50,0,5),UDim2.fromOffset(40,20))
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local track = Instance.new("Frame")
        track.Position = UDim2.new(0,10,0,42)
        track.Size = UDim2.new(1,-20,0,8)
        track.BackgroundColor3 = Color3.fromRGB(75,70,85)
        track.BorderSizePixel = 0
        track.Parent = transCard
        Instance.new("UICorner",track).CornerRadius = UDim.new(1,0)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0.4,0,1,0)
        fill.BackgroundColor3 = presets[selected]
        fill.BorderSizePixel = 0
        fill.Parent = track
        Instance.new("UICorner",fill).CornerRadius = UDim.new(1,0)

        local knob = Instance.new("TextButton")
        knob.Size = UDim2.fromOffset(18,18)
        knob.AnchorPoint = Vector2.new(0.5,0.5)
        knob.Position = UDim2.new(0.4,0,0.5,0)
        knob.Text = ""
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.Parent = track
        knob.ZIndex = 3
        Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

        local UIS = game:GetService("UserInputService")
        local dragging = false

        local function updateSlider(x)
            local width = track.AbsoluteSize.X
            if width <= 0 then return end
            local a = math.clamp((x-track.AbsolutePosition.X)/width,0,1)
            transparency = math.floor(a*90+0.5)/100
            fill.Size = UDim2.new(transparency/0.9,0,1,0)
            knob.Position = UDim2.new(transparency/0.9,0,0.5,0)
            valueLabel.Text = tostring(math.floor(transparency*100)).."%"
            main.BackgroundTransparency = transparency
        end

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                updateSlider(input.Position.X)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(input.Position.X)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        local glowCard = card("Glow",60)
        label(glowCard,"NEON GLOW",UDim2.fromOffset(10,5),UDim2.new(1,-90,0,22))

        local glowButton = Instance.new("TextButton")
        glowButton.Size = UDim2.fromOffset(60,28)
        glowButton.Position = UDim2.new(1,-72,0.5,-14)
        glowButton.BackgroundColor3 = Color3.fromRGB(45,175,115)
        glowButton.Text = "ON"
        glowButton.TextColor3 = Color3.new(1,1,1)
        glowButton.Font = Enum.Font.GothamBold
        glowButton.TextSize = 11
        glowButton.Parent = glowCard
        Instance.new("UICorner",glowButton).CornerRadius = UDim.new(1,0)

        glowButton.Activated:Connect(function()
            glow = not glow
            glowButton.Text = glow and "ON" or "OFF"
            glowButton.BackgroundColor3 = glow
                and Color3.fromRGB(45,175,115)
                or Color3.fromRGB(75,72,82)
            applyTheme()
        end)

        local resetCard = card("Reset",48)
        local reset = Instance.new("TextButton")
        reset.Size = UDim2.new(1,-16,1,-12)
        reset.Position = UDim2.fromOffset(8,6)
        reset.BackgroundColor3 = Color3.fromRGB(75,65,95)
        reset.Text = "RESET THEME"
        reset.TextColor3 = Color3.new(1,1,1)
        reset.Font = Enum.Font.GothamBold
        reset.TextSize = 11
        reset.Parent = resetCard
        Instance.new("UICorner",reset).CornerRadius = UDim.new(0,6)

        reset.Activated:Connect(function()
            selected = "Void Purple"
            glow = true
            transparency = 0.4
            valueLabel.Text = "40%"
            fill.Size = UDim2.new(0.4,0,1,0)
            knob.Position = UDim2.new(0.4,0,0.5,0)
            glowButton.Text = "ON"
            glowButton.BackgroundColor3 = Color3.fromRGB(45,175,115)
            applyTheme()
        end)

        themeTab.Activated:Connect(function()
            page.Visible = true
        end)

        for _,tab in ipairs(sidebar:GetChildren()) do
            if tab:IsA("TextButton") and tab ~= themeTab then
                tab.Activated:Connect(function()
                    page.Visible = false
                end)
            end
        end

        applyTheme()
        print("NEXUS Theme Editor loaded!")
    end)

    if not ok then
        warn("NEXUS Theme Editor error: "..tostring(err))
    end
end)

-- hey my little femboy boyboy


-- NEXUS THEME STUDIO - PART 1 OF 2

task.spawn(function()
    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local UIS = game:GetService("UserInputService")
        local player = Players.LocalPlayer
        local gui = player:WaitForChild("PlayerGui"):WaitForChild("MyCustomGUI")
        local main = gui:WaitForChild("MainBackground")
        local sidebar = main:WaitForChild("Sidebar")

        local themeTab = sidebar:FindFirstChild("ThemeTab")
        if not themeTab then
            for _, obj in ipairs(sidebar:GetChildren()) do
                if obj:IsA("TextButton") and obj.Text == "Theme" then
                    themeTab = obj
                    break
                end
            end
        end
        assert(themeTab, "Theme tab not found")

        local old = main:FindFirstChild("NexusThemePage")
        if old then old:Destroy() end

        local themes = {
            ["Void Purple"] = {
                accent = Color3.fromRGB(174,105,255),
                bg = Color3.fromRGB(25,20,36),
                sidebar = Color3.fromRGB(30,24,43),
                panel = Color3.fromRGB(39,31,54),
                card = Color3.fromRGB(51,41,69),
                text = Color3.fromRGB(245,239,255)
            },
            ["Cyber Cyan"] = {
                accent = Color3.fromRGB(55,225,245),
                bg = Color3.fromRGB(17,29,36),
                sidebar = Color3.fromRGB(20,36,44),
                panel = Color3.fromRGB(25,43,52),
                card = Color3.fromRGB(34,58,68),
                text = Color3.fromRGB(230,250,255)
            },
            ["Neon Rose"] = {
                accent = Color3.fromRGB(255,90,155),
                bg = Color3.fromRGB(37,20,31),
                sidebar = Color3.fromRGB(44,23,37),
                panel = Color3.fromRGB(54,29,44),
                card = Color3.fromRGB(69,37,55),
                text = Color3.fromRGB(255,239,247)
            },
            ["Matrix"] = {
                accent = Color3.fromRGB(75,245,145),
                bg = Color3.fromRGB(15,27,21),
                sidebar = Color3.fromRGB(18,35,25),
                panel = Color3.fromRGB(23,43,30),
                card = Color3.fromRGB(31,56,39),
                text = Color3.fromRGB(232,255,239)
            }
        }

        local selected = "Void Purple"
        local transparency = 0.4
        local glow = true

        local page = Instance.new("Frame")
        page.Name = "NexusThemePage"
        page.Position = UDim2.fromOffset(145,42)
        page.Size = UDim2.new(1,-160,1,-54)
        page.BackgroundColor3 = themes[selected].bg
        page.BorderSizePixel = 0
        page.Visible = false
        page.ClipsDescendants = true
        page.Parent = main
        Instance.new("UICorner",page).CornerRadius = UDim.new(0,10)

        local pageStroke = Instance.new("UIStroke",page)
        pageStroke.Thickness = 1.5

        local header = Instance.new("TextLabel")
        header.Name = "ThemeHeader"
        header.Position = UDim2.fromOffset(14,8)
        header.Size = UDim2.new(1,-28,0,32)
        header.BackgroundTransparency = 1
        header.Text = "NEXUS / THEME STUDIO"
        header.Font = Enum.Font.GothamBlack
        header.TextSize = 17
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.Parent = page

        local subtitle = Instance.new("TextLabel")
        subtitle.Position = UDim2.fromOffset(15,37)
        subtitle.Size = UDim2.new(1,-30,0,20)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "Customize your entire interface"
        subtitle.TextColor3 = Color3.fromRGB(175,170,190)
        subtitle.Font = Enum.Font.Gotham
        subtitle.TextSize = 11
        subtitle.TextXAlignment = Enum.TextXAlignment.Left
        subtitle.Parent = page

        local scroll = Instance.new("ScrollingFrame")
        scroll.Name = "ThemeOptions"
        scroll.Position = UDim2.fromOffset(10,62)
        scroll.Size = UDim2.new(1,-20,1,-70)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 5
        scroll.ScrollingDirection = Enum.ScrollingDirection.Y
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.CanvasSize = UDim2.new(0,0,0,0)
        scroll.Active = true
        scroll.Parent = page

        local layout = Instance.new("UIListLayout",scroll)
        layout.Padding = UDim.new(0,9)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local padding = Instance.new("UIPadding",scroll)
        padding.PaddingTop = UDim.new(0,3)
        padding.PaddingBottom = UDim.new(0,12)
        padding.PaddingLeft = UDim.new(0,2)
        padding.PaddingRight = UDim.new(0,5)

        local function makeCard(name,height,order)
            local f = Instance.new("Frame")
            f.Name = name
            f.Size = UDim2.new(1,-4,0,height)
            f.BackgroundColor3 = themes[selected].card
            f.BorderSizePixel = 0
            f.LayoutOrder = order
            f.Parent = scroll
            Instance.new("UICorner",f).CornerRadius = UDim.new(0,9)

            local s = Instance.new("UIStroke",f)
            s.Name = "ThemeOutline"
            s.Thickness = 1
            s.Transparency = 0.65
            return f
        end

        local function makeLabel(parent,name,text,pos,size)
            local l = Instance.new("TextLabel")
            l.Name = name
            l.Position = pos
            l.Size = size
            l.BackgroundTransparency = 1
            l.Text = text
            l.TextColor3 = themes[selected].text
            l.Font = Enum.Font.GothamBold
            l.TextSize = 12
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = parent
            return l
        end

        -- Preset buttons
        local presetCard = makeCard("PresetCard",125,1)
        makeLabel(presetCard,"PresetTitle","COLOR PRESETS",
            UDim2.fromOffset(10,5),UDim2.new(1,-20,0,22))

        local presetButtons = {}
        local themeNames = {
            "Void Purple","Cyber Cyan","Neon Rose","Matrix"
        }

        for i,name in ipairs(themeNames) do
            local b = Instance.new("TextButton")
            b.Name = "Preset"..i
            b:SetAttribute("ThemeName",name)
            b.Size = UDim2.new(0.5,-16,0,31)
            b.Position = UDim2.new(
                ((i-1)%2)*0.5,10,
                0,31+math.floor((i-1)/2)*37
            )
            b.BackgroundColor3 = themes[name].accent
            b.BorderSizePixel = 0
            b.Text = name
            b.TextColor3 = Color3.fromRGB(25,25,32)
            b.TextSize = 10
            b.Font = Enum.Font.GothamBold
            b.Parent = presetCard
            Instance.new("UICorner",b).CornerRadius = UDim.new(0,6)
            table.insert(presetButtons,b)
        end

        -- Transparency slider card
        local transCard = makeCard("TransparencyCard",88,2)
        makeLabel(transCard,"TransparencyTitle",
            "BACKGROUND TRANSPARENCY",
            UDim2.fromOffset(10,5),UDim2.new(1,-70,0,22))

        local valueLabel = makeLabel(transCard,"TransparencyValue",
            "40%",UDim2.new(1,-52,0,5),UDim2.fromOffset(40,22))
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right

        local track = Instance.new("TextButton")
        track.Name = "TransparencyTrack"
        track.Position = UDim2.new(0,12,0,43)
        track.Size = UDim2.new(1,-24,0,12)
        track.BackgroundColor3 = Color3.fromRGB(75,70,87)
        track.BorderSizePixel = 0
        track.Text = ""
        track.AutoButtonColor = false
        track.Active = true
        track.Parent = transCard
        Instance.new("UICorner",track).CornerRadius = UDim.new(1,0)

        local fill = Instance.new("Frame")
        fill.Name = "SliderFill"
        fill.Size = UDim2.new(0.4/0.9,0,1,0)
        fill.BackgroundColor3 = themes[selected].accent
        fill.BorderSizePixel = 0
        fill.Parent = track
        Instance.new("UICorner",fill).CornerRadius = UDim.new(1,0)

        local knob = Instance.new("Frame")
        knob.Name = "SliderKnob"
        knob.AnchorPoint = Vector2.new(0.5,0.5)
        knob.Size = UDim2.fromOffset(18,18)
        knob.Position = UDim2.new(0.4/0.9,0,0.5,0)
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.BorderSizePixel = 0
        knob.Parent = track
        knob.ZIndex = 3
        Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)

        -- Part 2 continues from here.


        -- NEXUS THEME STUDIO - PART 2 OF 2

        local function applyTheme()
            local theme = themes[selected]

            -- Recolor the existing GUI without recreating it.
            main.BackgroundColor3 = theme.bg
            main.BackgroundTransparency = transparency

            for _,obj in ipairs(main:GetDescendants()) do
                if obj:IsA("Frame") then
                    if obj ~= page and obj ~= scroll
                        and not obj:IsDescendantOf(page) then

                        if obj.Name == "Sidebar" then
                            obj.BackgroundColor3 = theme.sidebar
                        elseif obj.Name == "NexusExploitsPage"
                            or obj.Name == "NexusHomeProfile" then
                            obj.BackgroundColor3 = theme.bg
                            obj.BackgroundTransparency = transparency
                        elseif obj.Name == "InfiniteJumpToggle"
                            or obj.Name == "NexusTogglePanel" then
                            obj.BackgroundColor3 = theme.panel
                        elseif obj.Name ~= "SliderFill"
                            and obj.Name ~= "SliderKnob" then
                            obj.BackgroundColor3 = theme.card
                        end
                    end
                elseif obj:IsA("TextButton") then
                    if obj.Name == "ThemeTab"
                        or obj.Text == "Home"
                        or obj.Text == "Exploits"
                        or obj.Text == "Keybinds"
                        or obj.Text == "Macro" then
                        obj.BackgroundColor3 = theme.panel
                    end
                elseif obj:IsA("TextLabel") then
                    if obj.Name ~= "TransparencyValue" then
                        obj.TextColor3 = theme.text
                    end
                elseif obj:IsA("UIStroke") then
                    obj.Color = theme.accent
                    obj.Transparency = glow and 0.2 or 0.75
                end
            end

            -- Style the Theme Studio itself.
            page.BackgroundColor3 = theme.bg
            page.BackgroundTransparency = transparency
            pageStroke.Color = theme.accent
            pageStroke.Transparency = glow and 0.05 or 0.7

            header.TextColor3 = theme.text
            subtitle.TextColor3 = Color3.fromRGB(175,170,190)

            for _,card in ipairs({presetCard,transCard}) do
                card.BackgroundColor3 = theme.card
                local stroke = card:FindFirstChild("ThemeOutline")
                if stroke then
                    stroke.Color = theme.accent
                    stroke.Transparency = glow and 0.15 or 0.7
                end
            end

            fill.BackgroundColor3 = theme.accent

            for _,button in ipairs(presetButtons) do
                local name = button:GetAttribute("ThemeName")
                button.BackgroundColor3 = themes[name].accent
                button.TextColor3 = Color3.fromRGB(25,25,32)
                button.Text = name .. (name == selected and "  ✓" or "")
            end
        end

        -- Select a preset.
        for _,button in ipairs(presetButtons) do
            button.Activated:Connect(function()
                selected = button:GetAttribute("ThemeName")
                applyTheme()
            end)
        end

        -- Update transparency from 0% to 90%.
        local dragging = false

        local function updateTransparency(inputX)
            local width = track.AbsoluteSize.X
            if width <= 0 then return end

            local relative = math.clamp(
                (inputX - track.AbsolutePosition.X) / width,
                0, 1
            )

            transparency = math.floor(relative * 90 + 0.5) / 100
            fill.Size = UDim2.new(transparency / 0.9,0,1,0)
            knob.Position = UDim2.new(transparency / 0.9,0,0.5,0)
            valueLabel.Text = tostring(math.floor(transparency * 100 + 0.5)) .. "%"

            main.BackgroundTransparency = transparency
            page.BackgroundTransparency = transparency

            -- Apply the chosen transparency to the main content panels.
            for _,name in ipairs({
                "NexusHomeProfile",
                "NexusExploitsPage"
            }) do
                local panel = main:FindFirstChild(name)
                if panel then
                    panel.BackgroundTransparency = transparency
                end
            end
        end

        track.Activated:Connect(function()
            updateTransparency(UIS:GetMouseLocation().X)
        end)

        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                updateTransparency(input.Position.X)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then
                updateTransparency(input.Position.X)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        -- Neon glow toggle.
        local glowCard = makeCard("GlowCard",65,3)
        makeLabel(glowCard,"GlowTitle","NEON GLOW",
            UDim2.fromOffset(10,8),UDim2.new(1,-100,0,22))

        local glowDescription = Instance.new("TextLabel")
        glowDescription.Position = UDim2.fromOffset(10,31)
        glowDescription.Size = UDim2.new(1,-100,0,20)
        glowDescription.BackgroundTransparency = 1
        glowDescription.Text = "Toggle accent outlines"
        glowDescription.TextColor3 = Color3.fromRGB(175,170,190)
        glowDescription.Font = Enum.Font.Gotham
        glowDescription.TextSize = 10
        glowDescription.TextXAlignment = Enum.TextXAlignment.Left
        glowDescription.Parent = glowCard

        local glowButton = Instance.new("TextButton")
        glowButton.Name = "GlowToggle"
        glowButton.Size = UDim2.fromOffset(65,28)
        glowButton.Position = UDim2.new(1,-77,0.5,-14)
        glowButton.BorderSizePixel = 0
        glowButton.Font = Enum.Font.GothamBold
        glowButton.TextSize = 11
        glowButton.Parent = glowCard
        Instance.new("UICorner",glowButton).CornerRadius = UDim.new(0,7)

        local function updateGlow()
            glowButton.Text = glow and "ON" or "OFF"
            glowButton.BackgroundColor3 = glow
                and themes[selected].accent
                or Color3.fromRGB(70,65,80)
            glowButton.TextColor3 = glow
                and Color3.fromRGB(25,25,32)
                or Color3.new(1,1,1)
        end

        glowButton.Activated:Connect(function()
            glow = not glow
            updateGlow()
            applyTheme()
        end)

        -- Reset settings.
        local resetCard = makeCard("ResetCard",58,4)
        local resetButton = Instance.new("TextButton")
        resetButton.Name = "ResetTheme"
        resetButton.Position = UDim2.fromOffset(8,7)
        resetButton.Size = UDim2.new(1,-16,1,-14)
        resetButton.BackgroundColor3 = Color3.fromRGB(65,55,80)
        resetButton.BorderSizePixel = 0
        resetButton.Text = "RESET TO VOID PURPLE"
        resetButton.TextColor3 = Color3.new(1,1,1)
        resetButton.Font = Enum.Font.GothamBold
        resetButton.TextSize = 11
        resetButton.Parent = resetCard
        Instance.new("UICorner",resetButton).CornerRadius = UDim.new(0,7)

        resetButton.Activated:Connect(function()
            selected = "Void Purple"
            transparency = 0.4
            glow = true

            fill.Size = UDim2.new(0.4/0.9,0,1,0)
            knob.Position = UDim2.new(0.4/0.9,0,0.5,0)
            valueLabel.Text = "40%"

            updateGlow()
            applyTheme()
        end)

        -- Show only the selected page.
        local function showThemePage()
            page.Visible = true

            local home = main:FindFirstChild("NexusHomeProfile")
            local exploits = main:FindFirstChild("NexusExploitsPage")
            local keybinds = main:FindFirstChild("NexusKeybindManager")

            if home then home.Visible = false end
            if exploits then exploits.Visible = false end
            if keybinds then keybinds.Visible = false end
        end

        themeTab.Activated:Connect(showThemePage)

        local function connectOtherTabs()
            for _,tab in ipairs(sidebar:GetChildren()) do
                if tab:IsA("TextButton") and tab ~= themeTab then
                    tab.Activated:Connect(function()
                        page.Visible = false
                    end)
                end
            end
        end

        connectOtherTabs()

        -- Initial appearance.
        updateGlow()
        applyTheme()

        print("NEXUS Theme Studio loaded successfully!")
    end)

    if not success then
        warn("NEXUS Theme Studio error: " .. tostring(err))
    end
end)

-- more now okay ?


-- NEXUS: FIX WALKSPEED + JUMP POWER SLIDER VISIBILITY

task.spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui"):WaitForChild("MyCustomGUI")
    local main = gui:WaitForChild("MainBackground")

    local accent = Color3.fromRGB(180, 110, 255)
    local trackColor = Color3.fromRGB(28, 25, 38)
    local knobColor = Color3.fromRGB(250, 245, 255)

    local fixed = 0

    for _, obj in ipairs(main:GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("TextButton") then
            local name = obj.Name:lower()
            local isSpeed = name:find("speed") ~= nil
                and name:find("walk") ~= nil
            local isJump = name:find("jump") ~= nil
                and name:find("power") ~= nil

            if isSpeed or isJump then
                -- Search inside the slider container for its track.
                for _, child in ipairs(obj:GetDescendants()) do
                    if child:IsA("Frame") or child:IsA("TextButton") then
                        local childName = child.Name:lower()

                        if childName:find("track")
                            or childName:find("sliderbar")
                            or childName == "bar" then
                            child.BackgroundColor3 = trackColor
                            child.BackgroundTransparency = 0
                            child.BorderSizePixel = 0

                            for _, part in ipairs(child:GetDescendants()) do
                                if part:IsA("Frame") then
                                    local partName = part.Name:lower()

                                    if partName:find("fill")
                                        or partName:find("progress") then
                                        part.BackgroundColor3 = accent
                                        part.BackgroundTransparency = 0
                                    elseif partName:find("knob")
                                        or partName:find("thumb")
                                        or partName:find("handle") then
                                        part.BackgroundColor3 = knobColor
                                        part.BackgroundTransparency = 0
                                    end
                                end
                            end

                            fixed += 1
                        end
                    end
                end
            end
        end
    end

    print("NEXUS: Slider visibility pass finished. Tracks updated:", fixed)

    if fixed == 0 then
        warn("NEXUS: Couldn't identify the slider tracks by name. Their actual instance names are needed for a precise fix.")
    end
end)

-- oooo dont be so susssyyy


-- NEXUS MACRO STUDIO - PART 1 OF 2

task.spawn(function()
    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local UIS = game:GetService("UserInputService")

        local player = Players.LocalPlayer
        local gui = player:WaitForChild("PlayerGui"):WaitForChild("MyCustomGUI")
        local main = gui:WaitForChild("MainBackground")
        local sidebar = main:WaitForChild("Sidebar")

        local macroTab = sidebar:FindFirstChild("MacroTab")
        if not macroTab then
            for _, obj in ipairs(sidebar:GetChildren()) do
                if obj:IsA("TextButton") and obj.Text == "Macro" then
                    macroTab = obj
                    break
                end
            end
        end

        assert(macroTab, "Macro tab not found")

        local old = main:FindFirstChild("NexusMacroPage")
        if old then old:Destroy() end

        local recordedMacros = {}
        local selectedMacro = nil
        local recording = false
        local playing = false
        local currentRecording = {}
        local connections = {}

        local page = Instance.new("Frame")
        page.Name = "NexusMacroPage"
        page.Position = UDim2.fromOffset(145, 42)
        page.Size = UDim2.new(1, -160, 1, -54)
        page.BackgroundColor3 = Color3.fromRGB(25, 20, 36)
        page.BackgroundTransparency = 0.1
        page.BorderSizePixel = 0
        page.Visible = false
        page.ClipsDescendants = true
        page.Parent = main

        Instance.new("UICorner", page).CornerRadius = UDim.new(0, 10)

        local outline = Instance.new("UIStroke", page)
        outline.Color = Color3.fromRGB(174, 105, 255)
        outline.Transparency = 0.25

        local header = Instance.new("TextLabel")
        header.Name = "MacroHeader"
        header.Position = UDim2.fromOffset(14, 8)
        header.Size = UDim2.new(1, -28, 0, 30)
        header.BackgroundTransparency = 1
        header.Text = "NEXUS / MACRO STUDIO"
        header.TextColor3 = Color3.fromRGB(245, 239, 255)
        header.Font = Enum.Font.GothamBlack
        header.TextSize = 17
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.Parent = page

        local subtitle = Instance.new("TextLabel")
        subtitle.Position = UDim2.fromOffset(15, 37)
        subtitle.Size = UDim2.new(1, -30, 0, 20)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "Record and manage in-game action sequences"
        subtitle.TextColor3 = Color3.fromRGB(175, 165, 195)
        subtitle.Font = Enum.Font.Gotham
        subtitle.TextSize = 11
        subtitle.TextXAlignment = Enum.TextXAlignment.Left
        subtitle.Parent = page

        local scroll = Instance.new("ScrollingFrame")
        scroll.Name = "MacroOptions"
        scroll.Position = UDim2.fromOffset(10, 62)
        scroll.Size = UDim2.new(1, -20, 1, -70)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 5
        scroll.ScrollBarImageColor3 = Color3.fromRGB(174, 105, 255)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.ScrollingDirection = Enum.ScrollingDirection.Y
        scroll.Active = true
        scroll.Parent = page

        local layout = Instance.new("UIListLayout", scroll)
        layout.Padding = UDim.new(0, 9)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local padding = Instance.new("UIPadding", scroll)
        padding.PaddingTop = UDim.new(0, 3)
        padding.PaddingBottom = UDim.new(0, 12)
        padding.PaddingLeft = UDim.new(0, 2)
        padding.PaddingRight = UDim.new(0, 5)

        local function makeCard(name, height, order)
            local card = Instance.new("Frame")
            card.Name = name
            card.Size = UDim2.new(1, -4, 0, height)
            card.BackgroundColor3 = Color3.fromRGB(45, 35, 60)
            card.BorderSizePixel = 0
            card.LayoutOrder = order
            card.Parent = scroll
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 9)

            local stroke = Instance.new("UIStroke", card)
            stroke.Color = Color3.fromRGB(174, 105, 255)
            stroke.Transparency = 0.7

            return card
        end

        local function makeLabel(parent, text, position, size)
            local label = Instance.new("TextLabel")
            label.Position = position
            label.Size = size
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(245, 239, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = parent
            return label
        end

        local function makeButton(parent, name, text, position, size, color)
            local button = Instance.new("TextButton")
            button.Name = name
            button.Position = position
            button.Size = size
            button.BackgroundColor3 = color
            button.BorderSizePixel = 0
            button.Text = text
            button.TextColor3 = Color3.new(1, 1, 1)
            button.Font = Enum.Font.GothamBold
            button.TextSize = 11
            button.AutoButtonColor = true
            button.Parent = parent
            Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
            return button
        end

        -- Recorder controls
        local recordCard = makeCard("RecorderCard", 112, 1)
        makeLabel(recordCard, "MACRO RECORDER",
            UDim2.fromOffset(10, 5), UDim2.new(1, -20, 0, 22))

        local status = makeLabel(recordCard, "● READY",
            UDim2.fromOffset(10, 29), UDim2.new(1, -20, 0, 20))
        status.Name = "RecordingStatus"
        status.TextColor3 = Color3.fromRGB(100, 225, 145)
        status.Font = Enum.Font.GothamMedium

        local recordButton = makeButton(recordCard, "RecordButton", "● RECORD",
            UDim2.new(0, 10, 0, 59), UDim2.new(0.34, -10, 0, 34),
            Color3.fromRGB(175, 55, 75))

        local stopButton = makeButton(recordCard, "StopButton", "■ STOP",
            UDim2.new(0.34, 5, 0, 59), UDim2.new(0.33, -8, 0, 34),
            Color3.fromRGB(80, 70, 100))

        local saveButton = makeButton(recordCard, "SaveButton", "SAVE",
            UDim2.new(0.67, 3, 0, 59), UDim2.new(0.33, -13, 0, 34),
            Color3.fromRGB(105, 65, 165))

        -- Macro name
        local nameCard = makeCard("MacroNameCard", 65, 2)
        makeLabel(nameCard, "MACRO NAME",
            UDim2.fromOffset(10, 5), UDim2.new(1, -20, 0, 18))

        local nameBox = Instance.new("TextBox")
        nameBox.Name = "MacroNameInput"
        nameBox.Position = UDim2.fromOffset(10, 28)
        nameBox.Size = UDim2.new(1, -20, 0, 27)
        nameBox.BackgroundColor3 = Color3.fromRGB(28, 24, 38)
        nameBox.BorderSizePixel = 0
        nameBox.PlaceholderText = "Enter macro name..."
        nameBox.Text = "My Macro"
        nameBox.TextColor3 = Color3.fromRGB(245, 239, 255)
        nameBox.PlaceholderColor3 = Color3.fromRGB(150, 140, 165)
        nameBox.Font = Enum.Font.Gotham
        nameBox.TextSize = 11
        nameBox.ClearTextOnFocus = false
        nameBox.Parent = nameCard
        Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)

        -- Macro list
        local listCard = makeCard("MacroListCard", 170, 3)
        makeLabel(listCard, "SAVED MACROS",
            UDim2.fromOffset(10, 5), UDim2.new(1, -20, 0, 22))

        local macroList = Instance.new("ScrollingFrame")
        macroList.Name = "SavedMacroList"
        macroList.Position = UDim2.fromOffset(8, 31)
        macroList.Size = UDim2.new(1, -16, 1, -39)
        macroList.BackgroundColor3 = Color3.fromRGB(29, 24, 39)
        macroList.BackgroundTransparency = 0.1
        macroList.BorderSizePixel = 0
        macroList.ScrollBarThickness = 4
        macroList.AutomaticCanvasSize = Enum.AutomaticSize.Y
        macroList.CanvasSize = UDim2.new(0, 0, 0, 0)
        macroList.Parent = listCard
        Instance.new("UICorner", macroList).CornerRadius = UDim.new(0, 6)

        local macroLayout = Instance.new("UIListLayout", macroList)
        macroLayout.Padding = UDim.new(0, 5)
        macroLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local macroPadding = Instance.new("UIPadding", macroList)
        macroPadding.PaddingTop = UDim.new(0, 5)
        macroPadding.PaddingLeft = UDim.new(0, 5)
        macroPadding.PaddingRight = UDim.new(0, 5)

        -- Playback controls
        local playCard = makeCard("PlaybackCard", 65, 4)
        makeLabel(playCard, "PLAYBACK",
            UDim2.fromOffset(10, 5), UDim2.new(1, -20, 0, 18))

        local playButton = makeButton(playCard, "PlayButton", "▶ PLAY SELECTED",
            UDim2.fromOffset(10, 28), UDim2.new(0.58, -12, 0, 28),
            Color3.fromRGB(65, 145, 95))

        local deleteButton = makeButton(playCard, "DeleteButton", "DELETE",
            UDim2.new(0.58, 3, 0, 28), UDim2.new(0.42, -13, 0, 28),
            Color3.fromRGB(150, 55, 65))

        -- Part 2 adds recording, saving, selecting and playback logic.


        -- NEXUS MACRO STUDIO - PART 2 OF 2

        local function setStatus(text, color)
            status.Text = "● " .. text
            status.TextColor3 = color
        end

        local function refreshMacroList()
            for _, child in ipairs(macroList:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end

            for index, macro in ipairs(recordedMacros) do
                local button = Instance.new("TextButton")
                button.Name = "MacroItem" .. index
                button.Size = UDim2.new(1, -4, 0, 30)
                button.BackgroundColor3 =
                    selectedMacro == macro
                    and Color3.fromRGB(100, 65, 145)
                    or Color3.fromRGB(48, 39, 62)
                button.BorderSizePixel = 0
                button.Text = "  " .. macro.name
                    .. "   •   " .. #macro.events .. " inputs"
                button.TextColor3 = Color3.fromRGB(245, 239, 255)
                button.TextSize = 10
                button.Font = Enum.Font.GothamMedium
                button.TextXAlignment = Enum.TextXAlignment.Left
                button.LayoutOrder = index
                button.Parent = macroList

                Instance.new("UICorner", button).CornerRadius =
                    UDim.new(0, 5)

                button.Activated:Connect(function()
                    selectedMacro = macro
                    nameBox.Text = macro.name
                    refreshMacroList()
                end)
            end
        end

        local function stopRecording()
            if not recording then
                return
            end

            recording = false
            setStatus(
                "RECORDING STOPPED • " .. #currentRecording .. " INPUTS",
                Color3.fromRGB(235, 190, 90)
            )
        end

        local function startRecording()
            if playing then
                setStatus("STOP PLAYBACK FIRST", Color3.fromRGB(255, 120, 120))
                return
            end

            currentRecording = {}
            recording = true

            setStatus("RECORDING...", Color3.fromRGB(255, 100, 120))
        end

        -- Record keyboard key names and elapsed time.
        connections.input = UIS.InputBegan:Connect(function(input, processed)
            if not recording or processed then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.Keyboard then
                return
            end

            if input.KeyCode == Enum.KeyCode.Unknown then
                return
            end

            table.insert(currentRecording, {
                key = input.KeyCode.Name,
                time = os.clock()
            })
        end)

        recordButton.Activated:Connect(function()
            if recording then
                stopRecording()
            else
                startRecording()
            end
        end)

        stopButton.Activated:Connect(function()
            if recording then
                stopRecording()
            end

            if playing then
                playing = false
                setStatus("PLAYBACK STOPPED", Color3.fromRGB(235, 190, 90))
            end
        end)

        saveButton.Activated:Connect(function()
            if recording then
                stopRecording()
            end

            if #currentRecording == 0 then
                setStatus("NO INPUTS TO SAVE", Color3.fromRGB(255, 120, 120))
                return
            end

            local macroName = nameBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
            if macroName == "" then
                macroName = "Macro " .. (#recordedMacros + 1)
            end

            local events = {}
            local firstTime = currentRecording[1].time

            for _, event in ipairs(currentRecording) do
                table.insert(events, {
                    key = event.key,
                    time = event.time - firstTime
                })
            end

            local macro = {
                name = macroName,
                events = events
            }

            table.insert(recordedMacros, macro)
            selectedMacro = macro
            refreshMacroList()

            setStatus("SAVED: " .. macroName, Color3.fromRGB(100, 225, 145))
        end)

        playButton.Activated:Connect(function()
            if playing then
                return
            end

            if recording then
                stopRecording()
            end

            if not selectedMacro then
                setStatus("SELECT A MACRO FIRST", Color3.fromRGB(255, 120, 120))
                return
            end

            playing = true
            local macroToPlay = selectedMacro

            setStatus("PREVIEWING: " .. macroToPlay.name,
                Color3.fromRGB(100, 225, 145))

            task.spawn(function()
                local startTime = os.clock()

                for index, event in ipairs(macroToPlay.events) do
                    if not playing then
                        break
                    end

                    local targetTime = startTime + event.time

                    while playing and os.clock() < targetTime do
                        task.wait(0.01)
                    end

                    if not playing then
                        break
                    end

                    setStatus(
                        "PREVIEW " .. index .. "/" .. #macroToPlay.events
                            .. " • " .. event.key,
                        Color3.fromRGB(174, 140, 255)
                    )
                end

                playing = false

                if page.Parent then
                    setStatus("PREVIEW COMPLETE",
                        Color3.fromRGB(100, 225, 145))
                end
            end)
        end)

        deleteButton.Activated:Connect(function()
            if not selectedMacro then
                setStatus("SELECT A MACRO TO DELETE",
                    Color3.fromRGB(255, 120, 120))
                return
            end

            for index, macro in ipairs(recordedMacros) do
                if macro == selectedMacro then
                    table.remove(recordedMacros, index)
                    break
                end
            end

            selectedMacro = nil
            refreshMacroList()
            setStatus("MACRO DELETED", Color3.fromRGB(235, 190, 90))
        end)

        -- Tab navigation.
        macroTab.Activated:Connect(function()
            page.Visible = true

            local home = main:FindFirstChild("NexusHomeProfile")
            local exploits = main:FindFirstChild("NexusExploitsPage")
            local keybinds = main:FindFirstChild("NexusKeybindManager")
            local theme = main:FindFirstChild("NexusThemePage")

            if home then home.Visible = false end
            if exploits then exploits.Visible = false end
            if keybinds then keybinds.Visible = false end
            if theme then theme.Visible = false end
        end)

        for _, tab in ipairs(sidebar:GetChildren()) do
            if tab:IsA("TextButton") and tab ~= macroTab then
                tab.Activated:Connect(function()
                    page.Visible = false
                end)
            end
        end

        -- Stop any active operation if the page is removed.
        page.Destroying:Connect(function()
            recording = false
            playing = false

            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
        end)

        refreshMacroList()
        setStatus("READY", Color3.fromRGB(100, 225, 145))

        print("NEXUS Macro Studio loaded successfully!")
    end)

    if not success then
        warn("NEXUS Macro Studio error: " .. tostring(err))
    end
end)

-- okay cool last text guys


-- NEXUS: BETA VERSION LABEL

local betaGui = player:WaitForChild("PlayerGui"):FindFirstChild("MyCustomGUI")
local betaMain = betaGui and betaGui:FindFirstChild("MainBackground")

if betaMain then
    local oldBeta = betaMain:FindFirstChild("BetaVersionLabel")
    if oldBeta then
        oldBeta:Destroy()
    end

    local beta = Instance.new("TextLabel")
    beta.Name = "BetaVersionLabel"
    beta.AnchorPoint = Vector2.new(1, 1)
    beta.Position = UDim2.new(1, -10, 1, -7)
    beta.Size = UDim2.fromOffset(190, 18)
    beta.BackgroundTransparency = 1
    beta.Text = "Made by JayJay226606  •  BETA VERSION  •  SOME THINGS MAY NOT WORK"
    beta.TextColor3 = Color3.fromRGB(180, 155, 220)
    beta.TextTransparency = 0.1
    beta.TextSize = 9
    beta.Font = Enum.Font.GothamMedium
    beta.TextXAlignment = Enum.TextXAlignment.Right
    beta.TextYAlignment = Enum.TextYAlignment.Center
    beta.ZIndex = 50
    beta.Parent = betaMain

    print("NEXUS beta label added!")
else
    warn("NEXUS: MainBackground not found!")
end

-- ----------------------------------




-- NEXUS: CREATOR CREDITS (SAFE VERSION)

task.spawn(function()
    local success, err = pcall(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        if not player then
            warn("NEXUS Credits: LocalPlayer unavailable.")
            return
        end

        local playerGui = player:WaitForChild("PlayerGui")
        local creditsGui = playerGui:WaitForChild("MyCustomGUI", 10)

        if not creditsGui then
            warn("NEXUS Credits: GUI not found.")
            return
        end

        local creditsMain = creditsGui:WaitForChild("MainBackground", 10)

        if not creditsMain then
            warn("NEXUS Credits: MainBackground not found.")
            return
        end

        local oldCredits = creditsMain:FindFirstChild("NexusCredits")
        if oldCredits then
            oldCredits:Destroy()
        end

        local credits = Instance.new("TextLabel")
        credits.Name = "NexusCredits"
        credits.Position = UDim2.fromOffset(12, 6)
        credits.Size = UDim2.fromOffset(230, 25)
        credits.BackgroundTransparency = 1
        credits.Text = "Made by: JayJay226606"
        credits.TextColor3 = Color3.fromRGB(190, 160, 255)
        credits.TextSize = 12
        credits.Font = Enum.Font.GothamBold
        credits.TextXAlignment = Enum.TextXAlignment.Left
        credits.ZIndex = 50
        credits.Parent = creditsMain

        print("NEXUS: Creator credits loaded!")
    end)

    if not success then
        warn("NEXUS Credits error: " .. tostring(err))
    end
end)
