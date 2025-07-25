export default function TermsOfUse() {
  return (
    <main className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] px-4 py-12">
      <section className="max-w-3xl mx-auto">
        <h1
          className="text-4xl sm:text-5xl font-extrabold mb-6 text-[var(--color-primary)]"
          style={{ fontFamily: "var(--font-heading)" }}
        >
          Terms of use
        </h1>

        <p
          className="text-[var(--color-muted)] text-lg mb-8"
          style={{ fontFamily: "var(--font-body)" }}
        >
          Last updated: June 6, 2025
        </p>

        <div
          className="space-y-8 text-base sm:text-lg leading-relaxed"
          style={{ fontFamily: "var(--font-body)" }}
        >
          <p>
            Welcome to <strong>GameLand</strong>! By using our platform, you
            agree to the following terms. Please read them carefully. GameLand
            is a community-driven library for borrowing and sharing games —
            board games, card games, video games, puzzles, and more.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            1. Eligibility
          </h2>
          <p>
            You must be at least 13 years old to use GameLand. If you&apos;re
            under 18, please make sure you have a parent or guardian&apos;s
            permission.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            2. Game borrowing
          </h2>
          <p>
            Users may borrow available games for a limited period as indicated
            in each listing. All borrowed games must be returned in good
            condition and by the due date. Repeated failure to return items may
            result in suspension or termination of your account.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            3. Late returns & fees
          </h2>
          <p>
            While GameLand does not charge fees by default, a late return may
            incur future borrowing restrictions or require a replacement of the
            game. In some cases, compensation may be requested if a game is lost
            or damaged beyond reasonable wear.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            4. Acceptable use
          </h2>
          <p>
            You agree to use GameLand respectfully. You will not misuse the
            platform, post offensive content, harass other users, or engage in
            any activity that disrupts the service or community.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            5. Account security
          </h2>
          <p>
            You&apos;re responsible for keeping your account credentials secure.
            If you believe your account has been compromised, notify us
            immediately.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            6. Modifications & availability
          </h2>
          <p>
            GameLand may update, suspend, or discontinue any part of the service
            at any time. We try to give notice when possible, but cannot
            guarantee availability or uninterrupted service.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            7. Limitation of liability
          </h2>
          <p>
            GameLand is not liable for lost or damaged property, missed returns,
            or user conflicts. All use of the platform is at your own risk. We
            are not responsible for external links or third-party content.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            8. Changes to these terms
          </h2>
          <p>
            We may update these terms of use from time to time. Any changes will
            be posted on this page. Continued use of GameLand after changes
            means you accept the revised terms.
          </p>

          <h2 className="text-2xl font-semibold text-[var(--color-primary)]">
            9. Contact
          </h2>
          <p>
            If you have any questions about these terms, please contact us at{" "}
            <a
              href="mailto:support@gameland.com"
              className="text-[var(--color-accent)] underline"
            >
              contact@gameland.fun
            </a>
            .
          </p>
        </div>
      </section>
    </main>
  );
}
