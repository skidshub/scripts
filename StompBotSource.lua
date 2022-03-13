getgenv().ServerHopTime = 120
local success, err = pcall(function()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i,v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") then
            v.Color = Color3.fromRGB(0,0,0)
        elseif v:IsA("Decal") and decalsyeeted then 
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then 
            v.Lifetime = NumberRange.new(0)
        end
    end
    repeat wait() until game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name)
    game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Visible = true
    game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Position = game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Size.Y)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TextLabel = Instance.new("TextLabel")
    local TextButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    
    game.Players.LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
    end)
    
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Name = tostring(math.random(999,9999999))
    
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Position = UDim2.new(0.230049878, 0, 0.48120302, 0)
    Frame.Size = UDim2.new(0, 327, 0, 83)
    Frame.Active = true
    Frame.Draggable = true
    
    UICorner.Parent = Frame
    
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.0366972461, 0, 0.108433738, 0)
    TextLabel.Size = UDim2.new(0, 306, 0, 24)
    TextLabel.Font = Enum.Font.GothamSemibold
    TextLabel.Text = "Idle"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 16.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local FileName = "StompBotSettings.json"
    
    local _settings_ = {
        Toggle = "No"
    }
    
    local on_ = false
    
    local function LoadData()
        local data = readfile(FileName)
        data = game:GetService("HttpService"):JSONDecode(data)
        if data['Toggle'] == "Yes" then
            on_ = true
        else
            on_ = false
        end
    end
    
    local function SetToggle(BOOLEAN)
        _settings_ = {
            Toggle = BOOLEAN
        }
        writefile(FileName, game:GetService("HttpService"):JSONEncode(_settings_))
    end
    
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Seat") then
            v:Destroy()
        end
    end
    
    if not pcall(function() readfile(FileName) end) then
        writefile(FileName, game:GetService("HttpService"):JSONEncode(_settings_))
    else
        LoadData()
    end
    
    local green = Color3.new(0,255,0)
    local red = Color3.new(255,0,0)
    
    TextButton.Parent = Frame
    if on_ then
        TextButton.BackgroundColor3 = green
    else
        TextButton.BackgroundColor3 = red
    end
    TextButton.Position = UDim2.new(0.269113153, 0, 0.481927723, 0)
    TextButton.Size = UDim2.new(0, 151, 0, 28)
    TextButton.Font = Enum.Font.GothamSemibold
    if on_ then
        TextButton.Text = "ON"
    else
        TextButton.Text = "OFF"
    end
    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.TextSize = 16.000
    
    UICorner_2.Parent = TextButton
    
    local function CreateHideOut()
        local Part = Instance.new("Part",workspace)
        local Name = "HIDE_PART_"..tostring(math.random(9,9999))
        Part.Name = Name
        Part.Size = Vector3.new(50,5,50)
        Part.CFrame = CFrame.new(40000,40000,40000)
        Part.Anchored = true
        Part.Transparency = 1
        return Name
    end
    local PART_ = CreateHideOut()
    local SAFESPOT = game.Workspace:FindFirstChild(PART_)
    
    local _settings_ = {
        Users = {}
    }
    local StopAllStomps = false
    local player = game.Players.LocalPlayer
    local Whitelisted = {}

    coroutine.resume(coroutine.create(function()
        wait(ServerHopTime)
        game.StarterGui:SetCore("SendNotification",{
            Title = "Stomp Bot!";
            Text = "SERVER HOPPING!";
            Duration = math.huge;
            Button1 = "OK";
        })
        StopAllStomps = false
        local servers_ = {}
        local servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
        for i,v in ipairs(servers) do
            if type(v) == "table" and v.id ~= game.JobId and v.maxPlayers > 35 then
                table.insert(servers_,v.id)
            end
        end
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("MeshPart") or v.Name == "Humanoid" or v.Name == "HumanoidRootPart" or v:IsA("Accessory") then
                v:Destroy()
            end
        end
        game.Players.LocalPlayer.CharacterAdded:Wait()
        wait(1)
        if #servers_ > 0 then
            for i=1,10 do
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers_[math.random(1, #servers_)])
                wait(5)
            end
        end
    end))

    coroutine.resume(coroutine.create(function()
        while wait() do
            function CheckPlayers()
                local cnt = 0
                for i,v in pairs(game.Players:GetChildren()) do
                    cnt = cnt + 1
                end
                return cnt
            end
            if CheckPlayers() <= 25 then
                local servers_ = {}
                local servers = game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
                for i,v in ipairs(servers) do
                    if type(v) == "table" and v.id ~= game.JobId and v.maxPlayers > 35 then
                        table.insert(servers_,v.id)
                    end
                end
                game.Players.LocalPlayer.Character.Humanoid.Health = 0
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("MeshPart") or v.Name == "Humanoid" or v.Name == "HumanoidRootPart" or v:IsA("Accessory") then
                        v:Destroy()
                    end
                end
                game.Players.LocalPlayer.CharacterAdded:Wait()
                wait(1)
                if #servers_ > 0 then
                    for i=1,10 do
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers_[math.random(1, #servers_)])
                        wait(5)
                    end
                end
            end
        end
    end))
    
    local FileName = "StompBot.json"
    
    local function LoadData()
        local data = readfile(FileName)
        data = game:GetService("HttpService"):JSONDecode(data)
        Whitelisted = data['Users']
    end
    
    if not pcall(function() readfile(FileName) end) then
        writefile(FileName, game:GetService("HttpService"):JSONEncode(_settings_))
    else
        LoadData()
    end

    local function CheckForKnives(_base_)
        local BaseTarget = game.Players:FindFirstChild(_base_)
        if BaseTarget == nil then
            return false
        end
        for i,v in pairs(game.Players:GetChildren()) do
            if (v.Character.HumanoidRootPart.Position-BaseTarget.Character.HumanoidRootPart.Position).Magnitude < 10 then
                if v.Character:FindFirstChild("[Knife]") then
                    return true
                end
            end
        end
        return false
    end
    
    local function GetTarget()
        for i,v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                if not table.find(Whitelisted,v.Name) then
                    if v.Character then
                        if v.Character.BodyEffects:FindFirstChild("K.O").Value == true then
                            if CheckForKnives(v.Name) == false then
                                return v.Name
                            end
                        end
                    end
                end
            end
        end
        return nil
    end
    
    game.Players.LocalPlayer.Chatted:Connect(function(msg)
        msg = string.lower(msg)
        msg = string.split(msg," ")
        if msg[1] and msg[2] then
            if msg[1] == "/whitelist" then
                for i,v in pairs(game.Players:GetChildren()) do
                    if v.Name ~= game.Players.LocalPlayer.Name then
                        if (string.sub(string.lower(v.Name),1,string.len(msg[2]))) == string.lower(msg[2]) then
                            game.StarterGui:SetCore("SendNotification",{
                                Title = "User!";
                                Text = "Stomp bot will now avoid stomping "..v.Name;
                                Duration = 10;
                            })
                            table.insert(Whitelisted,v.Name)
                            _settings_['Users'] = Whitelisted
                            writefile(FileName, game:GetService("HttpService"):JSONEncode(_settings_))
                            LoadData()
                        end
                    end
                end
            end
        end
    end)
    
    game:GetService("RunService").Stepped:Connect(function()
        if TextButton.BackgroundColor3 == green then
            if game.Players.LocalPlayer.Character.BodyEffects:FindFirstChild("K.O").Value == true then
                game.Players.LocalPlayer.Character.Humanoid.Health = 0
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("MeshPart") or v.Name == "Humanoid" or v.Name == "HumanoidRootPart" or v:IsA("Accessory") then
                        v:Destroy()
                    end
                end
            end
        end
    end)
    
    local function StompMF()
        while wait(0.01) do
            if TextButton.BackgroundColor3 == red then
                break
            end
            if StopAllStomps then
                break
            end
            game.ReplicatedStorage.MainEvent:FireServer("Block",true)
            local success, err = pcall(function()
                local target = GetTarget()
                if target ~= nil then
                    if game.Players:FindFirstChild(target).Character then
                        TextLabel.Text = "Stomping "..target
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players:FindFirstChild(target).Character.UpperTorso.Position.X,game.Players:FindFirstChild(target).Character.UpperTorso.Position.Y+1.5,game.Players:FindFirstChild(target).Character.UpperTorso.Position.Z)
                        game.ReplicatedStorage.MainEvent:FireServer("Stomp")
                    end
                else
                    TextLabel.Text = "Waiting for a target... or hopping"
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:FindFirstChild(PART_).CFrame.X,workspace:FindFirstChild(PART_).CFrame.Y+5,workspace:FindFirstChild(PART_).CFrame.Z)
                end
            end)
        end
    end
    
    TextButton.MouseButton1Click:Connect(function()
        if TextButton.BackgroundColor3 == red then
            TextButton.BackgroundColor3 = green
            TextButton.Text = "ON"
            SetToggle("Yes")
            StompMF()
        else
            SetToggle("No")
            TextButton.Text = "OFF"
            TextButton.BackgroundColor3 = red
        end
    end)
    
    if on_ then
        StompMF()
    end
end)
