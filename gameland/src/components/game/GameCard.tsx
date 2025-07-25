import Image from "next/image";
import Link from "next/link";
import { formatDistanceToNow } from "date-fns";

export type GameCardProps = {
  id: number;
  name: string;
  category: string;
  age: string;
  players: string;
  quantity: number;
  imageSrc: string;
  createdAt: Date;
};

export default function GameCard({
  id,
  name,
  category,
  age,
  players,
  quantity,
  imageSrc,
  createdAt,
}: GameCardProps) {
  const CATEGORY_DISPLAY_MAP: Record<string, { label: string; icon: string }> =
    {
      figurine: { label: "Figurine", icon: "🧙‍♂️" },
      board: { label: "Board game", icon: "🎲" },
      card: { label: "Card game", icon: "🃏" },
      puzzle: { label: "Puzzle", icon: "🧩" },
      build: {
        label: "Building game",
        icon: "🏗️",
      },
      video: { label: "Video game", icon: "🎮" },
      sport: { label: "Sport", icon: "⚽" },
    };

  const categoryInfo = CATEGORY_DISPLAY_MAP[category] || {
    label: category,
    icon: "🎯",
    accentColor: "text-gray-400",
  };

  return (
    <Link href={`/games/${id}`}>
      <div className="relative bg-[var(--color-surface)] hover:bg-[var(--color-primary)] hover:bg-opacity-10 hover:shadow-lg transition-colors duration-200 rounded-2xl shadow-md p-4 flex flex-col md:flex-row gap-4 cursor-pointer">
        <Image
          src={`/games/${imageSrc}`}
          alt={name}
          width={160}
          height={160}
          className="w-full md:w-40 h-40 object-cover rounded-xl"
        />

        <div className="flex flex-col justify-between flex-1">
          <div>
            <div className="relative">
              <h2 className="text-xl font-bold text-[var(--color-text)]">
                <span className="mr-2">{categoryInfo.icon}</span>
                {name}
              </h2>
            </div>

            <div className="mt-3 text-sm space-y-1 text-[var(--color-text)]">
              <p>🎂 Age: {age.toLowerCase() === "any" ? "Any" : age}</p>
              <p>👥 Players: {players}</p>
              <p>📦 Available: {quantity}</p>
            </div>
          </div>

          <p className="text-sm text-gray-500 dark:text-gray-300 mt-4">
            🕒 Added {formatDistanceToNow(createdAt)} ago
          </p>
        </div>
      </div>
    </Link>
  );
}
