import Image from "next/image";

export default function LegalNotice() {
  return (
    <main className="min-h-screen bg-[var(--color-background)] text-[var(--color-text)] px-4 py-12 flex flex-col items-center">
      <section className="max-w-3xl w-full">
        <h1 className="text-4xl font-heading mb-6 text-[var(--color-primary)]">
          Legal Notice
        </h1>

        <p className="mb-4">
          <strong>GameLand</strong> is a community-driven game sharing platform
          operated with love and imagination.
        </p>

        <p className="mb-4">
          <strong>Responsible entity:</strong> GameLand Cooperative
        </p>

        <p className="mb-4">
          <strong>Address:</strong> 🎅 Santa Claus Village, 96930 Rovaniemi,
          Finland 🇫🇮
        </p>

        <p className="mb-4">
          <strong>Contact:</strong>{" "}
          <a
            href="mailto:contact@gameland.fun"
            className="text-[var(--color-accent)] underline"
          >
            contact@gameland.fun
          </a>
        </p>

        <p className="mb-4">
          <strong>Representative:</strong> Krampus Darkhorn, Founder & Chief
          game officer
        </p>

        <p className="mb-4">
          <strong>Hosting:</strong> Hosted with care by Arctic cloud systems,
          Polar server street, Rovaniemi
        </p>

        <p className="mb-20 text-[var(--color-muted)] text-sm">
          This website is provided as a non-commercial community resource.
          GameLand does not sell or rent games, and all game borrowing is based
          on volunteer-led sharing. In cases of lost or unreturned games,
          members may be asked to replace or compensate for missing items.
        </p>

        <div className="rounded-xl overflow-hidden shadow-lg">
          <iframe
            title="Santa Claus village map"
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d39194.55996830528!2d25.812203053994183!3d66.54336755805308!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4c2c07cc88b9f3b3%3A0x4e401e36fbe4c1e5!2sSanta%20Claus%20Village!5e0!3m2!1sen!2sfi!4v1717665988751!5m2!1sen!2sfi"
            width="100%"
            height="400"
            style={{ border: 0 }}
            allowFullScreen
            referrerPolicy="no-referrer-when-downgrade"
          ></iframe>
        </div>

        <div className="mt-8 mb-4 rounded-xl overflow-hidden shadow-md relative w-full h-64 sm:h-80 md:h-96">
          <Image
            src="https://images.unsplash.com/photo-1668854349253-6cff0651a636?q=60&w=800&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            alt="Santa Claus village in Rovaniemi"
            className="object-cover"
            fill
          />
        </div>
      </section>
    </main>
  );
}
