pcall(function (...)
    

---@diagnostic disable-next-line: deprecated
function Nothing() end
_G.SecureMethod = "NoSecure"
_G.Mobile = false
local randomString=function(a)
    if type(a)~="number" then 
        error("function string.random: count of char is not a number!")
        return""
    end
    local b=""
    for c=1,a do
        local rnd = math.random(1,3)
        if rnd == 1 then
            b=b..string.char(math.random(48,57))
        elseif rnd == 2 then
            b=b..string.char(math.random(65,90))
        else
            b=b..string.char(math.random(97,122))
        end
        
    end
    return b 
end
--local CFrame=CFrame;local Vector3 = Vector3;local Vector2=Vector2;local UDim2=UDim2;local Color3=Color3;local Instance=Instance;local spawn=spawn;local workspace=workspace;local Enum=Enum;local wait=wait;local math=math;local ColorSequence=ColorSequence;local ColorSequenceKeypoint=ColorSequenceKeypoint;local NumberSequence=NumberSequence;local NumberSequenceKeypoint=NumberSequenceKeypoint;
local coreLocked = pcall(function()
	local a=Instance.new("Folder",game:GetService("CoreGui"))
end)
coreLocked=not coreLocked
local guiPlacing
if coreLocked then 
	guiPlacing = game:GetService("Players").LocalPlayer.PlayerGui 
else 
	guiPlacing = game:GetService("CoreGui") 
end

local Colorize = {}
local Drawing = {}
if _G.OptimizeMenu ~= true then
    _G.OptimizeMenu = false
end
local gui = {
    objs = {
        Gui = Instance.new("ScreenGui", guiPlacing),
    },
    page = {nil, 1},
    Loaded = true
}
gui["Hooks"] = {}
gui.objs["Gui"].Name = "RobloxGui"
gui.objs["Gui"].IgnoreGuiInset = true
gui.objs["Gui"].Enabled = true
gui.objs["Gui"].ResetOnSpawn = false
local Draws = Instance.new("Folder", gui.objs["Gui"])
Draws.Name = "Drawings"
do
    local game = game
    local GetService, FindFirstChild = game.GetService, game.FindFirstChild
    local IsA = game.IsA
    local Vector2new, Instancenew, UDim2new = Vector2.new, Instance.new, UDim2.new

    local Workspace = GetService(game, "Workspace");
    local Camera = FindFirstChild(Workspace, "Camera");
    local CoreGui = GetService(game, "CoreGui");

    local BaseDrawingProperties = setmetatable({
        Visible = false,
        Color = Color3.new(),
        Transparency = 0,
        Remove = function()
        end
    }, {
        __add = function(tbl1, tbl2)
            local new = {}
            for i, v in next, tbl1 do
                new[i] = v
            end
            for i, v in next, tbl2 do
                new[i] = v
            end
            return new
        end
    })

    Drawing.new = function(Type, UI)
        UI = Draws
        if (Type == "Text") then
            local TextProperties = ({
                Text = "",
                Font = "",
                Size = 10,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties)
            local TextLabel = Instancenew("TextLabel")
            TextLabel.Parent = UI
            TextLabel.Text = ""
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextColor3 = TextProperties.Color
            TextLabel.TextSize = TextProperties.Size
            TextLabel.TextXAlignment = Enum.TextXAlignment.Center
            TextLabel.Visible = false
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        TextLabel.Position = UDim2.fromOffset(Value.X,Value.Y)
                        TextProperties.Position = Value
                    end
                    if (Property == "Transparency") then
                        TextLabel.TextTransparency = Value
                        TextProperties.Transparency = Value
                    end
                    if (Property == "Text") then
                        TextLabel.Text = Value
                        TextProperties.Text = Value
                    end
                    if (Property == "Size") then
                        TextLabel.TextSize = Value
                        TextProperties.Size = Value
                    end
                    if (Property == "Color") then
                        TextLabel.TextColor3 = Value
                        TextProperties.Color = Value
                    end
                    if (Property == "XAlign") then
                        TextLabel.TextXAlignment = Enum.TextXAlignment[Value]
                        TextProperties.XAlign = Enum.TextXAlignment[Value]
                    end
                    if (Property == "YAlign") then
                        TextLabel.TextYAlignment = Enum.TextXYlignment[Value]
                        TextProperties.YAlign = Enum.TextXYlignment[Value]
                    end
                    if (Property == "Visible") then
                        TextLabel.Visible = Value
                        TextProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            TextLabel:Destroy();
                        end)
                    end
                    
                    return TextProperties[Property]
                end)
            })
        end
        if (Type == "Line") then
            local LineProperties = ({
                To = Vector2new(),
                From = Vector2new(),
                Thickness = 1,
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties)

            local LineFrame = Instancenew("Frame");
            LineFrame.AnchorPoint = Vector2new(0.5, 0.5);
            LineFrame.BorderSizePixel = 0
            LineFrame.BackgroundColor3 = LineProperties.Color
            LineFrame.Visible = LineProperties.Visible
            LineFrame.BackgroundTransparency = LineProperties.Transparency
            LineFrame.Parent = UI
            
            local UIFade = Instance.new("UIGradient",LineFrame)

            UIFade.Rotation = LineProperties.Rotation
            UIFade.Enabled = LineProperties.Fade.Enabled

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            LineProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            LineProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            LineProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Color") then
                        LineFrame.BackgroundColor3 = Value
                        LineProperties.Color = Value
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                    if (Property == "Thickness") then
                        --TODO
                        LineProperties.Thickness = Value
                    end
                    if (Property == "Transparency") then
                        LineFrame.BackgroundTransparency = Value
                        LineProperties.Transparency = Value
                    end

                    if (Property == "To") then
                        local To = Value
                        local Direction = (To - LineProperties.From);
                        local Center = (To + LineProperties.From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness);

                        LineProperties.To = To
                    end
                    if (Property == "From") then
                        local From = Value
                        local Direction = (LineProperties.To - From);
                        local Center = (LineProperties.To + From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineProperties.From = From
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            LineFrame:Destroy();
                        end)
                    end
                    
                    return LineProperties[Property]
                end)
            })
        end

        if (Type == "Square") then
            local SquareProperties = ({
                Thickness = 1,
                Size = Vector2new(),
                Position = Vector2new(),
                Filled = false,
                XAlign = "Left",
                YAlign = "Top",
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties);

            local SquareFrame = Instance.new("Frame");
            SquareFrame.AnchorPoint = Vector2new(0, 0);
            SquareFrame.BorderSizePixel = 0
            SquareFrame.Visible = false
            SquareFrame.Parent = UI
            local UIFade = Instance.new("UIGradient",SquareFrame)
            UIFade.Rotation = SquareProperties.Rotation
            UIFade.Enabled = SquareProperties.Fade.Enabled
            local UIOutline = Instance.new("UIStroke")
            UIOutline.Thickness = SquareProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = SquareFrame
            local UIFade2 = UIFade:Clone()
            UIFade2.Parent = UIOutline
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        --print(Value[1],Value[2],Value[3])
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            SquareProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            SquareProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            SquareProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Size") then
                        SquareFrame.Size = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Size = Value
                    end
                    if (Property == "Position") then
                        SquareFrame.Position = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Position = Value
                    end
                    if (Property == "Color") then
                        SquareFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        SquareProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if SquareProperties.Filled == true then
                            SquareFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        SquareProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            SquareFrame.Visible = true
                            if SquareProperties.Filled == true then
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                SquareFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            SquareFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        SquareProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if SquareProperties.Visible == true then
                            if Value == false then
                                SquareFrame.BackgroundTransparency = 1
                            else
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        SquareProperties.Filled = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            SquareFrame.AnchorPoint = Vector2new(0,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(0.5,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            SquareFrame.AnchorPoint = Vector2new(-1,SquareFrame.AnchorPoint.Y)
                        end
                        SquareProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, -1)
                        end
                        SquareProperties.YAlign = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            SquareFrame:Destroy();
                        end)
                    end
                    
                    return SquareProperties[Property]
                end)
            })
        end

        if (Type == "Image") then
            local ImageProperties = ({
                Data = "rbxassetid://848623155",
                Size = Vector2new(),
                Position = Vector2new(),
                Rounding = 0,
            });

            local ImageLabel = Instancenew("ImageLabel");

            ImageLabel.AnchorPoint = Vector2new(0.5, 0.5);
            ImageLabel.BorderSizePixel = 0
            ImageLabel.ScaleType = Enum.ScaleType.Stretch
            ImageLabel.Transparency = 1
            
            ImageLabel.Visible = false
            ImageLabel.Parent = UI

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        ImageLabel.Position = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Position = Value
                    end
                    if (Property == "Size") then
                        ImageLabel.Size = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Size = Value
                    end
                    if (Property == "Transparency") then
                        ImageLabel.ImageTransparency = Value
                        ImageProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        ImageLabel.Visible = Value
                        ImageProperties.Visible = Value
                    end
                    if (Property == "Color") then
                        ImageLabel.ImageColor3 = Value
                        ImageLabel.Color = Value
                    end
                    if (Property == "Data") then
                        ImageLabel.Image = Value
                        ImageProperties.Data = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            ImageLabel:Destroy();
                        end)
                    end
                    
                    return ImageLabel[Property]
                end)
            })
        end

        if (Type == "Circle") then -- will add later
            local CircleProperties = ({
                Radius = 50,
                Thickness = 1,
                Position = Vector2new(),
                Filled = false,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties);

            local CircleFrame = Instancenew("Frame");
            CircleFrame.AnchorPoint = Vector2new(0.5, 0.5);
            CircleFrame.BorderSizePixel = 0
            CircleFrame.Visible = false
            CircleFrame.Parent = UI
            CircleFrame.Size = UDim2new(0, 100, 0, 100);
            local UIOutline = Instancenew("UIStroke")
            UIOutline.Thickness = CircleProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = CircleFrame
            local UICorner = Instancenew("UICorner")
            UICorner.CornerRadius = UDim.new(1,0)
            UICorner.Parent = CircleFrame
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Radius") then
                        CircleFrame.Size = UDim2new(0, Value, 0, Value);
                        CircleProperties.Radius = Value
                    end
                    if (Property == "Thickness") then
                        UIOutline.Thickness = Value
                        CircleProperties.Thickness = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            CircleFrame.AnchorPoint = Vector2new(0,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(0.5,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            CircleFrame.AnchorPoint = Vector2new(-1,CircleFrame.AnchorPoint.Y)
                        end
                        CircleProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, -1)
                        end
                        CircleProperties.YAlign = Value
                    end
                    if (Property == "Position") then
                        local x = Value.X
                        local y = Value.Y
                        CircleFrame.Position = UDim2new(0, x, 0, y);
                        CircleProperties.Position = Value
                    end
                    if (Property == "Color") then
                        CircleFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        CircleProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if CircleProperties.Filled == true then
                            CircleFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        CircleProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            CircleFrame.Visible = true
                            if CircleProperties.Filled == true then
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                CircleFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            CircleFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        CircleProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if CircleProperties.Visible == true then
                            if Value == false then
                                CircleFrame.BackgroundTransparency = 1
                            else
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        CircleProperties.Filled = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            CircleFrame:Destroy();
                        end)
                    end
                    
                    return CircleProperties[Property]
                end)
            });
        end

        if (Type == "Quad") then -- will add later
            return setmetatable({}, {
                
            });
        end

    end
end
do
    Colorize.RGB = {}
    function Colorize.RGB:Darkness(color, factor)
        color.R = math.clamp(color.R * factor,0,255)
        color.G = math.clamp(color.G * factor,0,255)
        color.B = math.clamp(color.B * factor,0,255)
        return color
    end
end
gui["pages"] = {}
if guiPlacing.Name == "CoreGui" then
    gui.objs["NotifyCore"] = guiPlacing:WaitForChild("RobloxGui")
else
    gui.objs["NotifyCore"] = Instance.new("ScreenGui", guiPlacing)
end
gui.objs["NotifyCore"].ResetOnSpawn = false

gui.objs["Notify"] = Instance.new("Frame", gui.objs["NotifyCore"])
gui.objs["Notify"].BorderSizePixel = 1
gui.objs["Notify"].BorderColor3 = Color3.new(0,0,0)
gui.objs["Notify"].Position = UDim2.new(0, 50, 0, game:GetService("Workspace").CurrentCamera.ViewportSize.y - 150)
gui.objs["Notify"].Size = UDim2.new(0, 220, 0, 100)
gui.objs["Notify"].BackgroundColor3 = Color3.fromRGB(50,50,50)
gui.objs["Notify"].Visible = false

gui.objs["NotifyUp"] = Instance.new("Frame", gui.objs["Notify"])
gui.objs["NotifyUp"].Name = "Bar"
gui.objs["NotifyUp"].BorderSizePixel = 0
gui.objs["NotifyUp"].Size = UDim2.new(0, 220, 0, 10)
gui.objs["NotifyUp"].Position = UDim2.fromOffset(0, 0)
gui.objs["NotifyUp"].BackgroundColor3 = Color3.fromRGB(68,68,68)

