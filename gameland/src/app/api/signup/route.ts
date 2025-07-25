import { NextRequest, NextResponse } from "next/server";
import { CreateUserParams, createUser, getUserByEmail } from "@/lib/db";

export async function POST(request: NextRequest) {
  try {
    const body: CreateUserParams = await request.json();

    const requiredFields: (keyof CreateUserParams)[] = [
      "email",
      "password",
      "birthDate",
      "firstName",
      "lastName",
      "country",
      "postalCode",
      "street",
      "number",
      "phone",
    ];

    for (const field of requiredFields) {
      if (typeof body[field] !== "string" || !body[field]?.trim()) {
        return NextResponse.json(
          { message: `Invalid or missing field: ${field}` },
          { status: 400 }
        );
      }
    }

    const existingUser = await getUserByEmail(body.email);

    if (existingUser) {
      return NextResponse.json(
        { error: "User with this email already exists" },
        { status: 409 }
      );
    }

    const user = await createUser(body);

    return NextResponse.json(
      { message: "User created successfully", userId: user.id },
      { status: 201 }
    );
  } catch (error) {
    console.error("Signup error:", error);
    return NextResponse.json(
      { message: "Internal server error" },
      { status: 500 }
    );
  }
}
