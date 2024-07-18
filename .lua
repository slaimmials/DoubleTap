local coreLocked=pcall(function()local a=game.CoreGui end)local guiPlacing;if not coreLocked then guiPlacing = game.Players.LocalPlayer.PlayerGui else guiPlacing = game.CoreGui end
local gui = Instance.new("ScreenGui", guiPlacing)
gui.Name = "RobloxGui"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", gui)
MainFrame.Name = "Main"
MainFrame.Size = UDim2.fromScale(0.215,0.256)
MainFrame.Position = UDim2.fromScale(0.785,0.744)
MainFrame.BackgroundTransparency = 1

local functions = {
	selected = 1,
}
functions["list"] = {}
function AddFN(Name, FunctionOn, FunctionOff, Color)
	if Name ~= nil and typeof(Name) == "string" then
        if Color == nil then
            Color = Color3.fromRGB(255,255,255)
        end
        local TextLabel = Instance.new("TextLabel", MainFrame)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color
        TextLabel.Text = Name.." >> OFF"
        TextLabel.Size = UDim2.fromOffset(342,13)
        TextLabel.Position = UDim2.fromOffset(0,#functions.list*TextLabel.Size.Y.Offset)
        TextLabel.TextSize = 14
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        local base = {}
        base["Name"] = Name
        base["Index"] = #functions.list+1
        base["Type"] = "Toggle"
        base["FuncOn"] = FunctionOn
        base["FuncOff"] = FunctionOff
        base["Enabled"] = false
        base["Instance"] = TextLabel
        functions.list[#functions.list+1] = base
    end
end
function AddButton(Name, Function, Color)
	if Name ~= nil and typeof(Name) == "string" then
        if Color == nil then
            Color = Color3.fromRGB(255,255,255)
        end
        local TextLabel = Instance.new("TextLabel", MainFrame)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color
        TextLabel.Text = Name
        TextLabel.Size = UDim2.fromOffset(342,13)
        TextLabel.Position = UDim2.fromOffset(0,#functions.list*TextLabel.Size.Y.Offset)
        TextLabel.TextSize = 14
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        local base = {}
        base["Name"] = Name
        base["Index"] = #functions.list+1
        base["Type"] = "Button"
        base["Func"] = Function
        base["Enabled"] = false
        base["Instance"] = TextLabel
        functions.list[#functions.list+1] = base
    end
end

local hooks = {}

local UIS = game:GetService("UserInputService")

hooks[#hooks+1] = UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Down then
        functions.selected = math.clamp(functions.selected + 1, 1, #functions.list)
    elseif input.KeyCode == Enum.KeyCode.Up then
        functions.selected = math.clamp(functions.selected - 1, 1, #functions.list)
    end
    if input.KeyCode == Enum.KeyCode.Return then
        local selectedTable = functions.list[functions.selected]
        if selectedTable ~= nil then
            if selectedTable.Type == "Toggle" then
                selectedTable.Enabled = not selectedTable.Enabled
                if selectedTable.Enabled == true then
                    pcall(selectedTable.FuncOn)
                else
                    pcall(selectedTable.FuncOff)
                end
            elseif selectedTable.Type == "Button" then
                pcall(selectedTable.Func)
            end
        end
    end
end)

hooks[#hooks+1] = game:GetService("RunService").RenderStepped:Connect(function()
    if functions.selected ~= 0 then
        local selectedTable = functions.list[functions.selected]
        if selectedTable ~= nil then
            local Ins = selectedTable.Instance
            Ins.TextStrokeTransparency = 0
            if selectedTable.Type == "Toggle" then
                if selectedTable.Enabled == true then
                    Ins.Text = selectedTable.Name .. " >> ON"
                else
                    Ins.Text = selectedTable.Name .. " >> OFF"
                end
            end
        end
    end
end)

hooks[#hooks+1] = game:GetService("RunService").Stepped:Connect(function()
    for _,v in pairs(functions.list) do
        if v.Index ~= functions.selected then
            v.Instance.TextStrokeTransparency = 1
        end
    end
end)

local unloaded = false

function GetDist(dist1, dist2)
    if typeof(dist1) == "Instance" then
        if dist1.ClassName == "Model" then
            dist1 = dist1:GetPivot().Position
        else
            dist1 = dist1.CFrame.Position
        end
    elseif typeof(dist1) == "CFrame" then
        dist1 = dist1.Position
    end
    if typeof(dist2) == "Instance" then
        if dist2.ClassName == "Model" then
            dist2 = dist2:GetPivot().Position
        else
            dist2 = dist2.CFrame.Position
        end
    elseif typeof(dist2) == "CFrame" then
        dist2 = dist2.Position
    end
    return (dist1 - dist2).Magnitude
end

AddFN("Highlight Cups", function()
    local char = game.Players.LocalPlayer.Character
    spawn(function()
        while wait() do
            if unloaded == true then
                break
            end
            local closestArena = nil
            local dist = math.huge
            for _i,Arena in pairs(workspace.ArenasREAL:GetChildren()) do
                Arena.Name = "Arena"
                if (workspace.CurrentCamera.Focus.Position - Arena.CFrame.Position).Magnitude < dist then
                    dist = (workspace.CurrentCamera.Focus.Position - Arena.CFrame.Position).Magnitude
                    closestArena = Arena
                end
            end
            closestArena.Name = "Arenas"
            closestArena = closestArena.ArenaTemplate
            local IsCups = false
            local bypassedName = ""
            for _,ins in pairs(closestArena.Important:GetChildren()) do
                if #ins.Name == 7 then
                    IsCups = true
                    bypassedName = ins.Name
                    break
                end
            end
            if IsCups == true then
                local searching = true
                local Dpos = {}
                repeat
                    for _,diamond in pairs(closestArena.Important.Diamonds:GetChildren()) do
                        if diamond.Transparency == 0 then
                            local mostCup = nil
                            local mostDist = math.huge
                            for _,Cup in pairs(closestArena.Important[bypassedName]:GetChildren()) do
                                if GetDist(Cup, diamond) < mostDist then
                                    mostDist = GetDist(Cup, diamond)
                                    mostCup = Cup
                                end
                            end
                            Dpos[#Dpos+1] = mostCup.Name
                        end
                    end
                    if Dpos[1] ~= nil and Dpos[2] ~= nil then
                        searching = false
                    elseif not closestArena.Important:FindFirstChild("Diamonds") then
                        IsCups = false
                        searching = false
                    end
                    wait(0.2)
                until not searching
                if IsCups == true then
                    local hl1 = Instance.new("Highlight",workspace)
                    hl1.Name = "a"
                    hl1.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl1.FillTransparency = 1
                    hl1.OutlineColor = Color3.new(1,0,0)
                    local hl2 = Instance.new("Highlight",workspace)
                    hl2.Name = "a"
                    hl2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl2.FillTransparency = 1
                    hl2.OutlineColor = Color3.new(1,0,0)
                    repeat
                        hl1.Adornee = closestArena.Important[bypassedName][Dpos[1]]
                        hl2.Adornee = closestArena.Important[bypassedName][Dpos[2]]
                        if not closestArena.Important:FindFirstChild("Diamonds") then
                            IsCups = false
                        end
                        wait(1)
                    until not IsCups
                end
            end
        end
    end)
end, function()end)

AddButton("Unload", function()
    unloaded = true
    for _name,hook in pairs(hooks) do
        if typeof(_name) == "string" then
            print("> unloading '".._name.."'")
        else
            print"> unloading 'undefined'"
        end
        hook:Disconnect()
    end
    gui:Destroy()
    print"unloaded successfully ☑️"
end, Color3.new(1,0,0))
