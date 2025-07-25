import { User, Game, Borrow, PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

export const prisma = new PrismaClient();

export type CreateUserParams = {
  email: string;
  password: string;
  birthDate: string | Date;
  firstName: string;
  lastName: string;
  country: string;
  postalCode: string;
  street: string;
  number: string;
  phone: string;
};

export type UpdateUserParams = Partial<CreateUserParams>;

export async function createUser(data: CreateUserParams): Promise<User> {
  const user = await prisma.user.create({
    data: {
      email: data.email,
      password: await bcrypt.hash(data.password, 10),
      birthDate: new Date(data.birthDate),
      firstName: data.firstName,
      lastName: data.lastName,
      country: data.country,
      postalCode: data.postalCode,
      street: data.street,
      number: data.number,
      phone: data.phone,
    },
  });

  return user;
}

export async function updateUser(
  userId: number,
  data: UpdateUserParams
): Promise<User> {
  const updateData = { ...data };

  if (updateData.birthDate) {
    updateData.birthDate = new Date(updateData.birthDate);
  }

  if (updateData.password && updateData.password.trim() !== "") {
    const salt = await bcrypt.genSalt(10);
    updateData.password = await bcrypt.hash(updateData.password, salt);
  }

  // Remove undefined fields to avoid overwriting with null
  for (const key of Object.keys(updateData) as (keyof UpdateUserParams)[]) {
    if (updateData[key] === undefined) {
      delete updateData[key];
    }
  }

  return await prisma.user.update({
    where: { id: userId },
    data: updateData,
  });
}

export async function getUserByEmail(email: string): Promise<User | null> {
  return await prisma.user.findUnique({
    where: { email },
  });
}

export async function getAllGames(): Promise<Game[]> {
  return await prisma.game.findMany({
    orderBy: {
      id: "asc",
    },
  });
}

export async function getGameByID(id: number): Promise<Game | null> {
  return await prisma.game.findUnique({
    where: { id },
  });
}

export async function decrementGameQuantity(gameId: number) {
  return await prisma.game.update({
    where: { id: gameId },
    data: {
      quantity: {
        decrement: 1,
      },
    },
  });
}

export async function createBorrow(
  userId: number,
  gameId: number
): Promise<Borrow> {
  const game = await prisma.game.findUnique({ where: { id: gameId } });

  if (!game) throw new Error("Game not found");
  if (game.quantity <= 0) throw new Error("Game out of stock");

  const borrow = await prisma.borrow.create({
    data: {
      userId,
      gameId,
      deadline: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
    },
  });

  await decrementGameQuantity(gameId);

  return borrow;
}

export async function getAllCurrentBorrows(
  userId: number
): Promise<(Borrow & { game: Game; user: User })[]> {
  return await prisma.borrow.findMany({
    where: {
      userId: userId,
      returned: false,
    },
    include: {
      user: true,
      game: true,
    },
  });
}

export async function getAllPastBorrows(
  userId: number
): Promise<(Borrow & { game: Game; user: User })[]> {
  return await prisma.borrow.findMany({
    where: {
      userId: userId,
      returned: true,
    },
    include: {
      user: true,
      game: true,
    },
  });
}

export async function getAllOverdueBorrows(): Promise<Borrow[]> {
  const now = new Date();

  return await prisma.borrow.findMany({
    where: {
      returned: false,
      deadline: { lt: now },
    },
  });
}
