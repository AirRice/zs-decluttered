hook.Add("InitPostEntityMap", "Adding", function()
	for _, ent in pairs(ents.FindByClass("color_correction")) do
		ent:Fire("disable", "", 0)
	end
end)
