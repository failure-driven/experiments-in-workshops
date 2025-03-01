"use client";

import { useFormStatus } from "react-dom";

export function SubmitButton({ text }) {
  const { pending } = useFormStatus();

  return (
    <button disabled={pending} type="submit">
      {pending ? "Submitting..." : text}
    </button>
  );
}
