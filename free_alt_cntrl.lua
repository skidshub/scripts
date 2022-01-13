--[[
--// Made by Homolife#1525

Auto-Features:
[+] Anti-Afk

Settings:
Enter in the droppers ID's inside of the "getgenv().Droppers = {}" <- inside of {}
Enter in the operators ID's inside of the "getgenv().Operator = {}" <- inside of {}

Only execute this script for the alts.
For Krnl put this script into auto-execute folder.

Default prefix: .
Add a "." to the player argument to apply to all alts.

Commands:

.setup [place] - Setup command
Places: admin

.drop [player] - Starts to drop 10k or below.
.undrop [player] - Stops dropping.
.block [player] - Starts blocking.
.unblock [player] - Starts unblocking.
.bring [player] - Brings an alt/dropper to the operator.
.refresh [player] - Refreshes an alt/droppers character.
.hide [player] - Hides a dropper/alt.
.unhide [player] - Brings back a dropper/alt from hiding.
.ad [player] [message] - Starts to advertise a message.
.unad [player] - Stops advertising.
.freeze [player] - Freezes a player.
.unfreeze [player] - Unfreezes a player.
.air [player] - Makes a alt/dropper float.
.gpu [player] - Makes a alt/dropper screen black to reduce GPU power.
.setfps [player] [FPS] - Reduces a alts FPS.
]]

-- ^^^^^^^^^ OPEN SOURCE!!!

getgenv().Prefix = "."

getgenv().Operator = {}
getgenv().Droppers = {}

--// Made by Homolife#1525
--// discord.gg/encrypt
--// Originally created to prove skids on how easy it is to code an alt control, with advance commands.

local player = game.Players.LocalPlayer

player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),game.Workspace.CurrentCamera.CFrame)
end)

local function notify(a,b,c)
    game.StarterGui:SetCore("SendNotification",{
        Title = a;
        Text = b;
        Duration = c;
    })
end

local function annouce(anc)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(anc, 'All')
end

local function fancynum(num)
    num = tostring(num)
    return num:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local isaopeartor = false

local success, err = pcall(function()
    if table.find(Operator,player.UserId) then
        notify("Operator","Permission granted.",10)
        isaopeartor = true
    else
        notify("Alt","Name: "..player.Name,math.huge)
    end
end)
if err then notify("Error!","Error occured!",5) return end

local origin_spot
local adver_msg
local hidden_origin_spot

local dropping = false
local blocking = false
local advert = false

