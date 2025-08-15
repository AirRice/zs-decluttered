INC_SERVER()

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() then
		ent:GiveStatus("dimvision", 6)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end


function SWEP:Reload()
	if IsFirstTimePredicted() and not self.AlreadyTorso then
		if CurTime() < (self:GetOwner().SpawnedTime + 1) then return end
		self:BecomeTorso()
	end
end

function SWEP:BecomeTorso()
	local owner = self:GetOwner()
	local pos = owner:GetPos()
	local ang = owner:EyeAngles()
	local deathclass = owner.DeathClass or owner:GetZombieClass()
	self.AlreadyTorso = true
	local lastattacker = owner:GetLastAttacker()
	local classtable = GAMEMODE.ZombieClasses["Shadow Lurker"]
	local hpmul = math.min((owner:Health() * 1.25) / owner:GetMaxHealth(), 1)
	local spawnpos = pos
	spawnpos.z = spawnpos.z + owner:OBBMaxs().z
	if classtable then
		owner:RemoveStatus("overridemodel", false, true)
		local deathclass = owner.DeathClass or owner:GetZombieClass()
		owner:SetZombieClass(classtable.Index)
		owner:DoHulls(classtable.Index, TEAM_UNDEAD)
		owner.DeathClass = deathclass
		local effectdata = EffectData()
			effectdata:SetEntity(owner)
			effectdata:SetOrigin(pos)
		util.Effect("gib_player", effectdata, true, true)

		owner:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 75)
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