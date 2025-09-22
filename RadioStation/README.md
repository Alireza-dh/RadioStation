//
//  Untitled.swift
//  RadioStation
//
//  Created by Alireza on 22/09/2025.
//

RadioStation (iOS, SwiftUI)
A simple iOS radio streaming app built with SwiftUI and AVPlayer.
Supports background audio playback and lock-screen controls.
Features
Play and stop live radio stream
Background playback with AVAudioSession(.playback)
Lock-screen Now Playing info (title, artist) via MPNowPlayingInfoCenter
Minimal UI built in SwiftUI
Custom app icon included
Requirements
iOS 15+
Xcode 15+
Swift 5.9+
A valid HTTP(S) streaming URL (.mp3 or .m3u8 recommended)
Setup
Clone the project:
git clone https://github.com/<your-username>/RadioStation.git
cd RadioStation
open RadioStation.xcodeproj
Open Signing & Capabilities for the app target and make sure:
Background Modes is added
Audio, AirPlay, and Picture in Picture is checked
Configure the audio session before playback (already in the code):
import AVFoundation

try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
try? AVAudioSession.sharedInstance().setActive(true)
Set your streaming URL in the RadioStation model or player:
let radioURL = URL(string: "https://your-stream-url.example.com/stream.mp3")!
Build & Run on device or simulator.
Lock-Screen Controls (optional but included)
Update Now Playing metadata whenever you start playback:
import MediaPlayer

func setupNowPlaying(title: String = "Radio", artist: String = "Live") {
    MPNowPlayingInfoCenter.default().nowPlayingInfo = [
        MPMediaItemPropertyTitle: title,
        MPMediaItemPropertyArtist: artist
    ]
}
App Icon
The project contains a full AppIcon.appiconset.
If Xcode warns about missing sizes, replace the set with a complete one and ensure Target → General → App Icon points to AppIcon.
Troubleshooting
No sound in background
Ensure Background Modes → Audio is enabled and the app ran on a real device at least once.
Asset catalog warnings
Remove duplicate image sets; keep a single AppIcon and unique image names.
Stream doesn’t start
Verify the URL is reachable and uses HTTPS (or set ATS exceptions in Info.plist for non-HTTPS, only if needed).
Roadmap / TODO
Add play/pause from Lock Screen and Control Center commands
Show station list and favorites
Display artwork and track metadata (ICY / HLS tags)
Add error states and retry/backoff
Integrate background task handling
License
MIT — feel free to use and modify with attribution.
