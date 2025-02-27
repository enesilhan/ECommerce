### ECommerce



## 🔧 Technologies Used
- **📱 Minimum iOS Version:** iOS 15+
- **🛠 Architecture:** MVVM (Model-View-ViewModel)
- **⚡️ Libraries:**
  - [Kingfisher](https://github.com/onevcat/Kingfisher)

## 📂 Project Structure
```
Oddsy
│── AppDelegate.swift
│── SceneDelegate.swift
│── Resources/
│── Models/
│── Scene/
│── Networking/
│── Managerss/
│── Extensions/
│── Assets.xcassets
│── Info.plist
```

## 🔄 Git Flow
- **Main branch:** `master`
- **Development branch:** `develop`
- **Feature branches:** `feature/xxx`
- **Bugfix branches:** `bugfix/xxx`
- **Merge process:**
  - `feature/xxx` and `bugfix/xxx` are merged into `develop`.
  - `develop` is tested and merged into `master` after approval.
- **Commit Message Format (Semantic Commits):**
  - `feat(component): add new feature`
  - `fix(module): fix a bug`
  - `chore(dependency): update dependencies`
  - `docs(readme): update documentation`
  - `refactor(code): improve structure without changing functionality`

## 🚀 Setup
1. Clone the repository:
   ```sh
   git clone <https://github.com/enesilhan/ECommerce>
   ```
2. Install dependencies:
   ```sh
   swift package resolve  # For Swift Package Manager
   ```
3. Open the project in Xcode and run it.
