import { NextRequest, NextResponse } from "next/server";
import { getGameByID } from "@/lib/db";

export async function GET(req: NextRequest) {
  const url = new URL(req.url);
  const segments = url.pathname.split("/");
  const id = segments[segments.length - 1];

  try {
    const game = await getGameByID(parseInt(id, 10));

    if (!game) {
      return NextResponse.json({ message: "Game not found" }, { status: 404 });
    }

    return NextResponse.json(game);
  } catch (error) {
    console.error("Error fetching game:", error);
    return NextResponse.json(
      { message: "Internal server error" },
      { status: 500 }
    );
  }
}
