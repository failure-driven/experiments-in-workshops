"use client";

import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";

export default function Page() {
  const router = useRouter();
  const [data, setData] = useState()

  async function onSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    try {
      const formData = new FormData(event.currentTarget);
      // const body = { email, name, lastName, comment };
      const response = await fetch(`/comments/api`, {
        method: "POST",
        body: formData,
      });
      // handle response
      const data = await response.json();
      setData(data);
      if (!!data?.error) {
        console.log(data);
      } else {
        router.push("/");
      }
    } catch (error) {
      console.error(error);
    }
  }

  return (
    <form onSubmit={onSubmit}>
      <div>
        <label>Email</label>
        <div>
          <input autoFocus placeholder="email" type="email" name="email" />
        </div>
      </div>
      <div>
        <label>Name</label>
        <div>
          <input placeholder="name" type="text" name="name" />
        </div>
      </div>
      <div>
        <label>Last Name</label>
        <div>
          <input placeholder="last name" type="text" name="last-name" />
        </div>
      </div>
      <div>
        <label>Comment</label>
        <div>
          <textarea placeholder="comment" name="comment" />
        </div>
      </div>

      <button type="submit">Submit</button>
      <p
          aria-live="polite"
          className="sr-only"
          role="status"
          style={{ color: "red" }}
        >
          {data?.error}
        </p>
    </form>
  );
}
