Class FHIRTemplate.CarePlan Extends Resource
{

Parameter ResourceType = "CarePlan";

Parameter CategorySystem = "http://jpfhir.jp/fhir/CarePlan/CodeSystem/category";

Parameter CategoryDisplay = "discharge-plan,hospital-plan";

Property TextDiv As %String(MAXLEN = 10000);

/// identifier.value
Property IdentifierValue As %String;

/// statusvDISPLAYLIST = ",案,有効,保留,取消,完了,エラー,不明"
Property Status As %String(VALUELIST = ",draft,active,on-hold,revoked,completed,entered-in-error,unknown");

/// intent DISPLAYLIST = ",提案,計画,指示,オプション",
Property Intent As %String(VALUELIST = ",proposal,plan,order,option");

Property Category As FHIRTemplate.DataType.CodeableConcept;

Property Description As %String(MAXLEN = 10000);

/// Patient のUUID
Property Patient As %String;

/// EncounterのUUID
Property Encounter As %String;

/// PractitionerのUUID
Property Practitioner As %String;

Property Period As FHIRTemplate.DataType.Period;

Property CreationTime As FHIRTemplate.DataType.TimeStamp;

XData Template [ MimeType = application/json ]
{
{
    "resourceType": "#(..#ResourceType)#",
    "meta": {
        "profile": ["http://jpfhir.jp/fhir/eClinicalSummary/StructureDefinition/JP_CarePlan_eClinicalSummary"]
    },
    "text": {
        "status": "generated",
        "div": "#(..TextDiv)#"
    },
    "identifier": [
        {
            "system":"http://jpfhir.jp/fhir/Common/CodeSystem/resourceInstance-identifier",
            "value": "#(..IdentifierValue)#"
        }
],    
    "status": "#(..Status)#",
    "intent": "#(..Intent)#",
    "category": [ "#(..Category(FHIRTemplate.DataType.CodeableConcept))#"],
    "title":"退院時の方針",
    "description":"#(..Description)#",
    "subject": {
        "reference": "urn:uuid:#(..Patient)#"
    },
    "encounter": {
        "reference": "urn:uuid:#(..Encounter)#"
    },
    "period": "#(..Period)#",
    "created":"#(..CreationTime)#",
    "author":{
        "reference":"urn:uuid:#(..Practitioner)#"
    }
}
}

}
