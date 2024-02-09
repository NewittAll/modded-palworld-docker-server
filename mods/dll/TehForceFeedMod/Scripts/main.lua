local config = require "config"
local not_hooked = true

RegisterHook("/Script/Engine.PlayerController:ServerAcknowledgePossession", function (Context)
    if not_hooked then
        RegisterHook("/Game/Pal/Blueprint/Controller/AIAction/BaseCamp/RecoverHungry/BP_AIAction_BaseCampRecoverHungry.BP_AIAction_BaseCampRecoverHungry_C:ChangeActionEat", function(self)
            local controller = self:get()
            local pal = controller:GetCharacter()
            if pal then
                local pal_params = pal.CharacterParameterComponent
                local max_full_stomach = pal_params:GetMaxFullStomach()
                if max_full_stomach then
                    controller.HungeryParameter.RecoverSatietyTo = max_full_stomach * config.satiety_percentage
                end
            end
        end)

        if config.change_eat_speed then
            NotifyOnNewObject("/Game/Pal/Blueprint/Controller/AIAction/BaseCamp/RecoverHungry/BP_AIAction_BaseCampRecoverHungry_Eat.BP_AIAction_BaseCampRecoverHungry_Eat_C", function(self)
                self.EatTime = config.eat_speed
            end)
        end
    end
end)

