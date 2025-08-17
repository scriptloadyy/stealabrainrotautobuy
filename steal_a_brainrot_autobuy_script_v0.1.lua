-- Last updated 16 August 2025 23:43 CDT
-- Added Tracoducotulu Delapeladustuz, Tralalita Tralala, Urubini Flamenguini, Los Matteos, and Job Job Job Sahur.
-- Fixed directory changes, fixed trivial script pieces, Tracoducotulu Delapeladustuz is now set to false by default

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Version info
local version = "Version 0.42 — Last Updated 16 August 2025 23:43 CDT"

-- This is where the brainrots you wanna buy will be. !! Make sure they all have a , after each entry !!
local allowedNames = {
    -- Common
    ["Noobini Pizzanini"] = false,
    ["Lirilì Larilà"] = false,
    ["Tim Cheese"] = false,
    ["Fluriflura"] = false,
    ["Talpa Di Fero"] = false,
    ["Svinina Bombardino"] = false,
    ["Pipi Kiwi"] = false,
    ["Pipi Corni"] = false,
    -- Rare
    ["Trippi Troppi"] = false,
    ["Tung Tung Tung Sahur"] = false,
    ["Gangster Footera"] = false,
    ["Bandito Bobritto"] = false,
    ["Boneca Ambalabu"] = false,
    ["Cacto Hipopotamo"] = false,
    ["Ta Ta Ta Ta Sahur"] = false,
    ["Tric Trac Baraboom"] = false,
    ["Pipi Avocado"] = false,
    -- Epic
    ["Cappuccino Assassino"] = false,
    ["Brr Brr Patapim"] = false,
    ["Trulimero Trulicina"] = false,
    ["Bambini Crostini"] = false,
    ["Bananita Dolphinita"] = false,
    ["Perochello Lemonchello"] = false,
    ["Brri Brri Bicus Dicus Bombicus"] = false,
    ["Avocadini Guffo"] = false,
    ["Ti Ti Ti Sahur"] = false,
    ["Salamino Penguino"] = false,
    ["Penguino Cocosino"] = false,
    -- Legendary
    ["Burbaloni Loliloli"] = false,
    ["Chimpanzini Bananini"] = false,
    ["Ballerina Cappuccina"] = false,
    ["Chef Crabracadabra"] = false,
    ["Lionel Cactuseli"] = false,
    ["Glorbo Fruttodrillo"] = false,
    ["Blueberrini Octopusini"] = false,
    ["Strawberelli Flamingelli"] = false,
    ["Cocosini Mama"] = false,
    ["Pandaccini Bananini"] = false,
    ["Pi Pi Watermelon"] = false,
    ["Sigma Boy"] = false,
    -- Mythic
    ["Frigo Camelo"] = false,
    ["Orangutini Ananassini"] = false,
    ["Rhino Toasterino"] = false,
    ["Bombardiro Crocodilo"] = false,
    ["Spioniro Golubiro"] = false,
    ["Bombombini Gusini"] = false,
    ["Avocadorilla"] = false,
    ["Zibra Zubra Zibralini"] = false,
    ["Tigrilini Watermelini"] = false,
    ["Cavallo Virtuso"] = false,
    ["Gorillo Watermelondrillo"] = false,
    ["Tob Tobi Tobi"] = false,
    ["Ganganzelli Trulala"] = false,
    ["Te Te Te Sahur"] = false,
	["Tracoducotulu Delapeladustuz"] = false,
    -- Brainrot God
    ["Cocofanto Elefanto"] = false,
    ["Girafa Celestre"] = false,
    ["Gattatino Neonino"] = true, -- Admin only, probably leave it as true.
    ["Matteo"] = true, -- Admin only, probably leave it as true.
    ["Tralalero Tralala"] = true,
    ["Los Crocodillitos"] = true,
    ["Espresso Signora"] = true, -- Admin only, probably leave it as true.
    ["Odin Din Din Dun"] = true,
    ["Statutino Libertino"] = true, -- Admin only, probably leave it as true.
    ["Tukanno Bananno"] = false,
    ["Trenostruzzo Turbo 3000"] = true,
    ["Trippi Troppi Troppa Trippa"] = true,
    ["Ballerino Lololo"] = true,
    ["Los Tungtungtungcitos"] = false,
    ["Piccione Macchina"] = true,
    ["Los Orcalitos"] = false,
    ["Tigroligre Frutonni"] = false,
    ["Orcalero Orcala"] = false,
    ["Bulbito Bandito Traktorito"] = false,
    ["Tipi Topi Taco"] = true,
    ["Bombardini Tortinii"] = true,
	["Tralalita Tralala"] = true,
	["Urubini Flamenguini"] = true,
    -- Secret
    ["La Vacca Saturno Saturnita"] = true,
    ["Karkerkar Kurkur"] = true, -- Admin only, probably leave it as true.
    ["Chimpanzini Spiderini"] = true, -- Admin only, probably leave it as true.
    ["Agarrini la Palini"] = true,
    ["Los Tralaleritos"] = true,
    ["Las Tralaleritas"] = true,
    ["Las Vaquitas Saturnitas"] = true,
    ["Graipuss Medussi"] = true,
    ["Chicleteira Bicicleteira"] = true,
    ["La Grande Combinasion"] = true,
    ["Los Combinasionas"] = true,
    ["Nuclearo Dinossauro"] = true,
    ["Los Hotspotsitos"] = true,
    ["Garama and Madundung"] = true,
    ["Dragon Cannelloni"] = true,
    ["Torrtuginni Dragonfrutini"] = true,
    ["Pot Hotspot"] = true,
    ["Esok Sekolah"] = true,
    ["Nooo My Hotspot"] = true,
	["Los Matteos"] = true,
	["Job Job Job Sahur"] = true
}

