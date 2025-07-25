import type { NextApiRequest, NextApiResponse } from "next";
import { processOverdueBorrows } from "@/lib/processOverdueBorrows";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  await processOverdueBorrows();
  res.status(200).json({ message: "Overdue borrows processed." });
}
