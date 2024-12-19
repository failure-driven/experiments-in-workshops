"use client";

import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";

export default function Page() {
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [lastName, setLastName] = useState("");
  const router = useRouter();

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    try {
      const body = { email, name, lastName };
      await fetch(`/api/submit`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      router.push("/");
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <form onSubmit={onSubmit}>
      <input type="text" name="name" />
      <input
        autoFocus
        onChange={(e) => setEmail(e.target.value)}
        placeholder="email"
        type="email"
        value={email}
      />
      <input
        onChange={(e) => setName(e.target.value)}
        placeholder="name"
        type="text"
        value={name}
      />
      <input
        onChange={(e) => setLastName(e.target.value)}
        placeholder="last name"
        type="text"
        value={lastName}
      />
      <button type="submit">Submit</button>
    </form>
  );
}
