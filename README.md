# Movie Explorer

iOS app to explore movies and TV shows using the TMDB API.

## Requirements
- Xcode 15+
- iOS 16+
- Account at [TMDB](https://www.themoviedb.org)

## Setup
1. Clone the repository
2. Create the file `MovieExplorer/Config.xcconfig`
3. Add your token:
TMDB_ACCESS_TOKEN = your_token_here
4. In Xcode go to `MovieExplorer` target → `Info` → add a new key:
   - Key: `TMDB_ACCESS_TOKEN`
   - Type: `String`
   - Value: `$(TMDB_ACCESS_TOKEN)`
5. Open `MovieExplorer.xcodeproj`
6. Run the project with `Cmd + R`

## Architecture

The app follows the **MVVM** (Model-View-ViewModel) pattern:

- **Networking/** — Handles all API calls using `URLSession` with `async/await`. Contains `NetworkManager` and `TMDBService`.
- **Models/** — Data models representing API responses (Movie, TVShow, MovieDetail, TVShowDetail, Season, Episode, Cast, Video).
- **Features/Home/** — Home screen showing Trending, Popular, and Top Rated sections for movies and TV shows.
- **Features/Detail/** — Detail screens for movies, TV shows, seasons and episodes with cast, trailers and recommendations.
- **Features/Search/** — Search functionality for movies and TV shows with 500ms debounce.

## Technical Decisions

- **Kingfisher** — Used for image caching. Avoids redundant network requests when the same poster is displayed multiple times during scrolling.
- **Config.xcconfig** — Stores the TMDB API token outside of the codebase so it is never committed to Git.
- **TMDBServiceProtocol** — Defines a protocol for the API service enabling dependency injection. This allows unit tests to use a mock service instead of making real API calls.
- **YouTubeiOSPlayerHelper** — Used to embed and play YouTube trailers directly inside the app using `YTPlayerView` wrapped in a `UIViewRepresentable`.

## GitFlow

This project follows the **GitFlow** workflow:

- **`main`** — Stable production branch. Only receives merges from `develop` after review.
- **`develop`** — Main development branch. All features are merged here via Pull Requests.
- **`feature/name`** — One branch per feature, created from `develop`. Examples: `feature/nested-navigation`, `feature/unit-tests`.

### Workflow
1. Create a feature branch from `develop`
2. Develop and commit using Conventional Commits (`feat:`, `fix:`, `chore:`)
3. Push and open a Pull Request to `develop`
4. PR is reviewed before merging
5. Branch is deleted after merge

## Testing

Run tests with `Cmd + U` in Xcode.

### What is tested
- **Model decoding** — Verifies that `Movie` and `TVShow` JSON responses decode correctly into Swift models.
- **HomeViewModel** — Verifies that `loadData()` correctly populates the movies and TV shows arrays.
- **Error handling** — Verifies that `HomeViewModel` sets `errorMessage` when the service fails.

### Mocks
`MockTMDBService` and `MockTMDBServiceError` simulate API responses without making real network calls. This ensures tests pass regardless of internet connectivity.

## Dependencies

- [Kingfisher](https://github.com/onevcat/Kingfisher) — Image caching
- [YouTubeiOSPlayerHelper](https://github.com/youtube/youtube-ios-player-helper) — YouTube video playback
