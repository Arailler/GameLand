export default function PrivacyPolicy() {
  return (
    <main className="min-h-screen px-4 py-12 text-[var(--color-text)] bg-[var(--color-background)] font-[var(--font-body)]">
      <div className="max-w-4xl mx-auto">
        <header className="mb-12">
          <h1 className="text-4xl sm:text-5xl font-[var(--font-heading)] text-[var(--color-primary)] mb-4">
            Privacy policy
          </h1>
          <p className="text-base sm:text-lg text-[var(--color-muted)]">
            Last updated: June 6, 2025
          </p>
        </header>

        <section className="space-y-10 text-base sm:text-lg leading-relaxed">
          <p>
            At GameLand, your privacy is a priority. This Privacy policy
            explains how we collect, use, and protect your personal data while
            you explore and borrow games through our platform. By using
            GameLand, you agree to these terms.
          </p>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              1. What we collect
            </h2>
            <p>
              We collect basic information like your name, email address, and
              borrowing history. This helps us facilitate lending, returns, and
              building community trust.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              2. How we use it
            </h2>
            <p>
              Your data is used solely to provide and improve the GameLand
              experience — like managing loans, reminding you of due dates, and
              ensuring games are returned in good condition. In rare cases of
              non-return, we may use contact info to resolve the issue,
              including charging a replacement fee if applicable.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              3. Late returns & liability
            </h2>
            <p>
              While GameLand is free to use, failure to return a borrowed game
              in due time may lead to temporary suspension or, in rare cases,
              replacement cost charges. This ensures fairness for all members.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              4. We don’t sell your info
            </h2>
            <p>
              Your personal information will never be sold. We may share data
              with secure service providers that help us run the site, such as
              email systems or hosting providers, under strict confidentiality.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              5. Cookies & analytics
            </h2>
            <p>
              We use cookies to understand how people use the site and improve
              it. You can disable cookies in your browser settings if you
              prefer.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              6. Your rights
            </h2>
            <p>
              You have full control over your data. You can request deletion of
              your profile and data at any time by emailing{" "}
              <a
                href="mailto:contact@gameland.fun"
                className="text-[var(--color-accent)] underline"
              >
                contact@gameland.fun
              </a>
              .
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              7. Updates
            </h2>
            <p>
              If this policy changes, we’ll notify you in-app or via email. You
              can always review the latest version here.
            </p>
          </div>

          <div>
            <h2 className="text-2xl font-bold text-[var(--color-primary)] mb-2">
              8. Contact us
            </h2>
            <p>
              For any privacy concerns, email us at{" "}
              <a
                href="mailto:contact@gameland.fun"
                className="text-[var(--color-accent)] underline"
              >
                contact@gameland.fun
              </a>
              . We’re here to help.
            </p>
          </div>
        </section>

        <footer className="mt-16 text-sm text-[var(--color-muted)] text-center">
          © {new Date().getFullYear()} GameLand. All rights reserved.
        </footer>
      </div>
    </main>
  );
}