gui.objs["NotifyTitle"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyTitle"].Name = "Title"
gui.objs["NotifyTitle"].BackgroundTransparency = 1
gui.objs["NotifyTitle"].TextSize = 7
gui.objs["NotifyTitle"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyTitle"].Text = "Title"
gui.objs["NotifyTitle"].Size = UDim2.new(0, 220, 0, 10)

gui.objs["NotifyText"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyText"].Name = "Text"
gui.objs["NotifyText"].BackgroundTransparency = 1
gui.objs["NotifyText"].TextSize = 10
gui.objs["NotifyText"].Text = "Text"
gui.objs["NotifyText"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyText"].Size = UDim2.new(0, 220, 0, 90)
gui.objs["NotifyText"].Position = UDim2.fromOffset(0, 10)

local notifyQueue = {}
local notifyCount = 0

function gui:Notify(Title,Text,time)
    notifyCount = notifyCount + 1
    gui.objs["NotifyTitle"].Text = Title or ""
    gui.objs["NotifyText"].Text = Text or ""
    gui.objs["Notify"].Visible = true
    spawn(function()
        wait(time or 3.5)
        gui.objs["Notify"].Visible = false
    end)
    --return true
end

--[[gui.objs["Gui"].Name = randomString(math.random(5,13))
game:GetService("RunService").RenderStepped:Connect(function()
    gui.objs["Gui"].Name = randomString(math.random(5,20))
end)]]

function gui:Modal(title, button1, button2)
    local selection = false
    local startup = {}
    startup["Frame"] = Instance.new("Frame")
    startup["Frame"].Parent = gui.objs["Gui"]
    startup["Frame"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame"].BorderSizePixel = 0
    startup["Frame"].Size = UDim2.new(0, 182, 0, 58)
    startup["Frame"].Position = UDim2.fromOffset(gui.objs["Gui"].AbsoluteSize.X/2-startup["Frame"].AbsoluteSize.X/2, gui.objs["Gui"].AbsoluteSize.Y/2-startup["Frame"].AbsoluteSize.Y/2)
    startup["UIStroke"] = Instance.new("UIStroke")
    startup["UIStroke"].Color = Color3.new(1,1,1)
    startup["UIStroke"].Thickness = 1
    startup["UIStroke"].Parent = startup["Frame"]
    startup["Title"] = Instance.new("TextLabel")
    startup["Title"].Name = "Title"
    startup["Title"].Parent = startup["Frame"]
    startup["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].BackgroundTransparency = 1.000
    startup["Title"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Title"].BorderSizePixel = 0
    startup["Title"].Size = UDim2.new(0, 181, 0, 15)
    startup["Title"].Font = Enum.Font.SourceSans
    startup["Title"].Text = " "..title
    startup["Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].TextSize = 14.000
    startup["Title"].TextXAlignment = Enum.TextXAlignment.Left
    startup["UIGradient"] = Instance.new("UIGradient")
    startup["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(184, 184, 184))}
    startup["UIGradient"].Rotation = -90
    startup["UIGradient"].Parent = startup["Title"]
    startup["UIGradient_2"] = Instance.new("UIGradient")
    startup["UIGradient_2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(186, 186, 186))}
    startup["UIGradient_2"].Rotation = 52
    startup["UIGradient_2"].Parent = startup["Frame"]
    startup["UIGradient_21"] = Instance.new("UIGradient")
    startup["UIGradient_21"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
    startup["UIGradient_21"].Rotation = 70
    startup["UIGradient_21"].Parent = startup["UIStroke"]
    startup["Frame_2"] = Instance.new("Frame")
    startup["Frame_2"].Parent = startup["Frame"]
    startup["Frame_2"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_2"].Position = UDim2.new(0, 10, 0, 23)
    startup["Frame_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_3"] = Instance.new("UIGradient")
    startup["UIGradient_3"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_3"].Rotation = -125
    startup["UIGradient_3"].Parent = startup["Frame_2"]
    startup["TextLabel"] = Instance.new("TextLabel")
    startup["TextLabel"].Parent = startup["Frame_2"]
    startup["TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].BackgroundTransparency = 1.000
    startup["TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel"].BorderSizePixel = 0
    startup["TextLabel"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel"].Font = Enum.Font.SourceSans
    startup["TextLabel"].Text = button1
    startup["TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].TextSize = 14.000
    startup["UIGradient_4"] = Instance.new("UIGradient")
    startup["UIGradient_4"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_4"].Rotation = -125
    startup["UIGradient_4"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_4"].Parent = startup["TextLabel"]
    startup["Frame_3"] = Instance.new("Frame")
    startup["Frame_3"].Parent = startup["Frame"]
    startup["Frame_3"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_3"].Position = UDim2.new(0, 96, 0, 23)
    startup["Frame_3"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_5"] = Instance.new("UIGradient")
    startup["UIGradient_5"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_5"].Rotation = -125
    startup["UIGradient_5"].Parent = startup["Frame_3"]
    startup["TextLabel_2"] = Instance.new("TextLabel")
    startup["TextLabel_2"].Parent = startup["Frame_3"]
    startup["TextLabel_2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].BackgroundTransparency = 1.000
    startup["TextLabel_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel_2"].BorderSizePixel = 0
    startup["TextLabel_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel_2"].Font = Enum.Font.SourceSans
    startup["TextLabel_2"].Text = button2
    startup["TextLabel_2"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].TextSize = 14.000
    startup["UIGradient_6"] = Instance.new("UIGradient")
    startup["UIGradient_6"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_6"].Rotation = -125
    startup["UIGradient_6"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_6"].Parent = startup["TextLabel_2"]

    local methodSelected = false

    local c1 = startup["Frame_2"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            methodSelected = true
        end
    end)

    local c2 = startup["Frame_3"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            selection = true
            methodSelected = true
        end
    end)

    repeat
        wait(0.05)
    until methodSelected
    
    
    c1:Disconnect()
    c2:Disconnect()
    startup["Frame"]:Destroy()

    return selection
end

if gui:Modal("Select startup method", "Default", "Secure") then
    _G.SecureMethod = "FullSecurity" 
end

--gui:Modal("Select startup method", "Default", "Secure")

gui.objs["Gui"].Enabled = false

gui:Notify("Info","Loading",1)

if _G.SecureMethod ~= "FullSecurity" then
    local VPFrame = Instance.new("ViewportFrame", gui.objs["Gui"])
    --VPFrame.Name = randomString(math.random(5,13))
    VPFrame.Size = UDim2.fromScale(1,1)
    VPFrame.CurrentCamera = game:GetService("Workspace").CurrentCamera or game:GetService("Workspace").Camera
    VPFrame.BackgroundTransparency = 1
end

gui.objs["AntiMissclick"] = Instance.new("TextButton", gui.objs["Gui"])
gui.objs["AntiMissclick"].Name = "Frame"
gui.objs["AntiMissclick"].Size = UDim2.new(0, 350, 0, 200)
gui.objs["AntiMissclick"].Position = UDim2.new(0, 250, 0, 250)
gui.objs["AntiMissclick"].BackgroundTransparency = 1
gui.objs["AntiMissclick"].Text = ""

gui.objs["MainFrame"] = Instance.new("Frame", gui.objs["AntiMissclick"])
gui.objs["MainFrame"].Name = "Frame"
--gui.objs["MainFrame"].BorderSizePixel = 1
--gui.objs["MainFrame"].BorderColor3 = Color3.new(0,0,0)
gui.objs["MainFrame"].Size = UDim2.new(0, 350, 0, 200)
gui.objs["MainFrame"].Position = UDim2.new(0, 250, 0, 250)
gui.objs["MainFrame"].BackgroundTransparency = 0
gui.objs["MainFrame"].BackgroundColor3 = Color3.fromRGB(100,100,100)

gui.objs["MenuOutline"] = Instance.new("UIStroke", gui.objs["MainFrame"])
gui.objs["MenuOutline"].Thickness = 1.5
gui.objs["MenuOutline"].Color = Color3.fromRGB(255,255,255)

gui.objs["MenuOutlineGradient"] = Instance.new("UIGradient", gui.objs["MenuOutline"])
gui.objs["MenuOutlineGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)) ,ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))}
gui.objs["MenuOutlineGradient"].Rotation = 180

gui.objs["PageFrame"] = Instance.new("Frame", gui.objs["MainFrame"])
gui.objs["PageFrame"].BorderSizePixel = 0
gui.objs["PageFrame"].Size = UDim2.new(0, 70, 0, 200)
gui.objs["PageFrame"].Position = UDim2.new(0, 0, 0, 0)
gui.objs["PageFrame"].BackgroundColor3 = Color3.fromRGB(68,68,68)

gui.objs["FunctionFrame"] = Instance.new("Frame", gui.objs["MainFrame"])
gui.objs["FunctionFrame"].BorderSizePixel = 0
gui.objs["FunctionFrame"].Position = UDim2.new(0, 70, 0, 0)
gui.objs["FunctionFrame"].Size = UDim2.new(0, 280, 0, 200)
gui.objs["FunctionFrame"].BackgroundColor3 = Color3.fromRGB(50,50,50)

gui.objs["ListSwitcher+"] = Instance.new("TextLabel", gui.objs["FunctionFrame"])
gui.objs["ListSwitcher+"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcher+"].Position = UDim2.fromOffset(256,178)
gui.objs["ListSwitcher+"].BackgroundColor3 = Color3.fromRGB(80,80,80)
gui.objs["ListSwitcher+"].Text = ">"
gui.objs["ListSwitcher+"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["ListSwitcher+"].BorderSizePixel = 0

gui.objs["ListSwitcherNum"] = Instance.new("TextLabel", gui.objs["ListSwitcher+"])
gui.objs["ListSwitcherNum"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcherNum"].Position = UDim2.fromOffset(-15,0)
gui.objs["ListSwitcherNum"].BackgroundTransparency = 1
gui.objs["ListSwitcherNum"].Text = "1"
gui.objs["ListSwitcherNum"].TextColor3 = Color3.fromRGB(255,255,255)

gui.objs["ListSwitcher-"] = Instance.new("TextLabel", gui.objs["ListSwitcher+"])
gui.objs["ListSwitcher-"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcher-"].Position = UDim2.fromOffset(-30,0)
gui.objs["ListSwitcher-"].BackgroundColor3 = Color3.fromRGB(80,80,80)
gui.objs["ListSwitcher-"].Text = "<"
gui.objs["ListSwitcher-"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["ListSwitcher-"].BorderSizePixel = 0

gui.objs["ListSwitcher+"].InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if gui.page[1] ~= nil then
            if gui["pages"][gui.page[1]]["Count"] ~= nil then
                local max = tonumber(gui["pages"][gui.page[1]]["Count"])
                local current = tonumber(gui.objs["ListSwitcherNum"].Text)
                if current < max then
                    current = current + 1
                    gui.objs["ListSwitcherNum"].Text = tostring(current)
                    gui.page[2] = current
                end
            end
        end
    end
end)

gui.objs["ListSwitcher-"].InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if gui.page[1] ~= nil then
            if gui["pages"][gui.page[1]]["Count"] ~= nil then
                local max = tonumber(gui["pages"][gui.page[1]]["Count"])
                local current = tonumber(gui.objs["ListSwitcherNum"].Text)
                if current-1 > 0 then
                    current = current - 1
                    gui.objs["ListSwitcherNum"].Text = tostring(current)
                    gui.page[2] = current
                end
            end
        end
    end
end)

local ActiveFunctions = {
    Enabled = false,
}
ActiveFunctions["active"] = {}
ActiveFunctions["list"] = {}
function ActiveFunctions:Create(Name,Text)
    Text = Text or Name
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = Text
    local Frame_2 = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    Frame.Parent = gui.objs["Gui"]
    Frame.AnchorPoint = Vector2.new(1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(1, 0, 0, 0)
    Frame.Size = UDim2.new(0, 48, 0, 26)
    Frame.Visible = false
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Size = UDim2.new(1, 0, 0.9, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 26.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0, 0, 0.9, 0)
    Frame_2.Size = UDim2.new(1, 0, 0.1, 0)
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(143, 143, 143))}
    UIGradient.Parent = Frame
    Frame.Size = UDim2.fromOffset(TextLabel.TextBounds.X,26)

    ActiveFunctions.list[Name] = {}
    ActiveFunctions.list[Name].ui = Frame
    ActiveFunctions.list[Name].size = TextLabel.TextBounds.X
    ActiveFunctions.list[Name].Enabled = false
end

spawn(function()
    gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
        local actives = {}
        for name, fn in pairs(ActiveFunctions.list) do
            if fn.Enabled == true and ActiveFunctions.Enabled then
                local ptr = #actives
                actives[ptr+1] = name
            else
                fn.ui.Visible = false
            end
        end
        
        local sorted = true
        while sorted do
            sorted = false
            for i = 2, #actives do
                if ActiveFunctions.list[actives[i]].size > ActiveFunctions.list[actives[i-1]].size then
                    sorted = true
                    local old = actives[i-1]
                    actives[i-1] = actives[i]
                    actives[i] = old
                end
            end
        end
        
        for num, name in pairs(actives) do
            ActiveFunctions.list[name].ui.Position = UDim2.new(1,0,0,(num-1)*26)
            ActiveFunctions.list[name].ui.Visible = true
        end
    end)
end)

function gui:ToggleListSwithcer(state)
    if typeof(state) == "boolean" then
        gui.objs["ListSwitcher+"].Visible = state
        return true
    else
        error("Cannot toggle list switcher, state is not bool")
        return false
    end
end

function gui:Page(Name)
    local obj = Instance.new("TextLabel", gui.objs["PageFrame"])
    gui["pages"][Name] = {}
    gui["pages"][Name]["Enabled"] = false
    gui["pages"][Name]["Functions"] = {}
    gui["pages"][Name]["Spots"] = {}
    gui["pages"][Name]["Exec"] = function()end
    gui["pages"][Name]["Count"] = 0
    --obj.Name = Name
    obj.Size = UDim2.fromOffset(70, 20)
    local pages = -1
    for _,_ in pairs(gui["pages"]) do
        pages = pages + 1
    end
    obj.Position = UDim2.fromOffset(0,20*pages)
    obj.Text = Name
    obj.BackgroundColor3 = Color3.fromRGB(68,68,68)
    obj.BorderSizePixel = 0
    obj.TextColor3 = Color3.fromRGB(150,150,150)
    obj.InputBegan:Connect(function(input)
	    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            gui.objs["ListSwitcherNum"].Text = "1"
            gui.page[2] = 1
            
            if gui.page[1] == Name then
                gui.page[1] = nil
            else
                gui.page[1] = Name
            end
            if typeof(gui["pages"][Name]["Exec"]) == "function" then
                pcall(gui["pages"][Name]["Exec"])
            else warn("call error") end
        end
    end)
    spawn(function()
        gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
            --obj.Name = randomString(math.random(5,13))
            if gui.page == Name then
                obj.TextColor3 = Color3.fromRGB(255,255,255)
                gui["pages"][Name]["Enabled"] = true
            else
                obj.TextColor3 = Color3.fromRGB(150,150,150)
                gui["pages"][Name]["Enabled"] = false
            end
        end)
    end)
end

function gui:Input(Page, Name, Text, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        --obj.Name = randomString(math.random(5,13))
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Input"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Text or ""

        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,60,0,15)
        obj.BorderSizePixel = 2
        obj.BackgroundColor3 = Color3.fromRGB(50,50,50)
        obj.BorderMode = Enum.BorderMode.Inset
        obj.BorderColor3 = Color3.fromRGB(100,100,100)
        local text = Instance.new("TextBox", obj)
        text.Size = UDim2.fromOffset(60,15)
        text.Position = UDim2.fromOffset(-2,-2)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Center
        text.TextSize = 8
        text.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
        text.TextColor3 = Color3.new(1,1,1)
        text.TextScaled = true
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = text.Text
            end)
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --obj.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:Button(Page, Name, Executable, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        --obj.Name = randomString(math.random(5,13))
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Button"
		if Executable ~= nil then
			if type(Executable) == "function" then
				gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = Executable
			else	
				gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = function()end
			end
		end
        
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,60,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(100,100,100)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(60,15)
        text.Position = UDim2.fromOffset(0,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Center
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                pcall(gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"])
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                obj.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:CheckBox(Page, Name, NumberInList, ManualActivate, AddFBar, FBarText)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if ManualActivate == nil then
            ManualActivate = false
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "CheckBox"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = ManualActivate
        gui["pages"][Page]["Functions"][NumberInList][Name]["Active"] = true
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,15,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        local check = Instance.new("Frame", obj)
        check.Size = UDim2.fromOffset(11,11)
        check.BorderSizePixel = 0
        check.Position = UDim2.fromOffset(2,2)
        check.Visible = false
        check.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(20,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and gui["pages"][Page]["Functions"][NumberInList][Name]["Active"] then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
                check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] 
            end
        end)
        if AddFBar then
            ActiveFunctions:Create(FBarText or Name)
        end
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if AddFBar then
                    ActiveFunctions.list[FBarText or Name].Enabled = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
                end
                --obj.Name = randomString(math.random(5,13))
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Active"] then
                    text.TextColor3 = Color3.new(1,1,1)
                else
                    text.TextColor3 = Color3.new(0.5,0.5,0.5)
                end
                
                check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] 
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    obj.Visible = true
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:Slider(Page, Name, Max, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Slider"
        gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = 0

        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,100,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local check = Instance.new("Frame", obj)
        check.Size = UDim2.fromOffset(0,15)
        check.BorderSizePixel = 0
        check.Position = UDim2.fromOffset(0,0)
        check.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(obj.AbsoluteSize.X,15)
        text.Position = UDim2.fromOffset(obj.AbsoluteSize.X+5,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        local num = Instance.new("TextLabel", obj)
        num.Size = UDim2.fromOffset(0,15)
        num.Position = UDim2.fromOffset(0,0)
        num.BackgroundTransparency = 1
        num.TextSize = 8
        num.TextXAlignment = Enum.TextXAlignment.Right
        num.Text = "0"
        text.TextColor3 = Color3.new(1,1,1)
        local state = {
            current = 0,
            max     = Max,
            enabled = false,
        }
        local holding = false
        spawn(function()
            local time = 0
            if _G.OptimizeMenu == true then time = 0.09 end
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
        
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                holding = true
            end
        end)
        obj.InputEnded:Connect(function()
            holding = false
        end)
        local firstDel = true
        gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
            --obj.Name = randomString(math.random(5,13))
            if num.Size ~= UDim2.fromOffset(check.AbsoluteSize.X,15) then
                num.Size = UDim2.fromOffset(check.AbsoluteSize.X,15)
            end
            if check.Size.X.Scale <= 0.05 then
                num.TextXAlignment = Enum.TextXAlignment.Left
            elseif num.TextXAlignment == Enum.TextXAlignment.Left then
                num.TextXAlignment = Enum.TextXAlignment.Right
            end
            if holding then
                local pos = math.clamp(mouse.X, obj.AbsolutePosition.X, obj.AbsolutePosition.X+obj.AbsoluteSize.X) - obj.AbsolutePosition.X
                local locMax = obj.AbsoluteSize.X
                local step = state.max/obj.AbsoluteSize.X
                state.current = math.floor(step*pos)
                check.Size = UDim2.new(pos/locMax,0,1,0)
                num.Text = state.current
            else
                if gui["pages"][Page]["Functions"][NumberInList][Name]["State"] ~= state.current then
                    state.current = gui["pages"][Page]["Functions"][NumberInList][Name]["State"]
                    num.Text = state.current
                    local step = state.max/obj.AbsoluteSize.X 
                    local pos = gui["pages"][Page]["Functions"][NumberInList][Name]["State"]/step
                    check.Size = UDim2.new(pos/obj.AbsoluteSize.X,0,1,0)
                end
            end
            gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = state.current
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:MultiDropDown(Page, Name, Params, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "MultiDropDown"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Items"] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params or {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local distance = 5
        local MainBar = Instance.new("Frame", gui.objs["FunctionFrame"])
        --MainBar.Name = Name
        MainBar.Size = UDim2.fromOffset(60,15)
        MainBar.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        MainBar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        MainBar.BorderSizePixel = 0
        local Label = Instance.new("TextLabel", MainBar)
        Label.Text = Name
        Label.Position = UDim2.fromOffset(65,0)
        Label.Size = UDim2.fromOffset(45,15)
        Label.TextSize = 8
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextColor3 = Color3.fromRGB(255,255,255)
        local BG = Instance.new("TextLabel", MainBar)
        BG.Name = Name
        BG.Size = UDim2.fromOffset(56,11)
        BG.Position = UDim2.fromOffset(2,2)
        BG.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        BG.BorderSizePixel = 0
        BG.TextXAlignment = Enum.TextXAlignment.Center
        BG.TextSize = 8
        BG.Text = ""
        BG.TextColor3 = Color3.new(1,1,1)
        local listt = {}
        local function showList(toggle)
            for _,panel in pairs(listt) do
                panel.Visible = toggle
            end
        end
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == false then
                    for _,v in pairs(listt) do
                        v:Destroy()
                    end
                    listt = {}
                    local count = 0
                    for _i,v in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"]) do
                        count = count + 1
                        local namee = ""
                        namee = _i
                        local Panel = Instance.new("TextLabel", MainBar)
                        Panel.Name = count
                        Panel.Size = UDim2.fromOffset(60,15)
                        Panel.Position = UDim2.fromOffset(0,15+(((count-1)*15)-(1*count-1)))
                        Panel.Visible = false
                        Panel.BorderSizePixel = 1
                        Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                        for _pos,_name in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
                            if _name == namee then
                                Panel.BackgroundColor3 = Color3.fromRGB(130,130,130)
                            end
                        end
                        Panel.BorderColor3 = Color3.new(0,0,0)
                        Panel.BorderMode = Enum.BorderMode.Inset
                        Panel.Text = count..". "..namee
                        Panel.TextSize = 8
                        Panel.TextScaled = true
                        Panel.TextXAlignment = Enum.TextXAlignment.Center
                        Panel.TextColor3 = Color3.new(1,1,1)
                        Panel.ZIndex = 10
                        
                        Panel.InputBegan:Connect(function(input)
                            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                                if not gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] then
                                    gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] = {Panel.Name, v}
                                    Panel.BackgroundColor3 = Color3.fromRGB(130,130,130)
                                else
                                    gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] = nil
                                    Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                                end
                            end
                        end)
                        listt[count] = Panel
                    end
                end
            end)
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --MainBar.Name = randomString(math.random(5,13))
                local count = 0
                local txt = ""
                for name,val in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
                    count = count + 1
                    txt = txt .. val[1]..", "
                end
                if count == 0 then
                    BG.Text = ""
                else
                    txt = txt:sub(1,#txt-2)
                    BG.Text = txt
                end
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    MainBar.Visible = true
                else
                    MainBar.Visible = false
                end
            end)
        end)
        MainBar.InputBegan:Connect(function(input)
            local connection = nil
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == true then
                    connection = game:GetService("UserInputService").InputBegan:Connect(function(i)
                        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.MouseButton2 then
                            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                            if mouse.X < MainBar.AbsolutePosition.X and mouse.Y < MainBar.AbsolutePosition.Y and mouse.X > MainBar.AbsolutePosition.X + MainBar.AbsoluteSize.X and mouse.Y > MainBar.AbsolutePosition.Y + MainBar.AbsoluteSize.Y then
                                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
                                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
                                --print("closing")
                                connection:Disconnect()
                            end
                        end
                    end)
                end
                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
            end
        end)
    end
end

function gui:DropDown(Page, Name, Params, NumberInList, Default)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if Default == nil then
            Default = ""
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "DropDown"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Item"] = Default
        gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params or {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local distance = 5
        local MainBar = Instance.new("Frame", gui.objs["FunctionFrame"])
        --MainBar.Name = Name
        MainBar.Size = UDim2.fromOffset(60,15)
        MainBar.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        MainBar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        MainBar.BorderSizePixel = 0
        local Label = Instance.new("TextLabel", MainBar)
        Label.Text = Name
        Label.Position = UDim2.fromOffset(65,0)
        Label.Size = UDim2.fromOffset(45,15)
        Label.TextSize = 8
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextColor3 = Color3.fromRGB(255,255,255)
        local BG = Instance.new("TextLabel", MainBar)
        BG.Name = Name
        BG.Size = UDim2.fromOffset(56,11)
        BG.Position = UDim2.fromOffset(2,2)
        BG.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        BG.BorderSizePixel = 0
        BG.TextXAlignment = Enum.TextXAlignment.Center
        BG.TextSize = 8
        BG.Text = ""
        BG.TextColor3 = Color3.new(1,1,1)
        local listt = {}
        local function showList(toggle)
            for _,panel in pairs(listt) do
                panel.Visible = toggle
            end
        end
        spawn(function ()
            while wait(0.1) do
                if not gui.Loaded then break end
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == false then
                    for _,v in pairs(listt) do
                        v:Destroy()
                    end
                    listt = {}
                    for _i,v in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"]) do
                        local Panel = Instance.new("TextLabel", MainBar)
                        Panel.Size = UDim2.fromOffset(60,15)
                        Panel.Position = UDim2.fromOffset(0,15+(((_i-1)*15)-(1*_i-1)))
                        Panel.Visible = false
                        Panel.BorderSizePixel = 1
                        Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                        Panel.BorderColor3 = Color3.new(0,0,0)
                        Panel.BorderMode = Enum.BorderMode.Inset
                        Panel.Text = tostring(v)
                        Panel.TextSize = 8
                        Panel.TextScaled = true
                        Panel.TextXAlignment = Enum.TextXAlignment.Center
                        Panel.TextColor3 = Color3.new(1,1,1)
                        Panel.ZIndex = 10
                        Panel.InputBegan:Connect(function(input)
                            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                                gui["pages"][Page]["Functions"][NumberInList][Name]["Item"] = tostring(v)
                                showList(false)
                            end
                        end)
                        listt[_i] = Panel
                    end
                end
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --MainBar.Name = randomString(math.random(5,13))
                BG.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Item"]
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    MainBar.Visible = true
                else
                    MainBar.Visible = false
                end
            end)
        end)
        MainBar.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
            end
        end)
    end
end

function gui:Paragraph(Page, Name, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Paragraph"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Name
        local distance = 5
        local text = Instance.new("TextLabel", gui.objs["FunctionFrame"])
        --text.Name = Name
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                text.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
                --text.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    text.Visible = true
                else
                    text.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:PlayerSpot(Page, Name, Type, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        --[[
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        --]]
        if gui["pages"][Page]["Spots"][NumberInList] == nil then
            gui["pages"][Page]["Spots"][NumberInList] = {}
        end
        --[[
        for _,_ in pairs(gui["pages"][Page]["Spots"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        --]]
        if Type == nil then
            Type = "R15"
        end
        gui["pages"][Page]["Spots"][NumberInList][Name] = {}
        gui["pages"][Page]["Spots"][NumberInList][Name]["Type"] = "Spot"
        gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "Head"
        local localBone = "Head"
        local distance = 5
        local Main = Instance.new("Frame", gui.objs["FunctionFrame"])
        Main.Name = Name
        Main.Size = UDim2.fromOffset(100,170)
        Main.Position = UDim2.fromOffset(180,13)
        Main.BackgroundTransparency = 1
        local Head = Instance.new("Frame", Main)
        Head.Size = UDim2.fromOffset(26,26)
        Head.Position = UDim2.fromOffset(37,0)
        Head.BackgroundTransparency = 0
        Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
        Head.BorderSizePixel = 0
        local HumanoidRootPart = Instance.new("Frame", Main)
        HumanoidRootPart.Size = UDim2.fromOffset(26,40)
        HumanoidRootPart.Position = UDim2.fromOffset(37,28)
        HumanoidRootPart.BackgroundTransparency = 0
        HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(100,100,100)
        HumanoidRootPart.BorderSizePixel = 0
        local LeftArm = Instance.new("Frame", Main)
        LeftArm.Size = UDim2.fromOffset(12,40)
        LeftArm.Position = UDim2.fromOffset(23,28)
        LeftArm.BackgroundTransparency = 0
        LeftArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
        LeftArm.BorderSizePixel = 0
        local RightArm = Instance.new("Frame", Main)
        RightArm.Size = UDim2.fromOffset(12,40)
        RightArm.Position = UDim2.fromOffset(65,28)
        RightArm.BackgroundTransparency = 0
        RightArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RightArm.BorderSizePixel = 0
        local LeftLeg = Instance.new("Frame", Main)
        LeftLeg.Size = UDim2.fromOffset(12,40)
        LeftLeg.Position = UDim2.fromOffset(37,70)
        LeftLeg.BackgroundTransparency = 0
        LeftLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        LeftLeg.BorderSizePixel = 0
        local RightLeg = Instance.new("Frame", Main)
        RightLeg.Size = UDim2.fromOffset(12,40)
        RightLeg.Position = UDim2.fromOffset(51,70)
        RightLeg.BackgroundTransparency = 0
        RightLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RightLeg.BorderSizePixel = 0
        local function deSelectAll()
            Head.BackgroundColor3 = Color3.fromRGB(100,100,100)
            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(100,100,100)
            LeftArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
            RightArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
            LeftLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
            RightLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        end
        spawn(function()
            while wait(0.1) do
                if not gui.Loaded then break end
                local bone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
                if localBone ~= bone then
                    if bone == "Head" then
                        deSelectAll()
                        Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "HumanoidRootPart" then
                        deSelectAll()
                        HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "LeftLowerArm" or bone == "LeftArm" then
                        deSelectAll()
                        LeftArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "RightLowerArm" or bone == "RightArm" then
                        deSelectAll()
                        RightArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "LeftLowerLeg" or bone == "LeftLeg" then
                        deSelectAll()
                        LeftLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "RightLowerLeg" or bone == "RightLeg" then
                        deSelectAll()
                        RightLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    end
                end
            end
        end)
        Head.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "Head"
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        HumanoidRootPart.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "HumanoidRootPart"
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        LeftArm.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLowerArm"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftArm"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            LeftArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        RightArm.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLowerArm"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightArm"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            RightArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        LeftLeg.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLowerLeg"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLeg"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            LeftLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        RightLeg.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLowerLeg"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLeg"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            RightLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    Main.Visible = true
                else
                    Main.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:ColorSelector(Page, Name, NumberInList, DefaultColor)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if DefaultColor == nil then
            DefaultColor = Color3.fromRGB(0,0,0)
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "ColorSelector"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Color"] = DefaultColor
        gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"] = false
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local function rgb_to_hsv(r, g, b)
            r, g, b = (r / 255), (g / 255), (b / 255)
            local mx = math.max(r, g, b)
            local mn = math.min(r, g, b)
            local h, s
         
            if mx == mn then
                h = 0
            d = 0
            else
            local d = mx - mn
                if     mx == r then h = (g - b) / d + (g < b and 6 or 0)
                elseif mx == g then h = (b - r) / d + 2
                elseif mx == b then h = (r - g) / d + 4 end
                h = h / 6
            end
            s = (mx == 0) and 0 or (d / mx)
         
            return h, s, mx
        end
        local function hsvToRgb(h, s, v)
            local hi = math.floor(h * 6)
            local f = h * 6 - hi
            local p = v * (1 - s)
            local q = v * (1 - f * s)
            local t = v * (1 - (1 - f) * s)
            local r
            local g
            local b
            
            if hi == 0 then
                r, g, b = v, t, p
            elseif hi == 1 then
                r, g, b = q, v, p
            elseif hi == 2 then
                r, g, b = p, v, t
            elseif hi == 3 then
                r, g, b = p, q, v
            elseif hi == 4 then
                r, g, b = t, p, v
            elseif hi == 5 then
                r, g, b = v, p, q
            end
            
            local a, b = pcall(function()
                r = math.floor(r * 255)
                g = math.floor(g * 255)
                b = math.floor(b * 255)
            end)
            if not a then
                return 0,0,0
            end
        
            return r, g, b
        end

        local Hue, Saturation, Value = rgb_to_hsv(DefaultColor.R, DefaultColor.G, DefaultColor.B)
        gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"] = {H=Hue, S=Saturation, V=Value}
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,15,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(0,0,0)
        local gearImage = Instance.new("ImageLabel", obj)
        gearImage.Size = UDim2.fromScale(1,1)
        gearImage.BorderSizePixel = 0
        gearImage.Position = UDim2.fromOffset(0,0)
        gearImage.Visible = true
        gearImage.BackgroundTransparency = 1
        gearImage.Image = "http://www.roblox.com/asset/?id=14562134132"
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(20,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        local HueMul = 0.71030640668523676880222841225627
        local SelectBG = Instance.new("Frame", obj)
        SelectBG.Position = UDim2.fromOffset(20,0)
        SelectBG.Size = UDim2.fromOffset(157,148)
        SelectBG.BackgroundColor3 = Color3.fromRGB(68,68,68)
        SelectBG.BorderSizePixel = 0
        SelectBG.ZIndex = 2
        SelectBG.Visible = false
        local ColorSelector = {
            Main = Instance.new("Frame", SelectBG),
            HueGradient = Instance.new("UIGradient"),
            SaturationFrame = Instance.new("Frame"),
            SaturationGradient = Instance.new("UIGradient")
        }
        ColorSelector.HueGradient.Parent = ColorSelector.Main
        ColorSelector.SaturationFrame.Parent = ColorSelector.Main
        ColorSelector.SaturationGradient.Parent = ColorSelector.SaturationFrame

        ColorSelector.Main.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ColorSelector.Main.Position = UDim2.fromOffset(9,7)
        ColorSelector.Main.Size = UDim2.fromOffset(124,118)
        ColorSelector.Main.BorderSizePixel = 0
        ColorSelector.Main.ZIndex = 3

        ColorSelector.HueGradient.Color = ColorSequence.new{ 
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)), 
            ColorSequenceKeypoint.new(1/6*1, Color3.fromRGB(255,0,255)),
            ColorSequenceKeypoint.new(1/6*2, Color3.fromRGB(0,0,255)),
            ColorSequenceKeypoint.new(1/6*3, Color3.fromRGB(0,255,255)),
            ColorSequenceKeypoint.new(1/6*4, Color3.fromRGB(0,255,0)),
            ColorSequenceKeypoint.new(1/6*5, Color3.fromRGB(255,255,0)), 
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0)),
        }

        ColorSelector.SaturationFrame.Size = UDim2.fromScale(1,1)
        ColorSelector.SaturationFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ColorSelector.SaturationFrame.BorderSizePixel = 0
        ColorSelector.SaturationFrame.ZIndex = 3
        ColorSelector.SaturationGradient.Rotation = -90
        ColorSelector.SaturationGradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        }

        local ValueSelector = {
            Main = Instance.new("Frame", SelectBG),
            Gradient = Instance.new("UIGradient")
        }
        ValueSelector.Gradient.Parent = ValueSelector.Main
        
        ValueSelector.Main.BackgroundColor3 = DefaultColor
        ValueSelector.Main.Size = UDim2.fromOffset(8,117)
        ValueSelector.Main.Position = UDim2.fromOffset(140,7)
        ValueSelector.Main.BorderSizePixel = 0
        ValueSelector.Main.ZIndex = 3

        ValueSelector.Gradient.Rotation = 90
        ValueSelector.Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
            ColorSequenceKeypoint.new(1,Color3.new(0,0,0))
        }

        local RainbowCheck = {
            Main = Instance.new("Frame", SelectBG),
            Check = Instance.new("Frame"),
            Text = Instance.new("TextLabel")
        }
        RainbowCheck.Check.Parent = RainbowCheck.Main
        RainbowCheck.Text.Parent = RainbowCheck.Main
        
        RainbowCheck.Main.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        RainbowCheck.Main.Position = UDim2.fromOffset(9,130)
        RainbowCheck.Main.Size = UDim2.fromOffset(12,12)
        RainbowCheck.Main.BorderSizePixel = 0
        RainbowCheck.Main.ZIndex = 3

        RainbowCheck.Check.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RainbowCheck.Check.Size = UDim2.fromOffset(8,8)
        RainbowCheck.Check.Position = UDim2.fromOffset(2,2)
        RainbowCheck.Check.Visible = false
        RainbowCheck.Check.BorderSizePixel = 0
        RainbowCheck.Check.ZIndex = 3

        RainbowCheck.Text.BackgroundTransparency = 1
        RainbowCheck.Text.Position = UDim2.fromOffset(17,0)
        RainbowCheck.Text.Size = UDim2.fromOffset(1,12)
        RainbowCheck.Text.Text = "Rainbow"
        RainbowCheck.Text.TextColor3 = Color3.new(1,1,1)
        RainbowCheck.Text.TextSize = 8
        RainbowCheck.Text.TextXAlignment = Enum.TextXAlignment.Left
        RainbowCheck.Text.ZIndex = 3

        RainbowCheck.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"]
                RainbowCheck.Check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"]
            end
        end)
        local selectingSaturation = false
        ValueSelector.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                selectingSaturation = true
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                repeat
                    local ry = ValueSelector.Main.AbsoluteSize.Y - math.clamp(mouse.Y - ValueSelector.Main.AbsolutePosition.Y, 0, ValueSelector.Main.AbsoluteSize.Y)
                    local stepY = 255/ValueSelector.Main.AbsoluteSize.Y
                    local newV = math.floor(ry*stepY)
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"] = newV
                    wait()
                until not selectingSaturation
            end
        end)
        ValueSelector.Main.InputEnded:Connect(function(input)
            selectingSaturation = false
        end)

        local selectingColor = false
        ColorSelector.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                selectingColor = true
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                repeat
                    local rx = ColorSelector.Main.AbsoluteSize.X - math.clamp(mouse.X - ColorSelector.Main.AbsolutePosition.X, 0, ColorSelector.Main.AbsoluteSize.X)
                    local ry = ColorSelector.Main.AbsoluteSize.Y - math.clamp(mouse.Y - ColorSelector.Main.AbsolutePosition.Y, 0, ColorSelector.Main.AbsoluteSize.Y)
                    local stepX = 255/ColorSelector.Main.AbsoluteSize.X
                    local stepY = 255/ColorSelector.Main.AbsoluteSize.Y
                    local newH = math.floor(rx*stepX)
                    local newS = math.floor(ry*stepY)
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"] = newH
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"] = newS
                    wait()
                until not selectingColor
            end
        end)

        ColorSelector.Main.InputEnded:Connect(function(input)
            selectingColor = false
        end)

        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                SelectBG.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == true then
                    game:GetService("TweenService"):Create(gearImage, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Rotation = 180}):Play()
                    spawn(function()
                        wait(0.7)
                        --gearImage.Rotation = 0
                    end)
                    
                else
                    game:GetService("TweenService"):Create(gearImage, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Rotation = 0}):Play()
                end
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                local r,g,b = hsvToRgb(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"]/255)
                obj.BackgroundColor3 = Color3.fromHSV(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"]/255)
                gui["pages"][Page]["Functions"][NumberInList][Name]["Color"] = obj.BackgroundColor3
                ValueSelector.Main.BackgroundColor3 = Color3.fromHSV(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,1,1)
                
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    obj.Visible = true
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:BindButton(Page, Name, Bind, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        --obj.Name = randomString(math.random(5,13))
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Button"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Bind"] = Bind or ""
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,60,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(100,100,100)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(60,15)
        text.Position = UDim2.fromOffset(0,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Center
        text.TextSize = 8
        text.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Bind"]
        text.TextColor3 = Color3.new(1,1,1)
        local text2 = Instance.new("TextLabel", obj)
        text2.Size = UDim2.fromOffset(75,15)
        text2.Position = UDim2.fromOffset(20,0)
        text2.BackgroundTransparency = 1
        text2.TextXAlignment = Enum.TextXAlignment.Left
        text2.TextSize = 8
        text2.Text = Name
        text2.TextColor3 = Color3.new(1,1,1)
        local binding = false

        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                binding = true
                text.Text = "..."
            end
        end)

        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if binding then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    gui["pages"][Page]["Functions"][NumberInList][Name]["Bind"] = input.KeyCode
                    text.Text = tostring(input.KeyCode)
                    binding = false
                end
            end
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:IsExist(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    if gui["pages"][Page]["Functions"][NumberInList] ~= nil then
        return gui["pages"][Page]["Functions"][NumberInList][Name] ~= nil
    else
        return false
    end
end

function gui:SetIsChecked(Page, Name, Value, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = Value
end

function gui:IsChecked(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    local ret;
    xpcall(function() 
        ret = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
    end, function()
        ret = false
    end)
    return ret
end

function gui:IsOpened(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
end

function gui:IsItemSelected(Page, Name, ItemName, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    local selected = false
    for _i,_ in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
        if _i == ItemName then
            selected = true
        end
    end
    return selected
end

function gui:GetState(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["State"]
end

function gui:SetState(Page, Name, Value, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = Value
end

function gui:GetDropItem(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Item"]
end

function gui:GetDropSelectedItems(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]
end

function gui:GetSelectedBone(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
end

function gui:SetText(Page, Name, Text, NumberInList)
	if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Text
end

function gui:SetButtonExec(Page, Name, Exec, NumberInList)
	if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = Exec
end

function gui:SetPageExec(Page, Exec)
    gui["pages"][Page]["Exec"] = Exec
end

function gui:SetList(Page, Name, Params, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params
end

function gui:GetText(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
end

function gui:GetColor(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Color"]
end

function gui:SetActive(Page, Name, State, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Active"] = State
end

gui:Page("Aimbot")
gui:PlayerSpot("Aimbot", "AimHitbox")
gui:CheckBox("Aimbot", "Enabled", nil, nil, true, "Aimbot")
--gui:BindButton("Aimbot", "Enabled", Bind, NumberInList)
gui:CheckBox("Aimbot", "Semi-Silent", nil, nil, true, "Semi-Silent")
gui:CheckBox("Aimbot", "Instant")
gui:CheckBox("Aimbot", "Wall check")
gui:CheckBox("Aimbot", "Team check")
gui:CheckBox("Aimbot", "Auto shoot")
gui:CheckBox("Aimbot", "Player lock")
gui:CheckBox("Aimbot", "Predict")
gui:CheckBox("Aimbot", "Hitscan")
gui:Slider("Aimbot", "Smooth", 10, 2)
gui:Slider("Aimbot", "Predict ", 50, 2)
gui:Slider("Aimbot", "FoV", 3600, 2)
gui:Slider("Aimbot", "Auto shoot delay", 30, 2)
gui:CheckBox("Aimbot", "Player aimbot", 2, true)
gui:CheckBox("Aimbot", "Entity aimbot", 2)
gui:MultiDropDown("Aimbot", "Entities", {}, 2)
gui:CheckBox("Aimbot", "Offset mode", 2)
gui:Slider("Aimbot", "X ", 30, 2)
gui:Slider("Aimbot", "Y ", 30, 3)
gui:CheckBox("Aimbot", "Manual Hitbox", 3)
gui:DropDown("Aimbot", "Hitboxes", {}, 3, "")

gui:Page("Visuals")
gui:CheckBox("Visuals", "Enabled")
gui:Paragraph("Visuals", "Aimbot ")
gui:CheckBox("Visuals", "FoV")
gui:Paragraph("Visuals", "Visuals")
gui:CheckBox("Visuals", "Team check", nil, nil, true)--
gui:CheckBox("Visuals", "Team")--
gui:CheckBox("Visuals", "Box", nil, nil, true)
gui:CheckBox("Visuals", "Lines", nil, nil, true)
gui:CheckBox("Visuals", "Offscreen pointers", nil, nil, true)
gui:CheckBox("Visuals", "Nametags", 2, nil, true)
gui:CheckBox("Visuals", "Health", 2, nil, true)--
gui:CheckBox("Visuals", "Health bar", 2, nil, true)--
gui:CheckBox("Visuals", "Weapon", 2, nil, true)--
gui:CheckBox("Visuals", "Distance", 2, nil, true)--
gui:CheckBox("Visuals", "Chams", 2, nil, true)
gui:DropDown("Visuals", "Type", {"Outline", "Fill"}, 2, "Fill")
gui:Paragraph("Visuals", "HUD Visuals", 2)
gui:CheckBox("Visuals", "Crosshair", 2)
gui:Slider("Visuals", "Crosshair size", 20, 3)
gui:ColorSelector("Visuals", "Crosshair color", 3, Color3.fromRGB(255, 255, 255))
gui:DropDown("Visuals", "Crosshair type", {"+", "×", "т"}, 3, "+")--1
gui:Paragraph("Visuals", "Local Visuals", 3)--2
gui:CheckBox("Visuals", "Chams", 3, nil, true)--3
gui:Slider("Visuals", "Transparency ", 100, 3)--4
gui:ColorSelector("Visuals", "Color ", 3, Color3.fromRGB(0,0,0))--5
--gui:CheckBox("Visuals", "Real chams", 3, nil, true)--6
--gui:Slider("Visuals", "Transparency  ", 100, 3)--7
--gui:ColorSelector("Visuals", "Color  ", 4, Color3.fromRGB(0,0,0))--8
if game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true) then
    gui:Paragraph("Visuals", "--MM2--", 4)
    gui:CheckBox("Visuals", "Roles", 4, nil, true)
    gui:CheckBox("Visuals", "Highlight roles", 4, nil, true)
    gui:CheckBox("Visuals", "Gun esp", 4, nil, true)
    gui:CheckBox("Visuals", "Shoot tracer", 4, nil, true)
    gui:CheckBox("Visuals", "Bullet impacts", 4, nil, true)
    gui:Paragraph("Visuals", "-------", 4)
end


gui:Page("Player")
gui:Slider("Player", "Speed", 20)
gui:Slider("Player", "Airboost speed", 3)
gui:CheckBox("Player", "Airboost", nil, nil, true)

gui:Page("Misc")
gui:Button("Misc", "Unload")
gui:CheckBox("Misc", "Bhop")
gui:Slider("Misc", "FoV", 120)
gui:CheckBox("Misc", "Third person")
gui:Slider("Misc", "Distance  ", 50)
gui:DropDown("Misc", "Fling Target", {})
gui:CheckBox("Misc", "Fling")
gui:DropDown("Misc", "Skybox", {"None", "Afternoon sky", "Morning sky", "Clouded sky", "Floodplain river", "Deep blue sky", "Deep space 1", "Deep space 2", "Nebula", "Frozen lake", "Winter", "Green screen"}, 1, "None")
if game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true) then
    gui:Paragraph("Misc", "--MM2--", 2)
    gui:CheckBox("Misc", "Tp players", 2)
    gui:DropDown("Misc", "Target player", {"Murderer", "Sheriff", "All"}, 2)
    gui:CheckBox("Misc", "Grab gun", 2)
    gui:CheckBox("Misc", "No fps decrease", 2)
    gui:CheckBox("Misc", "Coin grabber", 2)
end


gui:Page("HvH")
gui:CheckBox("HvH", "Backtrack", nil, nil, true)--
gui:Slider("HvH", "Backtrack Size", 10)
gui:CheckBox("HvH", "Fakelag", nil, nil, true) gui:SetActive("HvH", "Fakelag", false)
gui:Slider("HvH", "Factor ", 30)
gui:CheckBox("HvH", "Anti-Aim", nil, nil, true)
gui:DropDown("HvH", "Pitch", {"Down","Up","Front","Default"})
gui:DropDown("HvH", "Yaw", {"Backwards", "Sideways", "Random", "Front", "Lock"--[[, "Jitter"]], "Zero", "Spin", "Frik","Default"})
gui:Slider("HvH", "Jitter", 180, 1)
gui:CheckBox("HvH", "Random Jitter", 1)
gui:Slider("HvH", "Spin Speed", 360, 2)
gui:CheckBox("HvH", "Left sided", 2)
gui:CheckBox("HvH", "Wallshot", 2) gui:SetActive("HvH", "Wallshot", false, 2)

gui:Page("Configs")
gui:Button("Configs", "Load")
gui:Button("Configs", "Save")
gui:Button("Configs", "Create")
gui:Input("Configs", "Config name")
gui:Button("Configs", "Update list")
gui:DropDown("Configs", "Config")

gui:Page("Colors")
gui:Paragraph("Colors", "Visuals", 1)
gui:ColorSelector("Colors", "Esp color", 1, Color3.fromRGB(0,0,0))
gui:ColorSelector("Colors", "Chams color", 1, Color3.fromRGB(0,0,0))
gui:Slider("Colors", "Chams transparency", 100, 1)
gui:Slider("Colors", "ESP Size", 22, 1)
gui:Paragraph("Colors", "Menu", 1)
gui:CheckBox("Colors", "Function List")
gui:Slider("Colors", "Background transparency", 100, 1)

gui:Page("Lua")
--gui:Paragraph("Lua", "Soon")
gui:SetState("Colors", "ESP Size", 12)

gui:Page("Debugging")
gui:Paragraph("Debugging","freeRAM")
gui:Paragraph("Debugging","processedDatamodels")
gui:Paragraph("Debugging","renderInst")
gui:CheckBox("Debugging","Bounding boxes")
gui:CheckBox("Debugging","Show joints XYZ")
gui:CheckBox("Debugging","Show model tree")
gui:CheckBox("Debugging","Use legacy CSG")
gui:CheckBox("Debugging","Show assemblies")
gui:CheckBox("Debugging","Show NET owners")
gui:CheckBox("Debugging","Show anchors",2)
gui:CheckBox("Debugging","Show mechanisms",2)
gui:CheckBox("Debugging","Script stack tracing",2)
wait(1)

pcall(function()
    if gui["pages"]["Configs"]["Functions"][1]["Config"]["Opened"] == false then
        local list = {}
        for _,v in pairs(listfiles("")) do
            if v:sub(#v-4,#v) == ".scfg" then
                list[#list+1] = v:sub(1,#v-5)
            end
        end
        gui:SetList("Configs", "Config", list)
    end
end)

gui:SetButtonExec("Configs", "Update list", function()
    if gui["pages"]["Configs"]["Functions"][1]["Config"]["Opened"] == false then
        local list = {}
        for _,v in pairs(listfiles("")) do
            if v:sub(#v-4,#v) == ".scfg" then
                list[#list+1] = v:sub(1,#v-5)
            end
        end
        gui:SetList("Configs", "Config", list)
    end
end)

gui:SetButtonExec("Configs", "Create", function()
    if gui:GetText("Configs", "Config name") ~= "" then
        writefile(gui:GetText("Configs", "Config name")..".scfg", "")
    end
end)

gui:SetButtonExec("Configs", "Load", function()
    local HttpService = game:GetService("HttpService")
    if gui:GetDropItem("Configs", "Config") ~= "" then
        local loadedData = readfile(gui:GetDropItem("Configs", "Config")..".scfg")
        local config = {}
        config = HttpService:JSONDecode(loadedData)
        local a,b = pcall(function()
            for pageName,page in pairs(config) do
                for num,func in pairs(page["Functions"]) do
                    for paramName,param in pairs(func) do
                        pcall(function()
                            if param["Type"] == "CheckBox" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Enabled"] = param["Enabled"]
                            end
                            if param["Type"] == "Slider" then
                                gui["pages"][pageName]["Functions"][num][paramName]["State"] = param["State"]
                            end
                            if param["Type"] == "DropDown" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Item"] = param["Item"]
                            end
                            if param["Type"] == "MultiDropDown" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Items"] = param["Items"]
                            end
                            if param["Type"] == "ColorSelector" then
                                --print("set",paramName,"to",param["H"])
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["H"] = param["ColorHSV"]["H"]
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["S"] = param["ColorHSV"]["S"]
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["V"] = param["ColorHSV"]["V"]
                                gui["pages"][pageName]["Functions"][num][paramName]["Color"] = param["Color"]
                            end
                        end)
                    end
                end
                for num,spot in pairs(page["Spots"]) do
                    for paramName,param in pairs(spot) do
                        pcall(function()
                            if param["Type"] == "Spot" then
                                gui["pages"][pageName]["Spots"][num][paramName]["Bone"] = param["Bone"]
                            end
                        end)
                    end
                end
            end
        end)
        if not a then
            --print(b)
        end
    end
end)

gui:SetButtonExec("Configs", "Save", function()
    local HttpService = game:GetService("HttpService")
    local toSave = {}--gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"]
    local counter = 0
    local line = 0
    

    local data = HttpService:JSONEncode(gui["pages"])
    --print(data)
    if gui:GetDropItem("Configs", "Config") ~= "" then
        writefile(gui:GetDropItem("Configs", "Config")..".scfg", data)
    end
end)

------------------------------------------  ██▓      █    ██  ▄▄▄      -----------------------------------------
-----------------------------------------   ▓██▒     ██  ▓██▒▒████▄     ---------------------------------------
----------------------------------------    ▒██░    ▓██  ▒██░▒██  ▀█▄    --------------------------------------
---------------------------------------     ▒██░    ▓▓█  ░██░░██▄▄▄▄██    -------------------------------------
--------------------------------------      ░██████▒▒▒█████▓  ▓█   ▓██▒    ------------------------------------
---------------------------------------     ░ ▒░▓  ░░▒▓▒ ▒ ▒  ▒▒   ▓▒█░   -------------------------------------
----------------------------------------    ░ ░ ▒  ░░░▒░ ░ ░   ▒   ▒▒ ░  --------------------------------------
-----------------------------------------     ░ ░    ░░░ ░ ░   ░   ▒    ---------------------------------------
------------------------------------------      ░  ░   ░           ░  ░----------------------------------------

local LuaPage = Instance.new("Frame", gui.objs["FunctionFrame"])
LuaPage.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
LuaPage.Size = UDim2.fromOffset(250,163)
LuaPage.Position = UDim2.fromOffset(15,15)
LuaPage.BorderSizePixel = 0
LuaPage.ClipsDescendants = true
local LinesSeparator = Instance.new("Frame", LuaPage)
LinesSeparator.BackgroundColor3 = Color3.fromRGB(100,100,100)
LinesSeparator.Size = UDim2.fromOffset(2,163)
LinesSeparator.Position = UDim2.fromOffset(20,0)
LinesSeparator.BorderSizePixel = 0
local CodeFrame = Instance.new("ScrollingFrame", LuaPage)
CodeFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
CodeFrame.Size = UDim2.fromOffset(227,162)
CodeFrame.Position = UDim2.fromOffset(22,0)
CodeFrame.BorderSizePixel = 0
CodeFrame.ClipsDescendants = true
CodeFrame.BottomImage = "rbxassetid://4809886112"
CodeFrame.MidImage = "rbxassetid://4809886112"
CodeFrame.TopImage = "rbxassetid://4809886112"
CodeFrame.ScrollBarThickness = 6
CodeFrame.ScrollBarImageColor3 = Color3.fromRGB(170,170,170)
local LineNumber = Instance.new("TextLabel", LuaPage)
LineNumber.BackgroundTransparency = 1
LineNumber.Position = UDim2.fromOffset(0,0)
LineNumber.Size = UDim2.new(0,19,1,0)
LineNumber.Text = "1"
LineNumber.TextXAlignment = Enum.TextXAlignment.Right
LineNumber.TextYAlignment = Enum.TextYAlignment.Top
LineNumber.TextSize = 8
LineNumber.TextColor3 = Color3.fromRGB(255,255,255)
local LineCode = Instance.new("TextBox", CodeFrame)
LineCode.BackgroundTransparency = 1
LineCode.Position = UDim2.fromOffset(0,0)
LineCode.Size = UDim2.new(10,0,100000,0)
LineCode.ClearTextOnFocus = false
LineCode.MultiLine = true
LineCode.TextXAlignment = Enum.TextXAlignment.Left
LineCode.TextYAlignment = Enum.TextYAlignment.Top
LineCode.Text = "print(\"Hello world!\")"
LineCode.TextSize = 8
LineCode.TextColor3 = Color3.fromRGB(68, 68, 68)
local luaSyntax = Instance.new("TextLabel", CodeFrame)
luaSyntax.BackgroundTransparency = 1
luaSyntax.Position = UDim2.fromOffset(0,0)
luaSyntax.Size = UDim2.new(10,0,10,0)
luaSyntax.TextXAlignment = Enum.TextXAlignment.Left
luaSyntax.TextYAlignment = Enum.TextYAlignment.Top
luaSyntax.Text = ""
luaSyntax.RichText = true
luaSyntax.TextSize = 8
luaSyntax.TextColor3 = Color3.fromRGB(255,255,255)
--LineNumber.Parent = LinesSeparator7
local lua = {}
lua.Code = ""
function CanvasX(str)
    local TempText = Instance.new("TextLabel")
    TempText.Text = ""
    TempText.TextSize = 8
    local bestSize = 0
    for s in str:gmatch("[^\r\n]+") do
        TempText.Text = s
        if TempText.TextBounds.X > bestSize then
            bestSize = TempText.TextBounds.X
        end
    end
    return bestSize
end
function LinesCount(str)
    lines = {}
    for s in str:gmatch("\n") do
        table.insert(lines, s)
    end
    return #lines+1
end

local markup = {
    cyan = {"getrawmetatable", "newcclosure", "islclosure", "setclipboard", "game", "workspace", "script", "math", "string", "table", "print", "wait", "BrickColor", "Color3", "next", "pairs", "ipairs", "select", "Instance", "Vector2", "Vector3", "CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn", "tick", "loadstring", "_G", "shared", "getfenv", "setfenv", "newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall", "ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber", "tostring","_VERSION", "coroutine", "delay", "require", "spawn", "LoadLibrary", "settings", "stats", "time", "UserSettings", "version", "Axes", "ColorSequence", "Faces", "ColorSequenceKeypoint", "NumberRange", "NumberSequence", "NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage", "PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim", "Vector2int16", "Vector3int16", "load"},
    redB = {"and", "break", "do", "else", "elseif", "end", "for", "function", "goto", "if", "in", "local", "not", "or", "repeat", "return", "then", "until", "while", "unpack"},
    yellowB = {"false", "true", "nil"},
    yellow = {"WaitForChild", "FindFirstChild", "GetService"},
}

local syntaxPatterns = {
    [ [=[(%".-%")]=] ] = [[<font color='rgb(103,137,56)'>%1</font>]],
    --["(%-%-[^\%n]*)"] = [[<font color='rgb(102,102,102)'>%1</font>]],
    ["(%-%-%[%[.-%]%])"] = [[<font color='rgb(103,137,56)'>%1</font>]],
    ["(%-%-.-\n)"] = [[<font color='rgb(103,137,56)'>%1</font>]],
    --["(%d+)"] = [[<font color='rgb(102,102,102)'>%1</font>]],
}
for _,name in pairs(markup.cyan) do
    syntaxPatterns["("..name..")"] = [[<font color='rgb(132,213,246)'>%1</font>]]
end
for _,name in pairs(markup.redB) do
    syntaxPatterns["("..name.."%s+)"] = [[<font color='rgb(248,109,124)'><b>%1</b></font>]]
end
for _,name in pairs(markup.yellowB) do
    syntaxPatterns["("..name.."%s+)"] = [[<font color='rgb(255,198,0)'><b>%1</b></font>]]
end
for _,name in pairs(markup.yellow) do
    syntaxPatterns["("..name.."%s+)"] = [[<font color='rgb(246,244,168)'><b>%1</b></font>]]
end

function HighlightSyntax(source)
	for pattern, repl in pairs(syntaxPatterns) do
		source = string.gsub(source, pattern, repl)
        if pattern == "(%-%-.-\n)" then
            source = string.gsub(source, "(<font color='rgb(.-)'>.-</font>)", "%1")
        end
	end
	return source
end

function lua:Update()
    lua.Code = LineCode.Text
	local linesOut = ""
	for i = math.floor((CodeFrame.CanvasPosition.Y/5)/2)+1, math.clamp(math.floor((CodeFrame.CanvasPosition.Y/5)/2)+14,math.floor((CodeFrame.CanvasPosition.Y/5)/2)+1,LinesCount(lua.Code)) do
		linesOut = linesOut .. i .. "\n"
	end
    LineNumber.Text = linesOut
    luaSyntax.Text = HighlightSyntax(lua.Code.."\n")
    CodeFrame.CanvasSize = UDim2.fromOffset(CanvasX(lua.Code),LinesCount(lua.Code)*16)
    --LineNumber.Position = UDim2.fromOffset(0,-CodeFrame.CanvasPosition.Y)

end

gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    lua:Update()
end)

local RunLua = Instance.new("TextLabel", gui.objs["FunctionFrame"])
RunLua.BackgroundColor3 = Color3.fromRGB(100,100,100)
RunLua.Position = UDim2.fromOffset(205,181)
RunLua.Size = UDim2.new(0,60,0,15)
RunLua.BorderSizePixel = 0
RunLua.Text = "Execute"
RunLua.TextSize = 8
RunLua.TextColor3 = Color3.fromRGB(255,255,255)

RunLua.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		loadstring(lua.Code)()
	end
end)

spawn(function()
    while wait(0.03) do
        if not gui.Loaded then break end
        if gui.page[1] == "Lua" then
            gui:ToggleListSwithcer(false)
            LuaPage.Visible = true
            RunLua.Visible = true
        else
            gui:ToggleListSwithcer(true)
            LuaPage.Visible = false
            RunLua.Visible = false
        end
    end
end)


local lplr = game:GetService("Players").LocalPlayer
local Murder = ""
local Sheriff = ""
local roles = {}

spawn(function ()
    while wait(4) do
        if not gui.Loaded then break end
        if game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true) then
            local rls = {}
            local event = game:GetService("ReplicatedStorage"):FindFirstChild("GetPlayerData", true):InvokeServer()
            for i, v in pairs(event) do
                if i ~= game:GetService("Players").LocalPlayer.Name then
                    rls[i] = v.Role or "Unknown"
                    if v.Role == "Murderer" then
                        Murder = i
                    elseif v.Role == "Hero" or v.Role == "Sheriff" then
                        Sheriff = i
                    end
                end
            end
            roles = rls
        end
    end
end)

local RealCharacter = lplr.Character and lplr.Character:Clone() or nil

local LChams = Instance.new("Highlight", gui.objs.Gui)
LChams.DepthMode = Enum.HighlightDepthMode.Occluded
LChams.OutlineTransparency = 1

local RLChams = Instance.new("Highlight", gui.objs.Gui)
RLChams.DepthMode = Enum.HighlightDepthMode.Occluded
--RLChams.Adornee = lplr.Character
RLChams.OutlineTransparency = 1

local setInvisibleC = false
local setInvisibleRC = false
local transparenced = {}
gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    LChams.FillColor = gui:GetColor("Visuals", "Color ", 3)
    LChams.FillTransparency = gui:GetState("Visuals", "Transparency ", 3)/100
    --RLChams.FillColor = gui:GetColor("Visuals", "Color  ", 4)
    --RLChams.FillTransparency = gui:GetState("Visuals", "Transparency  ", 3)/100
    LChams.Adornee = lplr.Character
    --RLChams.Adornee = RealCharacter
    LChams.Enabled = gui:IsChecked("Visuals", "Chams", 3)
    --RLChams.Enabled = gui:IsChecked("Visuals", "Real chams", 3)
    if gui:IsChecked("Visuals", "Chams", 3) then
        for _,part in pairs(lplr.Character:GetChildren()) do
            if (part:IsA("BasePart") or part.ClassName == "MeshPart") and part.Name ~= "HumanoidRootPart" and part.Transparency == 0 then
                transparenced[part.Name] = part.Transparency
                part.Transparency = 0.999
                if part.Name:find("Head") and part:FindFirstChild("face") then
                    part:FindFirstChild("face").Transparency = 1
                end
            elseif part.ClassName == "Accessory" and part:FindFirstChild("Handle") then
                part:FindFirstChild("Handle").Transparency = 0.999
            end
        end
        setInvisibleC = true
    elseif setInvisibleC then
        setInvisibleC = false
        for _,part in pairs(lplr.Character:GetChildren()) do
            if (part:IsA("BasePart") or part.ClassName == "MeshPart") and transparenced[part.Name] then
                part.Transparency = 0
                if part.Name:find("Head") and part:FindFirstChild("face") then
                    part:FindFirstChild("face").Transparency = 0
                end
            elseif part.ClassName == "Accessory" and part:FindFirstChild("Handle") then
                part:FindFirstChild("Handle").Transparency = 0
            end
        end
    end
    --[[if gui:IsChecked("Visuals", "Real chams", 3) then
        RealCharacter.Parent = lplr.Character.Parent
        for _,part in pairs(RealCharacter:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 0.999
                if part.Name:find("Head") and part:FindFirstChild("face") then
                    part:FindFirstChild("face").Transparency = 1
                end
            elseif part.ClassName == "Accessory" and part:FindFirstChild("Handle") then
                part:FindFirstChild("Handle").Transparency = 0.999
            end
        end
    end]]
end)

spawn(function()
    while task.wait() do
        if not gui.Loaded then break end
        if gui:IsChecked("HvH", "Fakelag") then
            local factor = gui:GetState("HvH", "Factor ")
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0)
            print("lag")
            task.wait(factor/10)
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)
            print("unlag")
        end

        --[=[if gui:IsChecked("HvH", "Fakelag ") then
            flTimer = flTimer + 1
            if flTimer > gui:GetState("HvH", "Fakelags Size")*10 then
                flTimer = 0
                --[[pcall(RealCharacter and RealCharacter:Remove() or Nothing())
                RealCharacter = lplr.Character and lplr.Character:Clone() or nil
                for _,part in pairs(RealCharacter:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end]]
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)
                task.wait()
                game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0)
            end
        else
            --[[pcall(RealCharacter and RealCharacter:Remove() or Nothing())
            RealCharacter = lplr.Character and lplr.Character:Clone() or nil
            for _,part in pairs(RealCharacter:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end]]
            game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)
        end
        --RealCharacter.Name = randomString(12)]=]
    end
end)

local canTeamCheck = true
if #game:GetService("Teams"):GetChildren() <= 1 then
    canTeamCheck = false
end
if canTeamCheck then
    gui:SetActive("Aimbot", "Team check", false)
    gui:SetActive("Visuals", "Team check", false)
    gui:SetActive("Aimbot", "Team check", false)
    
end

function Setvisuals(v)
    spawn(function() -- Box
        local plr = v.Name
        local Box = Drawing.new("Square")
        Box.Color = Color3.new(255,255,255)
        Box.Thickness = 1
        Box.Filled = false
        local HP = Drawing.new("Text")
        HP.Text = "0"
        HP.Color3 = Color3.fromRGB(255,255,255)
        HP.Font = 2
        HP.Size = gui:GetState("Colors", "ESP Size")
        local HPBar = Drawing.new("Square")
        HPBar.Color = Color3.new(255,255,255)
        HPBar.Thickness = 0
        HPBar.Filled = true
        --HPBar.Fade = {Color3.fromRGB(255, 255, 255), 0, true}
        local Nametag = Drawing.new("Text")
        Nametag.Text = plr
        Nametag.Font = 2
        Nametag.Size = gui:GetState("Colors", "ESP Size")
        Nametag.Center = true
        local Team = Drawing.new("Text")
        Team.Text = "Unknown"
        Team.Font = 2
        Team.Size = gui:GetState("Colors", "ESP Size")
        Team.Center = true
        local weapon = Drawing.new("Text")
        weapon.Text = "???"
        weapon.Font = 2
        weapon.Size = gui:GetState("Colors", "ESP Size")
        weapon.Center = true 
        local Tracer = Drawing.new("Line")
        Tracer.Color = Color3.new(255,255,255)
        local ChamsInvisible = Instance.new("Highlight")
        ChamsInvisible.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ChamsInvisible.OutlineTransparency = 1
        ChamsInvisible.Parent = gui.objs["Gui"]
        local snapLine = Instance.new("Frame", Draws)
        snapLine.Size = UDim2.fromOffset(10,10)
        snapLine.Position = UDim2.fromScale(0.5,0.5)
        snapLine.AnchorPoint = Vector2.new(0.5,0.5)
        snapLine.BackgroundColor3 = Color3.new(1,1,1)
        snapLine.BorderSizePixel = 0
        snapLine.Style = Enum.FrameStyle.ChatBlue
        local snapTitle = Instance.new("TextLabel", snapLine)
        snapTitle.Size = UDim2.fromScale(1,1)
        snapTitle.BackgroundTransparency = 1
        snapTitle.TextColor3 = Color3.new(1,1,1)
        snapTitle.TextScaled = true
        local snapTitleOutline = Instance.new("UIStroke")
        snapTitleOutline.Thickness = 0.5
        snapTitleOutline.Color = Color3.new(0,0,0)
        --[[
            local snap = script.Parent.Frame
            local target = workspace.Rig
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                local destination, onScreen = workspace.CurrentCamera:WorldToScreenPoint(target.HumanoidRootPart.Position)
                if not onScreen then
                    snap.Visible = true
                    print(destination)
                    local screenX2 = math.floor(script.Parent.AbsoluteSize.X/2)
                    local screenY2 = math.floor(script.Parent.AbsoluteSize.Y/2)
                    local lookAt = Vector2.new(destination.X, destination.Y)
                    local direction =  (Vector2.new(screenX2,screenY2) - lookAt).Uniĺ
                    local angle = math.atan2(direction.Y, direction.X)
                    local x = (math.cos(angle) * 50) * (destination.Z < 0 and -1 or 1)
                    local y = (math.sin(angle) * 50) * (destination.Z < 0 and -1 or 1)
                    snap.Rotation = destination.Z < 0 and math.deg(angle)-180 or math.deg(angle)
                    snap.Position = UDim2.new(0.5, -x, 0.5, -y)
                else
                    snap.Visible = false
                end
            end)
        ]]
        local disabledOnce = false
        gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
            local char = v.Character
            weapon.Size = gui:GetState("Colors", "ESP Size")
            HP.Size = gui:GetState("Colors", "ESP Size")
            Nametag.Size = gui:GetState("Colors", "ESP Size")
            Team.Size = gui:GetState("Colors", "ESP Size")

            
            if not game:GetService("Players"):FindFirstChild(plr) then
                weapon.Visible = false
                Box.Visible = false
                HP.Visible = false
                HPBar.Visible = false
                Nametag.Visible = false
                Tracer.Visible = false
                Team.Visible = false
                ChamsInvisible:Remove()
                return;
            end
            
            if v and (gui:IsChecked("Visuals", "Team check") and v.Team and v.Team.Name ~= lplr.Team.Name) or not gui:IsChecked("Visuals", "Team check") then
                local success, fsdf = pcall(function()
                    if not char then return true; end
                    local camera = game:GetService("Workspace").CurrentCamera
                    local primarypart = char.HumanoidRootPart or char.PrimaryPart
                    local vector, onScreen = camera:WorldToViewportPoint(primarypart.Position+Vector3.new(0,4,0))
                    local destinationSnap, onScreenSnap = camera:WorldToViewportPoint(primarypart.Position)

                    if gui:IsChecked("Visuals", "Offscreen pointers") then
                        if not onScreenSnap and primarypart ~= nil and lplr.Character.HumanoidRootPart ~= nil then
                            snapLine.Visible = true
                            local screenX2 = math.floor(gui.objs["Gui"].AbsoluteSize.X/2)
                            local screenY2 = math.floor(gui.objs["Gui"].AbsoluteSize.Y/2)
                            local lookAt = Vector2.new(destinationSnap.X, destinationSnap.Y)
                            local direction =  (Vector2.new(screenX2,screenY2) - lookAt).Unit
                            local angle = math.atan2(direction.Y, direction.X)
                            local x = (math.cos(angle) * 50) * (destinationSnap.Z < 0 and -1 or 1)
                            local y = (math.sin(angle) * 50) * (destinationSnap.Z < 0 and -1 or 1)
                            snapLine.Rotation = destinationSnap.Z < 0 and math.deg(angle)-180 or math.deg(angle)
                            snapLine.Position = UDim2.new(0.5, -x, 0.5, -y)
                            snapTitle.Text =  math.floor((primarypart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude)
                        else
                            snapLine.Visible = false
                        end
                    else
                        snapLine.Visible = false
                    end

                    if onScreen == true then
                        local legPos = camera:WorldToViewportPoint(primarypart.Position)
                        local downPos = (legPos.Y-vector.Y)
                        local InterColor = gui:GetColor("Colors", "Esp color", 1)
                        if gui:IsExist("Visuals", "Highlight roles", 4) then
                            if gui:IsChecked("Visuals", "Highlight roles", 4) then
                                if roles[plr] ~= nil then
                                    if roles[plr] == "Murderer" then
                                        InterColor = Color3.fromRGB(200,0,0)
                                    elseif roles[plr] == "Hero" or roles[plr] == "Sheriff" then
                                        InterColor = Color3.fromRGB(0,0,200)
                                    end
                                end
                            end
                        end
                        --[[]]
                        if gui:IsChecked("Visuals", "Chams", 2) and gui:IsChecked("Visuals", "Enabled") then
                            local chamsTransparency = gui:GetState("Colors", "Chams transparency")/100
                            ChamsInvisible.FillColor = gui:GetColor("Colors", "Chams color", 1)
                            ChamsInvisible.FillTransparency = chamsTransparency
                            if _G.SecureMethod == "FullSecurity" then
                                ChamsInvisible.Parent = gui.objs["Gui"]
                            else
                                ChamsInvisible.Parent = char
                            end
                            ChamsInvisible.Adornee = char
                            ChamsInvisible.Enabled = true
                        else
                            ChamsInvisible.Enabled = false
                        end
                        --]]
                        if gui:IsChecked("Visuals", "Enabled") and gui:IsChecked("Visuals", "Team") then
                            Team.Text = v.Team.Name or "Unknown"
                            Team.Position = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,vector.Y+(downPos*2-downPos/2))
                            InterColor = v.Team.TeamColor.Color
                            Team.Color = InterColor
                            Team.Visible = true
                            if gui:IsExist("Visuals", "Roles", 2) then
                                Team.Position = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,vector.Y+(downPos*2-downPos/2))
                                Team.Color = InterColor
                                pcall(function()
                                    if gui:IsChecked("Visuals", "Roles", 2) then
                                        --spawn(function()
                                        Team.Text = roles[plr] or "No role"
                                        --Team.Visible = true
                                        --end)
                                    end
                                end)
                            end
                        elseif gui:IsChecked("Visuals", "Enabled") and gui:IsExist("Visuals", "Roles", 3) then
                            if gui:IsExist("Visuals", "Roles", 4) then
                                Team.Position = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,vector.Y+(downPos*2-downPos/2))
                                Team.Color = InterColor
                                pcall(function()
                                    if gui:IsChecked("Visuals", "Roles", 4) and roles[plr] ~= nil then
                                        --spawn(function()
                                        Team.Text = roles[plr] or "No role"
                                        Team.Visible = true
                                        --end)
                                    else
                                        Team.Visible = false
                                    end
                                end)
                            end
                        else
                            Team.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Enabled") and gui:IsChecked("Visuals", "Lines") then
                            Tracer.Color = InterColor
                            Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                            Tracer.To = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,vector.Y+downPos)
                            Tracer.Visible = true
                        else
                            Tracer.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Weapon", 2) and gui:IsChecked("Visuals", "Enabled") then
                            local adding = 0
                            if ( gui:IsChecked("Visuals", "Team") or ( gui:IsExist("Visuals", "Roles", 3) and gui:IsChecked("Visuals", "Roles", 3) ) ) and Team.Text ~= "" then
                                adding = 10
                            end
                            local haveWeapon = false
                            for _,tool in pairs(char:GetChildren()) do
                                if tool.ClassName == "Tool" then
                                    weapon.Text = tool.Name
                                    haveWeapon = true
                                end
                            end
                            if not haveWeapon then
                                weapon.Text = "Nothing"
                            end
                            weapon.Position = Vector2.new(((vector.X-downPos/4)+(downPos/2)/2),vector.Y+(downPos*2-downPos/2)+adding)
                            weapon.Color = InterColor
                            weapon.Visible = true
                        else
                            weapon.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Nametags",2) and not gui:IsChecked("Visuals", "Distance", 2) and gui:IsChecked("Visuals", "Enabled") then
                            Nametag.Position = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,(vector.Y+downPos/2)-16)
                            Nametag.Color = InterColor
                            Nametag.Visible = true
                            Nametag.Text = plr
                        elseif gui:IsChecked("Visuals", "Nametags",2) and gui:IsChecked("Visuals", "Distance", 2) and gui:IsChecked("Visuals", "Enabled") then
                            Nametag.Position = Vector2.new((vector.X-downPos/4)+(downPos/2)/2,(vector.Y+downPos/2)-16)
                            Nametag.Color = InterColor
                            Nametag.Visible = true
                            local dist = 0
                            dist = math.floor((primarypart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                            Nametag.Text = plr .. "[" .. dist .. "m]"
                        elseif not gui:IsChecked("Visuals", "Nametags",2) and gui:IsChecked("Visuals", "Distance", 2) and gui:IsChecked("Visuals", "Enabled") then
                            local dist = 0
                            dist = math.floor((primarypart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                            Nametag.Text = "  [" .. dist .. "m]"
                        else
                            Nametag.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Health bar", 2) and gui:IsChecked("Visuals", "Enabled") then
                            HPBar.YAlign = "Bottom"
                            HPBar.Position = Vector2.new(((vector.X-downPos/4)+downPos/2+6),(vector.Y+downPos/2)+(downPos-((downPos/char.Humanoid.MaxHealth)*char.Humanoid.Health)))
                            local dvHealth = 255/char.Humanoid.MaxHealth
                            HPBar.Size = Vector2.new(2,(downPos/char.Humanoid.MaxHealth)*char.Humanoid.Health)
                            HPBar.Color = Color3.fromRGB(255-char.Humanoid.Health*dvHealth,char.Humanoid.Health*dvHealth,0)
                            --HPBar.Fade = {Colorize.RGB:Darkness(HPBar.Color, 0.5)}
                            HPBar.Visible = true
                        else
                            HPBar.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Health", 2) and gui:IsChecked("Visuals", "Enabled")  then
                            local add = 0
                            if gui:IsChecked("Visuals", "Health bar", 2) then
                                add = 7
                            end
                            HP.Color = Color3.fromRGB(255-char.Humanoid.Health*2.55,char.Humanoid.Health*2.55,0)
                            HP.Position = Vector2.new((vector.X-downPos/4)+downPos/2+3+add,vector.Y+downPos/2)
                            HP.Text = "???"
                            HP.Text = math.floor(char.Humanoid.Health)
                            HP.Visible = true
                        else
                            HP.Visible = false
                        end

                        if gui:IsChecked("Visuals", "Enabled") and gui:IsChecked("Visuals", "Box") then
                            Box.Size = Vector2.new(downPos/2,downPos)
                            Box.Position = Vector2.new(vector.X-downPos/4,vector.Y+downPos/2)
                            Box.Color = InterColor
                            Box.Visible = true
                        else
                            Box.Visible = false
                        end
                        disabledOnce = false
                        
                        --print(downPos)
                    else
                        Tracer.Visible = false
                        weapon.Visible = false
                        Box.Visible = false
                        HPBar.Visible = false
                        HP.Visible = false
                        Nametag.Visible = false
                        Team.Visible = false
                        ChamsInvisible.Enabled = false
                        snapLine.Visible = false
                    end
                end)
                if not success then
                    --warn(fsdf)
                    Tracer.Visible = false
                    weapon.Visible = false
                    Box.Visible = false
                    HP.Visible = false
                    HPBar.Visible = false
                    Nametag.Visible = false
                    Team.Visible = false
                    ChamsInvisible.Enabled = false
                    snapLine.Visible = false
                end
            else
                Tracer.Visible = false
                weapon.Visible = false
                Box.Visible = false
                HP.Visible = false
                HPBar.Visible = false
                Nametag.Visible = false
                Team.Visible = false
                ChamsInvisible.Enabled = false
                snapLine.Visible = false
            end
        end)
    end)
end
function AltVisuals(plr)
    
end
if _G.SecureMethod == "NoSecure" then
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game:GetService("Players").LocalPlayer.Name then
            Setvisuals(v)
        end
    end
    
    gui["Hooks"][#gui["Hooks"]+1] = game:GetService("Players").PlayerAdded:Connect(function(plr)
        Setvisuals(plr)
    end)
elseif _G.SecureMethod == "FullSecurity" then
    for _,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game:GetService("Players").LocalPlayer.Name then
            Setvisuals(v)
        end
    end
    
    gui["Hooks"][#gui["Hooks"]+1] = game:GetService("Players").PlayerAdded:Connect(function(plr)
        Setvisuals(plr)
    end)
end


local UserInputService = game:GetService("UserInputService")
local cd = false
gui["Hooks"][#gui["Hooks"]+1] = UserInputService.InputBegan:Connect(function(input, _gameProcessed)
	if input.KeyCode == Enum.KeyCode.Insert and not cd then
        cd = true
		gui.objs["MainFrame"].Visible = not gui.objs["MainFrame"].Visible
        gui.objs["AntiMissclick"].Size = ((gui.objs["MainFrame"].Visible and UDim2.fromScale(1,1)) or UDim2.fromScale(0,0))
	end
end)

gui["Hooks"][#gui["Hooks"]+1] = UserInputService.InputEnded:Connect(function(input, _gameProcessed)
	if input.KeyCode == Enum.KeyCode.Insert then
        cd = false
	end
end)

local dwCamera = game:GetService("Workspace").CurrentCamera
local dwRunService = game:GetService("RunService")
local dwUIS = game:GetService("UserInputService")
local dwEntities = game:GetService("Players"):GetPlayers()
local dwLocalPlayer = game:GetService("Players").LocalPlayer
local dwMouse = dwLocalPlayer:GetMouse()

local Aimsettings = {
	Aimbot = true,
	Aiming = false,
    Aimbot_Shooting = false,
	Aimbot_AimPart = "Head",
	Aimbot_TeamCheck = false,
	Aimbot_Draw_FOV = true,
	Aimbot_FOV_Radius = 80,
	Aimbot_FOV_Color = Color3.fromRGB(255,255,255)
}
	
local fovcircle = Drawing.new("Circle")
fovcircle.Visible = Aimsettings.Aimbot_Draw_FOV
fovcircle.Radius = Aimsettings.Aimbot_FOV_Radius
fovcircle.Color = Aimsettings.Aimbot_FOV_Color
fovcircle.Visible = false
fovcircle.Thickness = 1
fovcircle.Filled = false
fovcircle.Transparency = 0
fovcircle.Position = Vector2.new(dwCamera.ViewportSize.X / 2, dwCamera.ViewportSize.Y / 2)
	
gui["Hooks"][#gui["Hooks"]+1] = dwUIS.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton2 and Aimsettings.Aimbot == true then
		Aimsettings.Aiming = true
	end
    if i.UserInputType == Enum.UserInputType.MouseButton1 and Aimsettings.Aimbot == true then
		Aimsettings.Aimbot_Shooting = true
	end
end)
	
gui["Hooks"][#gui["Hooks"]+1] = dwUIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton2 then
		Aimsettings.Aiming = false
	end
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
		Aimsettings.Aimbot_Shooting = false
	end
end)

spawn(function()
    if gui:IsExist("Misc", "Grab gun") then
        while wait() do
            if not gui.Loaded then break end
            if gui:IsChecked("Misc", "Grab gun") then
                local map
                for _,model in pairs(game:GetService("Workspace"):GetChildren()) do
                    if model:FindFirstChild("CoinContainer", true) ~= nil then
                        map = model
                        break
                    end
                end
                if map and map:FindFirstChild("GunDrop") then
                    pcall(function ()
                        wait(0.3)
                        local currentX = game:GetService("Players").LocalPlayer.Character.Head.CFrame.X
                        local currentY = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y
                        local currentZ = game:GetService("Players").LocalPlayer.Character.Head.CFrame.Z   
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Normal:FindFirstChild("GunDrop").CFrame 
                        game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        wait(0.01)   
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
                    end)
                end
            end
        end
    end
end)
local autoshoottime = true
local lastAimPlayer = nil
local lastCamPos = nil

spawn(function ()
    local map
    for _,model in pairs(game:GetService("Workspace"):GetChildren()) do
        if model:FindFirstChild("CoinContainer", true) ~= nil then
            map = model
            break
        end
    end
    --local coins = map:FindFirstChild("CoinContainer")
    --TODO: Coin grabber
end)
--local startTech = game.Lighting.Technology
local NPCs = {}
local WNPCs = {}
spawn(function()
    repeat
        local npscc = {}
        for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v.ClassName == "Humanoid" and (v.Parent:FindFirstChild("Head") ~= nil or v.Parent:FindFirstChild("HumanoidRootPart") ~= nil) and game.Players:GetPlayerFromCharacter(v.Parent) == nil then
                NPCs[v.Parent.Name] = true
                if gui:IsItemSelected("Aimbot", "Entities", v.Parent.Name, 2) then
                    npscc[#npscc+1] = v.Parent
                end 
            end
        end
        WNPCs = npscc
        if not gui:IsOpened("Aimbot", "Entities", 2) then
            local _ = gui:SetList("Aimbot", "Entities", NPCs, 2)
        end
        wait(4)
    until not gui.Loaded
end)

local hitboxesName = {
    ["Head"]=true,
    ["Torso"]=true
}
local hitboxes = {
    "Head",
    "Torso",
}

spawn(function()
    repeat
        local dwEnts = {}
        if gui:IsChecked("Aimbot", "Player aimbot", 2) then
            dwEnts = game:GetService("Players"):GetPlayers()
            for _,plr in pairs(dwEnts) do
                if plr.Character ~= nil then 
                    for _,part in pairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") and not hitboxesName[part.Name] then
                            hitboxesName[part.Name] = true
                            hitboxes[#hitboxes+1] = part.Name
                        end
                    end
                end
            end
        end
        if gui:IsChecked("Aimbot", "Entity aimbot", 2) then
            for i,v in pairs(WNPCs) do
                dwEnts[#dwEnts+1] = v
            end
        end
        dwEntities = dwEnts
        wait(0.5)
    until not gui.Loaded
end)

gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    Aimsettings.Aimbot_AimPart = gui:GetSelectedBone("Aimbot", "AimHitbox")
    gui:SetList("Aimbot", "Hitboxes", hitboxes, 3)
    local dist = math.huge
	local closest_char = nil
    local LAimPart
    if gui:IsChecked("Aimbot", "Manual Hitbox", 3) and gui:GetDropItem("Aimbot", "Hitboxes", 3)~="" then
        LAimPart = gui:GetDropItem("Aimbot", "Hitboxes", 3)
    else
        LAimPart = Aimsettings.Aimbot_AimPart
    end
    Aimsettings.Aimbot = gui:IsChecked("Aimbot", "Enabled")
    fovcircle.Radius = gui:GetState("Aimbot", "FoV", 2)
    fovcircle.Visible = gui:IsChecked("Visuals", "FoV")
	Aimsettings.Aimbot_FOV_Radius = gui:GetState("Aimbot", "FoV", 2)
	Aimsettings.Aimbot_TeamCheck = gui:IsChecked("Aimbot", "Team check")
	if Aimsettings.Aiming or gui:IsChecked("Aimbot", "Semi-Silent") or gui:IsChecked("Aimbot", "Instant")then
        if lastAimPlayer == nil or not gui:IsChecked("Aimbot", "Player lock") then
            for i,v in next, dwEntities do
                if v.ClassName == "Player" then
                    if v ~= dwLocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild(LAimPart) ~= nil then
                        if Aimsettings.Aimbot_TeamCheck == true and v.Team ~= dwLocalPlayer.Team or Aimsettings.Aimbot_TeamCheck == false then
                            local char = v.Character
                            
                            local char_part_pos, is_onscreen = dwCamera:WorldToViewportPoint(char[LAimPart].Position)
                            if is_onscreen then
                                local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude
                                if (mag < dist and mag < Aimsettings.Aimbot_FOV_Radius) then
                                    dist = mag
                                    closest_char = char
                                    lastAimPlayer = closest_char
                                end
                            end
                        end
                    end
                else
                    if v:FindFirstChild("Humanoid").Health > 0 then
                        local char = v
                        local char_part_pos, is_onscreen = dwCamera:WorldToViewportPoint(char[LAimPart].Position)
                        if is_onscreen then
                            local mag = (Vector2.new(dwMouse.X, dwMouse.Y) - Vector2.new(char_part_pos.X, char_part_pos.Y)).Magnitude
                            if mag < dist and mag < Aimsettings.Aimbot_FOV_Radius then
                                dist = mag
                                closest_char = char
                                lastAimPlayer = closest_char
                            end
                        end
                    end
                end
            end
        elseif gui:IsChecked("Aimbot", "Player lock") then
            closest_char = lastAimPlayer
        end
	    if closest_char ~= nil and closest_char:FindFirstChild("HumanoidRootPart") and closest_char:FindFirstChild("Humanoid") and closest_char:FindFirstChild("Humanoid").Health > 0 then
            local adding = Vector3.new(0,0,0)
            local work = true
            if gui:IsChecked("Aimbot", "Predict") then
                adding = adding + closest_char.Humanoid.MoveDirection * gui:GetState("Aimbot", "Predict ",2)/10
            end
            if gui:IsChecked("Aimbot", "Wall check") then
                local ray = game:GetService("Workspace"):Raycast(dwCamera.CFrame.Position, closest_char[LAimPart].Position - dwCamera.CFrame.Position)
                if not ray.Instance:IsDescendantOf(closest_char) then
                    if ray ~= nil and gui:IsChecked("Aimbot", "Hitscan") then
                        local Target = closest_char[LAimPart]
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
                        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                        raycastParams.IgnoreWater = true
                        if ray.Instance ~= Target then
                            local found = false
                            spawn(function() 
                                for x = Target.CFrame.Position.X-Target.Size.X/2+0.3, Target.CFrame.Position.X+Target.Size.X/2, 0.6 do
                                    for y = Target.CFrame.Position.Y-Target.Size.Y/2+0.2, Target.CFrame.Position.Y+Target.Size.Y/2, 0.4 do
                                        for z = Target.CFrame.Position.Z-Target.Size.Z/2+0.3, Target.CFrame.Position.Z+Target.Size.Z/2, 0.6 do
                                            ray = workspace:Raycast(dwCamera.CFrame.Position, (Vector3.new(x,y,z) - dwCamera.CFrame.Position), raycastParams)
                                            if ray then
                                                task.wait()
                                                if ray.Instance == Target then
                                                    found = true
                                                    break
                                                end
                                            end
                                        end
                                        if (ray and ray.Instance == Target) or found then
                                            found = true
                                            break
                                        end
                                    end
                                    if (ray and ray.Instance == Target) or found then
                                        found = true
                                        break
                                    end
                                end
                                found = "none"
                            end)
                            spawn(function() 
                                for x = Target.CFrame.Position.X-Target.Size.X/2, Target.CFrame.Position.X+Target.Size.X/2, 0.6 do
                                    for y = Target.CFrame.Position.Y-Target.Size.Y/2, Target.CFrame.Position.Y+Target.Size.Y/2, 0.4 do
                                        for z = Target.CFrame.Position.Z-Target.Size.Z/2, Target.CFrame.Position.Z+Target.Size.Z/2, 0.6 do
                                            ray = workspace:Raycast(dwCamera.CFrame.Position, (Vector3.new(x,y,z) - dwCamera.CFrame.Position), raycastParams)
                                            if ray then
                                                task.wait()
                                                if ray.Instance == Target then
                                                    found = true
                                                    break
                                                end
                                            end
                                        end
                                        if (ray and ray.Instance == Target) or found then
                                            found = true
                                            break
                                        end
                                    end
                                    if (ray and ray.Instance == Target) or found then
                                        found = true
                                        break
                                    end
                                end
                                found = "none"
                            end)
                            repeat task.wait() until found or found ~= "none"
                            if found == "none" then
                                work = false
                            end
                        end
                    else
                        work = false
                    end
                end
            end
            
            if work then
                local aimToPos = closest_char[LAimPart].Position
                local Smooth = gui:GetState("Aimbot", "Smooth",2)/10
                if Smooth == 1 then
                    Smooth = 0.96
                end
                if gui:IsChecked("Aimbot", "Offset mode", 2) then
                    local x = gui:GetState("Aimbot", "X ", 2)/10
                    local y = gui:GetState("Aimbot", "Y ", 3)/10
                    aimToPos = aimToPos + Vector3.new(dwCamera.CFrame.lookVector.X*x,y,dwCamera.CFrame.lookVector.Z*x)
                end
                if gui:IsChecked("Aimbot", "Semi-Silent") then
                    if Aimsettings.Aimbot_Shooting then
                        if lastCamPos == nil then
                            lastCamPos = dwCamera.CFrame
                        end
                        dwCamera.CFrame = CFrame.new(dwCamera.CFrame.Position, aimToPos + adding)
                    elseif lastCamPos ~= nil then
                        dwCamera.CFrame = lastCamPos
                        lastCamPos = nil
                    end
                else
                    dwCamera.CFrame = dwCamera.CFrame:lerp(CFrame.new(dwCamera.CFrame.Position, aimToPos + adding), 1-Smooth)
                end
                if gui:IsChecked("Aimbot", "Auto shoot") then
                    if game:GetService("Players").LocalPlayer:GetMouse().Target:IsDescendantOf(closest_char) then
                        local ray = game:GetService("Workspace"):Raycast(game:GetService("Players").LocalPlayer.Character.Head.Position, aimToPos - game:GetService("Players").LocalPlayer.Character.Head.Position)
                        if ray.Instance:IsDescendantOf(closest_char) then
                            if gui:GetState("Aimbot", "Auto shoot delay") > 0 then
                                if autoshoottime == true then
                                    spawn(function()
                                        autoshoottime = false
                                        local oldchar = closest_char
                                        for _i = 1, gui:GetState("Aimbot", "Auto shoot delay") do   
                                            --print(_i)
                                            if not oldchar == closest_char or not Aimsettings.Aiming then
                                                print("char changed, breaking")
                                                autoshoottime = true
                                                return;
                                            end
                                            wait()
                                        end
                                        if oldchar == closest_char and Aimsettings.Aiming then
                                            mouse1click()
                                            --print("trying shoot")
                                            autoshoottime = true
                                        end
                                    end)
                                end
                            else
                                mouse1click()
                            end
                        end
                    end
                end
            end
        end
	else
        lastAimPlayer = nil
    end
end)
local skybox = "None"
local mouseIcon = game:GetService("Players").LocalPlayer:GetMouse().Icon
local crossgui = Instance.new("ScreenGui", guiPlacing)
crossgui.IgnoreGuiInset = false
crossgui.ResetOnSpawn = false
crossgui.ZIndexBehavior = Enum.ZIndexBehavior.Global
crossgui.DisplayOrder = 999
local crosshair = {
    line1 = Instance.new("Frame",crossgui),
    line2 = Instance.new("Frame",crossgui)
}
crosshair.line1.BorderSizePixel = 0
crosshair.line2.BorderSizePixel = 0
crosshair.line1.ZIndex = 999
crosshair.line2.ZIndex = 999
local Thrust = Instance.new('BodyThrust')
Thrust.Force = Vector3.new(0,0,0)
Thrust.Name = "a"
local smodeN = {
    Fling = false
}
local fpvReset = false
local tpv = (lplr.CameraMode == Enum.CameraMode.Classic and true) or false
local oldMiZD = nil
local oldMaZD = nil

local holdingSpace = false

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        holdingSpace = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        holdingSpace = false
    end
end)

gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    if game:GetService("Players").LocalPlayer.Character == nil then return; end
    local char = game:GetService("Players").LocalPlayer.Character
    local humanoid = char.Humanoid
    if humanoid and gui:IsChecked("Misc", "Bhop") and holdingSpace then
        humanoid.Jump = true
    end
    local camera = workspace.CurrentCamera
    if gui:IsChecked("Misc", "Third person") then
        camera.CameraType = Enum.CameraType.Custom
        if not oldMiZD then
            oldMaZD = lplr.CameraMaxZoomDistance
            oldMiZD = lplr.CameraMinZoomDistance
        end
        lplr.CameraMinZoomDistance = gui:GetState("Misc", "Distance  ")
        lplr.CameraMaxZoomDistance = gui:GetState("Misc", "Distance  ")
        lplr.CameraMode = Enum.CameraMode.Classic
        fpvReset = true
    elseif fpvReset then
        fpvReset = false
        lplr.CameraMinZoomDistance = oldMiZD
        lplr.CameraMaxZoomDistance = oldMaZD
        oldMiZD = nil
        oldMaZD = nil
        if not tpv then
            camera.CameraType = Enum.CameraType.Custom  
            lplr.CameraMode = Enum.CameraMode.LockFirstPerson
        end
    end
    if gui:GetState("Player", "Speed") ~= 0 --[[and _G.SecureMethod ~= "FullSecurity"]] then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection / (21 - gui:GetState("Player", "Speed"))
    end

    if gui:IsChecked("Player", "Airboost") then
        if game:GetService("Players").LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
            spawn(function()
                wait()
                while wait() do
                    if not gui.Loaded then break end
                    if game:GetService("Players").LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then break end
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection / (4 - gui:GetState("Player", "Airboost speed")) 
                end
            end)
        end
    end

    if gui:IsChecked("HvH", "Backtrack") then
        settings().Network.IncomingReplicationLag = gui:GetState("HvH", "Backtrack Size")/10
    else
        settings().Network.IncomingReplicationLag = 0
    end

    spawn(function()
        local players = {}
        for _,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                players[#players+1] = v.Name
            end
        end
        gui:SetList("Misc", "Fling Target", players)
    end)
    if _G.SecureMethod ~= "FullSecurity" then
        if gui:IsChecked("Misc", "Fling") and gui:GetDropItem("Misc", "Fling Target") ~= "" then
            Thrust.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Character"):WaitForChild("HumanoidRootPart")
            Thrust.Force = Vector3.new(9999,9999,9999)
            if game:GetService("Players")[gui:GetDropItem("Misc", "Fling Target")] ~= nil then
                spawn(function()
                    local Target = game:GetService("Players")[gui:GetDropItem("Misc", "Fling Target")]
                    repeat
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame --+ Vector3.new(0,0.5,0)
                        Thrust.Location = Target.Character.HumanoidRootPart.CFrame --+ Vector3.new(0,0.5,0)
                        game:FindService("RunService").Heartbeat:wait()
                    until not gui:IsChecked("Misc", "Fling")
                end)
            end
        else
            Thrust.Force = Vector3.new(0,0,0)
        end
    elseif gui:IsChecked("Misc", "Fling") then
        if smodeN.Fling == false then
            smodeN.Fling = true
            gui:Notify("Warning", "Cannot run fling in secure mode", 4)
        end
    end
    if gui:IsExist("Misc", "No fps decrease") and gui:IsChecked("Misc", "No fps decrease") then
        game:GetService("Workspace").StreamingEnabled = true
        settings():GetService("RenderSettings").EnableFRM = false
        settings():GetService("RenderSettings").ExportMergeByMaterial = false

        --game.Lighting.Technology = Enum.Technology.Compatibility
        spawn(function()
            if game:GetService("Workspace"):FindFirstChild("WeaponDisplays") then
                for i,v in pairs (workspace:GetChildren()) do
                    if v.Name == "KnifeDisplay" then
                        v:Destroy()
                    elseif v.Name == "GunDisplay" then
                        v:Destroy()
                    end
                end
            end
            if game:GetService("Workspace"):FindFirstChild("Normal") then
                for i,v in pairs(workspace:FindFirstChild("Normal"):GetChildren()) do
                    if v.Name == "Pet" then
                        v:Destroy()
                    elseif v.Name == "ThrowingKnife" then
                        v:Destroy()
                    elseif v.Name == "Raggy" then
                        v:Destroy()
                    end
                end
            end
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
                if v.Name == "Victory" then
                    v:Destroy()
                end
            end
        end)
    elseif gui:IsExist("Misc", "No fps decrease") and not gui:IsChecked("Misc", "No fps decrease") then
        --game.Lighting.Technology = startTech
    end
    gui.objs["Gui"].Name = randomString(math.random(5,13))
    fovcircle.Position = Vector2.new(dwCamera.ViewportSize.X / 2, dwCamera.ViewportSize.Y / 2)

    if gui:IsExist("Misc", "Tp players") == true then
        if gui:IsChecked("Misc", "Tp players") then
            local selected = gui:GetDropItem("Misc", "Target player", 2)
            if selected == "Murderer" then
                game:GetService("Players"):FindFirstChild(Murder).Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(7,4,0)
            elseif selected == "Sheriff" then
                game:GetService("Players"):FindFirstChild(Sheriff).Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(4,4,0)
            elseif selected == "All" then
                for _,v in pairs(game:GetService("Players"):GetPlayers()) do
                    if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                        local primarypart = v.Character.HumanoidRootPart or v.Character.PrimaryPart
                        primarypart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(4,4,0)
                    end
                end
            end
        end
    end
    if _G.SecureMethod ~= "FullSecurity" then
        if gui:GetDropItem("Misc", "Skybox") ~= "None" and skybox == gui:GetDropItem("Misc", "Skybox") then
            skybox = gui:GetDropItem("Misc", "Skybox")
            local l = game:GetService("Lighting")
            l.Ambient = Color3.new(0,0,0)
            if gui:GetDropItem("Misc", "Skybox") == "Afternoon sky" then
                l.Brightness = 2
                l.ColorShift_Top = Color3.fromRGB(216,180,116)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(118,146,189)
                l.ClockTime = 14
                l.GeographicLatitude = 41.733
            elseif gui:GetDropItem("Misc", "Skybox") == "Morning sky" then
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(210,119,213)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(75,91,130)
                l.ShadowSoftness = 0.15
                l.ClockTime = 6.362
                l.GeographicLatitude = 18.897
            elseif gui:GetDropItem("Misc", "Skybox") == "Clouded sky" then
                l.Brightness = 3
                l.ColorShift_Top = Color3.fromRGB(255,192,146)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(62,72,53)
                l.ClockTime = 7.793
                l.GeographicLatitude = 52.58
            elseif gui:GetDropItem("Misc", "Skybox") == "Floodplain river" then
                l.Brightness = 3
                l.ColorShift_Top = Color3.fromRGB(216,211,182)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(111,139,170)
                l.ClockTime = 13.329
                l.GeographicLatitude = 35.213
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep blue sky" then
                l.Brightness = 2
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(216,180,116)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(119,141,176)
                l.ShadowSoftness = 0.15
                l.ClockTime = 14
                l.GeographicLatitude = 41.733
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep space 1" then
                l.Brightness = 0
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(1,33,27)
                l.ShadowSoftness = 1
                l.ClockTime = 8.51
                l.GeographicLatitude = -16.283
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep space 2" then
                l.Brightness = 0
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(10,7,34)
                l.ShadowSoftness = 0.15
                l.ClockTime = 12
                l.GeographicLatitude = 0
            elseif gui:GetDropItem("Misc", "Skybox") == "Nebula" then
                l.Brightness = 0
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(28,9,22)
                l.ShadowSoftness = 1
                l.ClockTime = 8.51
                l.GeographicLatitude = -16.283
            elseif gui:GetDropItem("Misc", "Skybox") == "Frozen lake" then
                l.Brightness = 0.5
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(201,219,230)
                l.ShadowSoftness = 1
                l.ClockTime = 12.043
                l.GeographicLatitude = 23.295
            elseif gui:GetDropItem("Misc", "Skybox") == "Winter" then
                l.Brightness = 0.5
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(201,219,230)
                l.ShadowSoftness = 1
                l.ClockTime = 12.043
                l.GeographicLatitude = 23.295
            elseif gui:GetDropItem("Misc", "Skybox") == "Green screen" then
                l.Brightness = 0.5
                l.Ambient = Color3.new(0,0,0)
                l.ColorShift_Top = Color3.fromRGB(0,0,0)
                l.ColorShift_Bottom = Color3.new(0,0,0)
                l.OutdoorAmbient = Color3.fromRGB(201,219,230)
                l.ShadowSoftness = 1
                l.ClockTime = 12.043
                l.GeographicLatitude = 23.295
            end
        elseif gui:GetDropItem("Misc", "Skybox") ~= "None" and skybox ~= gui:GetDropItem("Misc", "Skybox") then
            skybox = gui:GetDropItem("Misc", "Skybox")
            local function setsky(Bk,Dn,Ft,Lf,Rt,Up,Sun,Moon)
                local skyboxInst = Instance.new("Sky")
                if not Sun then
                    Sun = "rbxasset://sky/sun.jpg"
                end
                if not Moon then
                    Moon = "rbxasset://sky/moon.jpg"
                end
                skyboxInst.SkyboxBk = Bk
                skyboxInst.SkyboxDn = Dn
                skyboxInst.SkyboxFt = Ft
                skyboxInst.SkyboxLf = Lf
                skyboxInst.SkyboxRt = Rt
                skyboxInst.SkyboxUp = Up
                skyboxInst.SunTextureId = Sun
                skyboxInst.MoonTextureId = Moon
                skyboxInst.Parent = game:GetService("Lighting")
            end
            local l = game:GetService("Lighting")
            l.Ambient = Color3.new(0,0,0)
            if gui:GetDropItem("Misc", "Skybox") == "Afternoon sky" then
                setsky(
                    "http://www.roblox.com/asset/?id=150335574",
                    "http://www.roblox.com/asset/?id=150335585",
                    "http://www.roblox.com/asset/?id=150335628",
                    "http://www.roblox.com/asset/?id=150335620",
                    "http://www.roblox.com/asset/?id=150335610",
                    "http://www.roblox.com/asset/?id=150335642",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Morning sky" then
                setsky(
                    "rbxassetid://627331893",
                    "rbxassetid://627331733",
                    "rbxassetid://627331981",
                    "rbxassetid://627331549",
                    "rbxassetid://627331779",
                    "rbxassetid://627332635",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Clouded sky" then
                setsky(
                    "http://www.roblox.com/asset/?id=252760981",
                    "http://www.roblox.com/asset/?id=252763035",
                    "http://www.roblox.com/asset/?id=252761439",
                    "http://www.roblox.com/asset/?id=252760980",
                    "http://www.roblox.com/asset/?id=252760986",
                    "http://www.roblox.com/asset/?id=252762652",
                    "rbxassetid://1345009717",
                    "rbxasset://sky/moon.jpg"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Floodplain river" then
                setsky(
                    "rbxassetid://559824335",
                    "rbxassetid://559824171",
                    "rbxassetid://559824401",
                    "rbxassetid://559824097",
                    "rbxassetid://559824244",
                    "rbxassetid://559824446",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep blue sky" then
                setsky(
                    "http://www.roblox.com/asset/?id=98202165",
                    "http://www.roblox.com/asset/?id=98202176",
                    "http://www.roblox.com/asset/?id=98202152",
                    "http://www.roblox.com/asset/?id=98202161",
                    "http://www.roblox.com/asset/?id=98202146",
                    "http://www.roblox.com/asset/?id=98202169",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep space 1" then
                setsky(
                    "http://www.roblox.com/asset/?id=159248188",
                    "http://www.roblox.com/asset/?id=159248183",
                    "http://www.roblox.com/asset/?id=159248187",
                    "http://www.roblox.com/asset/?id=159248173",
                    "http://www.roblox.com/asset/?id=159248192",
                    "http://www.roblox.com/asset/?id=159248176",
                    "rbxasset://sky/sun.jpg",
                    "rbxasset://sky/moon.jpg"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Deep space 2" then
                setsky(
                    "http://www.roblox.com/asset/?id=149397692",
                    "http://www.roblox.com/asset/?id=149397686",
                    "http://www.roblox.com/asset/?id=149397697",
                    "http://www.roblox.com/asset/?id=149397684",
                    "http://www.roblox.com/asset/?id=149397688",
                    "http://www.roblox.com/asset/?id=149397702",
                    "rbxasset://sky/sun.jpg",
                    "rbxasset://sky/moon.jpg"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Nebula" then
                setsky(
                    "http://www.roblox.com/asset/?id=159454299",
                    "http://www.roblox.com/asset/?id=159454296",
                    "http://www.roblox.com/asset/?id=159454293",
                    "http://www.roblox.com/asset/?id=159454286",
                    "http://www.roblox.com/asset/?id=159454300",
                    "http://www.roblox.com/asset/?id=159454288",
                    "rbxasset://sky/sun.jpg",
                    "rbxasset://sky/moon.jpg"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Frozen lake" then
                setsky(
                    "rbxassetid://510649951",
                    "rbxassetid://510649819",
                    "rbxassetid://510649985",
                    "rbxassetid://510649761",
                    "rbxassetid://510649888",
                    "rbxassetid://510650010",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Winter" then
                setsky(
                    "rbxassetid://510645155",
                    "rbxassetid://510645130",
                    "rbxassetid://510645179",
                    "rbxassetid://510645117",
                    "rbxassetid://510645146",
                    "rbxassetid://510645195",
                    "rbxassetid://1345009717",
                    "rbxassetid://1345054856"
                )
            elseif gui:GetDropItem("Misc", "Skybox") == "Green screen" then
                setsky(
                    "http://www.roblox.com/asset/?id=121375960",
                    "http://www.roblox.com/asset/?id=121375960",
                    "http://www.roblox.com/asset/?id=121375960",
                    "http://www.roblox.com/asset/?id=121375960",
                    "http://www.roblox.com/asset/?id=121375960",
                    "http://www.roblox.com/asset/?id=121375960",
                    "rbxasset://sky/sun.jpg",
                    "rbxasset://sky/moon.jpg"
                )
            end
        end
    end
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    if gui:IsChecked("Visuals", "Crosshair", 2) then
        mouse.Icon = "rbxassetid://0"
        crosshair.line1.BackgroundColor3 = gui:GetColor("Visuals", "Crosshair color", 3)
        crosshair.line2.BackgroundColor3 = gui:GetColor("Visuals", "Crosshair color", 3)
        crosshair.line1.Size = UDim2.fromOffset(2, gui:GetState("Visuals", "Crosshair size", 2)*2)
        crosshair.line2.Size = UDim2.fromOffset(gui:GetState("Visuals", "Crosshair size", 2)*2, 2)
        if gui:GetDropItem("Visuals", "Crosshair type", 2) == "+" then
            crosshair.line1.Position = UDim2.fromOffset(mouse.X,mouse.Y-crosshair.line1.AbsoluteSize.Y/2+1)
            crosshair.line2.Position = UDim2.fromOffset(mouse.X-crosshair.line2.AbsoluteSize.X/2+1,mouse.Y)
            crosshair.line1.Rotation = 0
            crosshair.line2.Rotation = 0
        elseif gui:GetDropItem("Visuals", "Crosshair type", 2) == "×" then
            crosshair.line1.Position = UDim2.fromOffset(mouse.X,mouse.Y-crosshair.line1.AbsoluteSize.Y/2+1)
            crosshair.line2.Position = UDim2.fromOffset(mouse.X-crosshair.line2.AbsoluteSize.X/2+1,mouse.Y)
            crosshair.line1.Rotation = 45
            crosshair.line2.Rotation = 45
        elseif gui:GetDropItem("Visuals", "Crosshair type", 2) == "т" then
            crosshair.line1.Position = UDim2.fromOffset(mouse.X,mouse.Y)
            crosshair.line2.Position = UDim2.fromOffset((mouse.X-crosshair.line2.AbsoluteSize.X/2)+1,mouse.Y)
            crosshair.line1.Rotation = 0
            crosshair.line2.Rotation = 0
        end
        crosshair.line1.Visible = true
        crosshair.line2.Visible = true
    else
        mouse.Icon = mouseIcon
        crosshair.line1.Visible = false
        crosshair.line2.Visible = false
    end
end)
local rotateTime = 0
local haveGun = false
local searchingTrace = false
local shootTracers = {}
local oldRotate = nil
local setRotateOnce = false
local headRot = nil
for i,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if v.Name:find("Rot") then
        headRot = v;
    end
end
local fovEdited = false
local tick = true
gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    tick=not tick
    if game:GetService("Players").LocalPlayer.Character == nil then return; end
    if gui:GetState("Misc", "FoV") ~= 0 or fovEdited then 
        game:GetService("Workspace").CurrentCamera.FieldOfView = gui:GetState("Misc", "FoV")
    elseif gui:GetState("Misc", "FoV") ~= 0 then
        fovEdited = true
    end
    ActiveFunctions.Enabled = gui:IsChecked("Colors", "Function List")
    setRotateOnce = false
    oldRotate = game:GetService("Players").LocalPlayer.Character.Humanoid.AutoRotate
    gui.objs["Gui"].Name = randomString(math.random(5,13))
    if gui.objs["MenuOutlineGradient"].Rotation > -180 then
        gui.objs["MenuOutlineGradient"].Rotation = gui.objs["MenuOutlineGradient"].Rotation - 1
    else
        gui.objs["MenuOutlineGradient"].Rotation = 180
    end
    if gui:IsChecked("HvH", "Anti-Aim") then
        local PitchParam = gui:GetDropItem("HvH", "Pitch")
        local Parameter = gui:GetDropItem("HvH", "Yaw")
        if Parameter == "" and PitchParam == ""  then
            if game:GetService("Players").LocalPlayer.Character ~= nil then
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.AutoRotate = true
                end)
            end
        else
            if not headRot and game:GetService("Players").LocalPlayer.Character ~= nil then
                for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v.Name:find("Cam") or v.Name:find("Rot") then
                        headRot = v;
                    end
                end
            end
            if headRot ~= nil and headRot.ClassName == "RemoteEvent" then
                
                if PitchParam == "Down" then
                    print("pitching")
                    --headRot:FireServer(CFrame.new(Vector3.new(0,0,0))*CFrame.Angles(0,0,math.rad(-90)))
                    --headRot:FireServer(0)
                elseif PitchParam == "Forward" then
                    --headRot:FireServer(CFrame.new(Vector3.new(0,0,0))*CFrame.Angles(0,0,math.rad(0)))
                    --headRot:FireServer(0.5)
                elseif PitchParam == "Up" then
                    --headRot:FireServer(CFrame.new(Vector3.new(0,0,0))*CFrame.Angles(math.rad(90),0,0))
                    --headRot:FireServer(1)
                end
            end
            if game:GetService("Players").LocalPlayer.Character ~= nil then
                pcall(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.AutoRotate = false
                end)
            end
            if Parameter == "Random" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(math.random(-20000,20000),0,math.random(-20000,20000)))
            elseif Parameter == "Jitter" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(90), 0)
            elseif Parameter == "Spin" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(gui:GetState("HvH", "Spin Speed", 2)), 0)
            elseif Parameter == "Backwards" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(game.Workspace.CurrentCamera.CFrame.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y,game.Workspace.CurrentCamera.CFrame.Position.Z))
            elseif Parameter == "Zero" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(9.99998000001e+11,0,9.99998000001e+11))
            elseif Parameter == "Sideways" then
                --game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(game.Workspace.CurrentCamera.CFrame.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y,game.Workspace.CurrentCamera.CFrame.Position.Z))
                if gui:IsChecked("HvH", "Left sided", 2) then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(game.Workspace.CurrentCamera.CFrame.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y,game.Workspace.CurrentCamera.CFrame.Position.Z)) * CFrame.Angles(0, math.rad(-90), 0)
                else
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(game.Workspace.CurrentCamera.CFrame.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y,game.Workspace.CurrentCamera.CFrame.Position.Z)) * CFrame.Angles(0, math.rad(90), 0)
                end
            elseif Parameter == "Front" then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(game.Workspace.CurrentCamera.CFrame.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Y,game.Workspace.CurrentCamera.CFrame.Position.Z))
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(180), 0)
            elseif Parameter == "Lock" then
                --TODO AA
                local targetAngle = math.rad(180) -- (25% )
                local flickSpeed = 1.5 --  flick
                local currentAngle = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation.Y
                local angleDifference = targetAngle - currentAngle
                local rotationIncrement = angleDifference * (flickSpeed * 2) 
                
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, rotationIncrement, 0)
            elseif Parameter == "Frik" then
                local frikaeb = math.cos(os.time() * 2) * 45
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(frikaeb), 0)
            end
            if gui:IsChecked("HvH", "Random Jitter") and gui:GetState("HvH", "Jitter") ~= 0 then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(math.random(-gui:GetState("HvH", "Jitter"),gui:GetState("HvH", "Jitter"))), 0)
            elseif tick then
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(gui:GetState("HvH", "Jitter")*2), 0)
            end
            
        end
    elseif setRotateOnce == false then
        setRotateOnce = true
        if game:GetService("Players").LocalPlayer.Character ~= nil then
            pcall(function()
                game:GetService("Players").LocalPlayer.Character.Humanoid.AutoRotate = oldRotate
            end)
        end
    end
    gui:SetText("Debugging","freeRAM", "NET free RAM: "..tostring(settings().Network.FreeMemoryMBytes).." mb")
    gui:SetText("Debugging","processedDatamodels", "Processed DataModels: "..tostring(settings().Diagnostics.JobCount))
    gui:SetText("Debugging","renderInst", "Count of rendering instances: "..tostring(settings().Diagnostics.InstanceCount))
    
    if gui:IsChecked("Debugging", "Bounding boxes") then
        settings():GetService("RenderSettings").ShowBoundingBoxes = true
    else
        settings():GetService("RenderSettings").ShowBoundingBoxes = false
    end
    if gui:IsChecked("Debugging", "Show joints XYZ") then
        settings().Physics.AreJointCoordinatesShown = true
    else
        settings().Physics.AreJointCoordinatesShown = false
    end
    if gui:IsChecked("Debugging", "Show model tree") then
        settings().Physics.IsTreeShown = true
    else
        settings().Physics.IsTreeShown = false
    end
    if gui:IsChecked("Debugging", "Use legacy CSG") then
        settings().Physics.DisableCSGv2 = true
    else
        settings().Physics.DisableCSGv2 = false
    end
    if gui:IsChecked("Debugging", "Show assemblies") then
        settings().Physics.AreAssembliesShown = true
    else
        settings().Physics.AreAssembliesShown = false
    end
    if gui:IsChecked("Debugging", "Show NET owners") then
        settings().Physics.AreOwnersShown = true
    else
        settings().Physics.AreOwnersShown = false
    end
    if gui:IsChecked("Debugging", "Show anchors",2) then
        settings().Physics.AreAnchorsShown = true
    else
        settings().Physics.AreAnchorsShown = false
    end
    if gui:IsChecked("Debugging", "Show mechanisms",2) then
        settings().Physics.AreMechanismsShown = true
    else
        settings().Physics.AreMechanismsShown = false
    end
    if gui:IsChecked("Debugging", "Script stack tracing",2) then
        settings().Diagnostics.IsScriptStackTracingEnabled = true
    else
        settings().Diagnostics.IsScriptStackTracingEnabled = false
    end
end)
gui["Hooks"][#gui["Hooks"]+1] = game:GetService("Players").LocalPlayer:GetMouse().Button1Down:Connect(function()
    if gui:IsExist("Visuals", "Shoot tracer", 3) and gui:IsChecked("Visuals", "Shoot tracer", 3) then
        if (lplr.Backpack:FindFirstChild("Gun") or lplr.Character:FindFirstChild("Gun")) then
            local gun = lplr.Backpack:FindFirstChild("Gun") or lplr.Character:FindFirstChild("Gun")
            haveGun = true
            if searchingTrace == false then
                searchingTrace = true
                spawn(function()
                    while haveGun do
                        wait()
                        if not gun.Handle then break end
                        local InitalPos = gun.Handle.Position
                        local ImpactPos = nil
                        repeat
                            if not haveGun then break end
                            pcall(function() ImpactPos = game:GetService("Workspace").Part end)
                            wait()
                        until ImpactPos ~= nil
                        if not haveGun or not ImpactPos then break end
                        if ImpactPos.Size == Vector3.new(0.2,0.2,0.2) then break end
                        --print("Creating line")
                        --print(ImpactPos.Size)
                        ImpactPos:Clone()
                        ImpactPos = ImpactPos.Position
                        local timestamp = tostring(tick())
                        shootTracers[timestamp] = {}
                        shootTracers[timestamp]["pos1"] = InitalPos
                        shootTracers[timestamp]["pos2"] = ImpactPos
                        shootTracers[timestamp]["line"] = Drawing.new("Line")
                        shootTracers[timestamp]["time"] = tick()
                        shootTracers[timestamp]["connect"] = game:GetService("RunService").RenderStepped:Connect(function()
                            local camera = game:GetService("Workspace").CurrentCamera
                            local pos1, onScreen1 = camera:WorldToViewportPoint(shootTracers[timestamp]["pos1"])
                            local pos2, onScreen2 = camera:WorldToViewportPoint(shootTracers[timestamp]["pos2"])
                            if onScreen1 and onScreen2 then
                                shootTracers[timestamp]["line"].Color = Color3.fromRGB(185,0,0)
                                shootTracers[timestamp]["line"].From = Vector2.new(pos1.X,pos1.Y)
                                shootTracers[timestamp]["line"].To = Vector2.new(pos2.X,pos2.Y)
                                shootTracers[timestamp]["line"].Visible = true
                            else
                                shootTracers[timestamp]["line"].Visible = false
                            end
                        end)
                        gui["Hooks"][#gui["Hooks"]+1] = shootTracers[timestamp]["connect"]
                        spawn(function()
                            wait(5)
                            shootTracers[timestamp]["connect"]:Disconnect()
                            shootTracers[timestamp]["line"].Visible = false
                        end)
                    end
                    searchingTrace = false
                end)
            end
        else
            haveGun = false
        end
    end
end)
print("SpiralHack v1\nmade by slaimmials\ndiscord: admin16")
gui.objs["Gui"].Enabled = true

gui:SetButtonExec("Misc", "Unload", function()
    gui.Loaded = false
    for _,hook in pairs(gui["Hooks"]) do
        spawn(function()hook:Disconnect()end)
    end
    gui.objs["Gui"]:Destroy()
end)
end)