local function main_cmds(msg,plr)
    if isaopeartor == false or table.find(Operator,plr) then
        local operator = game.Players:GetPlayerByUserId(plr)
        msg = string.lower(msg)
        cmd = string.split(msg," ")
        if cmd[2] and cmd[1] then
            if cmd[1] == Prefix.."setup" then
                local places = {"admin"}
                if table.find(places,cmd[2]) then
                    local success, err = pcall(function()
                        if cmd[2] == 'admin' then
                            local pos = {
                                a1 = "-871,-39,-589",
                                a2 = "-871,-39,-619",
                                a3 = "-906,-40,-620",
                                a4 = "-907,-39,-590",
                                a5 = "-908,-40,-561",
                                a6 = "-873,-39,-559",
                                a7 = "-837,-40,-559",
                                a8 = "-836,-39,-590",
                                a9 = "-837,-40,-619",
                                a10 = "-856,-39,-606",
                                a11 = "-871,-39,-606",
                                a12 = "-887,-39,-606",
                                a13 = "-887,-39,-590",
                                a14 = "-886,-39,-573",
                                a15 = "-872,-39,-574",
                                a16 = "-857,-39,-574",
                                a17 = "-856,-39,-588",
                                a18 = "-820,-40,-629",
                                a19 = "-922,-40,-629",
                                a20 = "-924,-40,-550",
                                a21 = "-821,-40,-549",
                                a22 = "-864,-39,-580",
                                a23 = "-864,-39,-580",
                                a24 = "-881,-39,-580",
                                a25 = "-881,-39,-600",
                                a26 = "-864,-39,-600",
                            }
                            local cnt = 0
                            for i,v in pairs(Droppers) do
                                if game.Players:GetPlayerByUserId(v) then
                                    cnt = cnt + 1
                                    local new_pos = pos['a'..cnt]
                                    local split_cframe = string.split(new_pos,",")
                                    local x,y,z = split_cframe[1],split_cframe[2],split_cframe[3]
                                    game.Players:GetPlayerByUserId(v).Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
                                end
                            end
                            if game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored == true then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                            end
                            local HumanoidRootPart_ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart_.X,HumanoidRootPart_.Y+7,HumanoidRootPart_.Z)
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                        end
                    end)
                    if err then print(err) end
                end
            elseif cmd[1] == Prefix.."drop" then
                if cmd[2] == "." then
                    annouce(player.Name.." started dropping!")
                    dropping = true
                    repeat
                        local dropamt = 10000
                        if player.DataFolder.Currency.Value >= 10000 then
                            dropamt = 10000
                        else
                            dropamt = player.DataFolder.Currency.Value
                        end
                        game.ReplicatedStorage.MainEvent:FireServer("DropMoney",dropamt)
                        wait(0.1)
                    until dropping == false
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    dropping = true
                    annouce(player.Name.." started dropping!")
                    repeat
                        local dropamt = 10000
                        if player.DataFolder.Currency.Value >= 10000 then
                            dropamt = 10000
                        else
                            dropamt = player.DataFolder.Currency.Value
                        end
                        game.ReplicatedStorage.MainEvent:FireServer("DropMoney",dropamt)
                        wait(0.1)
                    until dropping == false
                end
            elseif cmd[1] == Prefix.."undrop" then
                if cmd[2] == "." then
                    annouce(player.Name.." stopped dropping!")
                    dropping = false
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    dropping = false
                    annouce(player.Name.." stopped dropping!")
                end
            elseif cmd[1] == Prefix.."block" then
                if cmd[2] == "." then
                    annouce(player.Name.." started blocking!")
                    blocking = true
                    repeat
                        game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                        wait(0.1)
                    until blocking == false
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    annouce(player.Name.." started blocking!")
                    blocking = true
                    repeat
                        game.ReplicatedStorage.MainEvent:FireServer("Block",true)
                        wait(0.1)
                    until blocking == false
                end
            elseif cmd[1] == Prefix.."unblock" then
                if cmd[2] == "." then
                    annouce(player.Name.." stopped blocking!")
                    blocking = false
                    game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    annouce(player.Name.." stopped blocking!")
                    blocking = false
                    game.ReplicatedStorage.MainEvent:FireServer("Block",false)
                end
            elseif cmd[1] == Prefix.."bring" then
                if cmd[2] == "." then
                    player.Character.HumanoidRootPart.CFrame = operator.Character.HumanoidRootPart.CFrame
                    annouce(player.Name.." is here.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    player.Character.HumanoidRootPart.CFrame = operator.Character.HumanoidRootPart.CFrame
                    annouce(player.Name.." is here.")
                end
            elseif cmd[1] == Prefix.."refresh" then
                if cmd[2] == "." then
                    origin_spot = player.Character.HumanoidRootPart.CFrame
                    player.Character.Humanoid.Health = 0
                    wait(7.5)
                    player.Character.HumanoidRootPart.CFrame = origin_spot
                    annouce(player.Name.." character refreshed.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    origin_spot = player.Character.HumanoidRootPart.CFrame
                    player.Character.Humanoid.Health = 0
                    wait(7.5)
                    player.Character.HumanoidRootPart.CFrame = origin_spot
                    annouce(player.Name.." character refreshed.")
                end
            elseif cmd[1] == Prefix.."hide" then
                if cmd[2] == "." then
                    hidden_origin_spot = player.Character.HumanoidRootPart.CFrame
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(651,47,-441)
                    annouce(player.Name.." is now hidden.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    hidden_origin_spot = player.Character.HumanoidRootPart.CFrame
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(651,47,-441)
                    annouce(player.Name.." is now hidden.")
                end
            elseif cmd[1] == Prefix.."unhide" then
                if cmd[2] == "." then
                    if player.Character.HumanoidRootPart.Anchored == true then
                        player.Character.HumanoidRootPart.Anchored = false
                    end
                    player.Character.HumanoidRootPart.CFrame = hidden_origin_spot
                    annouce(player.Name.." is now unhidden.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    if player.Character.HumanoidRootPart.Anchored == true then
                        player.Character.HumanoidRootPart.Anchored = false
                    end
                    player.Character.HumanoidRootPart.CFrame = hidden_origin_spot
                    annouce(player.Name.." is now unhidden.")
                end
            elseif cmd[1] == Prefix.."air" then
                if cmd[2] == "." then
                    local cur_human = player.Character.HumanoidRootPart.CFrame
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(cur_human.X,cur_human.Y+7,cur_human.Z)
                    wait()
                    player.Character.HumanoidRootPart.Anchored = true
                    annouce(player.Name.." is now floating.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    local cur_human = player.Character.HumanoidRootPart.CFrame
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(cur_human.X,cur_human.Y+7,cur_human.Z)
                    wait()
                    player.Character.HumanoidRootPart.Anchored = true
                    annouce(player.Name.." is now floating.")
                end
            elseif cmd[1] == Prefix.."unad" then
                if cmd[2] == "." then
                    advert = false
                    annouce(player.Name.." stopped advertising.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    advert = false
                    annouce(player.Name.." stopped advertising.")
                end
            elseif cmd[1] == Prefix.."freeze" then
                if cmd[2] == "." then
                    player.Character.HumanoidRootPart.Anchored = true
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    player.Character.HumanoidRootPart.Anchored = true
                end
            elseif cmd[1] == Prefix.."unfreeze" then
                if cmd[2] == "." then
                    player.Character.HumanoidRootPart.Anchored = false
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    player.Character.HumanoidRootPart.Anchored = false
                end
            elseif cmd[1] == Prefix.."gpu" then
                if cmd[2] == "." then
                    local qwertgh = Instance.new("ScreenGui")
                    local Frame = Instance.new("Frame")
                    qwertgh.Name = "qwertgh"
                    qwertgh.Parent = game.CoreGui
                    qwertgh.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

                    Frame.Parent = qwertgh
                    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.Position = UDim2.new(-0.34374997, 0, -0.585276067, 0)
                    Frame.Size = UDim2.new(0, 10000, 0, 10000)
                    annouce(player.Name.." has GPU saver on.")
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    local qwertgh = Instance.new("ScreenGui")
                    local Frame = Instance.new("Frame")
                    qwertgh.Name = "qwertgh"
                    qwertgh.Parent = game.CoreGui
                    qwertgh.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

                    Frame.Parent = qwertgh
                    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.Position = UDim2.new(-0.34374997, 0, -0.585276067, 0)
                    Frame.Size = UDim2.new(0, 10000, 0, 10000)
                    annouce(player.Name.." has GPU saver on.")
                end
            end
        elseif cmd[1] and cmd[2] and cmd[3] then
            if cmd[1] == Prefix.."setfps" then
                if cmd[2] == "." then
                    setfps(tonumber(cmd[3]))
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    setfps(tonumber(cmd[3]))
                end
            elseif cmd[1] == Prefix.."ad" then
                if cmd[2] == "." then
                    advert = false
                    annouce(player.Name.." started advertising.")
                    advert = true
                    adver_msg = cmd[3]
                    repeat
                        annouce(adver_msg)
                        wait(3)
                    until advert == false
                elseif (string.sub(string.lower(player.Name),1,string.len(cmd[2]))) == string.lower(cmd[2]) then
                    advert = true
                    annouce(player.Name.." started advertising.")
                    adver_msg = cmd[3]
                    repeat
                        annouce(adver_msg)
                        wait(3)
                    until advert == false
                end
            end
        end
    end
end

for i,v in pairs(game.Players:GetChildren()) do
    if table.find(Operator,v.UserId) then
        v.Chatted:Connect(function(msg)
            main_cmds(msg,v.UserId)
        end)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    if table.find(Operator,plr.UserId) then
        plr.Chatted:Connect(function(msg)
            main_cmds(msg,plr.UserId)
        end)
    end
end)
