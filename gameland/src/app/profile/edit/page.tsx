"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { User } from "@prisma/client";
import { countries } from "@/lib/countryData";
import { validatePostalCode, validatePhoneNumber } from "@/lib/validators";

export default function EditProfile() {
  const router = useRouter();
  const [user, setUser] = useState<User | null>(null);
  const [formData, setFormData] = useState({
    firstName: "",
    lastName: "",
    birthDate: "",
    phone: "",
    street: "",
    number: "",
    postalCode: "",
    country: "",
  });
  const [errors, setErrors] = useState<{ [key: string]: string }>({});
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetch("/api/profile")
      .then((res) => res.json())
      .then((data) => {
        let formattedBirthDate = "";
        if (data.birthDate) {
          const date = new Date(data.birthDate);
          if (!isNaN(date.getTime())) {
            formattedBirthDate = date.toISOString().slice(0, 10);
          }
        }

        setUser(data);
        setFormData({
          firstName: data.firstName,
          lastName: data.lastName,
          birthDate: formattedBirthDate,
          phone: data.phone || "",
          street: data.street || "",
          number: data.number || "",
          postalCode: data.postalCode || "",
          country: data.country || "",
        });
      });
  }, []);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
    setErrors((prev) => ({ ...prev, [e.target.name]: "" }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const newErrors: typeof errors = {};

    if (formData.birthDate) {
      const date = new Date(formData.birthDate);
      if (isNaN(date.getTime())) {
        newErrors.birthDate = "Invalid birth date.";
      }
    }

    if (!validatePhoneNumber(formData.phone)) {
      newErrors.phone =
        "Invalid phone number format. Use + followed by digits.";
    }

    if (!validatePostalCode(formData.postalCode, formData.country)) {
      newErrors.postalCode = "Invalid postal code for selected country.";
    }

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    setLoading(true);

    const response = await fetch("/api/profile/edit", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(formData),
    });

    setLoading(false);

    if (response.ok) {
      router.push("/profile");
    } else {
      const errorData = await response.json();
      alert(errorData.message || "Something went wrong.");
    }
  };

  if (!user) return <p>Loading...</p>;

  return (
    <div
      className="max-w-3xl mx-auto p-6 mt-10 rounded-xl shadow"
      style={{ backgroundColor: "var(--color-surface)" }}
    >
      <h1
        className="text-3xl font-bold mb-6"
        style={{
          color: "var(--color-text)",
          fontFamily: "var(--font-heading)",
        }}
      >
        Edit Profile
      </h1>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm text-[var(--color-muted)]">
              First name
            </label>
            <input
              type="text"
              name="firstName"
              className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
              value={formData.firstName}
              onChange={handleChange}
            />
          </div>
          <div>
            <label className="block text-sm text-[var(--color-muted)]">
              Last name
            </label>
            <input
              type="text"
              name="lastName"
              className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
              value={formData.lastName}
              onChange={handleChange}
            />
          </div>
        </div>

        <div>
          <label className="block text-sm text-[var(--color-muted)]">
            Birth Date
          </label>
          <input
            type="date"
            name="birthDate"
            className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
            value={formData.birthDate}
            onChange={handleChange}
          />
          {errors.birthDate && (
            <p className="text-[var(--color-warning)] text-sm">
              {errors.birthDate}
            </p>
          )}
        </div>

        <div>
          <label className="block text-sm text-[var(--color-muted)]">
            Phone
          </label>
          <input
            type="text"
            name="phone"
            className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
            value={formData.phone}
            onChange={handleChange}
          />
          {errors.phone && (
            <p className="text-[var(--color-warning)] text-sm">
              {errors.phone}
            </p>
          )}
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm text-[var(--color-muted)]">
              Street
            </label>
            <input
              type="text"
              name="street"
              className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
              value={formData.street}
              onChange={handleChange}
            />
          </div>
          <div>
            <label className="block text-sm text-[var(--color-muted)]">
              Number
            </label>
            <input
              type="text"
              name="number"
              className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
              value={formData.number}
              onChange={handleChange}
            />
          </div>
        </div>

        <div>
          <label className="block text-sm text-[var(--color-muted)]">
            Country
          </label>
          <select
            name="country"
            className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
            value={formData.country}
            onChange={handleChange}
          >
            <option value="">Select a country</option>
            {countries.map((country) => (
              <option key={country} value={country}>
                {country}
              </option>
            ))}
          </select>
        </div>

        <div>
          <label className="block text-sm text-[var(--color-muted)]">
            Postal code
          </label>
          <input
            type="text"
            name="postalCode"
            className="w-full border border-[var(--color-border)] rounded-md p-2 text-[var(--color-text)] bg-[var(--color-surface)]"
            value={formData.postalCode}
            onChange={handleChange}
          />
          {errors.postalCode && (
            <p className="text-[var(--color-warning)] text-sm">
              {errors.postalCode}
            </p>
          )}
        </div>

        <button
          type="submit"
          className="bg-[var(--color-primary)] text-white px-6 py-2 rounded-md hover:bg-blue-700 disabled:opacity-50"
          disabled={loading}
        >
          {loading ? "Updating..." : "Update profile"}
        </button>
      </form>
    </div>
  );
}
