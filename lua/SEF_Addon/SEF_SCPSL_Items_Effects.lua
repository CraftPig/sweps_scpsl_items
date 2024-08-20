StatusEffects.SCP244A = {
    Name = "SCP-244 Hypothermia",
    Icon = "SEF_Icons/SCP244B.png",
    Desc = "Icey fog is consuming you... Death is imminent.",
	Type = "DEBUFF",
    Effect = function(ent, time)   
        local TimeLeft = ent:GetTimeLeft("SCP244A")
        
        if not ent.WitherDamage then
            ent.WitherDamage = 0
        end

        local sounds = {
            "weapons/scpsl/244/ice1.wav",
            "weapons/scpsl/244/ice2.wav",
			"weapons/scpsl/244/ice3.wav",
			"weapons/scpsl/244/ice4.wav",
			"weapons/scpsl/244/ice5.wav",
        }

        if TimeLeft > 0.1 then
            if CurTime() >= (ent.SCP244ATimer or 0) then
                ent.SCP244ATimer = CurTime() + 1
				if ent:HaveEffect("Wither") then
				    ent.WitherDamage = ent.WitherDamage + 0.5
                    local randomSound = sounds[math.random(#sounds)]
                    ent:EmitSound(randomSound)
				end
            end
        end
		
		if ent:HaveEffect("SCP244A") then
		    ent:ApplyEffect("Hindered", 0.35, 80)
		    if not ent.SCP244AIni then
			    ent:EmitSound("scpsl_244_freeze")
			    ent.SCP244ATimerIni = CurTime() + 7
                ent.SCP244AIni = true
		    end
			
			if CurTime() >= (ent.SCP244ATimerIni) then
				ent:ApplyEffect("Wither", 1, ent.WitherDamage, 1)
			end
		end
		
		if TimeLeft < 0.1 then
		    if ent:HaveEffect("SCP244A") then
			    ent.SCP244AIni = nil
				ent.WitherDamage = nil
				ent:StopSound("scpsl_244_freeze")
		    end
		end
    end,
    ClientHooks = {
        {
            HookType = "HUDPaintBackground",
            HookFunction = function()
                local TimeLeft = LocalPlayer():GetTimeLeft("SCP244A")
                if not MaxTime then
                    MaxTime = LocalPlayer():GetTimeLeft("SCP244A")
                end
                if LocalPlayer():HaveEffect("SCP244A") then
                    local alphaMultiplier = math.Clamp(TimeLeft / MaxTime * 255, 0, 255)
                    surface.SetMaterial(Material("scp244screen.png"))
                    surface.SetDrawColor(255, 255, 255, alphaMultiplier)
                    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
                else
                    MaxTime = nil
                end
            end,
        }
    }
}