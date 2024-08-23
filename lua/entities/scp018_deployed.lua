AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "SCP-018"
ENT.Author = "Aaron"
ENT.Spawnable = true
ENT.Category = "SCP: SL"

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/weapons/sweps/scpsl/018/w_018.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetModelScale(1)
        
        -- Ustawienie fizyki na "Super Sprężysty"
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            phys:SetMaterial("gmod_bouncy") 
            phys:SetMass(10)
            phys:EnableMotion(true) -- Zapewnienie, że obiekt może się poruszać
            phys:EnableDrag(false) -- Wyłączenie oporu powietrza
            phys:SetDamping(0, 0) -- Wyłączenie tłumienia ruchu (linearny i kątowy)
        end
        self.SCP018BounceCount = 0
    end
end

function ENT:PhysicsCollide(data, phys)
    if SERVER then
        self.SCP018BounceCount = self.SCP018BounceCount + 1
        -- PrintMessage(HUD_PRINTTALK, "Bounces: " .. self.SCP018BounceCount .. " Owner: " .. self.DamageDealer:Nick())

        if self.DamageDealer == nil then
            self.DamageDealer = self
        end

        local dmg = DamageInfo()
        dmg:SetDamage(2 * self.SCP018BounceCount)
        dmg:SetAttacker(self.DamageDealer)
        dmg:SetInflictor(self)
        dmg:SetDamageType(DMG_CLUB)
        dmg:SetDamageForce(data.OurOldVelocity)
        dmg:SetDamagePosition(data.HitPos)
        if data.HitEntity:IsValid() then
            data.HitEntity:TakeDamageInfo(dmg)
            if data.HitEntity:IsPlayer() or data.HitEntity:IsNPC() then
                data.HitEntity:ApplyEffect("Hindered", 2, 100)
            end
        end
		
		if self.SCP018BounceCount <= 10 then
		    self:EmitSound("scpsl_018_low")
			local bounceVelocity = phys:GetVelocity():GetNormalized() * (100 * self.SCP018BounceCount)
			phys:SetVelocity(bounceVelocity)
		elseif self.SCP018BounceCount <= 30 then
		    self:EmitSound("scpsl_018_low")
			local bounceVelocity = phys:GetVelocity():GetNormalized() * (50 * self.SCP018BounceCount)
			phys:SetVelocity(bounceVelocity)
		elseif self.SCP018BounceCount <= 84 then
		    self:EmitSound("scpsl_018_med")
			local bounceVelocity = phys:GetVelocity():GetNormalized() * (30 * self.SCP018BounceCount)
			phys:SetVelocity(bounceVelocity)
		elseif self.SCP018BounceCount >= 85 then
		    self:EmitSound("scpsl_018_high")
		    local bounceVelocity = phys:GetVelocity():GetNormalized() * (20 * self.SCP018BounceCount)
			phys:SetVelocity(bounceVelocity) 		
		end
 
        -- if self.SCP018BounceCount == 10 then
            -- util.SpriteTrail(self, 0, color_white, true, 4, 0, 1, 1 / 4 * 0.1, "effects/arrowtrail_blu")
        -- elseif self.SCP018BounceCount == 30 then
            -- util.SpriteTrail(self, 0, color_white, true, 4, 0, 2, 1 / 4 * 0.5, "effects/arrowtrail_red")
		-- elseif self.SCP018BounceCount == 85 then
            -- util.SpriteTrail(self, 0, color_white, true, 0, 0, 0, 0 / 4 * 0.5, "effects/arrowtrail_red")
        -- end

        if self.SCP018BounceCount >= 200 then
            local explosion = ents.Create("env_explosion")
            explosion:SetPos(self:GetPos())
            explosion:SetOwner(self.DamageDealer)
            explosion:Spawn()
            explosion:SetKeyValue("iMagnitude", "300")
            explosion:Fire("Explode", 0, 0)
            self:Remove()
        end
    end
end

function ENT:Use(activator, caller)
    -- if IsValid(caller) and caller:IsPlayer() then
        -- if caller:GetAmmoCount("scp-018") == 0 then
            -- caller:GiveAmmo(1, "scp-018")
        -- end
    -- end
    -- self:Remove()
end
