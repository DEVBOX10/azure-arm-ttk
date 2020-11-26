﻿<#
.Synopsis
    TODO: summary of test
.Description
    TODO: describe this test
#>

param(
[Parameter(Mandatory=$true)]
[PSObject]
$TemplateObject,

[Parameter(Mandatory=$true)]
[PSObject]
$CreateUIDefinitionObject
)

foreach ($parameter in $TemplateObject.parameters.psobject.properties) {
    $parameterName = $parameter.Name
    $parameterInfo = $parameter.Value
    $defaultValue = $parameterInfo.defaultValue
    if ($defaultValue -eq $null) { # empty string is ok, only missing defaultValues should be flagged
        if ($CreateUIDefinitionObject.parameters.outputs.$parameterName -eq $null) {
            Write-Error "$parameterName does not have a default value, and is not defined in CreateUIDefinition.outuputs" -ErrorId Parameter.Without.Default.Missing.From.CreateUIDefinition -TargetObject $TemplateObject.parameters
            continue
        }
    }
}
