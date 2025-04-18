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

local STools = {}

function STools:GetHttpText(http)
    local work = pcall(function()
        local a = game:HttpGet(http)
    end)
    if work == true then
        return game:HttpGet(http)
    else
        return "Error while loading"
    end
    --return ""
end

function AddFN(Name, FunctionOn, FunctionOff, Color)
	if Name ~= nil and typeof(Name) == "string" then
        if Color == nil then
            Color = Color3.fromRGB(255,255,255)
        end
        local TextLabel = Instance.new("TextLabel", MainFrame)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color
        TextLabel.Text = Name.." >> OFF"
        TextLabel.Size = UDim2.fromOffset(342,16)
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
        TextLabel.Size = UDim2.fromOffset(342,16)
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

local hook = {}
function hook:Add(Name)
    local ret = {}
    hooks[Name] = true
    ret["Name"] = Name
    function ret:Unhook()
        hooks[ret.Name] = nil
    end
    return ret
end

local UIS = game:GetService("UserInputService")
local hookC = 0
hookC=hookC+1;hooks["InputService"..hookC] = UIS.InputEnded:Connect(function(input)
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

hookC=hookC+1;hooks["InterfaceSystem"..hookC] = game:GetService("RunService").RenderStepped:Connect(function()
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

hookC=hookC+1;hooks["InterfaceSystem"..hookC] = game:GetService("RunService").Stepped:Connect(function()
    for _,v in pairs(functions.list) do
        if v.Index ~= functions.selected then
            v.Instance.TextStrokeTransparency = 1
        end
    end
end)

--========================--
-------------==-------------
--========================--

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

function isNumber(value: string)
    return string.find("0123456789", value) ~= nil
end

local ArenasFound = {
    Cups = false,
    TTT = false,
}

local ArenaStatus = Instance.new("TextLabel")
ArenaStatus.Visible = false
ArenaStatus.Size = UDim2.fromScale(0.102,0.049)
ArenaStatus.Position = UDim2.fromScale(0.47,0.744)
ArenaStatus.BackgroundTransparency = 1
ArenaStatus.TextColor3 = Color3.new(1,0.1,0.1)
ArenaStatus.TextStrokeTransparency = 0
ArenaStatus.Text = "Status: Waiting"
ArenaStatus.TextXAlignment = Enum.TextXAlignment.Left
ArenaStatus.TextYAlignment = Enum.TextYAlignment.Top
ArenaStatus.TextSize = 13
ArenaStatus.Parent = gui

local ArenaHook = nil
AddFN("ArenaStatus", function()
    spawn(function()
        ArenaHook = hook:Add("ArenaStatus")
        while hooks["ArenaStatus"] == true do
            if (functions.list[2].Enabled == true and ArenasFound.Cups == true) or (functions.list[3].Enabled == true and ArenasFound.TTT == true) then
                ArenaStatus.Text = "Status: Connected"
                ArenaStatus.TextColor3 = Color3.new(0.1,1,0.1)
            else
                ArenaStatus.Text = "Status: Waiting"
                ArenaStatus.TextColor3 = Color3.new(1,0.1,0.1)
            end
            wait(0.3)
        end
    end)
    ArenaStatus.Visible = true
end,function ()
    ArenaStatus.Visible = false
    if ArenaHook ~= nil then
        ArenaHook:Unhook()
        ArenaHook = nil
    end
end)

AddFN("Highlight Cups", function()
    local char = game.Players.LocalPlayer.Character
    spawn(function()
        hook:Add("CupHighlight")
        local function hookCheck()
            if hooks["CupHighlight"] == nil then
                for _, inst in pairs(workspace:GetChildren()) do
                    if inst.Name == "a" then
                        inst:Remove()
                    end
                end
                ArenasFound.Cups = false
                return false
            else
                return true
            end
        end
        ArenasFound.Cups = false
        while wait() do
            if not hookCheck() then break end
            for _, inst in pairs(workspace:GetChildren()) do
                if inst.Name == "a" then
                    inst:Remove()
                end
            end
            local closestArena = nil
            local dist = math.huge
            for _i,Arena in pairs(workspace.ArenasREAL:GetChildren()) do
                if not hookCheck() then break end
                Arena.Name = "Arena"
                for _,b in pairs(Arena:GetDescendants()) do
                    if b.Name == "Username" then
                        if b.Text:find(game.Players.LocalPlayer.Name) then
                            Arena.Name = "Arenas"
                            closestArena = Arena
                        end
                    end
                end
            end
            local IsCups = false
            local bypassedName = ""
            pcall(function()
                closestArena = closestArena.ArenaTemplate
                for _,ins in pairs(closestArena.Important:GetChildren()) do
                    local params = {
                        false,
                        false,
                        false,
                        true
                    }
                    for char = 1,#ins.Name do
                        if not params[1] then
                            if isNumber(ins.Name:sub(char,char)) then
                                params[1] = true
                            end
                        elseif not params[2] then
                            if not isNumber(ins.Name:sub(char,char)) then
                                params[1] = true
                            end
                        elseif not params[3] then
                            if isNumber(ins.Name:sub(char,char)) then
                                params[1] = true
                            end
                        else
                            if not isNumber(ins.Name:sub(char,char)) then
                                params[4] = false
                            end
                        end
                    end
                    if params[4] then
                        IsCups = true
                        bypassedName = ins.Name
                        break
                    end
                end
            end)
            if IsCups == true then
                pcall(function()
                    ArenasFound.Cups = true
                    local searching = true
                    local Dpos = {}
                    repeat
                        if not hookCheck() then break end
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
                                if #Dpos == 1 and Dpos[#Dpos] ~= mostCup.Name then
                                    Dpos[#Dpos+1] = mostCup.Name
                                elseif #Dpos == 0 then
                                    Dpos[#Dpos+1] = mostCup.Name
                                end
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
                            if not hookCheck() then break end
                            hl1.Adornee = closestArena.Important[bypassedName][Dpos[1]]
                            hl2.Adornee = closestArena.Important[bypassedName][Dpos[2]]
                            if not closestArena.Important:FindFirstChild("Diamonds") then
                                IsCups = false
                            end
                            wait(0.01)
                        until not IsCups
                    end
                end)
            end
            ArenasFound.Cups = false
        end
    end)
end, function()
    hooks["CupHighlight"] = nil
end)

AddFN("TicTacToe Bot", function()
    hook:Add("TTTBot")
    local plate = {
        {0,0,0},
        {0,0,0},
        {0,0,0},
    }
    local Hl = Instance.new("BillboardGui",workspace)
    Hl.Name = "b"
    Hl.AlwaysOnTop = true
    Hl.Adornee = workspace.CurrentCamera
    Hl.Size = UDim2.fromOffset(200,50)
    local Tl = Instance.new("TextLabel",Hl)
    Tl.BackgroundTransparency = 1
    Tl.TextColor3 = Color3.new(1,1,1)
    Tl.TextScaled = true
    Tl.TextStrokeTransparency = 0
    Tl.Size = UDim2.fromScale(1,1)
    Tl.Text = "×"
    pcall(function()
        for _,v in pairs(game.Players.LocalPlayer.PlayerGui.TicTacToe["Bottom Middle Template"].Buttons:GetChildren()) do
            pcall(function()
                v.BackgroundTransparency = 1
                v.Full.BackgroundTransparency = 1
                v.Background.BackgroundTransparency = 1
            end)
        end
    end)
    
    spawn(function()
        print"spawning"
        local function hookCheck()
            if hooks["TTTBot"] == nil then
                for _, inst in pairs(workspace:GetChildren()) do
                    if inst.Name == "b" then
                        inst:Remove()
                    end
                end
                ArenasFound.TTT = false
                return false
            else
                return true
            end
        end
        local Arena = nil
        while wait() do
            print("scanning")
            if not hookCheck() then break end

            repeat
                for i,v in pairs(workspace.ArenasREAL:GetChildren()) do
                    for _,b in pairs(v:GetDescendants()) do
                        if b.Name == "Username" then
                            if b.Text:find(game.Players.LocalPlayer.Name) then
                                v.Name = "Arenas"
                                Arena = v.ArenaTemplate.Important
                            end
                        end
                    end
                end
                wait(0.02)
            until Arena ~= nil
            print"Arena found"
            ArenasFound.TTT = true
            for _,char in pairs(Arena.Drops:GetChildren()) do
                print(char.Name)
                if char.Color == Color3.fromRGB(85, 131, 182) then
                    plate[4-tonumber(char.Name:sub(2,2))][tonumber(char.Name:sub(1,1))] = 1
                elseif char.Color == Color3.fromRGB(255, 102, 102) then
                    plate[4-tonumber(char.Name:sub(2,2))][tonumber(char.Name:sub(1,1))] = 2
                end
            end

            local enemy = 1
            local lplr = 2
            if game.Players.LocalPlayer.PlayerGui.TicTacToe["Top Middle Template"].RoundInfo.TeamColorBlue.Visible == true then
                lplr = 1
                enemy = 2
            end

            local function HighlightPos(x,y)
                print("подсвечиваем: ",x,y)
                Hl.Adornee = Arena.Slots[tostring(x)..tostring(4-y)]
            end
    
            function plate:Dot(x,y)
                --print(x,y..": "..plate[y][x])
                return plate[y][x]
            end
    
            function plate:Center()
                print(plate[2][2])
                if plate[2][2] == 0 then
                    return false
                end
                return true
            end
    
            function plate:Area(x1,y1,x2,y2)
                local mostY = y1
                local lessY = y2
                if y2 > y1 then
                    mostY = y2
                    lessY = y1
                end
                local mostX = x1
                local lessX = x2
                if x2 > x1 then
                    mostX = x2
                    lessX = x1
                end
                local found = false
                for _y = lessY, mostY do
                    for _x = lessX, mostX do
                        if plate:Dot(_x,_y) ~= 0 then
                            if typeof(found) == "boolean" then
                                found = {}
                            end
                            found[#found+1] = {_x,_y}
                            break
                        end
                    end
                end
                return found
            end
    
            function plate:Around()
                local found = false
                for _y = 1,3 do
                    for _x = 1,3 do
                        if _y ~= 2 and _x ~= 2 then
                            if plate:Dot(_x,_y) ~= 0 then
                                if typeof(found) == "boolean" then
                                    found = {}
                                end
                                found[#found+1] = {_x,_y}
                            end
                        end
                    end
                end
                return found
            end
    
            function plate:GetFree()
                local free = false
                for _y = 1,3 do
                    for _x = 1,3 do
                        if plate:Dot(_x,_y) == 0 then
                            if typeof(free) == "boolean" then
                                free = {}
                            end
                            free[#free+1] = {x=_x,y=_y}
                        end
                    end
                end
                return free
            end
    
            function plate:Rotate(x,y,degrees)
                if x==2 and y==2 then return {x=2,y=2} end
                if degrees == 90 then
                    if x==1 and y==1 then
                        return {x=3,y=1}
                    elseif x==3 and y==1 then
                        return {x=3,y=3}
                    elseif x==3 and y==3 then
                        return {x=1,y=3}
                    elseif x==1 and y==3 then
                        return {x=1,y=1}
    
                    elseif x==2 and y==1 then
                        return {x=3,y=2}
                    elseif x==3 and y==2 then
                        return {x=2,y=3}
                    elseif x==2 and y==3 then
                        return {x=1,y=2}
                    elseif x==1 and y==2 then
                        return {x=2,y=1}
                    end
                else
                    if x==1 and y==1 then
                        return {x=3,y=3}
                    elseif x==3 and y==1 then
                        return {x=1,y=3}
                    elseif x==3 and y==3 then
                        return {x=1,y=1}
                    elseif x==1 and y==3 then
                        return {x=3,y=1}
    
                    elseif x==2 and y==1 then
                        return {x=2,y=3}
                    elseif x==3 and y==2 then
                        return {x=1,y=2}
                    elseif x==2 and y==3 then
                        return {x=2,y=1}
                    elseif x==1 and y==2 then
                        return {x=3,y=2}
                    end
                end
            end

            function plate:Equals(plate2)
                local equal = true
                for _y = 1,3 do
                    for _x = 1,3 do
                        if self[_y][_x] ~= plate2[_y][_x] then
                            equal = false
                        end
                    end
                end
                return equal
            end

            function plate:LookNew(Folder)
                if Folder == nil then
                    return false
                end
                local Nplate = {
                    {0,0,0},
                    {0,0,0},
                    {0,0,0},
                }
                for _,char in pairs(Folder:GetChildren()) do
                    if char.Color == Color3.fromRGB(85, 131, 182) then
                        Nplate[4-tonumber(char.Name:sub(2,2))][tonumber(char.Name:sub(1,1))] = 1
                    elseif char.Color == Color3.fromRGB(255, 102, 102) then
                        Nplate[4-tonumber(char.Name:sub(2,2))][tonumber(char.Name:sub(1,1))] = 2
                    end
                end
                return Nplate
            end
    
            local function checkPotentialWin(plr)
                
                local op = (plr==1 and 2) or 2
                local function N(x,y)
                    return plate:Dot(x,y) == 0
                end
                local function P(x,y)
                    return plate:Dot(x,y) == plr
                end
                local function OP(x,y)
                    return plate:Dot(x,y) == op
                end

                -- горизонтальный скан
                for _y = 1,3 do
                    if P(1,_y) and P(2,_y) and N(3,_y) then
                        return {x=3,y=_y}
                    elseif P(1,_y) and N(2,_y) and P(3,_y) then
                        return {x=2,y=_y}
                    elseif N(1,_y) and P(2,_y) and P(3,_y) then
                        return {x=1,y=_y}
                    end
                end

                -- вертикальный скан
                for _x = 1,3 do
                    if P(_x,1) and P(_x,2) and N(_x,3) then
                        return {x=_x,y=3}
                    elseif P(_x,1) and N(_x,2) and P(_x,3) then
                        return {x=_x,y=2}
                    elseif N(_x,1) and P(_x,2) and P(_x,3) then
                        return {x=_x,y=1}
                    end
                end
                
                -- диагонали
                if P(1,1) and P(2,2) and N(3,3) then
                    
                elseif P(1,1) and N(2,2) and P(3,3) then

                elseif N(1,1) and P(2,2) and P(3,3) then
                end

                for _y = 1,3 do
                    
                end

                if plate:Dot(1,1) == plr and plate:Dot(2,2) == plr and plate[3][3] == 0 then
                    return {x=3,y=3}
                elseif plate:Dot(3,1) == plr and plate:Dot(2,2) == plr and plate[3][1] == 0 then
                    return {x=1,y=3}
                elseif plate[1][3] == 0 and plate:Dot(2,2) == plr and plate:Dot(1,3) == plr then
                    return {x=3,y=1}
                elseif plate[1][1] == 0 and plate:Dot(2,2) == plr and plate:Dot(3,3) == plr then
                    return {x=1,y=1}
                elseif plate:Dot(3,1) == plr and plate[2][2] == 0 and plate:Dot(1,3) == plr then
                    return {x=2,y=2}
                elseif plate:Dot(1,1) == plr and plate[2][2] == 0 and plate:Dot(3,3) == plr then
                    return {x=2,y=2}
                end
    
                return false
            end

            local function checkPotentialLose(plr)
                local lplr = (plr == 1 and 2) or 1
                local function N(x,y)
                    return plate:Dot(x,y) == 0
                end
                local function P(x,y)
                    return plate:Dot(x,y) == plr
                end
                local function LP(x,y)
                    return plate:Dot(x,y) == lplr
                end
                for _y = 1,3 do
                    if P(1,_y) and P(2,_y) and N(3,_y) then
                        return {x=3,y=_y}
                    elseif P(1,_y) and N(2,_y) and P(3,_y) then
                        return {x=2,y=_y}
                    elseif N(1,_y) and P(2,_y) and P(3,_y) then
                        return {x=1,y=_y}
                    end
                end

                for _x = 1,3 do
                    if P(_x,1) and P(_x,2) and N(_x,3) then
                        return {x=_x,y=3}
                    elseif P(_x,1) and N(_x,2) and P(_x,3) then
                        return {x=_x,y=2}
                    elseif N(_x,1) and P(_x,2) and P(_x,3) then
                        return {x=_x,y=1}
                    end
                end
                
                -- диагонали
                if plate:Dot(1,1) == plr and plate:Dot(2,2) == plr and plate:Dot(3,3) == 0 then
                    return {x=3,y=3}
                elseif plate:Dot(3,1) == plr and plate:Dot(2,2) == plr and plate:Dot(1,3) == 0 then
                    return {x=1,y=3}
                elseif plate:Dot(3,1) == 0 and plate:Dot(2,2) == plr and plate:Dot(1,3) == plr then
                    return {x=3,y=1}
                elseif plate:Dot(1,1) == 0 and plate:Dot(2,2) == plr and plate:Dot(3,3) == plr then
                    return {x=1,y=1}
                elseif plate:Dot(3,1) == plr and plate:Dot(2,2) == 0 and plate:Dot(1,3) == plr then
                    return {x=2,y=2}
                elseif plate:Dot(1,1) == plr and plate:Dot(2,2) == 0 and plate:Dot(3,3) == plr then
                    return {x=2,y=2}
                end

                if P(1,1) and LP(2,2) and P(3,3) then
                    return {x=2,y=3}
                elseif P(3,1) and LP(2,2) and P(1,3) then
                    return {x=2,y=3}
                end
                return false
            end
    
            local function plusCheck(plr)
                local Llplr = 1
                if plr == 1 then Llplr = 2 end
                local function N(x,y)
                    return plate:Dot(x,y) == 0
                end
                local function P(x,y)
                    return plate:Dot(x,y) == Llplr
                end
                local function OP(x,y)
                    return plate:Dot(x,y) == plr
                end
                if P(3,1) and OP(2,2) and N(1,3) then
                    return {x=1,y=3}
                end

                if plate:Dot(2,2) == Llplr then
                    if plate:Dot(2,1) == plr then
                        if plate:Dot(3,3) == Llplr then
                            return {x=3,y=1}
                        else
                            return {x=3,y=3}
                        end
                    elseif plate:Dot(2,3) == plr then
                        if plate:Dot(1,1) == Llplr then
                            return {x=1,y=3}
                        else
                            return {x=1,y=1}
                        end
                    elseif plate:Dot(1,2) == plr then
                        if plate:Dot(3,3) == Llplr then
                            return {x=1,y=3}
                        else
                            return {x=3,y=3}
                        end
                    elseif plate:Dot(3,2) == plr then
                        if plate:Dot(1,3) == Llplr then
                            return {x=3,y=3}
                        else
                            return {x=1,y=3}
                        end
                    end
                end
                
                return false
            end
    
            repeat
                pcall(function()
                    if plate:GetFree() ~= false then
                        print(plate:Area(1,1,1,2))
                        print(plate[1][1], plate[1][2], plate[1][3])
                        print(plate[2][1], plate[2][2], plate[2][3])
                        print(plate[3][1], plate[3][2], plate[3][3])
                        
                        if plate:Center() == true then
                            print"центр занят"
                            local canWin = checkPotentialWin(lplr)
                            if canWin ~= false then
                                print(canWin)
                                print"проверяем потенциальные победные ходы"
                                HighlightPos(canWin.x,canWin.y)
                            else
                                local canEnenmyWin = checkPotentialWin(enemy)
                                if canEnenmyWin ~= false then
                                    print(canEnenmyWin)
                                    print"перекрываем возможную победу противника"
                                    HighlightPos(canEnenmyWin.x,canEnenmyWin.y)
                                else
                                    local isPlusStyle = plusCheck(enemy)
                                    if isPlusStyle ~= false then
                                        print"проверяем на лёгкую победу"
                                        HighlightPos(isPlusStyle.x,isPlusStyle.y)
                                    else
                                        print"пытаемся не проиграть"
                                        local isFree = plate:GetFree()
                                        if isFree ~= false then
                                            if #isFree > 1 then
                                                --if plate[2][2] == lplr then
                                                    local rotated = {x=1,y=1}
                                                    local filled = false
                                                    for _ = 1,4 do
                                                        rotated = plate:Rotate(rotated.x,rotated.y,90)
                                                        print"крутиим"
                                                        if plate:Dot(rotated.x,rotated.y) == 0 then
                                                            HighlightPos(rotated.x,rotated.y)
                                                            filled = true
                                                            break
                                                        end
                                                    end
                                                    if filled == false then
                                                        for _,v in pairs(isFree) do
                                                            print(v)
                                                        end
                                                        HighlightPos(isFree[math.random(1,#isFree)].x,isFree[math.random(1,#isFree)].y)
                                                    end
                                                --else
                                                --end
                                            else
                                                HighlightPos(isFree[1].x,isFree[1].y)
                                            end
                                        end
                                    end
                                end
                            end
                        --[[elseif plate:Center() == true and plate:Dot(2,2) ~= lplr then
                        ]]
                        else
                            local canWin = checkPotentialWin(lplr)
                            if canWin ~= false then
                                print(canWin)
                                print"проверяем потенциальные победные ходы"
                                HighlightPos(canWin.x,canWin.y)
                            else
                                local canEnenmyWin = checkPotentialLose(enemy)
                                if canEnenmyWin ~= false then
                                    print(canEnenmyWin)
                                    print"перекрываем возможную победу противника"
                                    HighlightPos(canEnenmyWin.x,canEnenmyWin.y)
                                else
                                    print"центр cвободен"
                                    if plate:Around() ~= false then
                                        if #plate:Around() == 1 then
                                            HighlightPos(2,2)
                                        end
                                    else
                                        HighlightPos(2,2)
                                    end
                                end
                            end
                        end
                    end
                    local newPlate = plate:LookNew(Arena.Drops)
                    repeat
                        newPlate = plate:LookNew(Arena.Drops)
                        if newPlate == false then
                            break
                        end
                        wait(0.03)
                    until newPlate == false or not plate:Equals(newPlate)
                    if newPlate ~= false then
                        for _y = 1,3 do
                            for _x = 1,3 do
                                plate[_y][_x]=newPlate[_y][_x]
                            end
                        end
                    end
                    wait(0.01)
                end)
                local found = pcall(function()
                    local _ = Arena.Drops
                end)
                wait(0.01)
            until not found or not hookCheck()
            ArenasFound.TTT = false
        end
    end)
end, function()
    hook["TTTBot"] = nil
end)

local UpdatesGui = Instance.new("TextLabel")
UpdatesGui.Visible = false
UpdatesGui.Size = UDim2.fromScale(0.257,0.256)
UpdatesGui.Position = UDim2.fromScale(0.545,0.744)
UpdatesGui.BackgroundTransparency = 1
UpdatesGui.TextColor3 = Color3.new(1,1,1)
UpdatesGui.TextStrokeTransparency = 0
UpdatesGui.Text = STools:GetHttpText("https://raw.githubusercontent.com/slaimmials/DoubleTap/main/addings")
UpdatesGui.TextXAlignment = Enum.TextXAlignment.Left
UpdatesGui.TextYAlignment = Enum.TextYAlignment.Top
UpdatesGui.TextSize = 10
UpdatesGui.Parent = gui

AddButton("Updates", function()
    UpdatesGui.Visible = not UpdatesGui.Visible
end, Color3.new(0,1,0))

AddButton("Unload", function()
    for _name,hook in pairs(hooks) do
        --print(typeof(hook))
        if typeof(_name) == "string" then
            if typeof(hook) ~= "boolean" then
                print("> unloading '".._name:sub(1,#_name-1).."'")
            else
                print("> unloading '".._name.."'")
            end
        else
            print"> unloading 'undefined'"
        end
        if typeof(hook) == "RBXScriptConnection" then
            hook:Disconnect()
        else
            hooks[_name] = nil
        end
    end
    gui:Destroy()
    print"unloaded successfully ☑️"
end, Color3.new(1,0,0))
