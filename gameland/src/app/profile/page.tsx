import crypto from "crypto";
import Image from "next/image";
import GameCard from "@/components/game/GameCard";
import { getServerSession } from "next-auth/next";
import {
  getUserByEmail,
  getAllCurrentBorrows,
  getAllPastBorrows,
} from "@/lib/db";

export default async function Profile() {
  const session = await getServerSession();

  if (!session?.user?.email) {
    return (
      <p className="text-center text-red-500">
        You must be signed in to view this page.
      </p>
    );
  }

  const user = await getUserByEmail(session.user.email);

  if (!user) {
    return <p className="text-center text-red-500">User not found.</p>;
  }

  const birthDateFormatted = user.birthDate.toLocaleDateString();

  const gravatarHash = crypto
    .createHash("md5")
    .update(user.email.trim().toLowerCase())
    .digest("hex");

  const gravatarUrl = `https://www.gravatar.com/avatar/${gravatarHash}?s=200&d=identicon`;

  const currentBorrows = await getAllCurrentBorrows(user.id);

  const pastBorrows = await getAllPastBorrows(user.id);

  return (
    <div className="max-w-3xl mx-auto mt-10 p-8 bg-[var(--color-surface)] text-[var(--color-text)] rounded-2xl shadow-md">
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 sm:gap-6">
        <div className="flex items-center gap-6">
          <Image
            src={gravatarUrl}
            alt="User Gravatar"
            unoptimized
            width={100}
            height={100}
            className="rounded-full"
          />
          <div>
            <h1 className="text-2xl font-heading">
              {user.firstName} {user.lastName}
            </h1>
            <p className="text-[var(--color-muted)]">{user.email}</p>
          </div>
        </div>
        <a
          href="/profile/edit"
          className="inline-block bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 text-sm"
        >
          Edit profile
        </a>
      </div>

      <hr className="my-8 border-[var(--color-border)]" />

      <section>
        <h2 className="text-xl font-semibold mb-2">Personal information</h2>
        <p>
          <strong>Birth date:</strong> {birthDateFormatted}
        </p>
        <p>
          <strong>Phone:</strong> {user.phone}
        </p>
        <p>
          <strong>Address:</strong>
          <br />
          {user.number} {user.street}, {user.postalCode}, {user.country}
        </p>
      </section>

      <hr className="my-8 border-[var(--color-border)]" />

      <section>
        <h2 className="text-xl font-semibold mb-2">Favorite games</h2>
        <p className="text-[var(--color-muted)]">No favorites yet.</p>
      </section>

      <hr className="my-8 border-[var(--color-border)]" />

      <section>
        <h2 className="text-xl font-semibold mb-2">Currently borrowed games</h2>
        {currentBorrows.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {currentBorrows.map((borrow) => (
              <div key={borrow.id} className="flex flex-col">
                <p className="text-sm text-red-600 font-semibold mt-1">
                  Max due date: {new Date(borrow.deadline).toLocaleDateString()}
                </p>
                <GameCard {...borrow.game} />
              </div>
            ))}
          </div>
        ) : (
          <p className="text-[var(--color-muted)]">
            No games borrowed right now.
          </p>
        )}
      </section>

      <hr className="my-8 border-[var(--color-border)]" />

      <section>
        <h2 className="text-xl font-semibold mb-2">Past borrowed games</h2>
        {pastBorrows.length > 0 ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {pastBorrows.map((borrow) => (
              <GameCard key={borrow.id} {...borrow.game} />
            ))}
          </div>
        ) : (
          <p className="text-[var(--color-muted)]">No history available yet.</p>
        )}
      </section>
    </div>
  );
}
