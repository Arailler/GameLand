import { NextRequest, NextResponse } from "next/server";
import { processOverdueBorrows } from "@/lib/processOverdueBorrows";

export default async function GET(
  req: NextRequest,
  res: NextResponse
) {
  await processOverdueBorrows();
  return NextResponse.json({ message: "Overdue borrows processed." });
}
