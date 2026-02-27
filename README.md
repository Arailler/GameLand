# 🧝‍♀️✨ GameLand

Welcome to **GameLand**, a whimsical website managed by mythical creatures for all game lovers! This project blends modern web technologies with a magical universe to offer a smooth, immersive, and user-friendly experience.

---

## 🧰 Tech Stack

- **Framework**: [Next.js](https://nextjs.org/) (App Router, Server Actions, RSC)
- **Language**: JavaScript / TypeScript
- **Backend**: [Node.js](https://nodejs.org/en)
- **Database**: [PostgreSQL](https://www.postgresql.org/) (via [Prisma](https://www.prisma.io/) ORM)
- **Authentication**: [NextAuth.js](https://next-auth.js.org/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **Email**: [Nodemailer](https://nodemailer.com/) integration for sending messages
- **Deployment**: [Vercel](https://vercel.com)
- **Containerization**: [Docker/docker-compose](https://www.docker.com/) and [Slim](https://github.com/slimtoolkit/slim) for image optimization
- **Other Features**:
  - Local storage-based **theme management**
  - AI-generated game illustrations

---

## ✨ Main Features

### 🎲 Game Catalog

- 🔍 Dynamic filtering by:
  - Name
  - Category
  - Minimum age
  - Number of players
- 📄 Pagination support
- ♻️ Filter reset button
- 🎨 AI-generated game images

### 👤 User Management

- 🔐 Sign up, sign in, and sign out via NextAuth
- 🧾 User profile with borrowed games and editable personal information

### 📦 Borrowing System

- 🧠 Stock update when a game is borrowed
- 📚 Borrowed games listed in the user's profile
- ⏰ Automatic return deadline calculation

### 📱 Responsive Design

- 🖥️ Optimized for desktop, tablet, and mobile
- 🌗 Light / dark mode support:
  - Matches system preference by default
  - Can be toggled manually via a switch
  - Preference saved in local storage

### 📬 Email Contact Form

- 📨 Built-in form to contact the site admin
- 🔒 Secure message delivery via Nodemailer
- ✉️ Credentials stored in environment variables

---

## 🗂️ Project Goals

This repository was created to:

- Showcase my full-stack development skills
- Demonstrate knowledge of modern web technologies
- Present a clean, maintainable codebase
- Be used as part of a portfolio

---

## 🌐 Vercel Deployment

If you're only interested in seeing what the application looks like and how it behaves, you can find it online at: **https://gameland-ten.vercel.app/**

---

## 🛠️ Play Locally With The Code

Clone the repo and configure your `.env` file using the provided `.env.example`.

```bash
git clone https://github.com/your-username/gameland.git
cd gameland
cp .env.example .env
```

### 🔐 Environment Variables

You’ll need to fill in your `.env` file with valid values. Here’s what each variable does:

- `DATABASE_URL` – PostgreSQL connection string (e.g. `postgres://user:password@localhost:5432/gameland`)
- `POSTGRES_PASSWORD`, `POSTGRES_DB` – Used to initialize the PostgreSQL container
- `GMAIL_USER`, `GMAIL_APP_PASSWORD` – Used by Nodemailer to send contact form emails. It's optional if you don't use the contact form.
- `NEXTAUTH_SECRET` – Cryptographic key for session tokens (generate with `openssl rand -base64 32`)
- `NEXTAUTH_URL` – Base URL of your app (e.g. `http://localhost:3000` for local dev)

Use the `.env.example` file as a template and **never commit** your actual `.env` to version control.

### ⚡ Quick Setup with Docker

For a quick local setup using [Docker/docker-compose](https://www.docker.com/), run the following. The app will be available at [http://localhost:3000](http://localhost:3000).

```bash
docker compose up -d
```

### 💻 Full Dev Experience (Hot Reload)

For a full development workflow:

1. Install [Node.js](https://nodejs.org/)
2. Install dependencies
3. Run the development server

Changes will reflect instantly in your browser.

```bash
npm install
npm run dev
```
