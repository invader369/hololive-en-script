# set working directory to whereever the ps1 file is at
# (important to use LiteralPath)
Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot
$loc = Get-Location
Write-Host "Working directory: $loc"

#options
$cookie = "cookies.txt"
$WAIT_FOR_NEXT_STREAM = $True

$channelList = [ordered]@{}

# check cookie file
if (-not (Test-Path -Path $cookie -PathType Leaf)) {
    Write-Warning "No cookie file found matching: $cookie"
}

# myth
$channelList.add("Callipe Mori", @("Callipe Mori", "UCL_qhgtOy0dy1Agp8vkySQg"))
$channelList.add("Takanashi Kiara", @("Takanashi Kiara", "UCHsx4Hqa-1ORjQTh9TYDhww"))
$channelList.add("Ninomae Ina", @("Ninomae Ina'nis", "UCMwGHR0BTZuLsmjY_NT5Pwg"))
$channelList.add("Gawr Gura", @("Gawr Gura", "UCoSrY_IQQVpmIRZ9Xf-y93g"))
$channelList.add("Amelia Watson", @("Amelia Watson", "UCyl1z3jo3XHR1riLFKG5UAg"))

# councilrys
$channelList.add("IRyS", @("IRyS", "UC8rcEBzJSleTkf_-agPM20g"))
$channelList.add("Ceres Fauna", @("Ceres Fauna", "UCO_aKKYxn4tvrqPjcTzZ6EQ"))
$channelList.add("Ouro Kronii", @("Ouro Kronii", "UCmbs8T6MWqUHP1tIQvSgKrg"))
$channelList.add("Nanashi Mumei", @("Nanashi Mumei", "UC3n5uGu18FoCy23ggWWp8tA"))
$channelList.add("Hakos Baelz", @("Hakos Baelz", "UCgmPnx-EEeOrZSg5Tiw7ZRQ"))

# print choices
# 0 is custom
# 1+ is based on the channelList
Write-Host '0. Custom URL'

$option = 1
$channelList.keys | ForEach-Object {
    $optionMsg = '{0}. {1}' -f $option, $_
    $option++
    Write-Host $optionMsg
}

Write-Host ""
$choice = Read-Host -Prompt "Select option"

if ($choice -eq 0) {
    $WAIT_FOR_NEXT_STREAM = $False
    $nameFormat = "'unwatched/[%(channel)s] %(upload_date)s %(title)s (%(id)s)'"
    # grab channel name from the youtube metadata
    $url = Read-Host -Prompt "Enter youtube url" 
} else {
    $channelName = $channelList[$choice-1].get(0)
    $channelId = $channelList[$choice-1].get(1)

    $nameFormat = "'unwatched/[$channelName] %(upload_date)s %(title)s (%(id)s)'"

    # format https://www.youtube.com/channel/<channel_id>/live
    $url = "https://www.youtube.com/channel/{0}/live" -f $channelId
}

# check for cookie file
if (Test-Path -Path $cookie -PathType Leaf) {
    $ytCommand = ".\ytarchive.exe -c {0} --vp9 -v -t -r 60 -o {1} {2} best" -f $cookie, $nameFormat, $url
}
else {
    $ytCommand = ".\ytarchive.exe --vp9 -v -t -r 60 -o {0} {1} best" -f $nameFormat, $url
}

Write-Host "Starting download for: " $channelName
Write-Debug "Using url: $url"
Write-Debug "Command: $ytCommand"

DO {
    Invoke-Expression "$ytCommand"
} While ($WAIT_FOR_NEXT_STREAM)