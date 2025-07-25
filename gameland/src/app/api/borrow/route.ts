import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/authOptions";
import { createBorrow } from "@/lib/db";

export async function POST(req: NextRequest) {
  const session = await getServerSession(authOptions);
  if (!session) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { gameId } = await req.json();

  if (!gameId || typeof gameId !== "number") {
    return NextResponse.json({ error: "Invalid game ID" }, { status: 400 });
  }

  try {
    const userId = parseInt(session.user.id as string, 10);
    const borrow = await createBorrow(userId, gameId);
    return NextResponse.json({ message: "Borrow created", borrow });
  } catch (err) {
    console.error("Error creating borrow:", err);
    return NextResponse.json(
      { error: "Failed to create borrow" },
      { status: 500 }
    );
  }
}
