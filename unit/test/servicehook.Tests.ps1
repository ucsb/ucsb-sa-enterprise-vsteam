Set-StrictMode -Version Latest

InModuleScope servicehooks {
   [VSTeamVersions]::Account = 'https://dev.azure.com/test'

   Describe 'servicehooks'{
      # Mock the call to Get-Projects by the dynamic parameter for ProjectName
      Mock Invoke-RestMethod { return @() } -ParameterFilter {
         $Uri -like "*_apis/projects*"
      }

      . "$PSScriptRoot\mocks\mockProjectNameDynamicParamNoPSet.ps1"

      $obj = @{
         id  = 47
         rev = 1
         url = "https://dev.azure.com/test/_apis/wit/workItems/47"
      }

      $collection = @{
         count = 1
         value = @($obj)
      }

      Context 'Show-ServiceHooks' {         
         Mock Show-Browser { }

         It 'Should open browser' {
            Show-VSTeamServiceHook -projectName project

            Assert-MockCalled Show-Browser -Exactly -Scope It -Times 1 -ParameterFilter { $url -eq 'https://dev.azure.com/test/project/_settings/serviceHooks' }
         }
      }

      Context 'Get-ServiceHooks' {         
         It 'Should return a list of service hooks' {
            Mock Invoke-RestMethod {
               # If this test fails uncomment the line below to see how the mock was called.
               # Write-Host $args
   
               return $collection
            }

            Get-VSTeamServiceHook

            Assert-MockCalled Invoke-RestMethod -Exactly -Scope It -Times 1 -ParameterFilter {
               $Uri -like "*https://dev.azure.com/test/_apis/hooks/subscriptions*" -and
               $Uri -like "*api-version=$([VSTeamVersions]::Hooks)*"
            }
         }
      }

      Context 'Get-ServiceHooks by ID' {
         It 'Should return a list of service hooks' {
            Mock Invoke-RestMethod {
               # If this test fails uncomment the line below to see how the mock was called.               
               # Write-Host $args
   
               return $obj
            }

            Get-VSTeamServiceHook -Id 00000000-0000-0000-0000-000000000000

            Assert-MockCalled Invoke-RestMethod -Exactly -Scope It -Times 1 -ParameterFilter {
               $Uri -like "*https://dev.azure.com/test/_apis/hooks/subscriptions*" -and
               $Uri -like "*00000000-0000-0000-0000-000000000000*" -and
               $Uri -like "*api-version=$([VSTeamVersions]::Hooks)*"
            }
         }
      }
   }
}