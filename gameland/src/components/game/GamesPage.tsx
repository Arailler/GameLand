"use client";

import { useState, useTransition } from "react";
import GameCard from "@/components/game/GameCard";
import { useRouter, useSearchParams } from "next/navigation";

type Game = {
  id: number;
  name: string;
  category: string;
  age: string;
  players: string;
  createdAt: Date;
  imageSrc: string;
  quantity: number;
};

type Filters = Partial<{
  category: string;
  age: string;
  players: string;
  name: string;
}>;

export default function GamesPage({
  games,
  total,
  currentPage,
  pageSize,
  filters,
}: {
  games: Game[];
  total: number;
  currentPage: number;
  pageSize: number;
  filters: Filters;
}) {
  const [filterOpen, setFilterOpen] = useState(false);
  const [isPending, startTransition] = useTransition();
  const router = useRouter();
  const totalPages = Math.ceil(total / pageSize);
  const searchParams = useSearchParams();

  const [localFilters, setLocalFilters] = useState<Filters>({
    category: filters.category || "all",
    age: filters.age || "all",
    players: filters.players || "all",
    name: filters.name || "",
  });

  const handleFilterChange = (name: keyof Filters, value: string) => {
    setLocalFilters((prev) => ({ ...prev, [name]: value }));

    const params = new URLSearchParams(searchParams.toString());
    if (value === "" || value === "all") {
      params.delete(name);
    } else {
      params.set(name, value);
    }
    params.set("page", "1");
    startTransition(() => {
      router.push(`?${params.toString()}`);
    });
  };

  const resetFilters = () => {
    const resetValues = {
      category: "all",
      age: "all",
      players: "all",
      name: "",
    };
    setLocalFilters(resetValues);

    const params = new URLSearchParams(searchParams.toString());
    ["category", "age", "players", "name"].forEach((key) => params.delete(key));
    params.set("page", "1");

    startTransition(() => {
      router.push(`?${params.toString()}`);
    });
  };

  const goToPage = (page: number) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("page", page.toString());
    startTransition(() => {
      router.push(`?${params.toString()}`);
    });
  };

  return (
    <div className="flex flex-col lg:flex-row gap-4 p-4 bg-[var(--color-background)] text-[var(--color-text)] min-h-screen">
      {/* Desktop filters */}
      <aside className="hidden lg:block w-64 shrink-0 bg-[var(--color-surface)] p-4 rounded-xl shadow sticky top-4 h-fit">
        <h2 className="text-lg font-semibold mb-4 text-[var(--color-primary)]">
          Filters
        </h2>
        <div className="space-y-4">
          {/* Name filter */}
          <div>
            <label className="block text-sm font-medium mb-1">Name</label>
            <input
              type="text"
              className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
              placeholder="Search by name"
              value={localFilters.name}
              onChange={(e) => handleFilterChange("name", e.target.value)}
            />
          </div>

          {/* Category */}
          <div>
            <label className="block text-sm font-medium mb-1">Category</label>
            <select
              className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
              value={localFilters.category}
              onChange={(e) => handleFilterChange("category", e.target.value)}
            >
              <option value="all">All</option>
              <option value="figurine">Figurine</option>
              <option value="board">Board game</option>
              <option value="card">Card game</option>
              <option value="puzzle">Puzzle</option>
              <option value="build">Building game</option>
              <option value="video">Video game</option>
              <option value="sport">Sport</option>
            </select>
          </div>

          {/* Age */}
          <div>
            <label className="block text-sm font-medium mb-1">Age</label>
            <select
              className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
              value={localFilters.age}
              onChange={(e) => handleFilterChange("age", e.target.value)}
            >
              <option value="all">All</option>
              <option value="0-3">0-3</option>
              <option value="3-6">3-6</option>
              <option value="6-12">6-12</option>
              <option value="12-18">12-18</option>
              <option value="18+">18+</option>
            </select>
          </div>

          {/* Players */}
          <div>
            <label className="block text-sm font-medium mb-1">Players</label>
            <select
              className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
              value={localFilters.players}
              onChange={(e) => handleFilterChange("players", e.target.value)}
            >
              <option value="all">All</option>
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5+">5+</option>
            </select>
          </div>

          {/* Reset */}
          <button
            onClick={resetFilters}
            className="w-full mt-2 text-sm px-3 py-2 text-white bg-[var(--color-primary)] rounded hover:bg-blue-700 transition"
          >
            Reset filters
          </button>
        </div>
      </aside>

      {/* Main Content */}
      <div className="flex-1">
        {/* Mobile filters */}
        <div className="lg:hidden mb-4">
          <button
            className="bg-[var(--color-primary)] text-white px-4 py-2 rounded shadow"
            onClick={() => setFilterOpen(!filterOpen)}
          >
            {filterOpen ? "Hide filters" : "Show filters"}
          </button>
          {filterOpen && (
            <div className="mt-4 bg-[var(--color-surface)] p-4 rounded-xl shadow">
              <div className="space-y-4">
                {/* Mobile filters replicate desktop controls */}
                <div>
                  <label className="block text-sm font-medium mb-1">Name</label>
                  <input
                    type="text"
                    className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
                    placeholder="Search by name"
                    value={localFilters.name}
                    onChange={(e) => handleFilterChange("name", e.target.value)}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium mb-1">
                    Category
                  </label>
                  <select
                    className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
                    value={localFilters.category}
                    onChange={(e) =>
                      handleFilterChange("category", e.target.value)
                    }
                  >
                    <option value="all">All</option>
                    <option value="figurine">Figurine</option>
                    <option value="board">Board game</option>
                    <option value="card">Card game</option>
                    <option value="puzzle">Puzzle</option>
                    <option value="build">Building game</option>
                    <option value="video">Video game</option>
                    <option value="sport">Sport</option>
                  </select>
                </div>

                <div>
                  <label className="block text-sm font-medium mb-1">Age</label>
                  <select
                    className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
                    value={localFilters.age}
                    onChange={(e) => handleFilterChange("age", e.target.value)}
                  >
                    <option value="all">All</option>
                    <option value="0-3">0-3</option>
                    <option value="3-6">3-6</option>
                    <option value="6-12">6-12</option>
                    <option value="12-18">12-18</option>
                    <option value="18+">18+</option>
                  </select>
                </div>

                <div>
                  <label className="block text-sm font-medium mb-1">
                    Players
                  </label>
                  <select
                    className="w-full p-2 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
                    value={localFilters.players}
                    onChange={(e) =>
                      handleFilterChange("players", e.target.value)
                    }
                  >
                    <option value="all">All</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5+">5+</option>
                  </select>
                </div>

                <button
                  onClick={resetFilters}
                  className="w-full mt-2 text-sm px-3 py-2 text-white bg-[var(--color-primary)] rounded hover:bg-blue-700 transition"
                >
                  Reset filters
                </button>
              </div>
            </div>
          )}
        </div>

        {isPending && (
          <div className="text-center py-4 text-[var(--color-primary)]">
            Loading...
          </div>
        )}

        {/* Game cards */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-4 gap-6">
          {games.map((game) => (
            <GameCard key={game.id} {...game} />
          ))}
        </div>

        {/* Pagination */}
        <div className="mt-6 flex flex-col sm:flex-row justify-between items-center gap-4">
          <div className="flex items-center gap-4">
            <span className="text-sm">
              Showing {(currentPage - 1) * pageSize + 1}–
              {Math.min(currentPage * pageSize, total)} of {total} games
            </span>

            {/* Page size selector */}
            <label className="text-sm flex items-center gap-2">
              per page:
              <select
                className="p-1 rounded border border-[var(--color-border)] bg-[var(--color-surface)]"
                value={pageSize}
                onChange={(e) => {
                  const newSize = parseInt(e.target.value);
                  const params = new URLSearchParams(searchParams.toString());
                  params.set("pageSize", newSize.toString());
                  params.set("page", "1");
                  startTransition(() => {
                    router.push(`?${params.toString()}`);
                  });
                }}
              >
                {[20, 50, 100].map((size) => (
                  <option key={size} value={size}>
                    {size}
                  </option>
                ))}
              </select>
            </label>
          </div>

          <div className="flex items-center gap-2">
            <button
              className={`px-4 py-2 rounded-xl border font-semibold transition-colors cursor-pointer
      ${
        currentPage <= 1
          ? "bg-gray-400 border-gray-400 text-white cursor-not-allowed opacity-50"
          : "bg-[var(--color-primary)] border-[var(--color-primary)] text-white hover:bg-[var(--color-primary-hover)]"
      }
    `}
              disabled={currentPage <= 1}
              onClick={() => goToPage(currentPage - 1)}
            >
              Previous
            </button>

            {[...Array(totalPages)].map((_, i) => {
              const page = i + 1;
              const isActive = currentPage === page;
              return (
                <button
                  key={page}
                  onClick={() => goToPage(page)}
                  className={`px-4 py-2 rounded-xl border font-semibold transition-colors cursor-pointer
          ${
            isActive
              ? "bg-[var(--color-primary)] border-[var(--color-primary)] text-white"
              : "bg-[var(--color-surface)] border-[var(--color-border)] text-[var(--color-text)] hover:bg-[var(--color-primary)] hover:text-white"
          }
        `}
                >
                  {page}
                </button>
              );
            })}

            <button
              className={`px-4 py-2 rounded-xl border font-semibold transition-colors cursor-pointer
      ${
        currentPage >= totalPages
          ? "bg-gray-400 border-gray-400 text-white cursor-not-allowed opacity-50"
          : "bg-[var(--color-primary)] border-[var(--color-primary)] text-white hover:bg-[var(--color-primary-hover)]"
      }
    `}
              disabled={currentPage >= totalPages}
              onClick={() => goToPage(currentPage + 1)}
            >
              Next
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
