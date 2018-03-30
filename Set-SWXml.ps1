function Set-SWXML{
    Param(
        [string]$title,
        [string]$alertDef,
        [string]$severity,
        [string]$emailTo,
        [string]$emailTocc,
        [string]$senderName,
        [string]$emailFrom,
        [string]$path,
        [string]$pathToSave
    )

    process{
        #Pull in the contents of the XML file  
        $xmlFile =  [xml](get-content $path)

        #Assign these values as they are easily defined
        $xmlFile.AlertDefinition.name = $title
        $xmlFile.AlertDefinition.AlertMessage = $alertDef
        $xmlFile.AlertDefinition.Severity = $severity

        #Change values in reset actions
        $descString = "To: $" + "{" + $emailTo + "}`n" +  "From: $" + "{" + $emailFrom +  "}`n" + "Subject: RESET: Node $" + "{NodeName} is $" + "{Status}.`nCC: $"+ "{" + $emailTocc  +"}"

       
        
        #SET THE RESERT ACCTIONS
        $xmlFile.AlertDefinition.ResetActions.ActionDefinition[1].ActionProperties.ActionProperty[1].PropertyValue = "$" + "{" + $emailTocc + "}"
        $xmlFile.AlertDefinition.ResetActions.ActionDefinition[1].ActionProperties.ActionProperty[2].PropertyValue = "$" + "{" + $emailFrom + "}"
        $xmlFile.AlertDefinition.ResetActions.ActionDefinition[1].ActionProperties.ActionProperty[4].PropertyValue = "$" + "{" + $emailTo + "}"
        $xmlFile.AlertDefinition.ResetActions.ActionDefinition[1].ActionProperties.ActionProperty[9].PropertyName = "$" + "{" + $senderName + "}"

        $xmlFile.AlertDefinition.ResetActions.ActionDefinition[1].Description = $descString

        #SET THE TRIGGER ACTIONS
        $xmlFile.AlertDefinition.TriggerActions.ActionDefinition[1].ActionProperties.ActionProperty[1].PropertyValue = "$" + "{" + $emailTocc + "}"
        $xmlFile.AlertDefinition.TriggerActions.ActionDefinition[1].ActionProperties.ActionProperty[2].PropertyValue = "$" + "{" + $emailFrom + "}"
        $xmlFile.AlertDefinition.TriggerActions.ActionDefinition[1].ActionProperties.ActionProperty[4].PropertyValue = "$" + "{" + $emailTo + "}"
        $xmlFile.AlertDefinition.TriggerActions.ActionDefinition[1].ActionProperties.ActionProperty[9].PropertyName  =  "$" + "{" + $senderName + "}"

        $xmlFile.AlertDefinition.TriggerActions.ActionDefinition[1].Description = $descString


        $xmlFile.Save($pathToSave)
    }
}       