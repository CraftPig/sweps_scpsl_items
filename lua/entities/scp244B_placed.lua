AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "SCP-244B"
ENT.Author = "Aaron"
ENT.Spawnable = true
ENT.Category = "SCP: SL"

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/weapons/sweps/scpsl/244/w_244B.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        -- self:SetMaterial("models/shadertest/shader5")
        self:SetModelScale(1)
        self:SetHealth(80)
		self:EmitSound("scpsl_244_pressure")
		self:EmitSound("scpsl_244_emit")

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end
end

function ENT:Use(activator, caller)
    -- activator:PickupObject(self)
	if IsValid(caller) and caller:IsPlayer() then
	    if caller:GetAmmoCount("scp-244") == 0 then
		    caller:Give("weapon_scpsl_244B")
		else
		    caller:GiveAmmo(1, "scp-244")
		end
    end
	self:Remove()
end

function ENT:OnTakeDamage(dmginfo)
    if dmginfo then
        self:SetHealth(self:Health() - dmginfo:GetDamage())
    end

    if self:Health() <= 0 then
        self:Remove()
		self:EmitSound("scpsl_244_break")
    end
end

function ENT:Think()
    if CLIENT then
        if not self.NextSmokeTime then
            self.NextSmokeTime = CurTime()
        end

        if CurTime() >= self.NextSmokeTime then

            local emitter = ParticleEmitter(self:GetPos())

            if emitter then

                local angle = math.Rand(0, 360)
                

                local velocity = Vector(math.cos(math.rad(angle)), math.sin(math.rad(angle)), 0) * 55
                
                local offset = Vector(0, 0, 25)
                local smokePos = self:LocalToWorld(offset)
                

                local smokeParticle = emitter:Add("particles/smokey", smokePos)
                if smokeParticle then
                    smokeParticle:SetVelocity(velocity)
                    smokeParticle:SetLifeTime(0)  -- Czas życia cząsteczki
                    smokeParticle:SetDieTime(5)  -- Czas trwania cząsteczki
                    smokeParticle:SetStartAlpha(50) -- Początkowa przezroczystość
                    smokeParticle:SetEndAlpha(0) -- Końcowa przezroczystość
                    smokeParticle:SetStartSize(1) -- Początkowy rozmiar
                    smokeParticle:SetEndSize(280)
                    smokeParticle:SetRoll(math.Rand(-1, 1)) 
                    smokeParticle:SetColor(180, 190, 230)
                end
                emitter:Finish()
            end
            self.NextSmokeTime = CurTime() + 0.01
        end
        
        self:NextThink(CurTime())
        return true
    else
        for i, ent in ipairs(ents.FindInSphere(self:GetPos(), 270)) do
            if ent ~= self and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then
                ent:ApplyEffect("SCP244A", 1)
            end
        end
    end
end

-- scripted_ents.Register(ENT, "scp244_placed")