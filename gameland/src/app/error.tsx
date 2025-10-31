"use client";

import Image from "next/image";
import Link from "next/link";

export default function ServerError() {
  return (
    <main className="flex flex-col items-center justify-center min-h-screen p-4 bg-zinc-50 dark:bg-zinc-900 text-zinc-900 dark:text-zinc-100">
      <h1 className="text-5xl font-extrabold mb-6">
        500 - Something went wrong
      </h1>
      <p className="text-lg mb-8 text-center max-w-md">
        Oops! Our server took a coffee break ☕️. Please try again later.
      </p>
      <div className="w-full max-w-3xl h-1/2 min-h-[300px] relative mb-8">
        <Image
          src="https://media.giphy.com/media/3o6ZsV7wEpihIs2Xwc/giphy.gif"
          alt="Funny server error meme"
          unoptimized
          fill
          className="object-contain rounded-lg shadow-lg"
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
