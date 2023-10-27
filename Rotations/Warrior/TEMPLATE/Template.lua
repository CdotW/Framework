-- [✓⁡ ⁡- BASE] [⁡⁣⁣⁢🚧 - 𝙏𝙀𝙈𝙋𝙇𝘼𝙏𝙀 - 🚧⁡] - Template for A Profiles Spec

local _G, setmetatable                   = _G, setmetatable
local TMW                                = TMW
local CNDT                               = TMW.CNDT
local Env                                = CNDT.Env
local Action                             = Action
local CONST                              = Action.CONST
local Listener                           = Action.Listener
local Create                             = Action.Create
local GetToggle                          = Action.GetToggle
local GetState                           = Action.GetState
local GetGCD                             = Action.GetGCD
local BurstIsOn                          = Action.BurstIsOn
local EnemyTeam                          = Action.EnemyTeam
local FriendlyTeam                       = Action.FriendlyTeam
local LoC                                = Action.LoC
local Player                             = Action.Player
local Pet                                = LibStub("PetLibary")
local MultiUnits                         = Action.MultiUnits
local UnitCooldown                       = Action.UnitCooldown
local Unit                               = Action.Unit
local IsUnitEnemy                        = Action.IsUnitEnemy
local IsUnitFriendly                     = Action.IsUnitFriendly
local ActiveUnitPlates                   = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit              = IsIndoors, UnitIsUnit
local pairs                              = pairs
local ACTION_CONST_CLASS_SPEC            = CONST.CLASS_SPEC
local ACTION_CONST_SPELLID_FREEZING_TRAP = CONST.SPELLID_FREEZING_TRAP

-- [⁡⁢⁢✔⁢⁡⁣⁢⁣⁡ ⁡- TOOL] [ ⁡⁢⁢⁣𝙏𝙊𝘼𝙎𝙏𝙀𝙍⁡ ] to display a toast message
local Toaster                            = _G.Toaster
local GetSpellTexture                    = _G.TMW.GetSpellTexture
Toaster:Register("DarkosToast", function(toast, ...)
    local title, message, spellID = ...
    toast:SetTitle(title or "nil")
    toast:SetText(message or "nil")
    if spellID then
        if type(spellID) ~= "number" then
            error(tostring(spellID) .. " (spellID) is not a number for DarkosToast")
            toast:SetIconTexture("Interface\\FriendsFrame\\Battlenet-WoWicon")
        else
            toast:SetIconTexture((GetSpellTexture(spellID)))
        end
    else
        toast:SetIconTexture("Interface\\FriendsFrame\\Battlenet-WoWicon")
    end
    toast:SetUrgencyLevel("very_low")
end)

-- [✔ - SPELLS] [ ⁡⁢⁢⁣𝙑𝘼𝙍𝘼𝘽𝙇𝙀𝙎⁡ ] - to put each spell into a var to be used
Action[ACTION_CONST_CLASS_SPEC] = {
    --Racial
    ArcaneTorrent     = Action.Create({ Type = "Spell", ID = 50613 }),
    BloodFury         = Action.Create({ Type = "Spell", ID = 20572 }),
    Fireblood         = Action.Create({ Type = "Spell", ID = 265221 }),
    AncestralCall     = Action.Create({ Type = "Spell", ID = 274738 }),
    Berserking        = Action.Create({ Type = "Spell", ID = 26297 }),
    ArcanePulse       = Action.Create({ Type = "Spell", ID = 260364 }),
    QuakingPalm       = Action.Create({ Type = "Spell", ID = 107079 }),
    Haymaker          = Action.Create({ Type = "Spell", ID = 287712 }),
    BullRush          = Action.Create({ Type = "Spell", ID = 255654 }),
    WarStomp          = Action.Create({ Type = "Spell", ID = 20549 }),
    GiftofNaaru       = Action.Create({ Type = "Spell", ID = 59544 }),
    Shadowmeld        = Action.Create({ Type = "Spell", ID = 58984 }),
    Stoneform         = Action.Create({ Type = "Spell", ID = 20594 }),
    BagofTricks       = Action.Create({ Type = "Spell", ID = 312411 }),
    WilloftheForsaken = Action.Create({ Type = "Spell", ID = 7744 }),
    EscapeArtist      = Action.Create({ Type = "Spell", ID = 20589 }),
    WilltoSurvive     = Action.Create({ Type = "Spell", ID = 59752 }),
    LightsJudgment    = Action.Create({ Type = "Spell", ID = 255647 }),

}
Action:CreateEssencesFor(ACTION_CONST_CLASS_SPEC)
local A      = setmetatable(Action[ACTION_CONST_CLASS_SPEC], { __index = Action })
local player = "player"
local pet    = "pet"
local target = "target"

