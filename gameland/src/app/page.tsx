import Image from "next/image";
import Link from "next/link";

const gamesPhotos = [
  {
    src: "https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=800&q=60",
    alt: "Arcade scene",
  },
  {
    src: "https://images.unsplash.com/photo-1632501641765-e568d28b0015?q=60&w=2574&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Close up of cards, dices and pawns",
  },
  {
    src: "https://images.unsplash.com/photo-1571156425562-12341e7c9aae?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Letter tiles everywhere",
  },
  {
    src: "https://images.unsplash.com/photo-1572537577590-ac6a88150100?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Video game controllers everywhere",
  },
  {
    src: "https://images.unsplash.com/photo-1612385763901-68857dd4c43c?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Puzzle pieces everywhere",
  },
  {
    src: "https://images.unsplash.com/photo-1695480542225-bc22cac128d0?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Chess board",
  },
  {
    src: "https://images.unsplash.com/photo-1646504632442-6cacb1858bd6?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Sport balls",
  },
  {
    src: "https://images.unsplash.com/photo-1585504198199-20277593b94f?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Board game",
  },
];

const peoplePhotos = [
  {
    src: "https://images.unsplash.com/photo-1630609674924-1b381d09d313?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Friends playing in an arcade scene",
  },
  {
    src: "https://images.unsplash.com/photo-1592486270660-3fdcfd944c03?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Friends playing cards",
  },
  {
    src: "https://images.unsplash.com/photo-1535223289827-42f1e9919769?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Man playing with a VR headset",
  },
  {
    src: "https://images.unsplash.com/photo-1611725088431-2528430c585e?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "People playing chess",
  },
  {
    src: "https://images.unsplash.com/photo-1563208964-a455770abf67?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Friends having video game fun together",
  },
  {
    src: "https://images.unsplash.com/photo-1733648213151-54ff57977151?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    alt: "Friends having sports fun together",
  },
];

export default function Home() {
  return (
    <main className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] py-10 flex flex-col justify-center items-center text-center">
      {/* Games section */}
      <section className="max-w-7xl my-20">
        <h1 className="text-5xl sm:text-6xl mb-4 text-[var(--color-primary)]">
          Welcome to GameLand! 🎮
        </h1>
        <p className="text-2xl sm:text-2xl text-[var(--color-muted)] mb-10">
          Dive into the ultimate board, card, puzzle, and video game library
          🧩♟️🎲 — and discover endless fun 😄 for all ages and players!
        </p>

        <div className="flex flex-col sm:flex-row justify-center gap-4">
          <Link
            href="/games"
            className="px-6 py-3 bg-[var(--color-primary)] text-white rounded-lg font-semibold hover:bg-blue-700 transition"
          >
            🔍 Browse games
          </Link>
          <Link
            href="/signup"
            className="px-6 py-3 border border-[var(--color-primary)] rounded-lg font-semibold hover:bg-[var(--color-primary)] hover:text-white transition"
          >
            🚀 Join GameLand
          </Link>
        </div>
      </section>

      {/* Games photo gallery */}
      <section className="w-full px-4 sm:px-6 md:px-12 mb-20">
        <div className="max-w-[1600px] mx-auto grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 auto-rows-[300px] sm:auto-rows-[350px] md:auto-rows-[400px] lg:auto-rows-[450px] gap-4 rounded-lg overflow-hidden shadow-lg">
          {gamesPhotos.map(({ src, alt }, idx) => (
            <div
              key={idx}
              className={`relative overflow-hidden rounded-lg ${
                idx === 0 ? "sm:col-span-2 md:col-span-2" : ""
              }`}
            >
              <Image
                src={src}
                alt={alt}
                unoptimized
                fill
                sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 25vw"
                className="object-cover transition-transform duration-300 hover:scale-105"
              />
            </div>
          ))}
        </div>
      </section>

      {/* People section */}
      <section className="max-w-7xl text-center mb-16">
        <h1 className="text-5xl font-semibold mb-10 text-[var(--color-primary)]">
          Join thousands of players having fun every day 🎉
        </h1>
        <p className="text-2xl text-[var(--color-muted)] mb-8">
          Whether you&apos;re a casual gamer or a serious strategist 🧠,
          GameLand brings people together 🤝 through games that entertain,
          challenge, and create lasting memories 💖. Explore new games, meet
          fellow enthusiasts, and level up your game nights 🎲✨.
        </p>

        <Link
          href="/signup"
          className="inline-block px-8 py-4 bg-[var(--color-primary)] text-white rounded-lg font-semibold hover:bg-blue-700 transition"
        >
          🙌 Get started now
        </Link>
      </section>

      {/* People photo gallery */}
      <section className="w-full px-4 sm:px-6 md:px-12 mb-10">
        <div className="max-w-[1600px] mx-auto grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 auto-rows-[300px] sm:auto-rows-[350px] md:auto-rows-[400px] lg:auto-rows-[450px] gap-4 rounded-lg overflow-hidden shadow-lg">
          {peoplePhotos.map(({ src, alt }, idx) => (
            <div
              key={idx}
              className={`relative overflow-hidden rounded-lg ${
                idx === 3 ? "sm:col-span-2 sm:row-span-2 h-full" : "h-full"
              }`}
            >
              <Image
                src={src}
                alt={alt}
                fill
                unoptimized
                sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
                className="object-cover transition-transform duration-300 hover:scale-105"
              />
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}
