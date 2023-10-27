SWEP.PrintName = "Civilian Leafblower"
SWEP.Author = "Obstructed"
SWEP.Instructions = "Gun"

SWEP.Spawnable = true 
SWEP.AdminOnly = false 

SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Buckshot"
SWEP.Secondary.Ammo = "none"
SWEP.Category = "Leafblower"

SWEP.AnimCooldown = 0
SWEP.Weight = 25
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false 
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.CSMuzzleFlashes = true 
SWEP.SoundEntities = {}
SWEP.ViewModel = "models/v_egon.mdl" 
SWEP.WorldModel = "models/v_egon.mdl"

SWEP.UseHands = true
SWEP.ShootSound = Sound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav")

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
        return
    end
    self.Cancel = false
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextPrimaryFire(CurTime() + .3)
    self:GetOwner():SetGroundEntity(NULL)
    self:GetOwner():SetVelocity(-self:GetOwner():GetAimVector()*25)
    self:ShootBullet(0, 25, .125)
    self:EmitSound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav ", nil, nil, 0.25)
    self:GetOwner():ViewPunch( Angle( -2, 0, 0 ) )
    self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + Angle(-3,math.random(-0.35,0.35),0))
    timer.Create("burst2", 0.0625, 1, function()
        if not self.Cancel then
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self:GetOwner():SetGroundEntity(NULL)
            self:GetOwner():SetVelocity(-self:GetOwner():GetAimVector()*25)
            self:ShootBullet(0, 25, .125)
            self:EmitSound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav ", nil, nil, 0.25)
            self:GetOwner():ViewPunch( Angle( -2, 0, 0 ) )
            self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + Angle(-3,math.random(-0.35,0.35),0))
        end
    end)
    timer.Create("burst3", 0.125, 1, function()
        if not self.Cancel then
            self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
            self:GetOwner():SetGroundEntity(NULL)
            self:GetOwner():SetVelocity(-self:GetOwner():GetAimVector()*25)
            self:ShootBullet(0, 25, .125)
            self:EmitSound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav ", nil, nil, 0.25)
            self:GetOwner():ViewPunch( Angle( -2, 0, 0 ) )
            self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + Angle(-3,math.random(-0.35,0.35),0))
        end
    end)
end

function SWEP:SecondaryAttack()

end

function SWEP:ShootBullet(damage, num_bullets, aimcone, ammo_type, force, tracer)
    local owner = self:GetOwner()

    if not IsValid(owner) then
        return
    end
    -- Create a bullet table
    local bullet = {}
    bullet.Num = num_bullets
    bullet.Src = owner:GetShootPos()
    bullet.Dir = owner:GetAimVector() - Vector(0, 0, self:GetOwner():GetViewPunchAngles().x)/50
    bullet.Spread = Vector(aimcone, aimcone, 0)
    bullet.Tracer = 0
    bullet.TracerName = "Tracer"
    bullet.Force = damage/20
    bullet.Damage = 0
    bullet.AmmoType = "Pistol"
    bullet.HullSize = 5
    
    owner:FireBullets(bullet)
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	self:SendWeaponAnim(ACT_VM_IDLE)
    self:EmitSound("weapons/auto_shotgun/gunother/autoshotgun_deploy_1.wav")
	return true
end

function SWEP:Holster()
    self.Cancel = true
    return true
end
