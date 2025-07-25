import { NextResponse } from "next/server";
import nodemailer from "nodemailer";

function escapeHTML(str: string) {
  return str.replace(
    /[&<>"']/g,
    (char) =>
      ({
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': "&quot;",
        "'": "&#039;",
      }[char] || char)
  );
}

export async function POST(req: Request) {
  const { name, email, message, nickname } = await req.json();

  if (nickname) {
    return NextResponse.json({ success: true });
  }

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: process.env.GMAIL_USER,
      pass: process.env.GMAIL_APP_PASSWORD,
    },
  });

  try {
    const escapedName = escapeHTML(name);
    const escapedEmail = escapeHTML(email);
    const escapedMessage = escapeHTML(message).replace(/\n/g, "<br/>");

    await transporter.sendMail({
      from: `${escapedName} <${email}>`,
      to: process.env.GMAIL_USER,
      subject: "GameLand - New message",
      text: message,
      html: `
        <div style="font-family: sans-serif; line-height: 1.5;">
          <p><strong>Name:</strong> ${escapedName}</p>
          <p><strong>Email:</strong> ${escapedEmail}</p>
          <p><strong>Message:</strong><br/>${escapedMessage}</p>
        </div>
      `,
    });

    return NextResponse.json({ success: true });
  } catch (error) {
    console.error("Email error:", error);
    return NextResponse.json({ error: "Email failed" }, { status: 500 });
  }
}