local animalsFolder = workspace
local plr = Players.LocalPlayer

local updateTargetInterval = 0.1
local acceptableDistance = 4
local tweenSpeed = 51.261

local running = true

print("————————————————————————————————————————————————————————————")
print(version)

local function getEnabledPets()
    local pets = {}
    for name, enabled in pairs(allowedNames) do
        if enabled then
            table.insert(pets, name)
        end
    end
    if #pets == 0 then
        return "None"
    else
        return table.concat(pets, ", ")
    end
end

print("Pets enabled: " .. getEnabledPets())
print("————————————————————————————————————————————————————————————")

local function tweenToAnimal(animal)
    if not running then return end

    local playerHRP = workspace[plr.Name]:WaitForChild("HumanoidRootPart")
    local lastUpdate = 0

    local hrp = animal:FindFirstChild("Part")
    if not hrp then
        return
    end

    local targetPos = hrp.Position

    local distance = (targetPos - playerHRP.Position).Magnitude
    local tweenTime = distance / tweenSpeed
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(playerHRP, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()

    while running and (playerHRP.Position - targetPos).Magnitude > acceptableDistance do
        local now = tick()
        if now - lastUpdate > updateTargetInterval then
            local newHrp = animal:FindFirstChild("Part")
            if newHrp then
                targetPos = newHrp.Position
            else
                warn("HumanoidRootPart disappeared for animal:", animal.Name)
                break
            end

            lastUpdate = now

            tween:Cancel()

            distance = (targetPos - playerHRP.Position).Magnitude
            tweenTime = distance / tweenSpeed
            tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
            tween = TweenService:Create(playerHRP, tweenInfo, {CFrame = CFrame.new(targetPos)})
            tween:Play()
        end
        task.wait(0.1)
    end
    tween:Cancel()
end

local childAddedConnection
childAddedConnection = animalsFolder.ChildAdded:Connect(function(animal)
    if not running then
        childAddedConnection:Disconnect()
        return
    end

    if not animal:IsA("Model") then
        return
end
    local hrp = animal:WaitForChild("Part", 5)
    if not hrp then
        return
    end

    local info = hrp:WaitForChild("Info", 5)
    if not info then
        return
    end

    local overhead = info:WaitForChild("AnimalOverhead", 5)
    if not overhead then
        return
    end

    local displayName = overhead:WaitForChild("DisplayName", 5)
    if not displayName then
        return
    end

    if allowedNames[displayName.Text] then
        tweenToAnimal(animal)

        local promptAttachment = hrp:FindFirstChild("PromptAttachment")
        if not promptAttachment then
            return
        end

        local prompt = promptAttachment:FindFirstChild("ProximityPrompt")
        if prompt then
            prompt:InputHoldBegin()
            task.wait(1)
            prompt:InputHoldEnd()

            if hrp:FindFirstChildOfClass("Sound") then
                print("✅ " .. displayName.Text .. " has been successfully purchased.")
            else
                print("❌ " .. displayName.Text .. " was unable to be purchased.")
            end
        else
            warn("No ProximityPrompt found for", displayName.Text)
        end
    else
    end
end)

local TextChatService = game:GetService("TextChatService")


TextChatService.OnIncomingMessage = function(message, channel)
    if not running then return end
    if message.TextSource and message.TextSource.UserId == plr.UserId then
        if message.Text:lower() == "stop" then
            running = false
            print("✅ Script successfully disconnected.")
        end
    end
end

