import GamesPage from "@/components/game/GamesPage";
import { getAllGames } from "@/lib/db";

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

type GameSearchParams = Partial<{
  category: string;
  age: string;
  players: string;
  name: string;
  page: string;
  pageSize: string;
}>;

function parseAgeFilter(filter: string) {
  if (!filter || filter === "all") return null;
  if (filter.includes("-")) {
    const [min, max] = filter.split("-").map(Number);
    return { min, max };
  }
  if (filter.includes("+")) {
    const min = Number(filter);
    return { min, max: Infinity };
  }
  return null;
}

function parsePlayersFilter(filter: string) {
  if (!filter || filter === "all") return null;
  if (filter.endsWith("+")) {
    const min = Number(filter.replace("+", ""));
    return { min, max: Infinity };
  }
  if (filter.includes("-")) {
    const [min, max] = filter.split("-").map(Number);
    return { min, max };
  }
  const val = Number(filter);
  return { min: val, max: val };
}

function parsePlayersRange(players: string) {
  if (!players || players.toLowerCase() === "any")
    return { min: 0, max: Infinity };
  if (players.endsWith("+")) {
    const min = Number(players.replace("+", ""));
    return { min, max: Infinity };
  }
  if (players.includes("-")) {
    const [min, max] = players.split("-").map(Number);
    return { min, max };
  }
  const val = Number(players);
  return { min: val, max: val };
}

export default async function Games({
  searchParams,
}: {
  searchParams: Promise<GameSearchParams>;
}) {
  const params = await searchParams;

  const { category, age, players, name, page = "1", pageSize = "20" } = params;

  const ageFilter = parseAgeFilter(age ?? "");
  const playersFilter = parsePlayersFilter(players ?? "");
  const currentPage = Number(page) || 1;
  const take = Number(pageSize) || 20;

  const skip = (currentPage - 1) * take;

  const allGames = await getAllGames();

  const filteredGames = allGames.filter((game: Game) => {
    if (name && !game.name.toLowerCase().startsWith(name.toLowerCase())) {
      return false;
    }

    // Category filter
    if (category && category !== game.category) return false;

    // Age filter
    if (ageFilter && game.age.toLowerCase() !== "any") {
      if (game.age.endsWith("+")) {
        const gameMin = Number(game.age.replace("+", ""));
        if (isNaN(gameMin)) return false;

        const filterContainsGameMin =
          ageFilter.min <= gameMin && ageFilter.max >= gameMin;
        const filterAboveGameMin = ageFilter.min > gameMin;

        if (!filterContainsGameMin && !filterAboveGameMin) return false;
      } else {
        const gameExact = Number(game.age);
        if (isNaN(gameExact)) return false;

        if (gameExact < ageFilter.min || gameExact > ageFilter.max)
          return false;
      }
    }

    // Players filter
    if (playersFilter) {
      const gameRange = parsePlayersRange(game.players);

      if (gameRange.max === Infinity) {
        if (playersFilter.min < gameRange.min) return false;
      } else {
        if (
          playersFilter.max < gameRange.min ||
          playersFilter.min > gameRange.max
        ) {
          return false;
        }
      }
    }

    return true;
  });

  const total = filteredGames.length;
  const paginatedGames = filteredGames.slice(skip, skip + take);

  return (
    <GamesPage
      games={paginatedGames}
      total={total}
      currentPage={currentPage}
      pageSize={take}
      filters={{ category, age, players, name }}
    />
  );
}
