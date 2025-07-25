import Image from "next/image";
import Link from "next/link";

export default function About() {
  return (
    <main className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] px-4 py-12 flex flex-col items-center">
      <section className="max-w-3xl w-full text-center mb-20">
        <h1 className="text-4xl font-heading text-[var(--color-primary)] mb-4">
          About GameLand 🎮
        </h1>
        <p className="text-2xl">
          We&apos;re on a mission to make games accessible, social, and
          sustainable for everyone. Welcome to a world where fun is shared, not
          sold.
        </p>
      </section>

      <section className="max-w-4xl w-full grid gap-8 mb-20">
        <div>
          <h2 className="text-2xl text-[var(--color-primary)] mb-2">
            Our mission
          </h2>
          <p>
            GameLand is a community-powered game library where people can
            borrow, enjoy, and return games of all types — from board and card
            games to puzzles and video games. We believe fun shouldn&apos;t have
            a paywall and that games bring people together.
          </p>
        </div>

        <div>
          <h2 className="text-2xl text-[var(--color-primary)] mb-2">
            Our vision
          </h2>
          <p>
            We envision neighborhoods with shared game collections, accessible
            to all ages and backgrounds. Whether you&apos;re a seasoned
            strategist or a casual puzzle fan, GameLand welcomes you.
          </p>
        </div>

        <div>
          <h2 className="text-2xl text-[var(--color-primary)] mb-2">
            Our values
          </h2>
          <ul className="list-disc list-inside space-y-1">
            <li>
              <strong>Community first:</strong> We grow by helping each other.
            </li>
            <li>
              <strong>Trust & respect:</strong> Borrowed items are everyone’s to
              care for.
            </li>
            <li>
              <strong>Accessibility:</strong> Everyone deserves playtime — no
              matter their budget.
            </li>
            <li>
              <strong>Joy:</strong> Fun is serious business around here.
            </li>
          </ul>
        </div>
      </section>

      <section className="max-w-6xl w-full mb-20">
        <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-6 text-center">
          Meet the team 🧌🧝‍♀️🧙‍♂️👹
        </h2>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-8">
          {[
            {
              name: "Krampus",
              role: "Founder & Chief game officer",
              image:
                "https://images.unsplash.com/photo-1575844261401-d69721eb5044?q=60&w=640",
              bio: "A misunderstood visionary who believes everyone deserves a second chance — and a good game night. Krampus started GameLand to promote joy, discipline, and shared responsibility.",
            },
            {
              name: "Gronk the orc",
              role: "Logistics & Brrowing manager",
              image:
                "https://cdn.pixabay.com/photo/2020/05/09/16/47/troll-5150380_1280.jpg",
              bio: "Once a mighty warrior, now a mighty organizer. Gronk ensures every game is tracked, cared for, and returned safely — or else.",
            },
            {
              name: "Elira the elf",
              role: "User experience enchanter",
              image:
                "https://images.unsplash.com/photo-1702700591520-43f7803b5def?q=60&w=640",
              bio: "Elegant, intuitive, and fast — just like her UX designs. Elira crafts every user interaction with magic and precision.",
            },
            {
              name: "Nimble the gnome",
              role: "Community happiness engineer",
              image:
                "https://images.unsplash.com/photo-1681969468623-973da4c87ed5?q=60&w=640",
              bio: "A cheerful fixer of problems and builder of bridges. Nimble handles support, events, and all things fun with boundless energy.",
            },
          ].map(({ name, role, image, bio }) => (
            <div
              key={name}
              className="bg-[var(--color-surface)] rounded-xl p-6 shadow-md flex gap-4 items-start"
            >
              <div className="flex-shrink-0">
                <Image
                  src={image}
                  alt={name}
                  unoptimized
                  width={150}
                  height={150}
                  className="rounded-full border-2 border-[var(--color-border)] object-cover"
                />
              </div>
              <div>
                <h3 className="text-xl font-bold text-[var(--color-primary)]">
                  {name}
                </h3>
                <p className="text-md text-[var(--color-muted)] mb-2">{role}</p>
                <p className="text-md">{bio}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="text-center">
        <p className="text-xl">
          Want to become a part of GameLand?{" "}
          <Link
            href="/signup"
            className="text-[var(--color-primary)] font-semibold hover:underline"
          >
            Join us today!
          </Link>
        </p>
      </section>
    </main>
  );
}
