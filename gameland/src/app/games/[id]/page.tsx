"use client";

import { useEffect, useState } from "react";
import Image from "next/image";
import { useParams } from "next/navigation";
import { useSession } from "next-auth/react";

type Game = {
  id: string;
  name: string;
  tagLine: string;
  description: string;
  imageSrc: string;
  age: string;
  players: string;
  quantity: number;
  category: string;
};

type Borrow = {
  id: number;
  gameId: number;
  userId: number;
  deadline: string;
};

const categoryMap: Record<string, { label: string; icon: string }> = {
  board: { label: "Board game", icon: "🎲" },
  card: { label: "Card game", icon: "🃏" },
  puzzle: { label: "Puzzle", icon: "🧩" },
  figurine: { label: "Figurine", icon: "🧙" },
  sport: { label: "Sport", icon: "⚽" },
  video: { label: "Video game", icon: "🎮" },
  build: { label: "Building game", icon: "🏗️" },
};

export default function GameDetailsPage() {
  const { id } = useParams();
  const { data: session, status } = useSession();
  const [game, setGame] = useState<Game | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [borrowStatus, setBorrowStatus] = useState<string | null>(null);
  const [borrowLoading, setBorrowLoading] = useState(false);
  const [hasBorrowed, setHasBorrowed] = useState(false);

  useEffect(() => {
    if (!id) return;

    const fetchGame = async () => {
      try {
        const res = await fetch(`/api/games/${id}`);
        if (!res.ok) {
          throw new Error("Failed to fetch game");
        }
        const data = await res.json();
        setGame(data);
      } catch {
        setError("Could not load game details.");
      } finally {
        setLoading(false);
      }
    };

    fetchGame();
  }, [id]);

  useEffect(() => {
    if (!session || !id) return;

    const fetchUserBorrows = async () => {
      try {
        const res = await fetch("/api/borrows/current");
        const data: Borrow[] = await res.json();
        const borrowed = data.some(
          (b) => b.gameId === parseInt(id as string, 10)
        );
        setHasBorrowed(borrowed);
      } catch (err) {
        console.error("Failed to check current borrows", err);
      }
    };

    fetchUserBorrows();
  }, [session, id]);

  if (loading) {
    return <p className="text-center py-20 text-lg">Loading...</p>;
  }

  if (error || !game) {
    return (
      <p className="text-center py-20 text-red-500 text-lg">
        {error ?? "Game not found."}
      </p>
    );
  }

  const isOutOfStock = game.quantity === 0;
  const categoryInfo = categoryMap[game.category] ?? {
    label: game.category,
    icon: "🎯",
  };

  const handleBorrow = async () => {
    setBorrowStatus(null);
    setBorrowLoading(true);
    try {
      const res = await fetch("/api/borrow", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ gameId: parseInt(id as string, 10) }),
      });

      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Borrow failed");

      setBorrowStatus("success");
      setGame((prev) => prev && { ...prev, quantity: prev.quantity - 1 });
      setHasBorrowed(true);
    } catch {
      setBorrowStatus("error");
    } finally {
      setBorrowLoading(false);
    }
  };

  const canBorrow = !isOutOfStock && !hasBorrowed;

  return (
    <div className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] px-6 py-10 flex justify-center">
      <div className="max-w-7xl w-full bg-[var(--color-surface)] shadow-xl rounded-2xl p-8 flex flex-col md:flex-row gap-10">
        {/* Game cover */}
        <div className="w-full md:w-1/2 flex justify-center items-start">
          <div className="relative w-[500px] h-[500px]">
            <Image
              src={`/games/${game.imageSrc}`}
              alt={game.name}
              fill
              className="rounded-2xl shadow-lg object-cover"
            />
          </div>
        </div>

        {/* Game info */}
        <div className="w-full md:w-1/2 space-y-8">
          <h1 className="text-5xl font-bold text-[var(--color-primary)]">
            {game.name}
          </h1>
          <p className="text-2xl italic text-[var(--color-text-muted)]">
            {game.tagLine}
          </p>

          <div>
            <h2 className="text-2xl font-semibold mb-2">Description</h2>
            <p className="text-lg leading-relaxed">{game.description}</p>
          </div>

          <div className="grid grid-cols-2 gap-6 text-lg">
            <div>
              <span className="font-semibold text-[var(--color-text-muted)]">
                {categoryInfo.icon} Category:
              </span>
              <p className="capitalize">{categoryInfo.label}</p>
            </div>
            <div>
              <span className="font-semibold text-[var(--color-text-muted)]">
                🎂 Age:
              </span>
              <p>{game.age.toLowerCase() === "any" ? "Any" : game.age}</p>
            </div>
            <div>
              <span className="font-semibold text-[var(--color-text-muted)]">
                👥 Players:
              </span>
              <p>{game.players}</p>
            </div>
            <div>
              <span className="font-semibold text-[var(--color-text-muted)]">
                📦 Available:
              </span>
              <p>{game.quantity} left</p>
              {game.quantity === 1 && (
                <p className="text-red-500 font-semibold animate-pulse">
                  ⚠️ Only one left!
                </p>
              )}
            </div>
          </div>

          <div className="pt-6">
            {status === "loading" ? (
              <p>Checking authentication...</p>
            ) : session ? (
              <div>
                <button
                  onClick={handleBorrow}
                  className={`w-full md:w-auto px-8 py-4 text-lg rounded-xl font-semibold transition-colors duration-300
        ${
          canBorrow
            ? "bg-blue-600 text-white rounded hover:bg-blue-700"
            : "bg-gray-400 cursor-not-allowed text-white"
        }`}
                  disabled={!canBorrow || borrowLoading}
                >
                  {isOutOfStock
                    ? "Out of stock"
                    : hasBorrowed
                    ? "Already borrowed"
                    : "Borrow now"}
                </button>

                {borrowStatus === "success" && (
                  <p className="text-green-500 pt-2 font-semibold">
                    🎉 Borrow confirmed! Check your profile.
                  </p>
                )}
                {borrowStatus === "error" && (
                  <p className="text-red-500 pt-2 font-semibold">
                    ❌ Failed to borrow game. Please try again.
                  </p>
                )}
              </div>
            ) : (
              <p className="text-center text-red-500 font-semibold">
                You have to be signed in to be able to borrow this game.
              </p>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
