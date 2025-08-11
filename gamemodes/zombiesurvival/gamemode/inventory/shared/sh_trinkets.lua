local meta = FindMetaTable("Player")
if not meta then return end

function meta:HasTrinket(trinket)
	return self:HasInventoryItem("trinket_" .. trinket)
end

function meta:CreateTrinketStatus(status)
	for _, ent in pairs(ents.FindByClass("status_" .. status)) do
		if ent:GetOwner() == self then return end
	end

	local ent = ents.Create("status_" .. status)
	if ent:IsValid() then
		ent:SetPos(self:EyePos())
		ent:SetParent(self)
		ent:SetOwner(self)
		ent:Spawn()
	end
end

function meta:ApplyAssocModifiers(assoc)
	local skillmodifiers = {}
	local gm_modifiers = GAMEMODE.SkillModifiers
	for skillid in pairs(assoc) do
		local modifiers = gm_modifiers[skillid]
		if modifiers then
			for modid, amount in pairs(modifiers) do
				skillmodifiers[modid] = (skillmodifiers[modid] or 0) + amount
			end
		end
	end

	for modid, func in pairs(GAMEMODE.SkillModifierFunctions) do
		func(self, skillmodifiers[modid] or 0)
	end
end

-- For trinkets, these apply after your skills, and they need to work differently so they can't be used to "update" your skills midgame.
function meta:ApplyTrinkets(override)
	if GAMEMODE.ZombieEscape or GAMEMODE.ClassicMode then return end -- Skills not used on these modes

	local allskills = GAMEMODE.Skills
	local real_assoc = {}

	if not override then
		for skillid, skilltbl in pairs(allskills) do
			if skilltbl.Trinket then
				local hastrinket = self:HasTrinket(skilltbl.Trinket)
				real_assoc[skillid] = hastrinket and true or nil

				if SERVER then
					if skilltbl.PairedWeapon then
						local pairedwep = "weapon_zs_t_"..skilltbl.Trinket
						if hastrinket and not self:HasWeapon(pairedwep) then
							self:Give(pairedwep)
						elseif not hastrinket and self:HasWeapon(pairedwep) then
							self:StripWeapon(pairedwep)
						end
					end

					if hastrinket and skilltbl.Status then
						self:CreateTrinketStatus(skilltbl.Status)
					end
				end
			end
		end
	end

	self:ApplyAssocModifiers(real_assoc)

	local funcs
	local gm_functions = GAMEMODE.SkillFunctions
	for skillid in pairs(allskills) do

		funcs = gm_functions[skillid]
		if funcs then
			if not real_assoc[skillid] then -- On but we want it off.
				for _, func in pairs(funcs) do
					func(self, false)
				end
			elseif real_assoc[skillid] then -- Off but we want it on.
				for _, func in pairs(funcs) do
					func(self, true)
				end
			end
		end
	end
end

function meta:GetTotalAdditiveModifier(...)
	local totalmod = 1
	for i, modifier in ipairs({...}) do
		totalmod = totalmod + (self[modifier] or 1) - 1
	end
	return totalmod
end
