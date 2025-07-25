"use client";

import { useState, useEffect } from "react";
import ThemeToggle from "@/components/global/ThemeToggle";
import Link from "next/link";
import Image from "next/image";
import { useRouter } from "next/navigation";
import { useSession, signOut } from "next-auth/react";
import { Menu, X } from "lucide-react";
import md5 from "blueimp-md5";

const DiceIcon = () => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="32"
    height="32"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
    className="text-[var(--color-primary)]"
  >
    <rect x="3" y="3" width="18" height="18" rx="2" ry="2" />
    <circle cx="8.5" cy="8.5" r="1.5" />
    <circle cx="15.5" cy="8.5" r="1.5" />
    <circle cx="8.5" cy="15.5" r="1.5" />
    <circle cx="15.5" cy="15.5" r="1.5" />
  </svg>
);

export default function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false);
  const [, setDarkMode] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const { data: session, status } = useSession();
  const router = useRouter();

  useEffect(() => {
    const stored = localStorage.getItem("theme");
    const prefersDark = window.matchMedia(
      "(prefers-color-scheme: dark)"
    ).matches;
    const enabled = stored === "dark" || (!stored && prefersDark);
    setDarkMode(enabled);
    document.documentElement.classList.toggle("dark", enabled);
  }, []);

  const handleSearch = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (searchTerm.trim()) {
      router.push(`/games?name=${encodeURIComponent(searchTerm.trim())}`);
      setMobileOpen(false);
    }
  };

  const gravatarUrl =
    session?.user?.email &&
    `https://www.gravatar.com/avatar/${md5(
      session.user.email.trim().toLowerCase()
    )}?d=identicon`;

  return (
    <header className="bg-[var(--color-surface)] text-[var(--color-text)] shadow-md sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Left: logo & nav */}
          <div className="flex items-center space-x-4">
            <Link href="/" className="flex items-center space-x-2">
              <DiceIcon />
              <span
                className="font-bold text-3xl text-[var(--color-primary)]"
                style={{ fontFamily: "var(--font-heading)" }}
              >
                GameLand
              </span>
            </Link>
            <nav className="hidden md:flex space-x-4 ml-6">
              <Link href="/" className="hover:text-[var(--color-primary)]">
                Home
              </Link>
              <Link href="/games" className="hover:text-[var(--color-primary)]">
                Games
              </Link>
              <Link href="/about" className="hover:text-[var(--color-primary)]">
                About
              </Link>
            </nav>
          </div>

          {/* Center: search */}
          <form onSubmit={handleSearch} className="hidden lg:block flex-1 mx-8">
            <input
              type="text"
              placeholder="Search games..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full px-4 py-2 rounded-full border border-[var(--color-border)] bg-[var(--color-surface)] text-[var(--color-text)] placeholder:text-[var(--color-muted)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)]"
            />
          </form>

          {/* Right: theme + auth + mobile toggle */}
          <div className="flex items-center space-x-3">
            <ThemeToggle />

            {status === "loading" ? null : session?.user ? (
              <>
                {gravatarUrl && (
                  <Link
                    href="/profile"
                    className="hidden md:flex items-center space-x-2 hover:opacity-80 transition-opacity"
                  >
                    <Image
                      src={gravatarUrl}
                      alt="Profile"
                      unoptimized
                      width={40}
                      height={40}
                      className="rounded-full border border-[var(--color-border)]"
                    />
                    <span className="text-sm text-[var(--color-text)] truncate max-w-[140px]">
                      {session.user.email}
                    </span>
                  </Link>
                )}

                <button
                  onClick={() => signOut()}
                  className="hidden md:inline px-4 py-2 text-sm font-medium text-red-600 border border-red-600 rounded hover:bg-red-100"
                >
                  Sign out
                </button>
              </>
            ) : (
              <>
                <Link
                  href="/signin"
                  className="hidden md:inline px-4 py-2 text-sm font-medium text-blue-600 border border-blue-600 rounded hover:bg-blue-100"
                >
                  Sign in
                </Link>
                <Link
                  href="/signup"
                  className="hidden md:inline px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded hover:bg-blue-700"
                >
                  Sign up
                </Link>
              </>
            )}

            {/* Mobile toggle */}
            <button
              className="md:hidden p-2 rounded hover:bg-[var(--color-muted)]"
              onClick={() => setMobileOpen(!mobileOpen)}
              aria-label="Toggle mobile menu"
            >
              {mobileOpen ? (
                <X className="h-6 w-6" />
              ) : (
                <Menu className="h-6 w-6" />
              )}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {mobileOpen && (
        <div className="md:hidden px-4 pb-4 space-y-2 bg-[var(--color-surface)]">
          <Link href="/" className="block hover:text-[var(--color-primary)]">
            Home
          </Link>
          <Link
            href="/games"
            className="block hover:text-[var(--color-primary)]"
          >
            Games
          </Link>
          <Link
            href="/about"
            className="block hover:text-[var(--color-primary)]"
          >
            About
          </Link>

          <form onSubmit={handleSearch} className="mt-2">
            <input
              type="text"
              placeholder="Search games..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full px-4 py-2 rounded-full border border-[var(--color-border)] bg-[var(--color-muted)] text-sm text-[var(--color-text)]"
            />
          </form>

          {session?.user ? (
            <>
              <Link
                href="/profile"
                className="block text-center py-2 rounded hover:bg-[var(--color-muted)]"
              >
                Profile
              </Link>
              <button
                onClick={() => {
                  setMobileOpen(false);
                  signOut();
                }}
                className="w-full text-red-600 border border-red-600 py-2 rounded hover:bg-red-100 text-center"
              >
                Sign out
              </button>
            </>
          ) : (
            <div className="flex space-x-2 pt-2">
              <Link
                href="/signin"
                className="w-full text-blue-600 border border-blue-600 py-2 rounded hover:bg-blue-100 text-center"
              >
                Sign In
              </Link>
              <Link
                href="/signup"
                className="w-full text-white bg-blue-600 py-2 rounded hover:bg-blue-700 text-center"
              >
                Sign Up
              </Link>
            </div>
          )}
        </div>
      )}
    </header>
  );
}
