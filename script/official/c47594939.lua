--召喚制限－ディスコードセクター
--And the Band Played On
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Cannot Special Summon monsters with the same Level/Rank
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetTarget(s.splimit)
	c:RegisterEffect(e2)
end
function s.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:HasLevel() then
		return Duel.IsExistingMatchingCard(aux.FilterFaceupFunction(Card.IsLevel,c:GetLevel()),sump,LOCATION_MZONE,0,1,nil)
	elseif c:IsRankAbove(0) then
		return Duel.IsExistingMatchingCard(aux.FilterFaceupFunction(Card.IsRank,c:GetRank()),sump,LOCATION_MZONE,0,1,nil)
	end
	return false
end