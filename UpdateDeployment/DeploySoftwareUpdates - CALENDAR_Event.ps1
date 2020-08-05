# To be used with DeploySoftwareUpdates.ps1 script. By using the same UpdateControl csv file, you can create calendar
# events to send to the stakeholders, notifying them of when the deployment will occur.


# Get the details for the deployment from the text file. (EDIT THIS)
$DeploymentDetail = Get-Content "C:\Location\UpdateControl.txt"

# Process each line of the input file.
ForEach ($Detail in $DeploymentDetail)
{
    # Each item in the input file is separated by a comma.  Split those values into their corresponding intended variable
    # and use as options for Start-CMSoftwareUpdateDeployment.
    $split=$Detail.split(",")
    $UpdateGroupName = $Split[0]
    $DeploymentTitle = $Split[1]
    $TargetCollection = $Split[2]
    $DeploymentDateTime = $Split[3]
    $DeadlineDateTime = $Split[4]


 #Create Calendar Event for Deployment.
    $ol = New-Object -ComObject Outlook.Application
    $meeting = $ol.CreateItem('olAppointmentItem')
    $meeting.Subject = $DeploymentTitle
    $meeting.Body = $DeploymentTitle
    $meeting.Location = 'Virtual'
    $meeting.ReminderSet = $true
    $meeting.Categories = 'Patching'
    #$meeting.Importance = 1
    $meeting.MeetingStatus = [Microsoft.Office.Interop.Outlook.OlMeetingStatus]::olMeeting
    $meeting.Recipients.Add('GroupEmail@email.com')
    $meeting.ReminderMinutesBeforeStart = 300
    $meeting.Start = [datetime]$DeadlineDateTime
    #$meeting.End = [datetime]"10/11/2019 19:00"
    $meeting.Duration = 360
    #$meeting.File = $CollectionMembersFile
    $meeting.Send()
}