function Add-VSTeamWebHook {
   [CmdletBinding(DefaultParameterSetName = 'BuildCompleted')]
   param(
      [parameter(Mandatory = $true, Position = 0)]
      [ValidateSet('Build completed', 'Code pushed', 'Pull request created', 'Pull request merge attempted', 'Pull request updated', 'Release abandoned', 'Release created', 'Release deployment approval completed', 'Release deployment approval pending', 'Release deployment completed', 'Release deployment started', 'Work item commented on', 'Work item created', 'Work item deleted', 'Work item restored', 'Work item updated')]
      [string] $Trigger,

      [parameter(ParameterSetName = 'BuildCompleted', Mandatory = $false, Position = 1)]
      [string] $BuildPipeline = '[Any]',

      [parameter(ParameterSetName = 'BuildCompleted', Mandatory = $false, Position = 2)]
      [string] $BuildStatus = '[Any]',

      [parameter(ParameterSetName = 'Code', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'PullRequest', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'PullRequestMerge', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'PullRequestUpdated', Mandatory = $false, Position = 1)]
      [string] $Repository = '[Any]',

      [parameter(ParameterSetName = 'Code', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'PullRequest', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'PullRequestMerge', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'PullRequestUpdated', Mandatory = $false, Position = 2)]
      [Alias('TargetBranch')]
      [string] $Branch = '[Any]',

      [parameter(ParameterSetName = 'Code', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'PullRequest', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'PullRequestMerge', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'PullRequestUpdated', Mandatory = $false, Position = 3)]
      [string] $Group = '[Any]',

      [parameter(ParameterSetName = 'PullRequest', Mandatory = $false, Position = 4)]
      [parameter(ParameterSetName = 'PullRequestMerge', Mandatory = $false, Position = 4)]
      [parameter(ParameterSetName = 'PullRequestUpdated', Mandatory = $false, Position = 4)]
      [string] $ReviewerGroup = '[Any]',

      [parameter(ParameterSetName = 'PullRequestMerge', Mandatory = $false, Position = 5)]
      [ValidateSet('[Any]', 'Merge Successful', 'Merge Unsuccessful - Reason: Any', 'Merge Unsuccessful - Reason: Conflicts', 'Merge Unsuccessful - Reason: Failure', 'Merge Unsuccessful - Reason: Rejected By Policy')]
      [string] $MergeResult = '[Any]',

      [parameter(ParameterSetName = 'PullRequestUpdated', Mandatory = $false, Position = 5)]
      [ValidateSet('[Any]', 'Source branch updated', 'Reviewers changed', 'Status changed', 'Votes score changed')]
      [string] $PullRequestChange = '[Any]',

      [parameter(ParameterSetName = 'ReleaseAbandonedOrCreated', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalCompleted', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalPending', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'ReleaseDeploymentCompleted', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'ReleaseDeploymentStarted', Mandatory = $false, Position = 1)]
      [string] $ReleasePipeline = '[Any]',

      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalCompleted', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalPending', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'ReleaseDeploymentCompleted', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'ReleaseDeploymentStarted', Mandatory = $false, Position = 2)]
      [string] $ReleaseStage = '[Any]',

      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalCompleted', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalPending', Mandatory = $false, Position = 3)]
      [ValidateSet('[Any]', 'Pre-deployment', 'Post-deployment')]
      [string] $ApprovalType = '[Any]',

      [parameter(ParameterSetName = 'ReleaseDeploymentApprovalCompleted', Mandatory = $false, Position = 4)]
      [ValidateSet('[Any]', 'Approved', 'Rejected')]
      [string] $ApprovalStatus = '[Any]',

      [parameter(ParameterSetName = 'ReleaseDeploymentCompleted', Mandatory = $false, Position = 3)]
      [ValidateSet('[Any]', 'Canceled', 'Partially Succeeded', 'Failed', 'Succeeded')]
      [string] $ReleaseStatus = '[Any]',

      [parameter(ParameterSetName = 'WorkItemCommentedOn', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'WorkItemRestored', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'WorkItemDeleted', Mandatory = $false, Position = 1)]
      [parameter(ParameterSetName = 'WorkItemCreated', Mandatory = $false, Position = 1)]
      [string] $AreaPath = '[Any]',

      [parameter(ParameterSetName = 'WorkItemCommentedOn', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'WorkItemRestored', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'WorkItemDeleted', Mandatory = $false, Position = 2)]
      [parameter(ParameterSetName = 'WorkItemCreated', Mandatory = $false, Position = 2)]
      [string] $WorkItemType = '[Any]',

      [parameter(ParameterSetName = 'WorkItemCommentedOn', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'WorkItemRestored', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'WorkItemDeleted', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'WorkItemCreated', Mandatory = $false, Position = 3)]
      [parameter(ParameterSetName = 'WorkItemUpdated', Mandatory = $false, Position = 3)]
      [string] $Tag,

      [parameter(ParameterSetName = 'WorkItemCommentedOn', Mandatory = $false, Position = 4)]
      [string] $Contains,

      [parameter(ParameterSetName = 'WorkItemCommentedOn', Mandatory = $false, Position = 4)]
      [string] $Field,

      [parameter(ParameterSetName = 'WorkItemCreated')]
      [parameter(ParameterSetName = 'WorkItemUpdated')]
      [switch] $LinksAddedOrRemoved,

      [parameter(Mandatory = $true)]
      [string] $Url,

      [switch] $AcceptUntrustedSSLCertificates,

      [string] $BasicAuthUsername,
      
      [securestring] $BasicAuthPassword,
      
      [string] $HttpHeaders,

      [ValidateSet('All', 'Minimal', 'None')]
      [string] $ResourceDetailsToSend = 'All',

      [ValidateSet('All', 'Text', 'HTML', 'Markdown', 'None')]
      [string] $MessagesToSend = 'All',
      
      [ValidateSet('All', 'Text', 'HTML', 'Markdown', 'None')]      
      [string] $DetailedMessagesToSend = 'All',
      
      [string] $ResourceVersion = '[Latest]'
   )   
   
   DynamicParam {
      _buildProjectNameDynamicParam
   }

   Process {
      $consumerId = 'webHooks'
      $consumerActionId = 'httpRequest'
      $eventId = ''
      $publisherId = ''
      $projectName = $PSBoundParameters["ProjectName"]
      
      # The user selected a project name but we need the id
      $projectId = Get-VSTeamProject -Name $projectName | Select-Object -ExpandProperty Id

      switch ($Trigger) {         
         'Build completed' {
            $publisherId = 'tfs'
            $eventId = 'build.complete'
         }
         'Code pushed' {
            $publisherId = 'tfs'            
            $eventId = 'git.push'
         }
         'Pull request created' {
            $publisherId = 'tfs'            
            $eventId = 'git.pullrequest.created'
         }
         'Pull request merge attempted' {
            $publisherId = 'tfs'            
            $eventId = 'git.pullrequest.merged'
         }
         'Pull request updated' {
            $publisherId = 'tfs'            
            $eventId = 'git.pullrequest.updated'
         }
         'Release abandoned' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.release-abandoned-event'
         }
         'Release created' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.release-created-event'
         }
         'Release deployment approval completed' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.deployment-approval-completed-event'
         }
         'Release deployment approval pending' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.deployment-approval-pending-event'
         }
         'Release deployment completed' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.deployment-completed-event'
         }
         'Release deployment started' {
            $publisherId = 'rm'            
            $eventId = 'ms.vss-release.deployment-started-event'
         }
         'Work item commented on' {
            $publisherId = 'tfs'            
            $eventId = 'workitem.commented'
         }
         'Work item created' {
            $publisherId = 'tfs'            
            $eventId = 'workitem.created'
         }
         'Work item deleted' {
            $publisherId = 'tfs'            
            $eventId = 'workitem.deleted'
         }
         'Work item restored' {
            $publisherId = 'tfs'            
            $eventId = 'workitem.restored'
         }
         'Work item updated' {
            $publisherId = 'tfs'            
            $eventId = 'workitem.updated'
         }
      }

      $body = @{
         publisherId      = $publisherId
         eventType        = $eventId
         resourceVersion  = $ResourceVersion
         consumerId       = $consumerId
         consumerActionId = $consumerActionId
         publisherInputs = @{
            projectId = $projectId
         }
         consumerInputs   = @{
            url = $Url
         }
      };

      $resp = _callAPI -Area 'hooks' -Resource 'subscriptions' `
         -Method Post -ContentType 'application/json' -Body ($body | ConvertTo-Json) `
         -Version $([VSTeamVersions]::Hooks)

      Write-Output $resp
   }
}