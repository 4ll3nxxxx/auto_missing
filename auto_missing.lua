local auto_missing = {tracking = {}, pos = {Vector(6220.9375, -4170.40625, 128.0), Vector(-553.46875, -353.40625, 0.0), Vector(-6198.0625, 4374.78125, 128.0)}}

function auto_missing.OnGameEnd()
    auto_missing = {tracking = {}, pos = {Vector(6220.9375, -4170.40625, 128.0), Vector(-553.46875, -353.40625, 0.0), Vector(-6198.0625, 4374.78125, 128.0)}}
end

function auto_missing.OnUpdate()
    if (GameRules.GetGameTime() / 60) < 15 then
        for i = 1, Heroes.Count() do
            local hero = Heroes.Get(i)
            if Heroes.GetLocal() and hero and not Entity.IsSameTeam(Heroes.GetLocal(), hero) then
                for p = 1, #auto_missing.pos do
                    local pos = auto_missing.pos[p]
                    if pos and Entity.GetAbsOrigin(Heroes.GetLocal()):Distance(pos):Length2D() < 2000 and Entity.GetAbsOrigin(hero):Distance(pos):Length2D() < 2000  then
                        if not auto_missing.tracking[hero] and Entity.IsAlive(hero) and not Entity.IsDormant(hero) and not NPC.IsIllusion(hero) and not NPC.HasModifier(hero, "modifier_antimage_blink_illusion") and not NPC.HasModifier(hero, "modifier_monkey_king_fur_army_soldier_hidden") and not NPC.HasModifier(hero, "modifier_monkey_king_fur_army_soldier") then
                            auto_missing.tracking[hero] = {say = false, time = GameRules.GetGameTime()}
                        end
                    end
                end
            end
        end
        for unit, date in pairs(auto_missing.tracking) do
            if date.time + 9 > GameRules.GetGameTime() and date.time + 8.9 < GameRules.GetGameTime() and Entity.IsDormant(unit) and not date.say then
                Engine.ExecuteCommand("chatwheel_say 8")
                date.say = true
            end
            if date.time + 9 < GameRules.GetGameTime() or date.time + 0.1 < GameRules.GetGameTime() and not Entity.IsDormant(unit) then
                auto_missing.tracking[unit] = nil
            end
        end
    end
end

return auto_missing