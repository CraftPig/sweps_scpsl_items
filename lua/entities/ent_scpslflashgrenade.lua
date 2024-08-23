AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Flashbang Grenade"
ENT.Author = "Aaron", "Craft_Pig"
ENT.Spawnable = false
ENT.Category = "SCP: SL"

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/props_junk/metal_paintcan001a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetModelScale(1)
        
        -- Ustawienie fizyki na "Super Sprężysty"
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
            -- phys:SetMaterial("gmod_bouncy") 
            phys:SetMass(1)
            -- phys:EnableMotion(true)
            -- phys:EnableDrag(false) 
            -- phys:SetDamping(0, 0)
        end
        self.ExplodeTime = CurTime() + 3
    end
end

function ENT:Think()
    if SERVER then
        if CurTime() > self.ExplodeTime then
            self:Explode()
        end
        self:NextThink(CurTime())
	    end
    return true
end

function ENT:Explode()
    local effectData = EffectData()
    effectData:SetOrigin(self:GetPos())
    util.Effect("ManhackSparks", effectData)
	
    if CLIENT then
	    local light = DynamicLight(self:EntIndex())
        if light then
            light.pos = self:GetPos()
            light.r = 255
            light.g = 255
            light.b = 255
            light.brightness = 5
            light.Decay = 1000
            light.Size = 500
            light.DieTime = CurTime() + 2.1
        end
	end

    local radius = 400
    local entities = ents.FindInSphere(self:GetPos(), radius)
    
	for _, ent in ipairs(entities) do
        if ent:IsPlayer() or ent:IsNPC() then
            local traceData = {}
            traceData.start = self:GetPos()
            traceData.endpos = ent:WorldSpaceCenter() -- Check from the grenade to the center of the entity
            traceData.filter = {self, ent} -- Ignore the grenade and the entity itself
            local trace = util.TraceLine(traceData)

            if trace.Hit and trace.Entity == ent then
                -- Only affect the entity if the trace hits it directly (not blocked)
                 ent:ApplyEffect("Blindness", 4)
                print(ent:GetClass() .. " is within the explosion radius and line of sight!") -- Print the class of the entity found
            end
                
        end
    end
    self:Remove()
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:Use(activator, caller)
end
