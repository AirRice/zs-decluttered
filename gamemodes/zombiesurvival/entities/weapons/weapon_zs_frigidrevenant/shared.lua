SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Frigid Revenant"

SWEP.MeleeDamage = 32

local Spread = {
	{0, 0},
	{-0.5, 0},
	{0.5, 0}
}
local function DoFleshThrow(pl, wep)
	if pl:IsValid() and pl:Alive() and wep:IsValid() then
		pl:ResetSpeed()
		pl.LastRangedAttack = CurTime()

		if SERVER then
			local startpos = pl:GetShootPos()
			local aimang = pl:EyeAngles()
			local ang

			for _, spr in pairs(Spread) do
				ang = Angle(aimang.p, aimang.y, aimang.r)
				ang:RotateAroundAxis(ang:Up(), spr[1] * 5)
				ang:RotateAroundAxis(ang:Right(), spr[2] * 5)

				local ent = ents.Create("projectile_ghoulfleshfr")
				if ent:IsValid() then
					ent:SetPos(startpos)
					ent:SetOwner(pl)
					ent:Spawn()

					local phys = ent:GetPhysicsObject()
					if phys:IsValid() then
						phys:SetVelocityInstantaneous(ang:Forward() * 750)
					end
				end
			end

			pl:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))
		end
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end

	self:SetNextSecondaryFire(CurTime() + 3)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:GetOwner():DoZombieEvent()
	self:EmitSound("npc/fast_zombie/leap1.wav", 74, math.Rand(110, 130))
	self:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	timer.Simple(0.7, function() DoFleshThrow(owner, self) end)
end

function SWEP:Reload()
	self:SecondaryAttack()
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end

function SWEP:PlayHitSound()
	self:EmitSound("NPC_FastZombie.AttackHit", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
	self:EmitSound("NPC_FastZombie.AttackMiss", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie_poison/pz_warn"..math.random(2)..".wav", 70, math.random(140, 145), 0.65, CHAN_AUTO)
	self:EmitSound("npc/metropolice/pain"..math.random(4)..".wav", 74, math.Rand(125, 135), 0.65, CHAN_WEAPON + 20)
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/antlion/idle"..math.random(5)..".wav", 70, math.random(60, 66))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/stalker/breathing3.wav", 70, math.random(80, 90))
end


function SWEP:Initialize()
	self.SpawnTime = CurTime()
	self.BaseClass.Initialize(self)
end

function SWEP:Reload()
	if IsFirstTimePredicted() then
		if CurTime() < (self.SpawnTime + 1) then return end
		self:BecomeTorso()
	end
end

function SWEP:BecomeTorso()
	local owner = self:GetOwner()
	local pos = owner:GetPos()
	local ang = owner:EyeAngles()
	local deathclass = owner.DeathClass or owner:GetZombieClass()
	if SERVER then
		owner:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 75)
		local lastattacker = owner:GetLastAttacker()
		local classtable = GAMEMODE.ZombieClasses["Frigid Lurker"]
		local hpmul = math.min((owner:Health() * 1.25) / owner:GetMaxHealth(), 1)
		local spawnpos = pos
		spawnpos.z = spawnpos.z + owner:OBBMaxs().z
		if classtable then
			owner:RemoveStatus("overridemodel", false, true)
			owner:SetZombieClass(classtable.Index)
			owner:DoHulls(classtable.Index, TEAM_UNDEAD)
			owner.DeathClass = deathclass
			spawnpos.z = spawnpos.z - owner:OBBMaxs().z

			local effectdata = EffectData()
				effectdata:SetEntity(owner)
				effectdata:SetOrigin(pos)
			util.Effect("gib_player", effectdata, true, true)

			timer.Simple(0, function()
				if owner:IsValidLivingZombie() then
					owner.DeathClass = nil
					owner.Revived = true
					owner:UnSpectateAndSpawn()
					owner.Revived = nil
					owner.DeathClass = deathclass
					owner:SetLastAttacker(lastattacker)
					owner:SetPos(spawnpos)
					owner:SetHealth(math.max(1, math.min(classtable.Health * hpmul, classtable.Health)))
					owner:SetEyeAngles(ang)
				end
			end)

		end
	end
end
