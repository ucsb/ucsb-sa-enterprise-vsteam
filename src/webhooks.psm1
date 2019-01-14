Set-StrictMode -Version Latest

# Load common code
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\common.ps1"

# Apply types to the returned objects so format and type files can
# identify the object and act on it.
function _applyTypesToWebHook {
   param($item)

   # If there are ids in the list that don't map to a work item and empty
   # entry is returned in its place if ErrorPolicy is Omit.
   if ($item) {
      $item.PSObject.TypeNames.Insert(0, 'Team.WebHook')
   }
}

function Add-VSTeamWebHook {
   [CmdletBinding()]
   param(
   )

   DynamicParam {
      _buildProjectNameDynamicParam
   }

   Process {
   }
}

function Update-VSTeamWebHook {
   [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = "Medium")]
   param(
      [switch] $Force
   )

   DynamicParam {
      _buildProjectNameDynamicParam
   }

   Process {

      if ($Force -or $pscmdlet.ShouldProcess($item, "Update Web Hook")) {
      }
   }
}

function Show-VSTeamWebHook {
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

function Get-VSTeamWebHook {
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
            
            _applyTypesToWebHook -item $resp

            Write-Output $resp
         }
      }
      else {
         # Build the url to list the builds
         $resp = _callAPI -Area 'hooks' -Resource 'subscriptions' `
            -Version $([VSTeamVersions]::Hooks) `
            -Querystring @{
               'consumerId' = 'webHooks'
            }
         
         # Apply a Type Name so we can use custom format view and custom type extensions
         foreach ($item in $resp.value) {
            _applyTypesToWebHook -item $item
         }

         Write-Output $resp.value
      }
   }
}

Set-Alias Add-WebHook Add-VSTeamWebHook
Set-Alias Get-WebHook Get-VSTeamWebHook
Set-Alias Show-WebHook Show-VSTeamWebHook
Set-Alias Update-WebHook Update-VSTeamWebHook

Export-ModuleMember `
   -Function Add-VSTeamWebHook, Get-VSTeamWebHook, Show-VSTeamWebHook, Update-VSTeamWebHook `
   -Alias Add-WebHook, Get-WebHook, Show-WebHook, Update-WebHook