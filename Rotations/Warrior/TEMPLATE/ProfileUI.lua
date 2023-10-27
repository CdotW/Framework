-- [✓⁡ ⁡- BASE] [⁡⁣⁣⁢🚧 - 𝙏𝙀𝙈𝙋𝙇𝘼𝙏𝙀 - 🚧⁡] - Template for A Profiles UI
local TMW                                    = TMW
local CNDT                                   = TMW.CNDT
local Env                                    = CNDT.Env
local A                                      = Action
local GetToggle                              = A.GetToggle
local InterruptIsValid                       = A.InterruptIsValid

local UnitCooldown                           = A.UnitCooldown
local Unit                                   = A.Unit
local Player                                 = A.Player
local Pet                                    = A.Pet
local LoC                                    = A.LossOfControl
local MultiUnits                             = A.MultiUnits
local EnemyTeam                              = A.EnemyTeam
local FriendlyTeam                           = A.FriendlyTeam
local TeamCache                              = A.TeamCache
local InstanceInfo                           = A.InstanceInfo
local select, setmetatable                   = select, setmetatable

A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI                             = {
    DateTime = "v1.0.0 (27 Octoberr 2023)",
    -- [✓⁡ ⁡- Spec] [⁡⁣⁣⁢🚧 - 𝙎𝙋𝙀𝘾 𝙏𝙀𝙈𝙋𝙇𝘼𝙏𝙀 - 🚧⁡] - Template for A Profiles UI Spec
    [2] = {
        [ACTION_CONST_CLASS_SPEC] = {

        },
    }
}