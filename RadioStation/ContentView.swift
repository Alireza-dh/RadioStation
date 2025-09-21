
//let url = URL(string: "https://stream.radiojar.com/cp13r2cpn3quv")!
//let url = URL(string: "https://stream.zeno.fm/0bybax2r3heuv")!
import SwiftUI
import AVFoundation
import Combine
struct RadioStation:  Identifiable, Equatable, Hashable  {
    let id = UUID()
    let name: String
    let url: String
}
let stations: [RadioStation] = [
    RadioStation(name: "Radio Farda", url: "https://stream.radiojar.com/cp13r2cpn3quv"),
    RadioStation(name: "BBC Radio 4", url: "https://stream.zeno.fm/0bybax2r3heuv"),
    RadioStation(name: "BBC World Service", url: "https://stream.live.vc.bbcmedia.co.uk/bbc_world_service"),
    RadioStation(name: "NPR Live", url: "https://npr-ice.streamguys1.com/live.mp3"),
    RadioStation(name: "NTS 1 London", url: "https://stream-relay-geo.ntslive.net/stream")
]

final class RadioPlayer: ObservableObject {
    private var player: AVPlayer?
    @Published var isPlaying = false
    @Published var currentStation: RadioStation?

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    func play(station: RadioStation) {
        guard let url = URL(string: station.url) else { return }
        player = AVPlayer(url: url)
        player?.play()
        currentStation = station
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }
}



struct ContentView: View {
    @StateObject private var player = RadioPlayer()
    @State private var selected: RadioStation? = stations.first

    var body: some View {
        VStack(spacing: 16) {
            Picker("ایستگاه رادیویی", selection: $selected) {
                ForEach(stations) { st in
                    Text(st.name).tag(Optional(st))
                }
            }
            .pickerStyle(.wheel)
            .onChange(of: selected) { newValue in
                if let st = newValue {
                    player.play(station: st)
                }
            }

            Text(player.currentStation?.name ?? "هیچ ایستگاهی انتخاب نشده")
                .font(.headline)

            Button(player.isPlaying ? "Pause" : "Play") {
                if let st = selected {
                    if player.isPlaying {
                        player.pause()
                    } else {
                        player.play(station: st)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            if let st = selected {
                player.play(station: st)
            }
        }
    }
}

#Preview {
    ContentView()
}
