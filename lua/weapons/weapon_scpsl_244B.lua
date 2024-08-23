if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_244B" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "SCP-244B"
SWEP.Author = "Craft_Pig", "Aaron"
SWEP.Purpose = 
[[                    					
]]
SWEP.Category = "SCP: SL"

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/sweps/scpsl/244/v_244B.mdl"
SWEP.WorldModel = "models/weapons/sweps/scpsl/244/w_244B.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 4
SWEP.SlotPos = 6
SWEP.DrawAmmo = true

SWEP.Primary.Ammo = "scp-244"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

local InitializeSEF = false

function SWEP:Initialize()
    self:SetHoldType("slam")
	
	local FilePathSEF = "lua/SEF/SEF_Functions.lua"
    if file.Exists(FilePathSEF, "GAME") then
        InitializeSEF = true
    else
        InitializeSEF = false
    end
end 

function SWEP:Deploy()
    local owner = self:GetOwner() 

    self:SendWeaponAnim(ACT_VM_DRAW)
    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.Idle = 0
	self.InitializeDeploying = 0
	self.vmcamera = nil
	
	-- self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())
	
	if owner:GetAmmoCount(self.Primary.Ammo) == 0 then owner:StripWeapon("weapon_scpsl_244B") end -- Reminder
	
	-- print(owner:GetPreviousWeapon())
	return true
end

function SWEP:DeploySCP(owner, weapon)
    if CLIENT then return end
    local startPos = owner:GetShootPos()
    local aimVec = owner:GetAimVector()
    local endPos = startPos + (aimVec * 110)

    local trace = util.TraceLine({
        start = startPos,
        endpos = endPos,
        filter = owner
    })
    if trace.HitPos then
        local ENT = ents.Create("scp244B_placed")
        if IsValid(ENT) then
            ENT:SetPos(trace.HitPos + trace.HitNormal * 5)
            ENT:Spawn()
        end
    end
	
	owner:RemoveAmmo(1, "scp-244")
	self:Deploy()


    -- if IsValid(weapon) then
        -- if IsValid(owner) and SERVER and activeWeapon:GetClass() == "weapon_scpsl_medkit" then -- Reminder
		
		    -- if InitializeSEF == true then
			    -- owner:ApplyEffect("Healing", 1, 65, 1)
				-- owner:RemoveEffect("Bleeding")
				-- owner:SoftRemoveEffect("Exposed")
			-- else
                -- owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + HealAmount))
                -- owner:SetArmor(math.min(owner:GetMaxArmor(), owner:Armor() + ArmorAmount))
			-- end
            -- owner:RemoveAmmo(1, "medkit") -- Reminder
            -- owner:EmitSound("scpsl_medkit_use_03")
            -- weapon:Deploy()
        -- end
    -- end
end 

function SWEP:PrimaryAttack()
    local owner = self.Owner

    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0)
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.InitializeDeploying = 1
	self.Idle = 1
end

function SWEP:SecondaryAttack()
    if CLIENT then return end
    local owner = self:GetOwner()
    local startPos = owner:GetShootPos()
    local aimVec = owner:GetAimVector()
    local endPos = startPos + (aimVec * 110)

    local trace = util.TraceLine({
        start = startPos,
        endpos = endPos,
        filter = owner
    })
    if trace.HitPos then
        local ENT = ents.Create("weapon_scpsl_244B")
        if IsValid(ENT) then
            ENT:SetPos(trace.HitPos + trace.HitNormal * 5)
            ENT:Spawn()
        end
    end
    owner:RemoveAmmo(1, "scp-244")
    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then owner:StripWeapon("weapon_scpsl_244B") end -- Reminder
end

function SWEP:Think()
	local owner = self.Owner
    if self.Idle == 0 and self.IdleTimer <= CurTime() then -- Idle Sequence
		self:SendWeaponAnim(ACT_VM_IDLE)  
        self.Idle = 1
    end
	
	if self.InitializeDeploying == 1 and self.IdleTimer <= CurTime() then
	    if IsValid(self) then
		    InitializeDeploying = 0
            self:DeploySCP(owner, weapon)
		end
	end
end

function SWEP:PostDrawViewModel( vm )
    local attachment = vm:GetAttachment(1)
    if attachment then
        self.vmcamera = vm:GetAngles() - attachment.Ang
    else
        self.vmcamera = Angle(0, 0, 0) 
    end
end

function SWEP:CalcView( ply, pos, ang, fov )
	self.vmcamera = self.vmcamera or Angle(0, 0, 0)  
    return pos, ang + self.vmcamera, fov
end

if CLIENT then -- Worldmodel offset
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	WorldModel:SetSkin(0)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local owner = self:GetOwner()

		if (IsValid(owner)) then
			local offsetVec = Vector(14, -17, -0)
			local offsetAng = Angle(-0, 90, 90)
			
			local boneid = owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
			if !boneid then return end

			local matrix = owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

            WorldModel:SetupBones()
		else
			
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
			self:DrawModel()
		end

		WorldModel:DrawModel()

	end
end