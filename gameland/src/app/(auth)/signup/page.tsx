"use client";

import type { CreateUserParams } from "@/lib/db";
import { useState } from "react";
import { useRouter } from "next/navigation";
import { useSession } from "next-auth/react";
import { countries } from "@/lib/countryData";
import Link from "next/link";
import {
  validatePostalCode,
  validatePhoneNumber,
  isPasswordSafe,
} from "@/lib/validators";

export default function SignUp() {
  const router = useRouter();
  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    country: "",
    postalCode: "",
    street: "",
    number: "",
    phone: "",
    email: "",
    birthDate: "",
    password: "",
    confirmPassword: "",
  });
  const [fieldErrors, setFieldErrors] = useState<Record<string, string>>({});
  const [isLoading, setIsLoading] = useState(false);
  const { data: session, status } = useSession();

  if (status === "loading") {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <p className="text-lg text-[var(--color-text)]">Checking session...</p>
      </div>
    );
  }

  if (session) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="max-w-lg w-full bg-[var(--color-surface)] rounded-xl shadow-lg p-8 text-center">
          <h1 className="text-2xl font-bold text-[var(--color-primary)] mb-4">
            You are already signed in
          </h1>
          <p className="text-[var(--color-text)] mb-6">
            You’re logged in as <strong>{session.user?.email}</strong>. If you
            want to create another account, please sign out first.
          </p>
          <Link
            href="/"
            className="inline-block px-6 py-3 bg-[var(--color-primary)] text-white rounded-full hover:bg-[#1e40af] transition"
          >
            Go to homepage
          </Link>
        </div>
      </div>
    );
  }

  function handleChange(
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) {
    setForm((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    setFieldErrors((prev) => ({ ...prev, [e.target.name]: "" }));
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setFieldErrors({});
    setIsLoading(true);

    const errors: Record<string, string> = {};

    if (!form.firstName.trim()) errors.firstName = "First name is required.";
    if (!form.lastName.trim()) errors.lastName = "Last name is required.";
    if (!form.country.trim()) errors.country = "Country is required.";
    if (
      !form.postalCode.trim() ||
      !validatePostalCode(form.postalCode, form.country)
    )
      errors.postalCode = "Please enter a valid postal code.";
    if (!form.street.trim()) errors.street = "Street is required.";
    if (!form.number.trim()) errors.number = "Number is required.";
    if (!form.phone.trim() || !validatePhoneNumber(form.phone))
      errors.phone =
        "Please enter a valid phone number starting with + and country code.";
    if (!form.email.trim()) errors.email = "Email is required.";
    if (!form.birthDate.trim()) errors.birthDate = "Birth date is required.";
    if (!isPasswordSafe(form.password))
      errors.password =
        "Password must be at least 8 characters, with letters, numbers, and special characters.";
    if (form.password !== form.confirmPassword)
      errors.confirmPassword = "Passwords do not match.";

    if (Object.keys(errors).length > 0) {
      setFieldErrors(errors);
      setIsLoading(false);
      return;
    }

    const userData: CreateUserParams = {
      firstName: form.firstName,
      lastName: form.lastName,
      birthDate: form.birthDate,
      country: form.country,
      postalCode: form.postalCode,
      street: form.street,
      number: form.number,
      phone: form.phone,
      email: form.email,
      password: form.password,
    };

    try {
      const response = await fetch("/api/signup", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      const data = await response.json();

      if (!response.ok) {
        if (data.error) {
          setFieldErrors({ email: data.error });
        }
        setIsLoading(false);
        return;
      }

      router.push("/signin?signup=success");
    } catch (error) {
      console.error("Error signing up:", error);
      setIsLoading(false);
    }
  }

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-[var(--color-background)] p-4 sm:p-8">
      <div className="max-w-lg w-full bg-[var(--color-surface)] rounded-xl shadow-lg pb-12">
        <form
          onSubmit={handleSubmit}
          noValidate
          className="max-w-[600px] w-full bg-[var(--color-surface)] p-6 sm:p-10 rounded-xl shadow-md text-[var(--color-text)] font-[var(--font-body)]"
        >
          <h1 className="text-[2.5rem] text-[var(--color-primary)] text-center mb-6 font-[var(--font-heading)]">
            Create your account
          </h1>

          {/* First and last Name */}
          <div className="flex flex-wrap gap-4 sm:gap-6 mb-4">
            {["firstName", "lastName"].map((field) => (
              <div key={field} className="flex-1 min-w-[45%]">
                <label
                  htmlFor={field}
                  className="block font-semibold mb-2 text-[var(--color-text)]"
                >
                  {field === "firstName" ? "First name" : "Last name"}
                </label>
                <input
                  id={field}
                  name={field}
                  type="text"
                  value={form[field as keyof typeof form]}
                  onChange={handleChange}
                  aria-invalid={!!fieldErrors[field]}
                  placeholder={`Your ${
                    field === "firstName" ? "first" : "last"
                  } name`}
                  required
                  className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                    fieldErrors[field]
                      ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                      : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
                  }`}
                />
                {fieldErrors[field] && (
                  <p className="mt-1 text-sm text-[var(--color-warning)]">
                    {fieldErrors[field]}
                  </p>
                )}
              </div>
            ))}
          </div>

          {/* Birth date */}
          <div className="mb-4">
            <label
              htmlFor="birthDate"
              className="block font-semibold mb-2 text-[var(--color-text)]"
            >
              Birth date
            </label>
            <input
              id="birthDate"
              name="birthDate"
              type="date"
              value={form.birthDate}
              onChange={handleChange}
              aria-invalid={!!fieldErrors.birthDate}
              required
              className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                fieldErrors.birthDate
                  ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                  : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
              }`}
            />
            {fieldErrors.birthDate && (
              <p className="mt-1 text-sm text-[var(--color-warning)]">
                {fieldErrors.birthDate}
              </p>
            )}
          </div>

          {/* Country */}
          <div className="mb-4">
            <label
              htmlFor="country"
              className="block font-semibold mb-2 text-[var(--color-text)]"
            >
              Country
            </label>
            <select
              id="country"
              name="country"
              value={form.country}
              onChange={handleChange}
              aria-invalid={!!fieldErrors.country}
              required
              className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                fieldErrors.country
                  ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                  : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
              }`}
            >
              <option value="">Select your country</option>
              {countries.map((c) => (
                <option key={c} value={c}>
                  {c}
                </option>
              ))}
            </select>
            {fieldErrors.country && (
              <p className="mt-1 text-sm text-[var(--color-warning)]">
                {fieldErrors.country}
              </p>
            )}
          </div>

          {/* Postal code, street, number */}
          <div className="grid grid-cols-1 md:grid-cols-12 gap-4 sm:gap-6 mb-4">
            <div className="md:col-span-4">
              <label
                htmlFor="postalCode"
                className="block mb-2 font-medium text-lg"
              >
                Postal code
              </label>
              <input
                id="postalCode"
                name="postalCode"
                type="text"
                value={form.postalCode}
                onChange={handleChange}
                required
                className={`w-full p-4 rounded border text-lg focus:outline-none focus:ring-2 ${
                  fieldErrors.postalCode
                    ? "border-red-500 focus:ring-red-500"
                    : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
                } bg-[var(--color-background)]`}
              />
              {fieldErrors.postalCode && (
                <p className="mt-1 text-sm text-red-500">
                  {fieldErrors.postalCode}
                </p>
              )}
            </div>

            <div className="md:col-span-5">
              <label
                htmlFor="street"
                className="block mb-2 font-medium text-lg"
              >
                Street
              </label>
              <input
                id="street"
                name="street"
                type="text"
                value={form.street}
                onChange={handleChange}
                required
                className={`w-full p-4 rounded border text-lg focus:outline-none focus:ring-2 ${
                  fieldErrors.street
                    ? "border-red-500 focus:ring-red-500"
                    : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
                } bg-[var(--color-background)]`}
              />
              {fieldErrors.street && (
                <p className="mt-1 text-sm text-red-500">
                  {fieldErrors.street}
                </p>
              )}
            </div>

            <div className="md:col-span-3">
              <label
                htmlFor="number"
                className="block mb-2 font-medium text-lg"
              >
                Number
              </label>
              <input
                id="number"
                name="number"
                type="text"
                value={form.number}
                onChange={handleChange}
                required
                className={`w-full p-4 rounded border text-lg focus:outline-none focus:ring-2 ${
                  fieldErrors.number
                    ? "border-red-500 focus:ring-red-500"
                    : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
                } bg-[var(--color-background)]`}
              />
              {fieldErrors.number && (
                <p className="mt-1 text-sm text-red-500">
                  {fieldErrors.number}
                </p>
              )}
            </div>
          </div>

          {/* Phone */}
          <div className="mb-4">
            <label
              htmlFor="phone"
              className="block font-semibold mb-2 text-[var(--color-text)]"
            >
              Phone number
            </label>
            <input
              id="phone"
              name="phone"
              type="tel"
              value={form.phone}
              onChange={handleChange}
              aria-invalid={!!fieldErrors.phone}
              placeholder="+1234567890"
              required
              className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                fieldErrors.phone
                  ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                  : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
              }`}
            />
            {fieldErrors.phone && (
              <p className="mt-1 text-sm text-[var(--color-warning)]">
                {fieldErrors.phone}
              </p>
            )}
          </div>

          {/* Email */}
          <div className="mb-4">
            <label
              htmlFor="email"
              className="block font-semibold mb-2 text-[var(--color-text)]"
            >
              Email
            </label>
            <input
              id="email"
              name="email"
              type="email"
              value={form.email}
              onChange={handleChange}
              aria-invalid={!!fieldErrors.email}
              placeholder="you@example.com"
              required
              className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                fieldErrors.email
                  ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                  : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
              }`}
            />
            {fieldErrors.email && (
              <p className="mt-1 text-sm text-[var(--color-warning)]">
                {fieldErrors.email}
              </p>
            )}
          </div>

          {/* Password & confirm password */}
          <div className="flex flex-wrap gap-4 sm:gap-6 mb-6">
            {[
              { id: "password", label: "Password" },
              { id: "confirmPassword", label: "Confirm password" },
            ].map(({ id, label }) => (
              <div key={id} className="flex-1 min-w-[45%]">
                <label
                  htmlFor={id}
                  className="block font-semibold mb-2 text-[var(--color-text)]"
                >
                  {label}
                </label>
                <input
                  id={id}
                  name={id}
                  type="password"
                  value={form[id as keyof typeof form]}
                  onChange={handleChange}
                  aria-invalid={!!fieldErrors[id]}
                  placeholder="••••••••"
                  required
                  autoComplete="new-password"
                  className={`w-full px-5 py-4 text-base rounded border transition-all font-[var(--font-body)] text-[var(--color-text)] bg-[var(--color-surface)] focus:outline-none focus:ring-2 ${
                    fieldErrors[id]
                      ? "border-[var(--color-warning)] focus:ring-[var(--color-warning)]"
                      : "border-[var(--color-border)] focus:ring-[var(--color-primary)]"
                  }`}
                />
                {fieldErrors[id] && (
                  <p className="mt-1 text-sm text-[var(--color-warning)]">
                    {fieldErrors[id]}
                  </p>
                )}
              </div>
            ))}
          </div>

          <button
            type="submit"
            disabled={isLoading}
            className="w-full py-5 bg-[var(--color-primary)] text-white text-xl rounded-full border-none shadow-md hover:bg-[#1e40af] transition-colors duration-300 disabled:opacity-60 disabled:cursor-not-allowed font-[var(--font-body)]"
          >
            {isLoading ? "Signing up..." : "Sign up"}
          </button>
        </form>

        <p className="text-center text-base text-[var(--color-text)]">
          Already have an account?{" "}
          <Link
            href="/signin"
            className="text-[var(--color-primary)] hover:underline font-medium"
          >
            Sign in
          </Link>
        </p>
      </div>
    </div>
  );
}
