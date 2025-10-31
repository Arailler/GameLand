import Image from "next/image";
import Link from "next/link";

export default function NotFound() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen p bg-zinc-50 dark:bg-zinc-900 text-zinc-900 dark:text-zinc-100">
      <h1 className="text-5xl font-extrabold mb-6">404 - Page Not Found</h1>
      <p className="text-lg mb-20 text-center max-w-md">
        Uh-oh... This page took a wrong turn at Albuquerque.
      </p>

      <div className="relative w-full max-w-3xl aspect-video mb-20 rounded-lg overflow-hidden shadow-lg">
        <Image
          src="https://media.giphy.com/media/3o7aCTPPm4OHfRLSH6/giphy.gif"
          alt="Funny lost reaction meme"
          unoptimized
          fill
          className="object-contain"
          sizes="(max-width: 768px) 100vw, 768px"
          priority
        />
      </div>

      <Link
        href="/"
        className="px-6 py-3 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700 transition"
      >
        Go back home
      </Link>
    </main>
  );
}
