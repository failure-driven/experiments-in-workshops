import "../public/styles/main.css";
import { PrismaClient } from "@prisma/client";
import Link from "next/link";

export default async function Page() {
  const prisma = new PrismaClient();
  const users = await prisma.user.findMany();

  return (
    <div>
      <ul>
        <li>
          <Link href="/comments" data-testid="new-comment">new comment API</Link>
        </li>
        <li>
          <Link href="/comments/new">new comment FORM data</Link>
        </li>
      </ul>
      <div>
        <ul data-testid="comment-list">
          {users.map((user) => (
            <li key={user.id}>
              {user.email}, {user.name}, {user.comment}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
