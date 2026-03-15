if status is-interactive
    set -g fish_greeting
    abbr -a update 'sudo dnf upgrade --refresh -y; and flatpak update -y'
    set -gx QT_QPA_PLATFORMTHEME qt6ct
    fastfetch --logo-type small  
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri
 function dl-music
    # 1. Download with better metadata handling
    yt-dlp -x --audio-format opus --audio-quality 0 \
    --embed-metadata --embed-thumbnail --add-metadata \
    --parse-metadata "title:%(artist)s - %(title)s" \
    --parse-metadata "playlist_title:%(album)s" \
    -o "~/Music/playlists/%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s" $argv

    # 2. Get the folder name safely
    set playlist_dir (yt-dlp --get-filename -o "%(playlist_title)s" $argv[1] | head -n 1)
    
   # 3. Build the playlist.m3u 
    if test -d "/home/benim/Music/playlists/$playlist_dir"
        printf '%s\n' /home/benim/Music/playlists/"$playlist_dir"/*.opus > /home/benim/Music/playlists/"$playlist_dir"/playlist.m3u
        echo "Successfully updated playlist for $playlist_dir
        cmus-remote -C "clear" -C "load /home/benim/Music/playlists/$playlist_dir/playlist.m3u""
    end
 end
set -gx EDITOR vim
 starship init fish | source
end
