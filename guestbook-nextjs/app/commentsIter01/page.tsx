"use client";

import { useActionState } from "react";
import { SubmitButton } from "../ui/button";
import createComment, { UserData } from "./actions";
import React from "react";

const initialState = {
  message: "",
  fields: {} as UserData,
};

export default function Page() {
  const [state, formAction] = useActionState(createComment, initialState);

  return (
    <div>
      <form action={formAction}>
        <div>
          <label htmlFor="email">Email</label>
          <div>
            <input
              autoFocus
              placeholder="email"
              type="email"
              name="email"
              defaultValue={state.fields?.email}
            />
          </div>
        </div>
        <div>
          <label>Name</label>
          <div>
            <input
              placeholder="name"
              type="text"
              name="name"
              defaultValue={state?.fields?.name}
            />
          </div>
        </div>
        <div>
          <label>Last Name</label>
          <div>
            <input
              placeholder="last name"
              type="text"
              name="lastName"
              defaultValue={state?.fields?.lastName}
            />
          </div>
        </div>
        <div>
          <label>Comment</label>
          <div>
            <textarea
              placeholder="comment"
              name="comment"
              defaultValue={state?.fields?.comment}
            />
          </div>
        </div>

        <SubmitButton text="Create" />
        <p
          aria-live="polite"
          className="sr-only"
          role="status"
          style={{ color: "red" }}
        >
          {state?.message}
        </p>
      </form>
    </div>
  );
}
