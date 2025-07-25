import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-[var(--color-surface)] text-[var(--color-text)] border-t border-[var(--color-border)] px-4 py-8 mt-10">
      <div className="max-w-7xl mx-auto flex flex-col sm:flex-row justify-between items-center gap-6 text-center sm:text-left">
        <p className="text-sm">
          &copy; {new Date().getFullYear()} GameLand All rights reserved.
        </p>

        <nav className="flex flex-wrap justify-center sm:justify-end gap-x-6 gap-y-2 text-sm">
          <Link
            href="/legal-notice"
            className="hover:text-[var(--color-primary)] transition-colors"
          >
            Legal notice
          </Link>
          <Link
            href="/terms-of-use"
            className="hover:text-[var(--color-primary)] transition-colors"
          >
            Terms of use
          </Link>
          <Link
            href="/privacy-policy"
            className="hover:text-[var(--color-primary)] transition-colors"
          >
            Privacy policy
          </Link>
          <Link
            href="/contact"
            className="hover:text-[var(--color-primary)] transition-colors"
          >
            Contact
          </Link>
        </nav>
      </div>
    </footer>
  );
}
