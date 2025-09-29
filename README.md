# iOS App Exercise: **Movie Explorer** with TheMovieDB API

## Goal
Build an iOS app using **SwiftUI**, **Swift**, and **Swift Package Manager (SPM)** that consumes the **TheMovieDB API**:  
👉 [TMDB Docs – Getting Started](https://developer.themoviedb.org/docs/getting-started)

The app should demonstrate modern iOS development practices, clean code, and Git workflow discipline.

---

## Functional Requirements

### General
- The app must **adapt to the system theme** (Light / Dark).
- Support **nested navigation**:  
  Example: from a movie detail, open a related movie’s detail, then from there open another related item, and so on.

### Content
- **Movies and TV Shows**:
  - Show collections (grids/lists) with poster images and basic metadata (title, year, rating).
  - Query for both **popular** and **top-rated** items.
  - Provide **search** functionality across movies and TV shows.
- **Details view**:
  - Show poster, title, year, genres, rating, runtime/season count, description, and cast (at least top 5).
  - Show **related/recommended items** with navigation to their details.
  - Integrate **videos** (trailers, clips) from TMDB, playable inside the app.
- **TV Series**:
  - Display seasons and episodes inside the details screen.

---

## Non-Functional / Technical Requirements
- **Language & UI**: Swift + SwiftUI (target iOS 16+ recommended).
- **Dependency Management**: Swift Package Manager only.
- **Architecture**:  
  - MVVM or similar separation of concerns.  
  - Apply **Clean Code** and **SOLID principles** where possible.  
  - Separate DTOs (API models) from Domain models.
- **Networking**:
  - Use `URLSession` with `async/await`.  
  - Organize API client to handle endpoints, parameters, and error cases.
- **Caching**:
  - Cache poster images.  
  - Cache API responses when possible.
- **Error Handling**:
  - Show loading, error, and empty states in all major views.  
  - Retry option on error.
- **Accessibility**:
  - Support Dynamic Type.  
  - VoiceOver labels for images and buttons.
- **Localization**:
  - Provide at least **English** and **Spanish**.

---

## Git & Collaboration
- Use **GitFlow** workflow:
  - Main branch: `main` (stable, reviewed code only).  
  - Development branch: `develop`.  
  - Feature branches from `develop`.  
  - Merge to `develop` via **Merge Requests** (MRs) that must be reviewed before merging.  
- Investigate and **document GitFlow** briefly in the README.

---

## Testing
- **Unit Tests** required:
  - API client decoding (JSON → models).  
  - ViewModels (loading state, pagination, errors).  
- Use mocks/stubs to avoid real API calls during testing.
- **Optional plus**: adopt **Test Driven Development (TDD)** in at least one feature.

---

## Extras / Plus Points
- **Multiplatform** (iPadOS or macOS via Catalyst).  
- **TDD** applied in features.  
- Snapshot/UI tests.  
- CI pipeline (GitHub Actions or similar) for build + test.  

---

## Recommendations
- Store API key securely using `xcconfig` or environment variables (do not commit secrets).  
- Use `NavigationStack` and `NavigationPath` for deep/nested navigation.  
- Provide a clean, modular structure with SPM packages:
        MovieExplorer/
            App/
            Packages/
                Core/
                Networking/
                TMDBClient/
                Features/
                    Home/
                    Search/
                    Details/
                    TVSeasons/
                    Video/
- Document technical decisions in the README.  
- Include screenshots or a short GIF demo of the app.

---

## Definition of Done (Checklist)
- [ ] App runs on iOS 16+ (simulator and device).  
- [ ] Respects Light/Dark system theme.  
- [ ] Home with multiple sections (Trending, Popular, Top Rated).  
- [ ] Search with debounce.  
- [ ] Detail view with videos, cast, and related items.  
- [ ] Nested navigation between related items.  
- [ ] TV shows with seasons and episodes.  
- [ ] Error, loading, and empty states.  
- [ ] Image caching.  
- [ ] Unit tests for networking and view models.  
- [ ] GitFlow with MR reviews.  
- [ ] README explaining setup and GitFlow.  

---

## Evaluation Criteria
- **Architecture**: modular, clean, testable.  
- **Code Quality**: readability, adherence to SOLID and Clean Code.  
- **UX & UI**: responsiveness, accessibility, error states.  
- **Testing**: quality and coverage.  
- **Git Workflow**: branch structure, MR usage, commit history.  
- **Documentation**: clarity of README and setup instructions.  

---

👉 This exercise is designed to be **practical yet complete**, so you’ll touch on networking, UI, architecture, testing, Git practices, and clean code.