local Temp   = {
    TotalAndPhys             = { "TotalImun", "DamagePhysImun" },
    TotalAndCC               = { "TotalImun", "CCTotalImun" },
    TotalAndPhysKick         = { "TotalImun", "DamagePhysImun", "KickImun" },
    TotalAndPhysAndCC        = { "TotalImun", "DamagePhysImun", "CCTotalImun" },
    TotalAndPhysAndStun      = { "TotalImun", "DamagePhysImun", "StunImun" },
    TotalAndPhysAndCCAndStun = { "TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun" },
    TotalAndMag              = { "TotalImun", "DamageMagicImun" },
    TotalAndMagKick          = { "TotalImun", "DamageMagicImun", "KickImun" },
    DisablePhys              = { "TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun" },
    DisableMag               = { "TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun" },
    incomingAoEDamage        = {
        192305,                          -- Eye of the Storm (mini-boss)
        200901,                          -- Eye of the Storm (boss)
        153804,                          -- Inhale
        175988,                          -- Omen of Death
        106228,                          -- Nothingness
        388008,                          -- Absolute Zero
        191284,                          -- Horn of Valor (HoV)
    },
    incAoEMagic              = { 372735, -- Tectonic Slam (RLP)
        385536,                          -- Flame Dance (RLP)
        392488,                          -- Lightning Storm (RLP)
        392486,                          -- Lightning Storm (RLP)
        372863,                          -- Ritual of Blazebinding (RLP)
        373680, 373688,                  -- Frost Overload (RLP)
        374720,                          -- Consuming Stomp (AV)
        384132,                          -- Overwhelming Energy (AV)
        388804,                          -- Unleashed Destruction (AV)
        388817,                          -- Shards of Stone (NO)
        387135,                          -- Arcing Strike (NO)
        387145,                          -- Totemic Overload (NO)
        386012,                          -- Stormbolt (NO)
        386025,                          -- Tempest (NO)
        384620,                          -- Electrical Storm (NO)
        387411,                          -- Death Bolt Volley (NO)
        387145,                          -- Totemic Overload (NO)
        377004,                          -- Deafening Screech (AA)
        388537,                          -- Arcane Fissue (AA)
        388923,                          -- Burst Forth (AA)
        212784,                          -- Eye Storm (CoS)
        211406,                          -- Firebolt (CoS)
        207906,                          -- Burning Intensity (CoS)
        207881,                          -- Infernal Eruption (CoS)
        397892,                          -- Scream of Pain (CoS)
        153094,                          -- Whispers of the Dark Star (SBG)
        164974,                          -- Dark Eclipse (SBG)
    },
}

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢𝟯⁡] [🚧 - ⁡⁣⁢⁣𝗦𝗧 𝙍𝙊𝙏𝘼𝙏𝙄𝙊𝙉⁡ - 🚧] - the main rotation for ST mostly
A[3] = function(icon, isMulti)
    local isMoving = A.Player:IsMoving()
    local inCombat = Unit(player):CombatTime()
    local ShouldStop = Action.ShouldStop()
    local TTD = MultiUnits.GetByRangeAreaTTD(10)
    local useRacial = A.GetToggle(1, "Racial")
    local rage = Player:Rage()
    local rageDeficit = Player:RageDeficit()
    local activeEnemies = MultiUnits.GetByRange(10, 4)
    Player:AddTier("Tier29", { 200426, 200428, 200423, 200425, 200427, })
    local T29has2P = Player:HasTier("Tier29", 2)
    local T29has4P = Player:HasTier("Tier29", 4)

    local function DamageRotation(unitID)
        local inMelee = A.MortalStrike:IsInRange(unitID)
        local useBurst = BurstIsON(unitID) and (Unit(unitID):TimeToDie() > 15 or TTD > 15)
    end
end

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢𝟭⁡⁡] [🚧 ⁡⁣⁣⁢-⁡ ⁡⁣⁣⁢𝗖𝗖⁡ ⁡⁣⁢⁢AntiFake⁡ ⁡⁣⁢⁣𝗥𝗢𝗧𝗔𝗧𝗜𝗢𝗡⁡ ⁡⁣⁣⁢-⁡ 🚧] -
A[1] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁡⁢⁣⁢𝟮⁡⁡] [🚧 ⁡⁣⁣⁢-⁡ ⁡⁣⁣⁢𝙆𝙄𝘾𝙆⁡ ⁡⁣⁢⁢AntiFake⁡ ⁡⁣⁢⁣⁡⁣⁢⁣𝗥𝗢𝗧𝗔𝗧𝗜𝗢𝗡⁡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[2] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢4⁡⁡] [🚧 ⁡⁣⁣⁢-⁡⁣⁢⁣ 𝘼𝙊𝙀 ⁡⁡⁣⁢⁣𝗥𝗢𝗧𝗔𝗧𝗜𝗢𝗡⁡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[4] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢5⁡] [🚧 ⁡⁣⁣⁢-⁡ ⁡⁢⁣⁣𝙏𝙍𝙄𝙉𝙆𝙀𝙏⁡⁡ ⁡⁣⁢⁢AntiFake⁡ ⁡⁣⁢⁣𝗥𝗢𝗧𝗔𝗧𝗜𝗢𝗡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[5] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢6⁡] [🚧 ⁡⁣⁣⁢-⁡ 𝙋𝘼𝙎𝙎𝙄𝙑𝙀: ⁡⁢⁣⁣@player⁡⁡, ⁡⁢⁢⁣@raid1⁡, ⁡⁢⁣⁣@party1⁡, ⁡⁢⁢⁣@arena1⁡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[6] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢𝟳⁡]🚧 ⁡⁣⁣⁢-⁡ ⁡⁣⁣⁡⁢⁢⁢𝙋𝘼𝙎𝙎𝙄𝙑𝙀⁡: ⁡⁢⁣⁣@player⁡⁡, ⁡⁢⁢⁣@raid1⁡, ⁡⁢⁣⁣@party1⁡, ⁡⁢⁢⁣@arena1⁡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[7] = nil

-- [🚧⁢✔⁢⁡⁣⁢⁣- ⁡⁢⁣⁢8⁡] [🚧 ⁡⁣⁣⁢-⁡ ⁡⁣⁣𝙋𝘼𝙎𝙎𝙄𝙑𝙀: ⁡⁢⁣⁣@player⁡⁡, ⁡⁢⁢⁣@raid1⁡, ⁡⁢⁣⁣@party1⁡, ⁡⁢⁢⁣@arena1⁡⁡  ⁡⁣⁣⁢- ⁡🚧] -
A[8] = nil
