--体力増強剤スーパーZ
--Nutrient Z (GOAT)
--Very weird activation window
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_HAND+LOCATION_SZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(s.condition2)
	e2:SetOperation(s.activate2)
	c:RegisterEffect(e2)
end
function s.activate2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_SZONE) then return end
	local eff=e:GetHandler():GetActivateEffect()
	eff:SetLabel(1)
	local act=eff:IsActivatable(tp,false,false)
	eff:SetLabel(0)
	if act and Duel.SelectEffectYesNo(tp,eff:GetHandler(),95) then
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
		Duel.Activate(e:GetHandler():GetActivateEffect())
	end
end
function s.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>=2000
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==1 or Duel.GetFlagEffect(tp,id)>0
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,4000)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		Duel.SetChainLimitTillChainEnd(s.chlimit)
	end
end
function s.chlimit(re,rp,tp)
	return (re:GetHandler():IsType(TYPE_COUNTER) and re:IsHasType(EFFECT_TYPE_ACTIVATE)) or re:GetHandler():IsCode(id)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,4000,REASON_EFFECT)
end
