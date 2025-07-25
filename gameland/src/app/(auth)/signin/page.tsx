"use client";

import React, { Suspense, useEffect, useState } from "react";
import { useSearchParams } from "next/navigation";
import { signIn } from "next-auth/react";
import { useRouter } from "next/navigation";
import Link from "next/link";

function SignInInner() {
  const searchParams = useSearchParams();
  const [showSuccess, setShowSuccess] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  useEffect(() => {
    if (searchParams.get("signup") === "success") {
      setShowSuccess(true);
      const timer = setTimeout(() => setShowSuccess(false), 5000);
      return () => clearTimeout(timer);
    }
  }, [searchParams]);

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!emailRegex.test(email.trim())) {
      setError("Please enter a valid email address.");
      return;
    }

    setIsLoading(true);

    const res = await signIn("credentials", {
      redirect: false,
      email,
      password,
    });

    setIsLoading(false);

    if (res?.ok) {
      router.push("/");
    } else {
      setError("Invalid email or password");
    }
  };

  return (
    <div>
      {showSuccess && (
        <div
          className="fixed top-1/5 left-1/2 transform -translate-x-1/2 -translate-y-1/2
               bg-green-600 text-white text-2xl font-bold px-10 py-6 rounded-2xl
               shadow-2xl z-50 flex items-center space-x-4 transition-opacity
               duration-1000 ease-in-out opacity-100 animate-fadeout"
        >
          <svg
            className="w-8 h-8 text-white"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M5 13l4 4L19 7"
            />
          </svg>
          <span>Account created successfully!</span>
        </div>
      )}
      <div className="min-h-screen flex items-center justify-center bg-[var(--color-background)] p-6">
        <div className="max-w-lg w-full bg-[var(--color-surface)] rounded-xl shadow-lg p-12">
          <h1 className="text-4xl font-bold text-[var(--color-primary)] mb-8 text-center">
            Welcome back
          </h1>

          {error && (
            <div className="mb-6 text-red-500 text-center font-medium">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-8">
            <div>
              <label
                htmlFor="email"
                className="block mb-2 font-medium text-[var(--color-text)] text-lg"
              >
                Email
              </label>
              <input
                id="email"
                type="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full p-4 rounded border border-[var(--color-border)] bg-[var(--color-background)] text-[var(--color-text)] text-lg focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)]"
                placeholder="you@example.com"
                autoComplete="email"
              />
            </div>

            <div>
              <label
                htmlFor="password"
                className="block mb-2 font-medium text-[var(--color-text)] text-lg"
              >
                Password
              </label>
              <input
                id="password"
                type="password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full p-4 rounded border border-[var(--color-border)] bg-[var(--color-background)] text-[var(--color-text)] text-lg focus:outline-none focus:ring-2 focus:ring-[var(--color-primary)]"
                placeholder="********"
                autoComplete="current-password"
              />
              <div className="mt-2 text-right">
                <Link
                  href="/forgot-password"
                  className="text-[var(--color-primary)] hover:underline text-sm"
                >
                  Forgot password?
                </Link>
              </div>
            </div>

            <button
              type="submit"
              disabled={isLoading}
              className="w-full bg-[var(--color-primary)] text-white font-semibold py-4 rounded hover:bg-[var(--color-primary-hover)] transition-colors disabled:opacity-60 text-lg"
            >
              {isLoading ? "Signing in..." : "Sign in"}
            </button>
          </form>

          <p className="mt-10 text-center text-base text-[var(--color-text)]">
            Don&apos;t have an account?{" "}
            <Link
              href="/signup"
              className="text-[var(--color-primary)] hover:underline font-medium"
            >
              Sign up
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}

export default function SignIn() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <SignInInner />
    </Suspense>
  );
}
