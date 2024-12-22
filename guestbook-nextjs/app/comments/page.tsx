"use client";

import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";

export default function Page() {
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [lastName, setLastName] = useState("");
  const [comment, setComment] = useState("");
  const router = useRouter();

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    try {
      const body = { email, name, lastName, comment };
      await fetch(`/comments/api`, {
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
      <div>
        <label>Email</label>
        <div>
          <input
            autoFocus
            onChange={(e) => setEmail(e.target.value)}
            placeholder="email"
            type="email"
            name="email"
            value={email}
          />
        </div>
      </div>
      <div>
        <label>Name</label>
        <div>
          <input
            onChange={(e) => setName(e.target.value)}
            placeholder="name"
            type="text"
            name="name"
            value={name}
          />
        </div>
      </div>
      <div>
        <label>Last Name</label>
        <div>
          <input
            onChange={(e) => setLastName(e.target.value)}
            placeholder="last name"
            type="text"
            name="last-name"
            value={lastName}
          />
        </div>
      </div>
      <div>
        <label>Comment</label>
        <div>
          <textarea
            onChange={(e) => setComment(e.target.value)}
            placeholder="comment"
            name="comment"
            value={comment}
          />
        </div>
      </div>

      <button type="submit">Submit</button>
    </form>
  );
}
