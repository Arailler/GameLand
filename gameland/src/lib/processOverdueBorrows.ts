import { prisma, getAllOverdueBorrows } from "@/lib/db";

export async function processOverdueBorrows() {
  const overdueBorrows = await getAllOverdueBorrows();

  for (const borrow of overdueBorrows) {
    await prisma.$transaction([
      prisma.borrow.update({
        where: { id: borrow.id },
        data: { returned: true },
      }),
      prisma.game.update({
        where: { id: borrow.gameId },
        data: { quantity: { increment: 1 } },
      }),
    ]);
  }
}
