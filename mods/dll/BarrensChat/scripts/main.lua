RegisterHook("/Script/Pal.PalPlayerState:EnterChat_Receive", function(self, msg)
	if (self:get()["ChatCounter"] >= 3) then
		self:get()["ChatCounter"] = 0
	end
end)

print("Successfully loaded Barrens Chat!")