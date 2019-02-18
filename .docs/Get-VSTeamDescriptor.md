<!-- #include "./common/header.md" -->

# Get-VSTeamDescriptor

## SYNOPSIS

<!-- #include "./synopsis/Get-VSTeamDescriptor.md" -->

## SYNTAX

## DESCRIPTION

<!-- #include "./synopsis/Get-VSTeamDescriptor.md" -->

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```PowerShell
PS C:\> Get-VSTeamUser | Select-Object -First 1 | Get-VSTeamDescriptor
```

This command gets the descriptor for the first user.

## PARAMETERS

### -StorageKey

The id of the subject (user, group, scope, project, etc.) to resolve

```yaml
Type: string
Required: True
Aliases: Id
Parameter Sets: ByStorageKey
Accept pipeline input: true (ByPropertyName, ByValue)
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS