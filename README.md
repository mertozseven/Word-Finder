
<p align="center">
  <img src="https://github.com/mertozseven/Word-Finder/assets/75128197/cdfeecf4-dd2f-4394-aa67-3a69213e2cca" width="150" height="150">
</p>

<div align="center">
  <h1>Word Finder - Turkcell Geleceği Yazanlar Bootcamp Final Project by Mert Adem Özseven</h1>
</div>

Welcome to Word Finder! Perfect companion for learn new words and see in depth information about them 📖. This app allows users to search and learn new words, see details and uses about them, listen the audio of the word's pronounciation, see synonyms and much more. 

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Improvements](#improvements)

## Features

- Explore every word and it's details by searching them.

- In home view, there's a search bar and recents tble view. If there is no recent search found, an empty view shows up and table view hides. Recent searches has a limit of 5 words and if searched word is searched before, it does not added again to the tableview and goes to the top of the list.

-  When searching word in the home view, search button follows the keyboard's height and stays on top of the keyboard.
  
- In Detail View of the word, there are phonetics, part of speech, definition, example, synonyms, filtered explanations of the word and much more!

- Filtering functionality for part of speech in details view (It doesn't merge like the requirements of the case but it filters them perfectly).

- When tapping to one of the synonyms in the bottom of the detail view, it directs to the detail view of the tapped word.

- If audio button is tapped, the audio of the word is played and if audio is not provided for that word, the button disappears.

- At the bottom of the detail view, there are synonyms of that word that are fetched from the other API that desired. After fething, 6 of the most highest ranked synonyms are selected and shown in the detail view.

- All of the data across the app is dynamic and all of the UI elements change it's height and other properties for it.

- Unit and UI tests

- UserDefaults integration for storing recent searches.

 ## Screenshots
 
| Image 1                | Image 2                | Image 3                |
|------------------------|------------------------|------------------------|
| ![splashDark](https://github.com/mertozseven/Word-Finder/assets/75128197/ade69402-ee34-45d3-9f16-8bd770219e29) | ![darkHome](https://github.com/mertozseven/Word-Finder/assets/75128197/2f40bda1-e7d7-47e1-923a-a8d380b06427) | ![darkDetail](https://github.com/mertozseven/Word-Finder/assets/75128197/663cee3a-b899-41b3-9070-e627d3528b3d) |
| Splash Screen (Dark Mode)    | Home (Dark Mode)    | Detail View (Dark Mode)    |

| Image 4                | Image 5                | Image 6                |
|------------------------|------------------------|------------------------|
| ![splashLight](https://github.com/mertozseven/Word-Finder/assets/75128197/661519af-dfe7-4b83-8ec2-4d1e6f0b9762) | ![lightHome](https://github.com/mertozseven/Word-Finder/assets/75128197/bcb56f72-992f-43fa-b9c8-9c2d3f8a86cc) | ![lightDetail](https://github.com/mertozseven/Word-Finder/assets/75128197/bc88f69b-9459-44a9-8206-8f7ca5e42b15) |
| Splash Screen (Light Mode)    | Home (Light Mode)    | Detail View (Light Mode)    |

## Tech Stack

- **Xcode:** Version 15.4
- **Language:** Swift 5.10
- **Minimum iOS Version:** 17.0
- **Dependency Manager:** SPM

## Architecture

![VIPER](https://github.com/mertozseven/Word-Finder/assets/75128197/1e078027-f797-4132-b22e-90fde2b08511)

In Word Finder's development, VIPER (View-Interactor-Presenter-Entity-Router) architecture is being used for these key reasons:

- **Enhanced Maintainability:** VIPER facilitates a clean separation of concerns by dividing the app into five distinct layers. Each layer has a specific responsibility, making it easier to manage and update the codebase as the app evolves.
- **Improved Testability:** The strict separation of concerns in VIPER allows for more straightforward unit testing. Developers can focus on testing the individual components (Interactor, Presenter, and Router) independently without worrying about the user interface.
- **Stronger Modularity:** VIPER's modular approach encourages reusability and scalability. Each module can be developed, tested, and maintained independently, leading to a more robust and scalable app architecture.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/mertozseven/Word-Finder.git
    ```

2. Open the project in Xcode:

    ```bash
    cd Gamesplorer
    open Gamesplorer.xcodeproj
    ```
    
3. Build and run the project.

## Usage Video

<p align="left">
  <video src="https://github.com/mertozseven/Word-Finder/assets/75128197/42fac85d-2288-4dfe-98f5-e132d09c5737" alt="Usage" width="200" height="400">
</p>

---

## Improvemets
- Filtering functionality is not the same as the required one. it does not merge labels into each other but works perfectly fine.
- Localization for other languages can be added to be able to reach more user.
