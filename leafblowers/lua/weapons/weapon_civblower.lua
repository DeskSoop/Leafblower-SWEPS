SWEP.PrintName = "Civilian Leafblower"
SWEP.Author = "Obstructed"
SWEP.Instructions = "Gun"

SWEP.Spawnable = true 
SWEP.AdminOnly = false 

SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"
SWEP.Category = "Leafblower"

SWEP.AnimCooldown = 0
SWEP.Weight = 25
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false 
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.CSMuzzleFlashes = true
SWEP.SoundEntities = {}
SWEP.ViewModel = "models/v_rpg.mdl" 
SWEP.WorldModel = "models/w_rpg.mdl"

SWEP.UseHands = true
SWEP.ShootSound = Sound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav")

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
        return
    end
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextPrimaryFire(CurTime() + .1)
    self:GetOwner():SetGroundEntity(NULL)
    self:GetOwner():SetVelocity(-(self:GetOwner():GetAimVector() + Vector(self:GetOwner():GetViewPunchAngles()))*25)
    self:ShootBullet(10, 3, .1)
    self:EmitSound("weapons/auto_shotgun/gunfire/auto_shotgun_fire_1.wav ", nil, nil, 0.25)
    self:GetOwner():ViewPunch(self:GetOwner():GetViewPunchAngles()/10 - Angle( 4, 0, 0 ) )
    self:GetOwner():SetEyeAngles(self:GetOwner():EyeAngles() + Angle(-3,math.random(-0.15,0.15),0))
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
    bullet.Dir = owner:GetAimVector() - Vector(0, 0, owner:GetViewPunchAngles().x)/50
    bullet.Spread = Vector(aimcone, aimcone, 0)
    bullet.Tracer = 0
    bullet.TracerName = "Tracer"
    bullet.Force = 10000
    bullet.Damage = damage
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

