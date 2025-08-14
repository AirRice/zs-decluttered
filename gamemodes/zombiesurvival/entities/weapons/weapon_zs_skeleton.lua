AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Skeletal Walker"

SWEP.MeleeDamage = 27

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound(string.format("npc/strider/creak%d.wav", math.random(4)), 70, math.random(115, 125))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/stalker/breathing3.wav", 70, math.random(110, 120))
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/fast_zombie/wake1.wav", 70, math.random(115, 140))
end


function SWEP:Initialize()
	self.SpawnTime = CurTime()
	self.BaseClass.Initialize(self)
end

function SWEP:Reload()
	print("haha")
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
		local classtable = GAMEMODE.ZombieClasses["Skeletal Crawler"]
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

if not CLIENT then return end

local matSheet = Material("models/props_c17/doll01")

function SWEP:PreDrawViewModel(vm, wep, pl)
	render.ModelMaterialOverride(matSheet)
end

function SWEP:PostDrawViewModel(vm, wep, pl)
	render.ModelMaterialOverride(nil)
end