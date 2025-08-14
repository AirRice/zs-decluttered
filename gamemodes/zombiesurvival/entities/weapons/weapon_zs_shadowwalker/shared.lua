SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Shadow Walker"

SWEP.MeleeDamage = 30

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
	self:EmitSound("npc/zombie_poison/pz_warn"..math.random(2)..".wav", 70, math.random(180, 190), nil, CHAN_AUTO)
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
		if CurTime() > (self.SpawnTime + 1) then return end
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
		local classtable = GAMEMODE.ZombieClasses["Shadow Lurker"]
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
