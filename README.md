# tidal-delete-duplicate-tracks
An extension to yaronzz/Tidal media downloader that allows syncing and deleting old tracks from playlists.

This is a little script to complement the [yaronzz / Tidal media downloader](https://github.com/yaronzz/Tidal-Media-Downloader), which allows you to sync playlists and delete tracks that are deleted on Tidal from your downloads as well.
The script is programmed really shitty, but it does its job well. And for that it is enough.

## How it works

The tidal-media-downloader downloads every song, what is in a playlist, with the sequential number of the position from the playlist in the prefix.
```
01 - Nina Chuba - Wildberry Lillet.flac   
02 - Liaze - PARADISE (MIT DIR).flac     
03 - Bonez MC - Taxi(Explicit).flac
04 - Topic - Kernkraft 400 (A Better Day).flac
...
```
If the order in the playlist changes, the number also changes and thus the entire playlist is downloaded again, because the filename matching of the downloader no longer works.
My script now checks if a number from the prefixes occurs twice in the folder. If this is the case, all files with the number (eg `02`) are taken and all songs, except the newest, are deleted.

This method deletes all old tracks, which may be duplicated, and with a few detours you can build a sync of the playlist.

## Usage

The usage is simple. Just run the script and specify the path to the folder with the tracks in the argument:
```
bash delete_duplicate_tracks.sh ~/Music/MyLibrary/
```

The best way to use the script is, running it directly after execute the tidal-dl tool.
