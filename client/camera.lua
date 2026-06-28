-- ============================================================
--  zxhud – Camera Status Indicator · client/camera.lua
--  Detects whether the player is inside a configured camera
--  coverage zone and updates the NUI accordingly.
--
--  Integration strategy:
--    • A lightweight separate thread checks zones every
--      Config.ZoneCheckInterval ms (default 600ms).
--    • The result is stored in a shared local so the MAIN
--      SendNUIMessage calls in Main.lua can embed it with
--      zero extra overhead.
--    • A dedicated SendNUIMessage is also sent whenever the
--      state *changes* for instant visual feedback.
-- ============================================================

-- Shared state – read by Main.lua via the global below
_G.RC2_CameraInZone = false

local lastCameraState = false

-- ──────────────────────────────────────────────────────────
-- Helper: check every configured zone
-- ──────────────────────────────────────────────────────────
local function IsPlayerInCameraZone()
    local ped    = PlayerPedId()
    local coords = GetEntityCoords(ped)

    for _, zone in ipairs(Config.CameraZones) do
        local dist = #(coords - zone.coords)
        if dist <= zone.radius then
            return true
        end
    end

    return false
end

-- ──────────────────────────────────────────────────────────
-- Zone-check thread
-- Runs independently so it never blocks Main.lua's 500ms loop
-- ──────────────────────────────────────────────────────────
CreateThread(function()
    while true do
        Wait(Config.ZoneCheckInterval)

        if LocalPlayer.state.isLoggedIn then
            local inZone = IsPlayerInCameraZone()

            -- Only fire a NUI update when the state actually changes
            -- (avoids flooding the NUI bridge)
            if inZone ~= lastCameraState then
                lastCameraState         = inZone
                _G.RC2_CameraInZone     = inZone

                SendNUIMessage({
                    action   = "updateCamera",
                    inZone   = inZone,
                })

                print(string.format(
                    "^5[zxhud]^7 Camera status changed → %s",
                    inZone and "^2IN ZONE^7" or "^8OUT OF ZONE^7"
                ))
            else
                -- Keep the global in sync even when no event fires
                _G.RC2_CameraInZone = inZone
            end
        end
    end
end)
