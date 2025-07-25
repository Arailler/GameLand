import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/authOptions";
import { getAllCurrentBorrows } from "@/lib/db";

export async function GET() {
  const session = await getServerSession(authOptions);

  if (!session?.user?.id) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const userId = Number(session.user.id);

  if (Number.isNaN(userId)) {
    return NextResponse.json({ error: "Invalid user ID" }, { status: 400 });
  }

  try {
    const userBorrows = await getAllCurrentBorrows(userId);

    return NextResponse.json(userBorrows);
  } catch (error) {
    console.error("Failed to fetch current borrows:", error);
    return NextResponse.json(
      { error: "Failed to fetch current borrows" },
      { status: 500 }
    );
  }
}
