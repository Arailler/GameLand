"use client";

import { useState } from "react";

export default function Contact() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    message: "",
    nickname: "",
  });

  const [status, setStatus] = useState<
    "idle" | "success" | "error" | "sending"
  >("idle");
  const [errors, setErrors] = useState<{ [key: string]: string }>({});

  const validate = () => {
    const newErrors: { [key: string]: string } = {};
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (formData.name.trim().length < 2) {
      newErrors.name = "Name must be at least 2 characters.";
    }

    if (!emailRegex.test(formData.email.trim())) {
      newErrors.email = "Please enter a valid email address.";
    }

    if (formData.message.trim().length < 10) {
      newErrors.message = "Message must be at least 10 characters.";
    } else if (formData.message.trim().length > 1000) {
      newErrors.message = "Message must be less than 1000 characters.";
    }

    return newErrors;
  };

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatus("idle");

    const validationErrors = validate();
    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    setErrors({});
    setStatus("sending");

    const res = await fetch("/api/contact", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(formData),
    });

    if (res.ok) {
      setFormData({ name: "", email: "", message: "", nickname: "" });
      setStatus("success");
    } else {
      setStatus("error");
    }
  };

  return (
    <main className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] px-4 py-12 flex flex-col items-center">
      <section className="max-w-xl w-full text-center mb-12">
        <h1 className="text-4xl font-heading text-[var(--color-primary)] mb-4">
          Contact us 📬
        </h1>
        <p className="text-lg text-[var(--color-muted)]">
          Have questions, suggestions, or just want to say hi? We’d love to hear
          from you!
        </p>
      </section>

      <form
        onSubmit={handleSubmit}
        className="w-full max-w-xl bg-[var(--color-surface)] p-6 rounded-2xl shadow-md space-y-4"
      >
        <div className="hidden">
          <label htmlFor="nickname">Nickname</label>
          <input
            type="text"
            id="nickname"
            name="nickname"
            autoComplete="off"
            tabIndex={-1}
            value={formData.nickname}
            onChange={handleChange}
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-1" htmlFor="name">
            Name
          </label>
          <input
            className="w-full p-3 rounded-md border border-[var(--color-border)] bg-transparent text-[var(--color-text)]"
            type="text"
            id="name"
            name="name"
            required
            value={formData.name}
            onChange={handleChange}
          />
          {errors.name && (
            <p className="text-red-500 text-sm mt-1">{errors.name}</p>
          )}
        </div>

        <div>
          <label className="block text-sm font-medium mb-1" htmlFor="email">
            Email
          </label>
          <input
            className="w-full p-3 rounded-md border border-[var(--color-border)] bg-transparent text-[var(--color-text)]"
            type="email"
            id="email"
            name="email"
            required
            value={formData.email}
            onChange={handleChange}
          />
          {errors.email && (
            <p className="text-red-500 text-sm mt-1">{errors.email}</p>
          )}
        </div>

        <div>
          <label className="block text-sm font-medium mb-1" htmlFor="message">
            Message
          </label>
          <textarea
            className="w-full p-3 rounded-md border border-[var(--color-border)] bg-transparent text-[var(--color-text)] min-h-[150px]"
            id="message"
            name="message"
            required
            value={formData.message}
            onChange={handleChange}
          ></textarea>
          <div className="flex justify-between text-sm text-[var(--color-muted)] mt-1">
            <span>{formData.message.length}/1000</span>
            {errors.message && <p className="text-red-500">{errors.message}</p>}
          </div>
        </div>

        <button
          type="submit"
          disabled={status === "sending"}
          className="bg-[var(--color-primary)] text-white font-semibold px-6 py-3 rounded-xl hover:opacity-90 transition disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {status === "sending" ? "Sending..." : "Send message"}
        </button>

        {status === "success" && (
          <p className="text-green-600 mt-2">
            ✅ Thanks! Your message has been sent.
          </p>
        )}
        {status === "error" && (
          <p className="text-red-600 mt-2">
            ❌ Something went wrong. Please try again.
          </p>
        )}
      </form>
    </main>
  );
}
