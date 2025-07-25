"use client";

import { useState } from "react";

export default function ForgotPassword() {
  const [email, setEmail] = useState("");
  const [message, setMessage] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setMessage(null);

    if (!email) {
      setError("Please enter your email address.");
      return;
    }

    setIsLoading(true);

    // Simulate async request for password reset email
    setTimeout(() => {
      setIsLoading(false);
      setMessage(
        "If an account with that email exists, a password reset link has been sent."
      );
      setEmail("");
    }, 1500);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-[var(--color-background)] p-6">
      <div className="max-w-md w-full bg-[var(--color-surface)] rounded-xl shadow-lg p-10">
        <h1 className="text-3xl font-bold text-[var(--color-primary)] mb-8 text-center">
          Forgot Password
        </h1>

        {error && (
          <div className="mb-6 text-red-500 text-center font-medium">
            {error}
          </div>
        )}
        {message && (
          <div className="mb-6 text-green-600 text-center font-medium">
            {message}
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

          <button
            type="submit"
            disabled={isLoading}
            className="w-full bg-[var(--color-primary)] text-white font-semibold py-4 rounded hover:bg-[var(--color-primary-hover)] transition-colors disabled:opacity-60 text-lg"
          >
            {isLoading ? "Sending..." : "Send Reset Link"}
          </button>
        </form>

        <p className="mt-10 text-center text-base text-[var(--color-text)]">
          Remembered your password?{" "}
          <a
            href="/signin"
            className="text-[var(--color-primary)] hover:underline font-medium"
          >
            Sign In
          </a>
        </p>
      </div>
    </div>
  );
}
