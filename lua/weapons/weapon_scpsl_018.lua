if CLIENT then 
    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/hud/vgui_018" )
	SWEP.BounceWeaponIcon = true 
    SWEP.DrawWeaponInfoBox = true
end

SWEP.PrintName = "SCP-018"
SWEP.Author = "Craft_Pig", "Aaron"
SWEP.Category = "SCP: SL"
SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/sweps/scpsl/018/v_018.mdl"
SWEP.WorldModel = "models/weapons/sweps/scpsl/018/w_018.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false 

SWEP.Spawnable = true
SWEP.Slot = 4
SWEP.SlotPos = 6
SWEP.DrawAmmo = true

SWEP.Primary.Ammo = "scp-018"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

local InitializeSEF = false

function SWEP:Initialize()
    self:SetHoldType("grenade")
	self.Ready = 0
end 

function SWEP:Deploy()
    local owner = self:GetOwner() 
    
	
	if self.Ready == 0 then
	    self:SendWeaponAnim(ACT_VM_PICKUP)
	    self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.Ready = 1
	else
        self:SendWeaponAnim(ACT_VM_DRAW)
        self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	end
	
	self.Idle = 0
	self.ThrowStart = 0
	self.ThrowIdle = 0
	self.ThrowEnd = 0
	self.CanThrow = 0
	self.vmcamera = nil
	
	-- self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration())
	if SERVER then
	    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then owner:StripWeapon("weapon_scpsl_018") end -- Reminder
    end
	
	return true
end

function SWEP:DeploySCP(owner, weapon)
	if SERVER then
		if not IsValid(owner) then return end
			
		-- Get the eye position and aim direction
		local eyePos = owner:EyePos()
		local aimDir = owner:GetAimVector()

		-- Calculate spawn position (in front of the player)
		local spawnPos = eyePos + aimDir * 30
		
		-- Create the entity
		local ent = ents.Create("scp018_deployed")

		if not IsValid(ent) then return end
		ent:SetPos(spawnPos)
		ent:SetAngles(aimDir:Angle())
		ent:Spawn()
		ent:Activate()
		ent.DamageDealer = owner

		util.SpriteTrail(ent, 0, color_white, true, 4, 0, 0.5, 1 / 4 * 0.5, "effects/beam001_white")

		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(aimDir * 750)
		end

		-- owner:EmitSound("WeaponFrag.Throw")
		owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)
		owner:RemoveAmmo(1, "scp-018")
	end
end 

function SWEP:Think()
	local owner = self.Owner
    if self.Idle == 0 and self.IdleTimer <= CurTime() then -- Idle Sequence
		self:SendWeaponAnim(ACT_VM_IDLE)  
        self.Idle = 1
    end
	
	if self.ThrowIdle == 1 and self.IdleTimer <= CurTime() then
	    self:SendWeaponAnim(ACT_VM_PULLBACK_HIGH)  
        self.ThrowIdle = 0
		self.CanThrow = 1
	end
	
	if not self.Owner:KeyDown(IN_ATTACK) and self.CanThrow == 1 and self.IdleTimer <= CurTime() then
	    self.CanThrow = 0
	    self:SendWeaponAnim(ACT_VM_PULLPIN)
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		timer.Create("TimerCreate018", 0.4, 1, function()
            self:DeploySCP(owner, weapon)
		end)
		timer.Create("TimerDeploy018", 0.7, 1, function()
		    self:Deploy()
		end)
	end
end

function SWEP:Reload()
    if self.CanThrow == 1 then
	    self:SendWeaponAnim(ACT_VM_PULLBACK_LOW) 
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
		self.Idle = 0
	    self.ThrowStart = 0
	    self.ThrowIdle = 0
	    self.ThrowEnd = 0
	    self.CanThrow = 0
	end
end

function SWEP:PrimaryAttack()
    local owner = self.Owner

    if owner:GetAmmoCount(self.Primary.Ammo) == 0 then return end

    self:SendWeaponAnim(ACT_VM_PULLBACK)
	self:SetNextPrimaryFire(CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0)
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	self.ThrowIdle = 1
	self.Idle = 1
	self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
    if self.CanThrow == 1 or self.ThrowIdle == 1 then return end
	timer.Remove("TimerCreate018")
	timer.Remove("TimerDeploy018")
	return true
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
			local offsetVec = Vector(0.35, -3.2, -0.85)
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