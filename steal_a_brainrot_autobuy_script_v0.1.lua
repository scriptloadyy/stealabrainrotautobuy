-- Last updated 31 August 2025 20:15 CDT
-- Updated to continuously move to animal and hold prompt, including Lucky Blocks

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local running = true

-- Version info
local version = "Version 1.0 — Last Updated 31 August 2025 20:15 CDT"

-- Allowed pets: only Common and Lucky Blocks included
local allowedNames = {

    -- Lucky Blocks
    ["Lucky Block"] = {
        { Rarity = "Mythic", Purchase = false },
        { Rarity = "Brainrot God", Purchase = false },
        { Rarity = "Secret", Purchase = true },
        { Rarity = "Admin", Purchase = true },
    },

    -- Common
    ["Noobini Pizzanini"] = { Purchase = false, Rarity = "Common" },
    ["Lirilì Larilà"] = { Purchase = false, Rarity = "Common" },
    ["Tim Cheese"] = { Purchase = false, Rarity = "Common" },
    ["Fluriflura"] = { Purchase = false, Rarity = "Common" },
    ["Talpa Di Fero"] = { Purchase = false, Rarity = "Common" },
    ["Svinina Bombardino"] = { Purchase = false, Rarity = "Common" },
    ["Pipi Kiwi"] = { Purchase = false, Rarity = "Common" },
    ["Pipi Corni"] = { Purchase = false, Rarity = "Common" },
    ["Raccooni Jandelini"] = { Purchase = false, Rarity = "Common" },

    -- Rare
    ["Trippi Troppi"] = { Purchase = false, Rarity = "Rare" },
    ["Tung Tung Tung Sahur"] = { Purchase = false, Rarity = "Rare" },
    ["Gangster Footera"] = { Purchase = false, Rarity = "Rare" },
    ["Bandito Bobritto"] = { Purchase = false, Rarity = "Rare" },
    ["Boneca Ambalabu"] = { Purchase = false, Rarity = "Rare" },
    ["Cacto Hipopotamo"] = { Purchase = false, Rarity = "Rare" },
    ["Ta Ta Ta Ta Sahur"] = { Purchase = false, Rarity = "Rare" },
    ["Tric Trac Baraboom"] = { Purchase = false, Rarity = "Rare" },
    ["Pipi Avocado"] = { Purchase = false, Rarity = "Rare" },

    -- Epic
    ["Cappuccino Assassino"] = { Purchase = false, Rarity = "Epic" },
    ["Brr Brr Patapim"] = { Purchase = false, Rarity = "Epic" },
    ["Trulimero Trulicina"] = { Purchase = false, Rarity = "Epic" },
    ["Bambini Crostini"] = { Purchase = false, Rarity = "Epic" },
    ["Bananita Dolphinita"] = { Purchase = false, Rarity = "Epic" },
    ["Perochello Lemonchello"] = { Purchase = false, Rarity = "Epic" },
    ["Brri Brri Bicus Dicus Bombicus"] = { Purchase = false, Rarity = "Epic" },
    ["Avocadini Guffo"] = { Purchase = false, Rarity = "Epic" },
    ["Ti Ti Ti Sahur"] = { Purchase = false, Rarity = "Epic" },
    ["Salamino Penguino"] = { Purchase = false, Rarity = "Epic" },
    ["Penguino Cocosino"] = { Purchase = false, Rarity = "Epic" },
    ["Avocadini Antilopini"] = { Purchase = false, Rarity = "Epic" },

    -- Legendary
    ["Burbaloni Loliloli"] = { Purchase = false, Rarity = "Legendary" },
    ["Chimpanzini Bananini"] = { Purchase = false, Rarity = "Legendary" },
    ["Ballerina Cappuccina"] = { Purchase = false, Rarity = "Legendary" },
    ["Chef Crabracadabra"] = { Purchase = false, Rarity = "Legendary" },
    ["Lionel Cactuseli"] = { Purchase = false, Rarity = "Legendary" },
    ["Glorbo Fruttodrillo"] = { Purchase = false, Rarity = "Legendary" },
    ["Blueberrini Octopusini"] = { Purchase = false, Rarity = "Legendary" },
    ["Strawberelli Flamingelli"] = { Purchase = false, Rarity = "Legendary" },
    ["Cocosini Mama"] = { Purchase = false, Rarity = "Legendary" },
    ["Pandaccini Bananini"] = { Purchase = false, Rarity = "Legendary" },
    ["Pi Pi Watermelon"] = { Purchase = false, Rarity = "Legendary" },
    ["Sigma Boy"] = { Purchase = false, Rarity = "Legendary" },
    ["Quivioli Ameleonni"] = { Purchase = false, Rarity = "Legendary" },

    -- Mythic
    ["Frigo Camelo"] = { Purchase = false, Rarity = "Mythic" },
    ["Orangutini Ananassini"] = { Purchase = false, Rarity = "Mythic" },
    ["Rhino Toasterino"] = { Purchase = false, Rarity = "Mythic" },
    ["Bombardiro Crocodilo"] = { Purchase = false, Rarity = "Mythic" },
    ["Spioniro Golubiro"] = { Purchase = false, Rarity = "Mythic" },
    ["Bombombini Gusini"] = { Purchase = false, Rarity = "Mythic" },
    ["Avocadorilla"] = { Purchase = false, Rarity = "Mythic" },
    ["Zibra Zubra Zibralini"] = { Purchase = false, Rarity = "Mythic" },
    ["Tigrilini Watermelini"] = { Purchase = false, Rarity = "Mythic" },
    ["Cavallo Virtuso"] = { Purchase = false, Rarity = "Mythic" },
    ["Gorillo Watermelondrillo"] = { Purchase = false, Rarity = "Mythic" },
    ["Tob Tobi Tobi"] = { Purchase = false, Rarity = "Mythic" },
    ["Ganganzelli Trulala"] = { Purchase = false, Rarity = "Mythic" },
    ["Te Te Te Sahur"] = { Purchase = false, Rarity = "Mythic" },
    ["Tracoducotulu Delapeladustuz"] = { Purchase = false, Rarity = "Mythic" },
    ["Carloo"] = { Purchase = false, Rarity = "Mythic" },
    ["Lerulerulerule"] = { Purchase = false, Rarity = "Mythic" },
    ["Carrotini Brainini"] = { Purchase = false, Rarity = "Mythic" },

    -- Brainrot God
    ["Cocofanto Elefanto"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Girafa Celestre"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Gattatino Nyanino"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Matteo"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Tralalero Tralala"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Los Crocodillitos"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Espresso Signora"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Odin Din Din Dun"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Unclito Samito"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Tukanno Bananno"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Trenostruzzo Turbo 3000"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Trippi Troppi Troppa Trippa"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Ballerino Lololo"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Los Tungtungtungcitos"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Piccione Macchina"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Los Orcalitos"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Tigroligre Frutonni"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Orcalero Orcala"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Bulbito Bandito Traktorito"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Tipi Topi Taco"] = { Purchase = true, Rarity = "Brainrot God" },
    ["Bombardini Tortinii"] = { Purchase = true, Rarity = "Brainrot God" },
    ["Tralalita Tralala"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Urubini Flamenguini"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Tartaruga Cisterna"] = { Purchase = true, Rarity = "Brainrot God" }, -- Admin only
    ["Brr es Teh Patipum"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Pakrahmatmamat"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Alessio"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Los Bombinitos"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Crabbo Limonetta"] = { Purchase = true, Rarity = "Brainrot God" },
    ["Mastodontico Telepiedone"] = { Purchase = false, Rarity = "Brainrot God" },
    ["Cacasito Satalito"] = { Purchase = false, Rarity = "Brainrot God" },

    -- Secret
    ["La Vacca Saturno Saturnita"] = { Purchase = true, Rarity = "Secret" },
    ["Karkerkar Kurkur"] = { Purchase = true, Rarity = "Secret" }, -- Admin only
    ["Sammyni Spyderini"] = { Purchase = true, Rarity = "Secret" }, -- Admin only
    ["Agarrini la Palini"] = { Purchase = true, Rarity = "Secret" },
    ["Los Tralaleritos"] = { Purchase = true, Rarity = "Secret" },
    ["Las Tralaleritas"] = { Purchase = true, Rarity = "Secret" },
    ["Las Vaquitas Saturnitas"] = { Purchase = true, Rarity = "Secret" },
    ["Graipuss Medussi"] = { Purchase = true, Rarity = "Secret" },
    ["Chicleteira Bicicleteira"] = { Purchase = true, Rarity = "Secret" },
    ["La Grande Combinasion"] = { Purchase = true, Rarity = "Secret" },
    ["Los Combinasionas"] = { Purchase = true, Rarity = "Secret" },
    ["Nuclearo Dinossauro"] = { Purchase = true, Rarity = "Secret" },
    ["Los Hotspotsitos"] = { Purchase = true, Rarity = "Secret" },
    ["Garama and Madundung"] = { Purchase = true, Rarity = "Secret" },
    ["Dragon Cannelloni"] = { Purchase = true, Rarity = "Secret" },
    ["Torrtuginni Dragonfrutini"] = { Purchase = true, Rarity = "Secret" },
    ["Pot Hotspot"] = { Purchase = true, Rarity = "Secret" },
    ["Esok Sekolah"] = { Purchase = true, Rarity = "Secret" },
    ["Nooo My Hotspot"] = { Purchase = true, Rarity = "Secret" },
    ["Los Matteos"] = { Purchase = true, Rarity = "Secret" },
    ["Job Job Job Sahur"] = { Purchase = true, Rarity = "Secret" },
    ["Bisonte Giuppitere"] = { Purchase = true, Rarity = "Secret" },
    ["La Supreme Combinasion"] = { Purchase = true, Rarity = "Secret" },
    ["Ketupat Kepat"] = { Purchase = true, Rarity = "Secret" },
    ["Los Spyderinis"] = { Purchase = true, Rarity = "Secret" },
    ["Blackhole Goat"] = { Purchase = true, Rarity = "Secret" },
    ["Dul Dul Dul"] = { Purchase = true, Rarity = "Secret" }, -- Admin only
    ["Spaghetti Tualetti"] = { Purchase = true, Rarity = "Secret" },
    ["Ketchuru and Musturu"] = { Purchase = true, Rarity = "Secret" },
    ["Guerriro Digitale"] = { Purchase = true, Rarity = "Secret" },
    
    -- OG
    ["Strawberry Elephant"] = { Purchase = true, Rarity = "OG" }
}

print("————————————————————————————————————————————————————————————")
print(version)

local function getEnabledPets()
    local pets = {}
    for name, data in pairs(allowedNames) do
        if type(data) == "table" then
            if data.Purchase then
                table.insert(pets, name)
            elseif type(data[1]) == "table" then
                for _, entry in ipairs(data) do
                    if entry.Purchase then
                        table.insert(pets, name .. " (" .. entry.Rarity .. ")")
                    end
                end
            end
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

local function walkToAndPurchase(animal)
    if not running then return end

    local player = workspace:WaitForChild(plr.Name)
    local humanoid = player:WaitForChild("Humanoid")
    local humanoidRoot = player:WaitForChild("HumanoidRootPart")

    local targetPart = animal:FindFirstChild("Part")
    if not targetPart then return end

    local promptAttachment = targetPart:FindFirstChild("PromptAttachment")
    local prompt = promptAttachment and promptAttachment:FindFirstChild("ProximityPrompt")

    while running and targetPart.Parent do
        local targetPos = targetPart.Position
        humanoid:MoveTo(targetPos)

        if prompt then
            prompt:InputHoldBegin()
        end

        task.wait(0.1) -- Update target position and keep holding

        if prompt and targetPart:FindFirstChildOfClass("Sound") then
            prompt:InputHoldEnd()
            print("✅ " .. animal.Part.Info.AnimalOverhead.DisplayName.Text .. " has been successfully purchased.")
            break
        end
    end
end

workspace.ChildAdded:Connect(function(animal)
    if not running then return end
    if not animal:IsA("Model") then return end

    local hrp = animal:WaitForChild("Part", 5)
    if not hrp then return end

    local info = hrp:WaitForChild("Info", 5)
    if not info then return end

    local overhead = info:WaitForChild("AnimalOverhead", 5)
    if not overhead then return end

    local displayName = overhead:WaitForChild("DisplayName", 5)
    local rarity = overhead:FindFirstChild("Rarity")
    if not displayName then return end

    local petData = allowedNames[displayName.Text]

    if petData then
        local shouldPurchase = false
        if petData.Purchase then
            if petData.Rarity and rarity and rarity.Text ~= petData.Rarity then
                shouldPurchase = false
            else
                shouldPurchase = true
            end
        elseif type(petData[1]) == "table" then
            for _, entry in ipairs(petData) do
                if entry.Purchase and rarity and entry.Rarity == rarity.Text then
                    shouldPurchase = true
                    break
                elseif entry.Purchase and not rarity then
                    shouldPurchase = true
                    break
                end
            end
        end

        if shouldPurchase then
            walkToAndPurchase(animal)
        end
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
