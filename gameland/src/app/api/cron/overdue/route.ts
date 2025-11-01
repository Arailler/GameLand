import { NextResponse } from "next/server";
import { processOverdueBorrows } from "@/lib/processOverdueBorrows";

export async function GET() {
  await processOverdueBorrows();
  return NextResponse.json({ message: "Overdue borrows processed." });
}
