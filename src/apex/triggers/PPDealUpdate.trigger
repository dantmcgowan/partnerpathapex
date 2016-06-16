trigger PPDealUpdate on Opportunity(after update){
	PartnerPathREST.checkDealUpdates(trigger.new, trigger.oldmap);
}