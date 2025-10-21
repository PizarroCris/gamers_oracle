# 🎮 Gamer's Oracle

## 🌟 Project Overview

**Gamer's Oracle** is an Artificial Intelligence assistant specialized and dedicated to the gaming community. It solves the problem of searching through outdated forums and guides by offering real-time tips, strategies, and relevant information about specific games, all within a focused chat environment.

The application allows users to create a dedicated "chat room" for their favorite game, where the AI assistant then becomes an oracle focused solely on that title.

**Target Audience:** Gamers, streamers, and anyone looking for immediate, contextualized assistance regarding their games.

---

## 📸 Application Screenshot

**A quick look at the Gamer's Oracle landing page:**

![Gamer's Oracle Landing Page](https://github.com/PizarroCris/Gamers_Oracle/blob/master/app/assets/gamers-oracle-landing.png?raw=true)
---

## ✨ Key Features

Gamer's Oracle provides a user experience focused on personalization and immediate communication:

1.  **Custom Game Creation:** Users can register and personalize their own games on the platform, including image uploads (via Cloudinary).
2.  **Contextualized AI Chats:** By creating a chat for a specific game, the AI assistant is programmed to **automatically recognize the game's name**, allowing the user to start asking questions immediately without needing to repeat the title.
3.  **Immediate Assistance (OpenAI Integration):** The core of the application, where the AI (powered by the **OpenAI API**) provides specific tips and answers, functioning as a personalized guide.
4.  **Real-Time Chat (TurboStreams):** Utilization of **TurboStreams and WebSocket** to ensure user messages and AI responses appear instantly, simulating a fluid conversation.

---

## 🛠️ Tech Stack

This project was built during a **Le Wagon Web Development Bootcamp** and utilizes the following technologies:

* **Main Backend:** **Ruby on Rails**
* **Frontend:** HTML, CSS, JavaScript (with Hotwire/Turbo)
* **Database:** **PostgreSQL**
* **Containerization:** **Docker**
* **Artificial Intelligence:** Integration with **OpenAI API**
* **Real-Time Functionality:** **TurboStreams** (via Hotwire)
* **Media Storage:** **Cloudinary** (for game image uploads)
* **Deployment:** **Fly.io**

---

## 🚀 Project Setup (For Developers)

Follow the steps below to get a local copy of the project running on your machine.

### Prerequisites

To run via Docker, you only need:
* **Git**
* **Docker** and **Docker Compose** installed on your system.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone git@github.com:PizarroCris/Gamers_Oracle.git
    cd gamers-oracle
    ```
    
2.  **Build the application and database containers:**
    ```bash
    docker-compose build
    ```
    
3.  **Run migrations and seed the database:**
    ```bash
    docker-compose run --rm web bundle exec rails db:create
    docker-compose run --rm web bundle exec rails db:migrate
    ```

4.  **API Key Configuration (OpenAI)**
    The project requires an OpenAI API key. Create a `.env` file (or use Rails secrets tools) and define the environment variable:
    ```
    OPENAI_API_KEY="YOUR_KEY_HERE"
    ```

5.  **Start the containers:**
    ```bash
    docker-compose up
    ```
    The application will be accessible at `http://localhost:3000/`.

---

## 👥 Team

This project was built during a one week sprint of the **Le Wagon Web Development Bootcamp**.

| Role | Member | GitHub |
| :--- | :--- | :--- |
| **Lead Developer** | Cristiano Pizarro | [GitHub](https://github.com/PizarroCris) |
| **Contributor** | Yan Buxes | [GitHub](https://github.com/ynbxs) |
| **Contributor** | Caio Figueiredo | [GitHub](https://github.com/CAiAuM) |
