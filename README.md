# hololive-en-script
Simple script to use with ytarchive.exe to download Hololive EN live streams

# Programs needed
The following programs need to be in the same **<working_directory>** as the ps1 file
- ytarchive.exe
- ffmpeg.exe

## File structure example:
![files](/images/files.png)

# How to install dependencies
## ytarchive.exe
 - download [ytarchive.exe](https://github.com/Kethsar/ytarchive/releases)
 - extract zip
 - move ytarchive.exe to the **<working_directory>**
## ffmpeg.exe
 - download [ffmpeg.exe](https://www.gyan.dev/ffmpeg/builds/)
 - extract zip
 - find the ffmpeg.exe inside the extracted folder
    - looks like:  `Downloads\ffmpeg-2022-08-25-git-9bf9d42d01-essentials_build\bin\ffmpeg.exe`
 - move ffmpeg.exe to the **<working_directory>**

# How to use
## Start the script by choosing one of the following: 
 - Double-click `start.bat`
 - or Right-clicking `hololive-en.ps1` and selecting `Run with Powershell`
## Select a channel and wait for stream to start
![select_channel](/images/example.png)

## Output
By default, the streams will be saved under a folder called `unwatched` in the **<working_directory**
```
unwatched/[channelName] YYYYMMDD STREAM_TITLE (YOUTUBE_ID)
```

## Wait after Downloading
By default, after downloading one stream the script will start waiting for the next one
> Cancel script by pressing `ctrl + c`


# Cookie file for member streams
## If you want to record a member stream you need to set a cookie file
 - Create cookie file: https://www.reddit.com/r/youtubedl/wiki/cookies/
 - Place the `cookie.txt` file in the **<working_directory>**

# Download just one archived stream
### replace `<url>` with the video url and run this 
```
.\ytarchive.exe -c cookies.txt --vp9 -v -t -r 60 -o 'unwatched/[%(channel)s] %(upload_date)s %(title)s (%(id)s)' <url> best
```
    
