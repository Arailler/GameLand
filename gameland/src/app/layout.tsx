import "./globals.css";
import NavBar from "@/components/global/NavBar";
import Footer from "@/components/global/Footer";
import Providers from "./providers";
import type { Metadata } from "next";
import { Permanent_Marker } from "next/font/google";

export const metadata: Metadata = {
  title: "GameLand",
  description:
    "GameLand is your ultimate destination for discovering, playing, and sharing the best board games, card games, puzzles, and video games. Join a vibrant community of gamers and level up your fun!",
};

const permanentMarkerFont = Permanent_Marker({
  subsets: ["latin"],
  weight: "400",
});

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <Providers>
          <NavBar />

          {children}

          <Footer />
        </Providers>
      </body>
    </html>
  );
}
