Set-StrictMode -Version Latest

# Load common code
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\common.ps1"

# Apply types to the returned objects so format and type files can
# identify the object and act on it.
function _applyTypesToServiceHook {
   param($item)

   # If there are ids in the list that don't map to a work item and empty
   # entry is returned in its place if ErrorPolicy is Omit.
   if ($item) {
      $item.PSObject.TypeNames.Insert(0, 'Team.ServiceHook')
   }
}

function Add-VSTeamServiceHook {
   [CmdletBinding()]
   param(
   )

   DynamicParam {
      _buildProjectNameDynamicParam
   }

   Process {
   }
}

function Update-VSTeamServiceHook {
   [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
   param(
      [switch] $Force
   )

   DynamicParam {
      _buildProjectNameDynamicParam
   }

   Process {

      if ($Force -or $pscmdlet.ShouldProcess($item, "Update Service Hook")) {
      }
   }
}

function Show-VSTeamServiceHook {
   [CmdletBinding()]
   param(
   )

   DynamicParam {
      _buildProjectNameDynamicParam
   }

   process {
      # Bind the parameter to a friendly variable
      $ProjectName = $PSBoundParameters["ProjectName"]

      Show-Browser "$([VSTeamVersions]::Account)/$ProjectName/_settings/serviceHooks"
   }
}

function Get-VSTeamServiceHook {
   [CmdletBinding(DefaultParameterSetName = 'ByID')]
   param(
      [Parameter(ParameterSetName = 'ByID', ValueFromPipeline = $true, Position = 0)]
      [Alias('SubscriptionId')]
      [guid[]] $Id
   )

   Process {

      # Call the REST API
      if ($id) {
         foreach ($item in $id) {
            # Build the url to return the single build
            $resp = _callAPI -Area 'hooks' -Resource 'subscriptions' -id $item `
               -Version $([VSTeamVersions]::Hooks)
            
            _applyTypesToServiceHook -item $resp

            Write-Output $resp
         }
      }
      else {
         # Build the url to list the builds
         $resp = _callAPI -Area 'hooks' -Resource 'subscriptions' `
            -Version $([VSTeamVersions]::Hooks)
         
         # Apply a Type Name so we can use custom format view and custom type extensions
         foreach ($item in $resp.value) {
            _applyTypesToServiceHook -item $item
         }

         Write-Output $resp.value
      }
   }
}

Set-Alias Add-ServiceHook Add-VSTeamServiceHook
Set-Alias Get-ServiceHook Get-VSTeamServiceHook
Set-Alias Show-ServiceHook Show-VSTeamServiceHook
Set-Alias Update-ServiceHook Update-VSTeamServiceHook

Export-ModuleMember `
   -Function Add-VSTeamServiceHook, Get-VSTeamServiceHook, Show-VSTeamServiceHook, Update-VSTeamServiceHook `
   -Alias Add-ServiceHook, Get-ServiceHook, Show-ServiceHook, Update-ServiceHook