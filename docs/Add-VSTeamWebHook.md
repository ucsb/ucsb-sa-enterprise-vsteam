


# Add-VSTeamWebHook

## SYNOPSIS

Adds a new web hook.

## SYNTAX

## DESCRIPTION

Adds a new web hook.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------

```PowerShell
PS C:\> Add-VSTeamWebHook -Trigger 'Build completed' -Url http://someurl.com
```

This command adds a web hook that is triggered on each completed build and posts via HTTP to http://someurl.com

## PARAMETERS

### -Trigger

The type of event this web hook is triggered on. The acceptable values for this parameter are:

- Build completed
- Code pushed
- Pull request created
- Pull request merge attempted
- Pull request updated
- Release abandoned
- Release created
- Release deployment approval completed
- Release deployment approval pending
- Release deployment completed
- Release deployment started
- Work item commented on
- Work item created
- Work item deleted
- Work item restored
- Work item updated

```yaml
Type: string
Parameter Sets:
Required: True
```

### -AreaPath

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: WorkItemCommentedOn, WorkItemRestored, WorkItemDeleted, WorkItemCreated
Required: False
```

### -WorkItemType

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: WorkItemCommentedOn, WorkItemRestored, WorkItemDeleted, WorkItemCreated
Required: False
```

### -Tag

```yaml
Type: string
Parameter Sets: WorkItemCommentedOn, WorkItemUpdated, WorkItemRestored, WorkItemDeleted, WorkItemCreated
Required: False
```

### -Contains

```yaml
Type: string
Parameter Sets: WorkItemCommentedOn
Required: False
```

### -Field

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: WorkItemUpdated
Required: False
```

### -LinksAddedOrRemoved

```yaml
Type: switch
Parameter Sets: WorkItemUpdated, WorkItemCreated
Required: False
```

### -BuildPipeline

```yaml
Type: string
Parameter Sets: BuildCompleted
Required: False
```

### -BuildStatus

```yaml
Type: string
Parameter Sets: BuildCompleted
Required: False
```

### -Repository

```yaml
Type: string
Parameter Sets: Code, PullRequest, PullRequestMerge, PullRequestUpdated
Required: False
```

### -Branch

```yaml
Type: string
Aliases: TargetBranch
Parameter Sets: Code, PullRequest, PullRequestMerge, PullRequestUpdated
Required: False
```

### -Group

Only trigger if the event is triggered by a member of this group.

```yaml
Type: string
Parameter Sets: Code, PullRequest, PullRequestMerge, PullRequestUpdated
Required: False
```

### -ReviewerGroup

Only trigger if the event is triggered by a reviewer that is a member of this group.

```yaml
Type: string
Parameter Sets: PullRequest, PullRequestMerge, PullRequestUpdated
Required: False
```

### -MergeResult

- \[Any\]
- Merge Successful
- Merge Unsuccessful - Reason: Any
- Merge Unsuccessful - Reason: Conflicts
- Merge Unsuccessful - Reason: Failure
- Merge Unsuccessful - Reason: Rejected By Policy

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: PullRequestMerge
Required: False
```

### -PullRequestChange

- \[Any\]
- Source branch updated
- Reviewers changed
- Status changed
- Votes score changed

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: PullRequestChange
Required: False
```

### -ReleasePipeline

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: Release, ReleaseDeploymentApprovalCompleted, ReleaseDeploymentApprovalPending, ReleaseDeploymentCompleted, ReleaseDeploymentStarted
Required: False
```

### -Stage

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: ReleaseDeploymentApprovalCompleted, ReleaseDeploymentApprovalPending, ReleaseDeploymentCompleted, ReleaseDeploymentStarted
Required: False
```

### -ApprovalType

- \[Any\]
- Pre-deployment
- Post-deployment

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: ReleaseDeploymentApprovalCompleted, ReleaseDeploymentApprovalPending
Required: False
```

### -ApprovalStatus

- \[Any\]
- Approved
- Rejected

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: ReleaseDeploymentApprovalCompleted
Required: False
```

### -ReleaseStatus

- \[Any\]
- Canceled
- Partially Succeeded
- Failed
- Succeeded

```yaml
Type: string
Default value: \[Any\]
Parameter Sets: ReleaseDeploymentCompleted
Required: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
